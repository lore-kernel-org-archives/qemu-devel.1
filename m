Received: from eggs.gnu.org ([2001:4830:134:3::10]:35584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fTIDJ-0005zf-0x
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fTIDH-0005VZ-Pl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:42:17 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:43962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fTIDH-0005V6-Js
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:42:15 -0400
Received: by mail-io0-x241.google.com with SMTP id t6-v6so5614449iob.10
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 19:42:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180613142443.GF2676@work-vm>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
	<1528212489-19137-10-git-send-email-lidongchen@tencent.com>
	<20180613142443.GF2676@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 14 Jun 2018 10:42:14 +0800
Message-ID: <CAOGPPbezWh-1axOujSRONXKOSy27ihmCteU8bBCeVGvXiLhbEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 09/10] migration: poll the cm event
 while wait RDMA work request completion
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

On Wed, Jun 13, 2018 at 10:24 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
>> maybe loop forever. so we should also poll the cm event fd, and when
>> receive RDMA_CM_EVENT_DISCONNECTED and RDMA_CM_EVENT_DEVICE_REMOVAL,
>> we consider some error happened.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> Was there a reply which explained/pointed to docs for cm_event?

https://linux.die.net/man/3/rdma_get_cm_event

> Or a Review-by from one of the Infiniband people would be fine.

yes, I should add Gal Shachaf <galsha@mellanox.com>,Aviad Yehezkel
<aviadye@mellanox.com>
we are working together on RDMA live migration.

Thanks.

>
> Dave
>
>> ---
>>  migration/rdma.c | 33 ++++++++++++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index f12e8d5..bb6989e 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1489,6 +1489,9 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
>>   */
>>  static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>>  {
>> +    struct rdma_cm_event *cm_event;
>> +    int ret = -1;
>> +
>>      /*
>>       * Coroutine doesn't start until migration_fd_process_incoming()
>>       * so don't yield unless we know we're running inside of a coroutine.
>> @@ -1505,13 +1508,37 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>>           * without hanging forever.
>>           */
>>          while (!rdma->error_state  && !rdma->received_error) {
>> -            GPollFD pfds[1];
>> +            GPollFD pfds[2];
>>              pfds[0].fd = rdma->comp_channel->fd;
>>              pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
>> +            pfds[0].revents = 0;
>> +
>> +            pfds[1].fd = rdma->channel->fd;
>> +            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
>> +            pfds[1].revents = 0;
>> +
>>              /* 0.1s timeout, should be fine for a 'cancel' */
>> -            switch (qemu_poll_ns(pfds, 1, 100 * 1000 * 1000)) {
>> +            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
>> +            case 2:
>>              case 1: /* fd active */
>> -                return 0;
>> +                if (pfds[0].revents) {
>> +                    return 0;
>> +                }
>> +
>> +                if (pfds[1].revents) {
>> +                    ret = rdma_get_cm_event(rdma->channel, &cm_event);
>> +                    if (!ret) {
>> +                        rdma_ack_cm_event(cm_event);
>> +                    }
>> +
>> +                    error_report("receive cm event while wait comp channel,"
>> +                                 "cm event is %d", cm_event->event);
>> +                    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
>> +                        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
>> +                        return -EPIPE;
>> +                    }
>> +                }
>> +                break;
>>
>>              case 0: /* Timeout, go around again */
>>                  break;
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
