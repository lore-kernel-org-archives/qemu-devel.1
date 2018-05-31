Received: from eggs.gnu.org ([2001:4830:134:3::10]:59747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fOHxL-0003hc-1D
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fOHxK-0004wS-4B
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:25:07 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fOHxJ-0004w2-Ts
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:25:06 -0400
Received: by mail-io0-x242.google.com with SMTP id l19-v6so14909396ioj.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 00:25:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530165038.GF2410@work-vm>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
	<1527673416-31268-11-git-send-email-lidongchen@tencent.com>
	<20180530165038.GF2410@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 31 May 2018 15:25:04 +0800
Message-ID: <CAOGPPbfES1YDge-jUOkF0EvporeJvz=hu1qrtyXiiVE-8=ArnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 10/12] migration: create a dedicated
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
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Aviad Yehezkel <aviadye@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Adi Dotan <adido@mellanox.com>, Lidong Chen <lidongchen@tencent.com>

On Thu, May 31, 2018 at 12:50 AM, Dr. David Alan Gilbert
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
>>  migration/rdma.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index dfa4f77..1b9e261 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2979,12 +2979,12 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
>>      }
>>  }
>>
>> -static int qio_channel_rdma_close(QIOChannel *ioc,
>> -                                  Error **errp)
>> +static void *qio_channel_rdma_close_thread(void *arg)
>>  {
>> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>> +    QIOChannelRDMA *rioc = arg;
>>      RDMAContext *rdmain, *rdmaout;
>> -    trace_qemu_rdma_close();
>> +
>> +    rcu_register_thread();
>>
>>      rdmain = rioc->rdmain;
>>      if (rdmain) {
>> @@ -3009,6 +3009,19 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
>>      g_free(rdmain);
>>      g_free(rdmaout);
>>
>> +    rcu_unregister_thread();
>> +    return NULL;
>> +}
>> +
>> +static int qio_channel_rdma_close(QIOChannel *ioc,
>> +                                  Error **errp)
>> +{
>> +    QemuThread t;
>> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>> +    trace_qemu_rdma_close();
>> +
>> +    qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
>> +                           rioc, QEMU_THREAD_DETACHED);
>
> I don't think this can be this simple; consider the lock in patch 4;
> now that lock means qui_channel_rdma_close() can't be called in
> parallel; but with this change it means:
>
>
>      f->lock
>        qemu_thread_create  (1)
>     !f->lock
>      f->lock
>        qemu_thread_create
>     !f->lock
>
> so we don't really protect the thing you were trying to lock

yes, I should not use rioc as the thread arg.

static int qio_channel_rdma_close(QIOChannel *ioc,
                                  Error **errp)
{
    QemuThread t;
    RDMAContext *rdma[2];
    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);

    trace_qemu_rdma_close();
    if (rioc->rdmain || rioc->rdmaout) {
        rdma[0] =  rioc->rdmain;
        rdma[1] =  rioc->rdmaout;
        qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
                           rdma, QEMU_THREAD_DETACHED);
        rioc->rdmain = NULL;
        rioc->rdmaout = NULL;
    }
    return 0;
}

>
> Dave
>
>>      return 0;
>>  }
>>
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
