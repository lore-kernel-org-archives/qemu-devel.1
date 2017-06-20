Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNDyE-0005la-Dv
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dNDy8-0002KU-Ci
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:53:06 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dNDy8-0002JQ-6p
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:53:00 -0400
Received: by mail-ua0-f175.google.com with SMTP id 70so7768926uau.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 00:52:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
	<VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 20 Jun 2017 09:52:57 +0200
Message-ID: <CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
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

On Tue, Jun 20, 2017 at 8:30 AM, Fernando Casas Sch=C3=B6ssow
<casasfernando@hotmail.com> wrote:
> Hi Ladi,
>
> In this case both guests are CentOS 7.3 running the same kernel
> 3.10.0-514.21.1.
> Also the guest that fails most frequently is running Docker with 4 or 5
> containers.
>
> Another thing I would like to mention is that the host is running on
> Alpine's default grsec patched kernel. I have the option to install also =
a
> vanilla kernel. Would it make sense to switch to the vanilla kernel on th=
e
> host and see if that helps?

The host kernel is less likely to be responsible for this, in my
opinion. I'd hold off on that for now.

> And last but not least KSM is enabled on the host. Should I disable it?

Could be worth the try.

> Following your advice I will run memtest on the host and report back. Jus=
t
> as a side comment, the host is running on ECC memory.

I see.

Would it be possible for you, once a guest is in the broken state, to
make it available for debugging? By attaching gdb to the QEMU process
for example and letting me poke around it remotely? Thanks!

> Thanks for all your help.
>
> Fer.
>
> On mar, jun 20, 2017 at 7:59 , Ladi Prosek <lprosek@redhat.com> wrote:
>
> Hi Fernando, On Tue, Jun 20, 2017 at 12:10 AM, Fernando Casas Sch=C3=B6ss=
ow
> <casasfernando@hotmail.com> wrote:
>
> Hi Ladi, Today two guests failed again at different times of day. One of
> them was the one I switched from virtio_blk to virtio_scsi so this change
> didn't solved the problem. Now in this guest I also disabled virtio_ballo=
on,
> continuing with the elimination process. Also this time I found a differe=
nt
> error message in the guest console. In the guest already switched to
> virtio_scsi: virtio_scsi virtio2: request:id 44 is not a head! Followed b=
y
> the usual "task blocked for more than 120 seconds." error. On the guest
> still running on virtio_blk the error was similar: virtio_blk virtio2:
> req.0:id 42 is not a head! blk_update_request: I/O error, dev vda, sector
> 645657736 Buffer I/O error on dev dm-1, logical block 7413821, lost async
> page write Followed by the usual "task blocked for more than 120 seconds.=
"
> error.
>
> Honestly this is starting to look more and more like a memory corruption.
> Two different virtio devices and two different guest operating systems, t=
hat
> would have to be a bug in the common virtio code and we would have seen i=
t
> somewhere else already. Would it be possible run a thorough memtest on th=
e
> host just in case?
>
> Do you think that the blk_update_request and the buffer I/O error may be =
a
> consequence of the previous "is not a head!" error or should I be worried
> for a storage level issue here? Now I will wait to see if disabling
> virtio_balloon helps or not and report back. Thanks. Fer On vie, jun 16,
> 2017 at 12:25 , Ladi Prosek <lprosek@redhat.com> wrote: On Fri, Jun 16, 2=
017
> at 12:11 PM, Fernando Casas Sch=C3=B6ssow <casasfernando@hotmail.com> wro=
te: Hi
> Ladi, Thanks a lot for looking into this and replying. I will do my best =
to
> rebuild and deploy Alpine's qemu packages with this patch included but no=
t
> sure its feasible yet. In any case, would it be possible to have this pat=
ch
> included in the next qemu release? Yes, I have already added this to my t=
odo
> list. The current error message is helpful but knowing which device was
> involved will be much more helpful. Regarding the environment, I'm not do=
ing
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
> and remove virtio_balloon. Thanks, please keep us posted. Another questio=
n:
> is there any way to monitor the virtqueue size either from the guest itse=
lf
> or from the host? Any file in sysfs or proc? This may help to understand =
in
> which conditions this is happening and to react faster to mitigate the
> problem. The problem is not in the virtqueue size but in one piece of
> internal state ("inuse") which is meant to track the number of buffers
> "checked out" by QEMU. It's being compared to virtqueue size merely as a
> sanity check. I'm afraid that there's no way to expose this variable with=
out
> rebuilding QEMU. The best you could do is attach gdb to the QEMU process =
and
> use some clever data access breakpoints to catch suspicious writes to the
> variable. Although it's likely that it just creeps up slowly and you won'=
t
> see anything interesting. It's probably beyond reasonable at this point
> anyway. I would continue with the elimination process (virtio_scsi instea=
d
> of virtio_blk, no balloon, etc.) and then maybe once we know which device=
 it
> is, we can add some instrumentation to the code. Thanks again for your he=
lp
> with this! Fer On vie, jun 16, 2017 at 8:58 , Ladi Prosek
> <lprosek@redhat.com> wrote: Hi, Would you be able to enhance the error
> message and rebuild QEMU? --- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio=
.c
> @@ -856,7 +856,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D
> vq->vring.num; if (vq->inuse =3D vq->vring.num) { - virtio_error(vdev,
> "Virtqueue size exceeded"); + virtio_error(vdev, "Virtqueue %u device %s
> size exceeded", vq->queue_index, vdev->name); goto done; } This would at
> least confirm the theory that it's caused by virtio-blk-pci. If rebuildin=
g
> is not feasible I would start by removing other virtio devices --
> particularly balloon which has had quite a few virtio related bugs fixed
> recently. Does your environment involve VM migrations or saving/resuming,=
 or
> does the crashing QEMU process always run the VM from its boot? Thanks!
>
>
>
