Received: from eggs.gnu.org ([2001:4830:134:3::10]:46940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hl3-0000NT-32
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hkz-0006Sh-SY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2hkz-0006SL-Jh
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:26:37 -0400
Date: Mon, 24 Apr 2017 18:26:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424172630.GO2362@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p28f240a4e6c78fb56be52f2641c3e5af6@eucas1p2.samsung.com>
	<1492175840-5021-6-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492175840-5021-6-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: send postcopy downtime back
 to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Right now to initiate postcopy live migration need to
> send request to source machine and specify destination.
> 
> User could request migration status by query-migrate qmp command on
> source machine, but postcopy downtime is being evaluated on destination,
> so it should be transmitted back to source. For this purpose return path
> socket was shosen.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

That will break a migration from an older QEMU to a newer QEMU with this feature
since the old QEMU won't know the message type and fail with a
  'Received invalid message'

near the start of source_return_path_thread.

The simpler solution is to let the stat be read on the destination side
and not bother sending it backwards over the wire.

Dave

> ---
>  include/migration/migration.h |  4 +++-
>  migration/migration.c         | 20 ++++++++++++++++++--
>  migration/postcopy-ram.c      |  1 +
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 5d2c628..5535aa6 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -55,7 +55,8 @@ enum mig_rp_message_type {
>  
>      MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
>      MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
> -
> +    MIG_RP_MSG_DOWNTIME,    /* downtime value from destination,
> +                               calculated and sent in case of post copy */
>      MIG_RP_MSG_MAX
>  };
>  
> @@ -364,6 +365,7 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
>  void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
> +void migrate_send_rp_downtime(MigrationIncomingState *mis, uint64_t downtime);
>  
>  void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
>  void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
> diff --git a/migration/migration.c b/migration/migration.c
> index 5bac434..3134e24 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -553,6 +553,19 @@ void migrate_send_rp_message(MigrationIncomingState *mis,
>  }
>  
>  /*
> + * Send postcopy migration downtime,
> + * at the moment of calling this function migration should
> + * be completed.
> + */
> +void migrate_send_rp_downtime(MigrationIncomingState *mis, uint64_t downtime)
> +{
> +    uint64_t buf;
> +
> +    buf = cpu_to_be64(downtime);
> +    migrate_send_rp_message(mis, MIG_RP_MSG_DOWNTIME, sizeof(downtime), &buf);
> +}
> +
> +/*
>   * Send a 'SHUT' message on the return channel with the given value
>   * to indicate that we've finished with the RP.  Non-0 value indicates
>   * error.
> @@ -1483,6 +1496,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_PONG]           = { .len =  4, .name = "PONG" },
>      [MIG_RP_MSG_REQ_PAGES]      = { .len = 12, .name = "REQ_PAGES" },
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
> +    [MIG_RP_MSG_DOWNTIME]       = { .len =  8, .name = "DOWNTIME" },
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1613,6 +1627,10 @@ static void *source_return_path_thread(void *opaque)
>              migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len);
>              break;
>  
> +        case MIG_RP_MSG_DOWNTIME:
> +            ms->downtime = ldq_be_p(buf);
> +            break;
> +
>          default:
>              break;
>          }
> @@ -1677,7 +1695,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>      int ret;
>      QIOChannelBuffer *bioc;
>      QEMUFile *fb;
> -    int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      bool restart_block = false;
>      migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_POSTCOPY_ACTIVE);
> @@ -1779,7 +1796,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>       */
>      ms->postcopy_after_devices = true;
>      notifier_list_notify(&migration_state_notifiers, ms);
> -    ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
>  
>      qemu_mutex_unlock_iothread();
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index ea89f4e..42330fd 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -330,6 +330,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>      }
>  
>      postcopy_state_set(POSTCOPY_INCOMING_END);
> +    migrate_send_rp_downtime(mis, get_postcopy_total_downtime());
>      migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
>  
>      if (mis->postcopy_tmp_page) {
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
