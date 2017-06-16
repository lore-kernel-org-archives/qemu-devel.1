Received: from eggs.gnu.org ([2001:4830:134:3::10]:36847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dLoRe-0003hG-Du
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dLoRb-0006d7-9U
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:25:38 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dLoRb-0006cf-53
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:25:35 -0400
Received: by mail-ua0-f180.google.com with SMTP id g40so23122894uaa.3
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 03:25:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
	<VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 16 Jun 2017 12:25:33 +0200
Message-ID: <CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
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

On Fri, Jun 16, 2017 at 12:11 PM, Fernando Casas Sch=C3=B6ssow
<casasfernando@hotmail.com> wrote:
> Hi Ladi,
>
> Thanks a lot for looking into this and replying.
> I will do my best to rebuild and deploy Alpine's qemu packages with this
> patch included but not sure its feasible yet.
> In any case, would it be possible to have this patch included in the next
> qemu release?

Yes, I have already added this to my todo list.

> The current error message is helpful but knowing which device was involve=
d
> will be much more helpful.
>
> Regarding the environment, I'm not doing migrations and only managed save=
 is
> done in case the host needs to be rebooted or shutdown. The QEMU process =
is
> running the VM since the host is started and this failuire is ocurring
> randomly without any previous manage save done.
>
> As part of troubleshooting on one of the guests I switched from virtio_bl=
k
> to virtio_scsi for the guest disks but I will need more time to see if th=
at
> helped.
> If I have this problem again I will follow your advise and remove
> virtio_balloon.

Thanks, please keep us posted.

> Another question: is there any way to monitor the virtqueue size either f=
rom
> the guest itself or from the host? Any file in sysfs or proc?
> This may help to understand in which conditions this is happening and to
> react faster to mitigate the problem.

The problem is not in the virtqueue size but in one piece of internal
state ("inuse") which is meant to track the number of buffers "checked
out" by QEMU. It's being compared to virtqueue size merely as a sanity
check.

I'm afraid that there's no way to expose this variable without
rebuilding QEMU. The best you could do is attach gdb to the QEMU
process and use some clever data access breakpoints to catch
suspicious writes to the variable. Although it's likely that it just
creeps up slowly and you won't see anything interesting. It's probably
beyond reasonable at this point anyway.

I would continue with the elimination process (virtio_scsi instead of
virtio_blk, no balloon, etc.) and then maybe once we know which device
it is, we can add some instrumentation to the code.

> Thanks again for your help with this!
>
> Fer
>
> On vie, jun 16, 2017 at 8:58 , Ladi Prosek <lprosek@redhat.com> wrote:
>
> Hi,
>
> Would you be able to enhance the error message and rebuild QEMU? ---
> a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -856,7 +856,7 @@ void
> *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D vq->vring.num; if (vq->i=
nuse
>>=3D vq->vring.num) { - virtio_error(vdev, "Virtqueue size exceeded"); +
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
