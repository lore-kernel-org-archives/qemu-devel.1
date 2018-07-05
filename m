Received: from eggs.gnu.org ([2001:4830:134:3::10]:60382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fb5Dh-0003Vd-UA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fb5Db-0000MB-TV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:26:53 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:40755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fb5Db-0000IF-OQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:26:47 -0400
Received: by mail-it0-x244.google.com with SMTP id 188-v6so12593927ita.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 07:26:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627185952.GJ2423@work-vm>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
	<1528212489-19137-9-git-send-email-lidongchen@tencent.com>
	<20180627185952.GJ2423@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 5 Jul 2018 22:26:46 +0800
Message-ID: <CAOGPPbfMZRTdfiXj0ekij1bwL3JgQEF3zHGR4AKuor-MGmQGiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 08/10] migration: create a dedicated
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
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Aviad Yehezkel <aviadye@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Adi Dotan <adido@mellanox.com>, Gal Shachaf <galsha@mellanox.com>, Lidong Chen <lidongchen@tencent.com>

On Thu, Jun 28, 2018 at 2:59 AM, Dr. David Alan Gilbert
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
>>  migration/rdma.c | 43 +++++++++++++++++++++++++++----------------
>>  1 file changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index dfa4f77..f12e8d5 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2979,35 +2979,46 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
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
>> +    RDMAContext **rdma = arg;
>> +    RDMAContext *rdmain = rdma[0];
>> +    RDMAContext *rdmaout = rdma[1];
>>
>> -    rdmain = rioc->rdmain;
>> -    if (rdmain) {
>> -        atomic_rcu_set(&rioc->rdmain, NULL);
>> -    }
>> -
>> -    rdmaout = rioc->rdmaout;
>> -    if (rdmaout) {
>> -        atomic_rcu_set(&rioc->rdmaout, NULL);
>> -    }
>> +    rcu_register_thread();
>>
>>      synchronize_rcu();
>
> * see below
>
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
>> +    return NULL;
>> +}
>> +
>> +static int qio_channel_rdma_close(QIOChannel *ioc,
>> +                                  Error **errp)
>> +{
>> +    QemuThread t;
>> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>> +    RDMAContext **rdma = g_new0(RDMAContext*, 2);
>> +
>> +    trace_qemu_rdma_close();
>> +    if (rioc->rdmain || rioc->rdmaout) {
>> +        rdma[0] =  rioc->rdmain;
>> +        rdma[1] =  rioc->rdmaout;
>> +        qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
>> +                           rdma, QEMU_THREAD_DETACHED);
>> +        atomic_rcu_set(&rioc->rdmain, NULL);
>> +        atomic_rcu_set(&rioc->rdmaout, NULL);
>
> I'm not sure this pair is ordered with the synchronise_rcu above;
> Doesn't that mean, on a bad day, that you could get:
>
>
>     main-thread          rdma_cleanup     another-thread
>     qmu_thread_create
>                       synchronise_rcu
>                                         reads rioc->rdmain
>                                         starts doing something with rdmain
>     atomic_rcu_set
>                       rdma_cleanup
>
>
> so the another-thread is using it during the cleanup?
> Would just moving the atomic_rcu_sets before the qemu_thread_create
> fix that?
yes, I will fix it.

>
> However, I've got other worries as well:
>    a) qemu_rdma_cleanup does:
>        migrate_get_current()->state == MIGRATION_STATUS_CANCELLING
>
>       which worries me a little if someone immediately tries to restart
>       the migration.
>
>    b) I don't understand what happens if someone does try and restart
>       the migration after that, but in the ~5s it takes the ibv cleanup
>       to happen.

yes, I will try to fix it.

>
> Dave
>
>
>> +    }
>>
>>      return 0;
>>  }
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
