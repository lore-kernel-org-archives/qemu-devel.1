Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frg73-00022K-NS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frg72-0005RI-WB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:04:37 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:53977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1frg72-0005R9-Qm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:04:36 -0400
Received: by mail-it0-x241.google.com with SMTP id 72-v6so19604687itw.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:04:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817140434.GJ2459@work-vm>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-11-git-send-email-lidongchen@tencent.com>
	<20180817140434.GJ2459@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 20 Aug 2018 17:04:35 +0800
Message-ID: <CAOGPPbd4Cx5v-wiVT+Ebc_MhHbn+z3tF-mOHZyOciYWxwmjAjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 10/11] migration: remove the unnecessary
 RDMA_CONTROL_ERROR message
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

On Fri, Aug 17, 2018 at 10:04 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> It's not necessary to send RDMA_CONTROL_ERROR when clean up rdma resource.
>> If rdma->error_state is ture, the message may not send successfully.
>> and the cm event can also notify the peer qemu.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> How does this keep 'cancel' working; I added 32bce196344 last year to
> make that code also send the RDMA_CONTROL_ERROR in 'cancelling'.

I guess send the RDMA_CONTROL_ERROR is to notify peer qemu close rdma
connection,
 and to make sure the receive rdma_disconnect event.

But the two sides qemu should cleanup rdma independently. maybe the
destination qemu is hang.

1.the current qemu version already not wait for
RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect,

2.for peer qemu, it's already poll rdma->channel->fd, compare to send
RDMA_CONTROL_ERROR, maybe use cm event
to notify peer qemu to quit is better. maybe the rdma is already in
error_state, and RDMA_CONTROL_ERROR
cannot send successfully. when cancel migraiton, the destination will
receive RDMA_CM_EVENT_DISCONNECTED.

3. I prefer use RDMA_CONTROL_ERROR to notify some code logic error,
not rdma connection error.

>
> Dave
>
>> ---
>>  migration/rdma.c | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index ae07515..e1498f2 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -2305,17 +2305,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>>      int idx;
>>
>>      if (rdma->cm_id && rdma->connected) {
>> -        if ((rdma->error_state ||
>> -             migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
>> -            !rdma->received_error) {
>> -            RDMAControlHeader head = { .len = 0,
>> -                                       .type = RDMA_CONTROL_ERROR,
>> -                                       .repeat = 1,
>> -                                     };
>> -            error_report("Early error. Sending error.");
>> -            qemu_rdma_post_send_control(rdma, NULL, &head);
>> -        }
>> -
>>          rdma_disconnect(rdma->cm_id);
>>          trace_qemu_rdma_cleanup_disconnect();
>>          rdma->connected = false;
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
