Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBkp9-0008M5-Hx
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBkp6-0008Pa-7j
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBkp6-0008PU-1F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:48 -0400
Date: Thu, 26 Apr 2018 18:36:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426173641.GN2631@work-vm>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-5-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524666934-8064-5-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>, berrange@redhat.com
Cc: quintela@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> This patch implements bi-directional RDMA QIOChannel. Because different
> threads may access RDMAQIOChannel concurrently, this patch use RCU to protect it.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

I'm a bit confused by this.

I can see it's adding RCU to protect the rdma structures against
deletion from multiple threads; that I'm OK with in principal; is that
the only locking we need? (I guess the two directions are actually
separate RDMAContext's so maybe).

But is there nothing else to make the QIOChannel bidirectional?

Also, a lot seems dependent on listen_id, can you explain how that's
being used.

Finally, I don't think you have anywhere that destroys the new mutex you
added.

Dave
P.S. Please cc Daniel Berrange on this series, since it's so much
IOChannel stuff.

> ---
>  migration/rdma.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 146 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index f5c1d02..0652224 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -86,6 +86,7 @@ static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
>                                  " to abort!"); \
>                  rdma->error_reported = 1; \
>              } \
> +            rcu_read_unlock(); \
>              return rdma->error_state; \
>          } \
>      } while (0)
> @@ -405,6 +406,7 @@ struct QIOChannelRDMA {
>      RDMAContext *rdma;
>      QEMUFile *file;
>      bool blocking; /* XXX we don't actually honour this yet */
> +    QemuMutex lock;
>  };
>  
>  /*
> @@ -2635,12 +2637,29 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>      QEMUFile *f = rioc->file;
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
>      int ret;
>      ssize_t done = 0;
>      size_t i;
>      size_t len = 0;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
> +    if (rdma->listen_id) {
> +        rdma = rdma->return_path;
> +    }
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
>      /*
> @@ -2650,6 +2669,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>      ret = qemu_rdma_write_flush(f, rdma);
>      if (ret < 0) {
>          rdma->error_state = ret;
> +        rcu_read_unlock();
>          return ret;
>      }
>  
> @@ -2669,6 +2689,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>  
>              if (ret < 0) {
>                  rdma->error_state = ret;
> +                rcu_read_unlock();
>                  return ret;
>              }
>  
> @@ -2677,6 +2698,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>          }
>      }
>  
> +    rcu_read_unlock();
>      return done;
>  }
>  
> @@ -2710,12 +2732,29 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>                                        Error **errp)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
>      RDMAControlHeader head;
>      int ret = 0;
>      ssize_t i;
>      size_t done = 0;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
> +    if (!rdma->listen_id) {
> +        rdma = rdma->return_path;
> +    }
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
>      for (i = 0; i < niov; i++) {
> @@ -2727,7 +2766,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>           * were given and dish out the bytes until we run
>           * out of bytes.
>           */
> -        ret = qemu_rdma_fill(rioc->rdma, data, want, 0);
> +        ret = qemu_rdma_fill(rdma, data, want, 0);
>          done += ret;
>          want -= ret;
>          /* Got what we needed, so go to next iovec */
> @@ -2749,25 +2788,28 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>  
>          if (ret < 0) {
>              rdma->error_state = ret;
> +            rcu_read_unlock();
>              return ret;
>          }
>  
>          /*
>           * SEND was received with new bytes, now try again.
>           */
> -        ret = qemu_rdma_fill(rioc->rdma, data, want, 0);
> +        ret = qemu_rdma_fill(rdma, data, want, 0);
>          done += ret;
>          want -= ret;
>  
>          /* Still didn't get enough, so lets just return */
>          if (want) {
>              if (done == 0) {
> +                rcu_read_unlock();
>                  return QIO_CHANNEL_ERR_BLOCK;
>              } else {
>                  break;
>              }
>          }
>      }
> +    rcu_read_unlock();
>      return done;
>  }
>  
> @@ -2823,6 +2865,16 @@ qio_channel_rdma_source_prepare(GSource *source,
>      GIOCondition cond = 0;
>      *timeout = -1;
>  
> +    if ((rdma->listen_id && rsource->condition == G_IO_OUT) ||
> +       (!rdma->listen_id && rsource->condition == G_IO_IN)) {
> +        rdma = rdma->return_path;
> +    }
> +
> +    if (!rdma) {
> +        error_report("RDMAContext is NULL when prepare Gsource");
> +        return FALSE;
> +    }
> +
>      if (rdma->wr_data[0].control_len) {
>          cond |= G_IO_IN;
>      }
> @@ -2838,6 +2890,16 @@ qio_channel_rdma_source_check(GSource *source)
>      RDMAContext *rdma = rsource->rioc->rdma;
>      GIOCondition cond = 0;
>  
> +    if ((rdma->listen_id && rsource->condition == G_IO_OUT) ||
> +       (!rdma->listen_id && rsource->condition == G_IO_IN)) {
> +        rdma = rdma->return_path;
> +    }
> +
> +    if (!rdma) {
> +        error_report("RDMAContext is NULL when check Gsource");
> +        return FALSE;
> +    }
> +
>      if (rdma->wr_data[0].control_len) {
>          cond |= G_IO_IN;
>      }
> @@ -2856,6 +2918,16 @@ qio_channel_rdma_source_dispatch(GSource *source,
>      RDMAContext *rdma = rsource->rioc->rdma;
>      GIOCondition cond = 0;
>  
> +    if ((rdma->listen_id && rsource->condition == G_IO_OUT) ||
> +       (!rdma->listen_id && rsource->condition == G_IO_IN)) {
> +        rdma = rdma->return_path;
> +    }
> +
> +    if (!rdma) {
> +        error_report("RDMAContext is NULL when dispatch Gsource");
> +        return FALSE;
> +    }
> +
>      if (rdma->wr_data[0].control_len) {
>          cond |= G_IO_IN;
>      }
> @@ -2905,15 +2977,29 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
>                                    Error **errp)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> +    RDMAContext *rdma;
>      trace_qemu_rdma_close();
> -    if (rioc->rdma) {
> -        if (!rioc->rdma->error_state) {
> -            rioc->rdma->error_state = qemu_file_get_error(rioc->file);
> -        }
> -        qemu_rdma_cleanup(rioc->rdma);
> -        g_free(rioc->rdma);
> -        rioc->rdma = NULL;
> +
> +    qemu_mutex_lock(&rioc->lock);
> +    rdma = rioc->rdma;
> +    if (!rdma) {
> +        qemu_mutex_unlock(&rioc->lock);
> +        return 0;
> +    }
> +    atomic_rcu_set(&rioc->rdma, NULL);
> +    qemu_mutex_unlock(&rioc->lock);
> +
> +    if (!rdma->error_state) {
> +        rdma->error_state = qemu_file_get_error(rioc->file);
> +    }
> +    qemu_rdma_cleanup(rdma);
> +
> +    if (rdma->return_path) {
> +        qemu_rdma_cleanup(rdma->return_path);
> +        g_free(rdma->return_path);
>      }
> +
> +    g_free(rdma);
>      return 0;
>  }
>  
> @@ -2956,12 +3042,21 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
>                                    size_t size, uint64_t *bytes_sent)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
>      int ret;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
>      if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        rcu_read_unlock();
>          return RAM_SAVE_CONTROL_NOT_SUPP;
>      }
>  
> @@ -3046,9 +3141,11 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
>          }
>      }
>  
> +    rcu_read_unlock();
>      return RAM_SAVE_CONTROL_DELAYED;
>  err:
>      rdma->error_state = ret;
> +    rcu_read_unlock();
>      return ret;
>  }
>  
> @@ -3224,8 +3321,8 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>      RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
>                                   .repeat = 1 };
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
> -    RDMAContext *rdma = rioc->rdma;
> -    RDMALocalBlocks *local = &rdma->local_ram_blocks;
> +    RDMAContext *rdma;
> +    RDMALocalBlocks *local;
>      RDMAControlHeader head;
>      RDMARegister *reg, *registers;
>      RDMACompress *comp;
> @@ -3238,8 +3335,17 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>      int count = 0;
>      int i = 0;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
> +    local = &rdma->local_ram_blocks;
>      do {
>          trace_qemu_rdma_registration_handle_wait();
>  
> @@ -3469,6 +3575,7 @@ out:
>      if (ret < 0) {
>          rdma->error_state = ret;
>      }
> +    rcu_read_unlock();
>      return ret;
>  }
>  
> @@ -3525,11 +3632,19 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
>                                          uint64_t flags, void *data)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
> +
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
>  
>      CHECK_ERROR_STATE();
>  
>      if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        rcu_read_unlock();
>          return 0;
>      }
>  
> @@ -3537,6 +3652,7 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
>      qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
>      qemu_fflush(f);
>  
> +    rcu_read_unlock();
>      return 0;
>  }
>  
> @@ -3549,13 +3665,21 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>  {
>      Error *local_err = NULL, **errp = &local_err;
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
>      RDMAControlHeader head = { .len = 0, .repeat = 1 };
>      int ret = 0;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdma);
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
>      if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        rcu_read_unlock();
>          return 0;
>      }
>  
> @@ -3587,6 +3711,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>                      qemu_rdma_reg_whole_ram_blocks : NULL);
>          if (ret < 0) {
>              ERROR(errp, "receiving remote info!");
> +            rcu_read_unlock();
>              return ret;
>          }
>  
> @@ -3610,6 +3735,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>                          "not identical on both the source and destination.",
>                          local->nb_blocks, nb_dest_blocks);
>              rdma->error_state = -EINVAL;
> +            rcu_read_unlock();
>              return -EINVAL;
>          }
>  
> @@ -3626,6 +3752,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>                              local->block[i].length,
>                              rdma->dest_blocks[i].length);
>                  rdma->error_state = -EINVAL;
> +                rcu_read_unlock();
>                  return -EINVAL;
>              }
>              local->block[i].remote_host_addr =
> @@ -3643,9 +3770,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>          goto err;
>      }
>  
> +    rcu_read_unlock();
>      return 0;
>  err:
>      rdma->error_state = ret;
> +    rcu_read_unlock();
>      return ret;
>  }
>  
> @@ -3707,6 +3836,7 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
>  
>      rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>      rioc->rdma = rdma;
> +    qemu_mutex_init(&rioc->lock);
>  
>      if (mode[0] == 'w') {
>          rioc->file = qemu_fopen_channel_output(QIO_CHANNEL(rioc));
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
