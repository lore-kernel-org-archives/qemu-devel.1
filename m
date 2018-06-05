Received: from eggs.gnu.org ([2001:4830:134:3::10]:42636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQCue-0002zX-Mb
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQCud-0006r8-8v
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:26:16 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:35908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fQCud-0006q0-1T
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:26:15 -0400
Received: by mail-it0-x22a.google.com with SMTP id e20-v6so3599302itc.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:26:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c7a6c24d-4699-cfb1-b097-93f62060e36d@dev.mellanox.co.il>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
	<1527673416-31268-12-git-send-email-lidongchen@tencent.com>
	<20180530173325.GG2410@work-vm>
	<CAOGPPbe=8AOX0S8vBAOmkV_vnb4A0EV_amUif8Qig0PuJQCwFg@mail.gmail.com>
	<c7a6c24d-4699-cfb1-b097-93f62060e36d@dev.mellanox.co.il>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 5 Jun 2018 22:26:13 +0800
Message-ID: <CAOGPPbd-iH09A0yOquW7ZC3kh1PzvgbG3YxVke+nXEarOaQHOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/12] migration: poll the cm event
 while wait RDMA work request completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gal Shachaf <galsha@mellanox.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>, Adi Dotan <adido@mellanox.com>, zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Lidong Chen <lidongchen@tencent.com>, Aviad Yehezkel <aviadye@dev.mellanox.co.il>

On Sun, Jun 3, 2018 at 11:04 PM, Aviad Yehezkel
<aviadye@dev.mellanox.co.il> wrote:
> +Gal
>
> Gal, please comment with our findings.

some suggestion from Gal:
1.Regarding the GIOConditions for the FPollFD.events/revents:
G_IO_IN is enough for cm_channel =E2=80=93 if it is not empty, it will retu=
rn
POLLIN | POLLRDNORM, but you can also use G_IO_HUP | G_IO_ERR just to
be safe.
2.Please note that you are not currently checking for error return
values on qemu_poll_ns, rdma_get_cm_event and rdma_ack_cm_event.
3.should consider checking for specific RDMA_CM_EVENT types:
RDMA_CM_EVENT_DISCONNECTED, RDMA_CM_EVENT_DEVICE_REMOVAL.for example,
receiving RDMA_CM_EVENT_ADDR_CHANGE should not result in error
4.it is better to first poll the CQ, and only if it has no new CQEs
poll the eventsQ. This way, you will not go into error even if you=E2=80=99=
ve
got a CQE.

I will send new version patch.

>
> Thanks!
>
>
> On 5/31/2018 10:36 AM, 858585 jemmy wrote:
>>
>> On Thu, May 31, 2018 at 1:33 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>>>
>>> * Lidong Chen (jemmy858585@gmail.com) wrote:
>>>>
>>>> If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
>>>> maybe loop forever. so we should also poll the cm event fd, and when
>>>> receive any cm event, we consider some error happened.
>>>>
>>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>>
>>> I don't understand enough about the way the infiniband fd's work to
>>> fully review this; so I'd appreciate if some one who does could
>>> comment/add their review.
>>
>> Hi Avaid:
>>      we need your help. I also not find any document about the cq
>> channel event fd and
>> cm channel event f.
>>      Should we set the events to G_IO_IN | G_IO_HUP | G_IO_ERR? or
>> G_IO_IN is enough?
>>      pfds[0].events =3D G_IO_IN | G_IO_HUP | G_IO_ERR;
>>      pfds[1].events =3D G_IO_IN | G_IO_HUP | G_IO_ERR;
>>      Thanks.
>>
>>>> ---
>>>>   migration/rdma.c | 35 ++++++++++++++++++++++++-----------
>>>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>>> index 1b9e261..d611a06 100644
>>>> --- a/migration/rdma.c
>>>> +++ b/migration/rdma.c
>>>> @@ -1489,6 +1489,9 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma=
,
>>>> uint64_t *wr_id_out,
>>>>    */
>>>>   static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>>>>   {
>>>> +    struct rdma_cm_event *cm_event;
>>>> +    int ret =3D -1;
>>>> +
>>>>       /*
>>>>        * Coroutine doesn't start until migration_fd_process_incoming()
>>>>        * so don't yield unless we know we're running inside of a
>>>> coroutine.
>>>> @@ -1504,25 +1507,35 @@ static int
>>>> qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>>>>            * But we need to be able to handle 'cancel' or an error
>>>>            * without hanging forever.
>>>>            */
>>>> -        while (!rdma->error_state  && !rdma->received_error) {
>>>> -            GPollFD pfds[1];
>>>> +        while (!rdma->error_state && !rdma->received_error) {
>>>> +            GPollFD pfds[2];
>>>>               pfds[0].fd =3D rdma->comp_channel->fd;
>>>>               pfds[0].events =3D G_IO_IN | G_IO_HUP | G_IO_ERR;
>>>> +            pfds[0].revents =3D 0;
>>>> +
>>>> +            pfds[1].fd =3D rdma->channel->fd;
>>>> +            pfds[1].events =3D G_IO_IN | G_IO_HUP | G_IO_ERR;
>>>> +            pfds[1].revents =3D 0;
>>>> +
>>>>               /* 0.1s timeout, should be fine for a 'cancel' */
>>>> -            switch (qemu_poll_ns(pfds, 1, 100 * 1000 * 1000)) {
>>>> -            case 1: /* fd active */
>>>> -                return 0;
>>>> +            qemu_poll_ns(pfds, 2, 100 * 1000 * 1000);
>>>
>>> Shouldn't we still check the return value of this; if it's negative
>>> something has gone wrong.
>>
>> I will fix this.
>> Thanks.
>>
>>> Dave
>>>
>>>> -            case 0: /* Timeout, go around again */
>>>> -                break;
>>>> +            if (pfds[1].revents) {
>>>> +                ret =3D rdma_get_cm_event(rdma->channel, &cm_event);
>>>> +                if (!ret) {
>>>> +                    rdma_ack_cm_event(cm_event);
>>>> +                }
>>>> +                error_report("receive cm event while wait comp
>>>> channel,"
>>>> +                             "cm event is %d", cm_event->event);
>>>>
>>>> -            default: /* Error of some type -
>>>> -                      * I don't trust errno from qemu_poll_ns
>>>> -                     */
>>>> -                error_report("%s: poll failed", __func__);
>>>> +                /* consider any rdma communication event as an error =
*/
>>>>                   return -EPIPE;
>>>>               }
>>>>
>>>> +            if (pfds[0].revents) {
>>>> +                return 0;
>>>> +            }
>>>> +
>>>>               if (migrate_get_current()->state =3D=3D
>>>> MIGRATION_STATUS_CANCELLING) {
>>>>                   /* Bail out and let the cancellation happen */
>>>>                   return -EPIPE;
>>>> --
>>>> 1.8.3.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
