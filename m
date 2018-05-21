Received: from eggs.gnu.org ([2001:4830:134:3::10]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fKjJS-00045f-Tz
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fKjJS-00049j-7P
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:49:15 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:39757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fKjJS-00049a-1X
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:49:14 -0400
Received: by mail-it0-x243.google.com with SMTP id c3-v6so20736981itj.4
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 04:49:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOGPPbeVvm5OM+oNpYfYiAsNTK7bn7eFDgzyMuvm8YymM2sq_w@mail.gmail.com>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
	<1525530936-21835-6-git-send-email-lidongchen@tencent.com>
	<379b3f13-f53f-966b-ccbf-66517d45aa9d@redhat.com>
	<CAOGPPbeVvm5OM+oNpYfYiAsNTK7bn7eFDgzyMuvm8YymM2sq_w@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 21 May 2018 19:49:12 +0800
Message-ID: <CAOGPPbdx1EPXFUibshPG+ZfgJ38ALpX4xBi2fk2LqkaLjbA6Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/6] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, Adi Dotan <adido@mellanox.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Wed, May 16, 2018 at 5:36 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Tue, May 15, 2018 at 10:54 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 05/05/2018 16:35, Lidong Chen wrote:
>>> @@ -2635,12 +2637,20 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>>>  {
>>>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>>>      QEMUFile *f = rioc->file;
>>> -    RDMAContext *rdma = rioc->rdma;
>>> +    RDMAContext *rdma;
>>>      int ret;
>>>      ssize_t done = 0;
>>>      size_t i;
>>>      size_t len = 0;
>>>
>>> +    rcu_read_lock();
>>> +    rdma = atomic_rcu_read(&rioc->rdmaout);
>>> +
>>> +    if (!rdma) {
>>> +        rcu_read_unlock();
>>> +        return -EIO;
>>> +    }
>>> +
>>>      CHECK_ERROR_STATE();
>>>
>>>      /*
>>
>> I am not sure I understand this.  It would probably be wrong to use the
>> output side from two threads at the same time, so why not use two mutexes?
>
> Two thread will not invoke qio_channel_rdma_writev at the same time.
> The source qemu, migration thread only use writev, and the return path
> thread only
> use readv.
> The destination qemu already have a mutex mis->rp_mutex to make sure
> not use writev
> at the same time.
>
> The rcu_read_lock is used to protect not use RDMAContext when another
> thread closes it.

Any suggestion?

>
>>
>> Also, who is calling qio_channel_rdma_close in such a way that another
>> thread is still using it?  Would it be possible to synchronize with the
>> other thread *before*, for example with qemu_thread_join?
>
> The MigrationState structure includes to_dst_file and from_dst_file
> QEMUFile, the two QEMUFile use the same QIOChannel.
> For example, if the return path thread call
> qemu_fclose(ms->rp_state.from_dst_file),
> It will also close the RDMAContext for ms->to_dst_file.
>
> For live migration, the source qemu invokes qemu_fclose in different
> threads include main thread, migration thread, return path thread.
>
> The destination qemu invokes qemu_fclose in main thread, listen thread and
> COLO incoming thread.
>
> I do not find an effective way to synchronize these threads.
>
> Thanks.
>
>>
>> Thanks,
>>
>> Paolo
