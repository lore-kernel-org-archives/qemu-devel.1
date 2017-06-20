Received: from eggs.gnu.org ([2001:4830:134:3::10]:43250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNCCD-0008GQ-SZ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNCC9-0006Im-11
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:59:25 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dNCC8-0006IY-Rq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:59:20 -0400
Received: by mail-ua0-f174.google.com with SMTP id d45so32249029uai.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 22:59:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
	<VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 20 Jun 2017 07:59:19 +0200
Message-ID: <CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest unresponsive after Virtqueue size exceeded
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Fernando,

On Tue, Jun 20, 2017 at 12:10 AM, Fernando Casas Sch=C3=B6ssow
<casasfernando@hotmail.com> wrote:
> Hi Ladi,
>
> Today two guests failed again at different times of day.
> One of them was the one I switched from virtio_blk to virtio_scsi so this
> change didn't solved the problem.
> Now in this guest I also disabled virtio_balloon, continuing with the
> elimination process.
>
> Also this time I found a different error message in the guest console.
> In the guest already switched to virtio_scsi:
>
> virtio_scsi virtio2: request:id 44 is not a head!
>
> Followed by the usual "task blocked for more than 120 seconds." error.
>
> On the guest still running on virtio_blk the error was similar:
>
> virtio_blk virtio2: req.0:id 42 is not a head!
> blk_update_request: I/O error, dev vda, sector 645657736
> Buffer I/O error on dev dm-1, logical block 7413821, lost async page writ=
e
>
> Followed by the usual "task blocked for more than 120 seconds." error.

Honestly this is starting to look more and more like a memory
corruption. Two different virtio devices and two different guest
operating systems, that would have to be a bug in the common virtio
code and we would have seen it somewhere else already.

Would it be possible run a thorough memtest on the host just in case?

> Do you think that the blk_update_request and the buffer I/O error may be =
a
> consequence of the previous "is not a head!" error or should I be worried
> for a storage level issue here?
>
> Now I will wait to see if disabling virtio_balloon helps or not and repor=
t
> back.
>
> Thanks.
>
> Fer
>
> On vie, jun 16, 2017 at 12:25 , Ladi Prosek <lprosek@redhat.com> wrote:
>
> On Fri, Jun 16, 2017 at 12:11 PM, Fernando Casas Sch=C3=B6ssow
> <casasfernando@hotmail.com> wrote:
>
> Hi Ladi, Thanks a lot for looking into this and replying. I will do my be=
st
> to rebuild and deploy Alpine's qemu packages with this patch included but
> not sure its feasible yet. In any case, would it be possible to have this
> patch included in the next qemu release?
>
> Yes, I have already added this to my todo list.
>
> The current error message is helpful but knowing which device was involve=
d
> will be much more helpful. Regarding the environment, I'm not doing
> migrations and only managed save is done in case the host needs to be
> rebooted or shutdown. The QEMU process is running the VM since the host i=
s
> started and this failuire is ocurring randomly without any previous manag=
e
> save done. As part of troubleshooting on one of the guests I switched fro=
m
> virtio_blk to virtio_scsi for the guest disks but I will need more time t=
o
> see if that helped. If I have this problem again I will follow your advis=
e
> and remove virtio_balloon.
>
> Thanks, please keep us posted.
>
> Another question: is there any way to monitor the virtqueue size either f=
rom
> the guest itself or from the host? Any file in sysfs or proc? This may he=
lp
> to understand in which conditions this is happening and to react faster t=
o
> mitigate the problem.
>
> The problem is not in the virtqueue size but in one piece of internal sta=
te
> ("inuse") which is meant to track the number of buffers "checked out" by
> QEMU. It's being compared to virtqueue size merely as a sanity check. I'm
> afraid that there's no way to expose this variable without rebuilding QEM=
U.
> The best you could do is attach gdb to the QEMU process and use some clev=
er
> data access breakpoints to catch suspicious writes to the variable. Altho=
ugh
> it's likely that it just creeps up slowly and you won't see anything
> interesting. It's probably beyond reasonable at this point anyway. I woul=
d
> continue with the elimination process (virtio_scsi instead of virtio_blk,=
 no
> balloon, etc.) and then maybe once we know which device it is, we can add
> some instrumentation to the code.
>
> Thanks again for your help with this! Fer On vie, jun 16, 2017 at 8:58 ,
> Ladi Prosek <lprosek@redhat.com> wrote: Hi, Would you be able to enhance =
the
> error message and rebuild QEMU? --- a/hw/virtio/virtio.c +++
> b/hw/virtio/virtio.c @@ -856,7 +856,7 @@ void *virtqueue_pop(VirtQueue *v=
q,
> size_t sz) max =3D vq->vring.num; if (vq->inuse
>
> =3D vq->vring.num) { - virtio_error(vdev, "Virtqueue size exceeded"); +
>
> virtio_error(vdev, "Virtqueue %u device %s size exceeded", vq->queue_inde=
x,
> vdev->name); goto done; } This would at least confirm the theory that it'=
s
> caused by virtio-blk-pci. If rebuilding is not feasible I would start by
> removing other virtio devices -- particularly balloon which has had quite=
 a
> few virtio related bugs fixed recently. Does your environment involve VM
> migrations or saving/resuming, or does the crashing QEMU process always r=
un
> the VM from its boot? Thanks!
>
>
>
