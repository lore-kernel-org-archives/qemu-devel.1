Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frgm5-0001Dd-A1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frgm3-0005bl-SA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:47:01 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1frgm3-0005bP-Mp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:46:59 -0400
Received: by mail-it0-x244.google.com with SMTP id d70-v6so7628772ith.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:46:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817145920.GK2459@work-vm>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-12-git-send-email-lidongchen@tencent.com>
	<20180817145920.GK2459@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 20 Aug 2018 17:46:58 +0800
Message-ID: <CAOGPPbf3hXEk76gVC0R-zFbWys1EfQqkgvyxozDCy-nEYG9PVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 11/11] migration: create a dedicated
 thread to release rdma resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Fri, Aug 17, 2018 at 10:59 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> ibv_dereg_mr wait for a long time for big memory size virtual server.
>>
>> The test result is:
>>   10GB  326ms
>>   20GB  699ms
>>   30GB  1021ms
>>   40GB  1387ms
>>   50GB  1712ms
>>   60GB  2034ms
>>   70GB  2457ms
>>   80GB  2807ms
>>   90GB  3107ms
>>   100GB 3474ms
>>   110GB 3735ms
>>   120GB 4064ms
>>   130GB 4567ms
>>   140GB 4886ms
>>
>> this will cause the guest os hang for a while when migration finished.
>> So create a dedicated thread to release rdma resource.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  migration/migration.c |  6 ++++++
>>  migration/migration.h |  3 +++
>>  migration/rdma.c      | 47 +++++++++++++++++++++++++++++++----------------
>>  3 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index f7d6e26..25d9009 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1499,6 +1499,7 @@ void migrate_init(MigrationState *s)
>>      s->vm_was_running = false;
>>      s->iteration_initial_bytes = 0;
>>      s->threshold_size = 0;
>> +    s->rdma_cleanup_thread_quit = true;
>>  }
>>
>>  static GSList *migration_blockers;
>> @@ -1660,6 +1661,10 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>          return false;
>>      }
>>
>> +    if (s->rdma_cleanup_thread_quit != true) {
>> +        return false;
>> +    }
>
> That's not good! We error out without saying anything to the user
> about why;  if we error we must always say why, otherwise we'll get
> bug reports from people without anyway to debug them.

Yes, it should give some error message.

>
> However, we also don't need to; all we need to do is turn this into
> a semaphore or similar, and then wait for it at the start of
> 'rdma_start_outgoing_migration' - that way there's no error exit, it
> just waits a few seconds and then carries on correctly.
> (Maybe we need to wait in incoming as well to cope with
> postcopy-recovery).

Yes, this should also consider postcopy-recovery case. I will fix it.
but rdma_start_outgoing_migration is invoked in the main thread, it's will a
little complex to wait.
and if it waits for a long time, it's not easy to troubleshooting.

Maybe report some error message is an easy way to fix it?
Thanks.

>
> Dave
>
>>      if (runstate_check(RUN_STATE_INMIGRATE)) {
>>          error_setg(errp, "Guest is waiting for an incoming migration");
>>          return false;
>> @@ -3213,6 +3218,7 @@ static void migration_instance_init(Object *obj)
>>
>>      ms->state = MIGRATION_STATUS_NONE;
>>      ms->mbps = -1;
>> +    ms->rdma_cleanup_thread_quit = true;
>>      qemu_sem_init(&ms->pause_sem, 0);
>>      qemu_mutex_init(&ms->error_mutex);
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 64a7b33..60138dd 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -224,6 +224,9 @@ struct MigrationState
>>       * do not trigger spurious decompression errors.
>>       */
>>      bool decompress_error_check;
>> +
>> +    /* Set this when rdma resource have released */
>> +    bool rdma_cleanup_thread_quit;
>>  };
>>
>>  void migrate_set_state(int *state, int old_state, int new_state);
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index e1498f2..3282f35 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2995,35 +2995,50 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
>>      }
>>  }
>>
>> -static int qio_channel_rdma_close(QIOChannel *ioc,
>> -                                  Error **errp)
>> +static void *qio_channel_rdma_close_thread(void *arg)
>>  {
>> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>> -    RDMAContext *rdmain, *rdmaout;
>> -    trace_qemu_rdma_close();
>> -
>> -    rdmain = rioc->rdmain;
>> -    if (rdmain) {
>> -        atomic_rcu_set(&rioc->rdmain, NULL);
>> -    }
>> +    RDMAContext **rdma = arg;
>> +    RDMAContext *rdmain = rdma[0];
>> +    RDMAContext *rdmaout = rdma[1];
>> +    MigrationState *s = migrate_get_current();
>>
>> -    rdmaout = rioc->rdmaout;
>> -    if (rdmaout) {
>> -        atomic_rcu_set(&rioc->rdmaout, NULL);
>> -    }
>> +    rcu_register_thread();
>>
>>      synchronize_rcu();
>> -
>>      if (rdmain) {
>>          qemu_rdma_cleanup(rdmain);
>>      }
>> -
>>      if (rdmaout) {
>>          qemu_rdma_cleanup(rdmaout);
>>      }
>>
>>      g_free(rdmain);
>>      g_free(rdmaout);
>> +    g_free(rdma);
>> +
>> +    rcu_unregister_thread();
>> +    s->rdma_cleanup_thread_quit = true;
>> +    return NULL;
>> +}
>> +
>> +static int qio_channel_rdma_close(QIOChannel *ioc,
>> +                                  Error **errp)
>> +{
>> +    QemuThread t;
>> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>> +    RDMAContext **rdma = g_new0(RDMAContext*, 2);
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    trace_qemu_rdma_close();
>> +    if (rioc->rdmain || rioc->rdmaout) {
>> +        rdma[0] =  rioc->rdmain;
>> +        rdma[1] =  rioc->rdmaout;
>> +        atomic_rcu_set(&rioc->rdmain, NULL);
>> +        atomic_rcu_set(&rioc->rdmaout, NULL);
>> +        s->rdma_cleanup_thread_quit = false;
>> +        qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
>> +                           rdma, QEMU_THREAD_DETACHED);
>> +    }
>>
>>      return 0;
>>  }
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
