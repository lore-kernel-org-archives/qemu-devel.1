Received: from eggs.gnu.org ([2001:4830:134:3::10]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fg1om-0003TT-1b
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fg1ok-0001Pm-Nb
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:49:36 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:43529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fg1ok-0001PT-Hb
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:49:34 -0400
Received: by mail-io0-x242.google.com with SMTP id y10-v6so6112170ioa.10
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 22:49:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOGPPbfMZRTdfiXj0ekij1bwL3JgQEF3zHGR4AKuor-MGmQGiw@mail.gmail.com>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
	<1528212489-19137-9-git-send-email-lidongchen@tencent.com>
	<20180627185952.GJ2423@work-vm>
	<CAOGPPbfMZRTdfiXj0ekij1bwL3JgQEF3zHGR4AKuor-MGmQGiw@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 19 Jul 2018 13:49:33 +0800
Message-ID: <CAOGPPbcTN55ASX64rJe3iUUNmxQJvuy22Har5Lwk7qsEVBxdow@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Aviad Yehezkel <aviadye@mellanox.com>, Gal Shachaf <galsha@mellanox.com>
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Adi Dotan <adido@mellanox.com>, Lidong Chen <lidongchen@tencent.com>

On Thu, Jul 5, 2018 at 10:26 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 2:59 AM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
>> * Lidong Chen (jemmy858585@gmail.com) wrote:
>>> ibv_dereg_mr wait for a long time for big memory size virtual server.
>>>
>>> The test result is:
>>>   10GB  326ms
>>>   20GB  699ms
>>>   30GB  1021ms
>>>   40GB  1387ms
>>>   50GB  1712ms
>>>   60GB  2034ms
>>>   70GB  2457ms
>>>   80GB  2807ms
>>>   90GB  3107ms
>>>   100GB 3474ms
>>>   110GB 3735ms
>>>   120GB 4064ms
>>>   130GB 4567ms
>>>   140GB 4886ms
>>>
>>> this will cause the guest os hang for a while when migration finished.
>>> So create a dedicated thread to release rdma resource.
>>>
>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>> ---
>>>  migration/rdma.c | 43 +++++++++++++++++++++++++++----------------
>>>  1 file changed, 27 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index dfa4f77..f12e8d5 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -2979,35 +2979,46 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
>>>      }
>>>  }
>>>
>>> -static int qio_channel_rdma_close(QIOChannel *ioc,
>>> -                                  Error **errp)
>>> +static void *qio_channel_rdma_close_thread(void *arg)
>>>  {
>>> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>>> -    RDMAContext *rdmain, *rdmaout;
>>> -    trace_qemu_rdma_close();
>>> +    RDMAContext **rdma = arg;
>>> +    RDMAContext *rdmain = rdma[0];
>>> +    RDMAContext *rdmaout = rdma[1];
>>>
>>> -    rdmain = rioc->rdmain;
>>> -    if (rdmain) {
>>> -        atomic_rcu_set(&rioc->rdmain, NULL);
>>> -    }
>>> -
>>> -    rdmaout = rioc->rdmaout;
>>> -    if (rdmaout) {
>>> -        atomic_rcu_set(&rioc->rdmaout, NULL);
>>> -    }
>>> +    rcu_register_thread();
>>>
>>>      synchronize_rcu();
>>
>> * see below
>>
>>> -
>>>      if (rdmain) {
>>>          qemu_rdma_cleanup(rdmain);
>>>      }
>>> -
>>>      if (rdmaout) {
>>>          qemu_rdma_cleanup(rdmaout);
>>>      }
>>>
>>>      g_free(rdmain);
>>>      g_free(rdmaout);
>>> +    g_free(rdma);
>>> +
>>> +    rcu_unregister_thread();
>>> +    return NULL;
>>> +}
>>> +
>>> +static int qio_channel_rdma_close(QIOChannel *ioc,
>>> +                                  Error **errp)
>>> +{
>>> +    QemuThread t;
>>> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>>> +    RDMAContext **rdma = g_new0(RDMAContext*, 2);
>>> +
>>> +    trace_qemu_rdma_close();
>>> +    if (rioc->rdmain || rioc->rdmaout) {
>>> +        rdma[0] =  rioc->rdmain;
>>> +        rdma[1] =  rioc->rdmaout;
>>> +        qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
>>> +                           rdma, QEMU_THREAD_DETACHED);
>>> +        atomic_rcu_set(&rioc->rdmain, NULL);
>>> +        atomic_rcu_set(&rioc->rdmaout, NULL);
>>
>> I'm not sure this pair is ordered with the synchronise_rcu above;
>> Doesn't that mean, on a bad day, that you could get:
>>
>>
>>     main-thread          rdma_cleanup     another-thread
>>     qmu_thread_create
>>                       synchronise_rcu
>>                                         reads rioc->rdmain
>>                                         starts doing something with rdmain
>>     atomic_rcu_set
>>                       rdma_cleanup
>>
>>
>> so the another-thread is using it during the cleanup?
>> Would just moving the atomic_rcu_sets before the qemu_thread_create
>> fix that?
> yes, I will fix it.
>
>>
>> However, I've got other worries as well:
>>    a) qemu_rdma_cleanup does:
>>        migrate_get_current()->state == MIGRATION_STATUS_CANCELLING
>>
>>       which worries me a little if someone immediately tries to restart
>>       the migration.

Because the current qemu version don't wait for
RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect,
so I think it's not necessary to send RDMA_CONTROL_ERROR.

compare to send RDMA_CONTROL_ERROR, I think use cm event to notify
peer qemu is better.
maybe the rdma is already in error_state, and RDMA_CONTROL_ERROR
cannot send successfully.

For peer qemu, in qemu_rdma_wait_comp_channel function, it's should
not only poll rdma->comp_channel->fd,
it's should also poll  rdma->channel->fd.

for the source qemu, it's fixed by this patch.
migration: poll the cm event while wait RDMA work request completion

and for destination qemu, it's need a new patch to fix it.

so I prefer to remove MIGRATION_STATUS_CANCELLING in qemu_rdma_cleanup function.

>>
>>    b) I don't understand what happens if someone does try and restart
>>       the migration after that, but in the ~5s it takes the ibv cleanup
>>       to happen.

I prefer to add a new variable in current_migration.  if the rdma
cleanup thread has not
exited. it's should not start a new migration.

>
> yes, I will try to fix it.
>
>>
>> Dave
>>
>>
>>> +    }
>>>
>>>      return 0;
>>>  }
>>> --
>>> 1.8.3.1
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
