Received: from eggs.gnu.org ([2001:4830:134:3::10]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqd41-0005Da-1C
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqd3z-0003Tw-Rg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:04:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eqd3z-0003Tm-NJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:04:51 -0500
References: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
	<473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
	<CANr0WEc6F0_-bKgG4EMgBCpMsw7t6sx_fV=A1VXqnzDzu51Qyw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cace15b-81b7-0217-72f9-92e451f370a3@redhat.com>
Date: Tue, 27 Feb 2018 12:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <CANr0WEc6F0_-bKgG4EMgBCpMsw7t6sx_fV=A1VXqnzDzu51Qyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU GSoC 2018 Project Idea (Apply polling to QEMU
 NVMe)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Huaicheng Li <huaicheng@cs.uchicago.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>

On 27/02/2018 10:05, Huaicheng Li wrote:
>     Including a RAM disk backend in QEMU would be nice too, and it may
>     interest you as it would reduce the delta between upstream QEMU and
>     FEMU.=C2=A0 So this could be another idea.
>=20
> Glad you're also interested in this part. This can definitely be part o=
f the
> project.
>=20
>     For (3), there is work in progress to add multiqueue support to QEM=
U's
>     block device layer.=C2=A0 We're hoping to get the infrastructure pa=
rt in
>     (removing the AioContext lock) during the first half of 2018.=C2=A0=
 As you
>     say, we can see what the workload will be.
>=20
> Thanks for letting me know this. Could you provide a link to the on-goi=
ng
> multiqueue implementation? I would like to learn how this is done. :)

Well, there is no multiqueue implementation yet, but for now you can see
a lot of work in block/ regarding making drivers and BlockDriverState
thread safe.  We can't just do it for null-co:// so we have a little
preparatory work to do. :)

>     However, the main issue that I'd love to see tackled is interrupt
>     mitigation.=C2=A0 With higher rates of I/O ops and high queue depth=
 (e.g.
>     32), it's common for the guest to become slower when you introduce
>     optimizations in QEMU.=C2=A0 The reason is that lower latency cause=
s higher
>     interrupt rates and that in turn slows down the guest.=C2=A0 If you=
 have any
>     ideas on how to work around this, I would love to hear about it.
>=20
> Yeah, indeed interrupt overhead (host-to-guest notification) is a heada=
che.
> I thought about this, and one intuitive optimization in my mind is to a=
dd
> interrupt coalescing support into QEMU NVMe. We may use some heuristic =
to batch
> I/O completions back to guest, thus reducing # of interrupts. The heuri=
stic
> can be time-window based (i.e., for I/Os completed in the same time win=
dow,
> we only do one interrupt for each CQ).
>=20
> I believe there are several research papers that can achieve direct int=
errupt
> delivery without exits for para-virtual devices, but those need KVM sid=
e
> modifications. It might be not a good fit here.=C2=A0=C2=A0

No, indeed.  But the RAM disk backend and interrupt coalescing (for
either NVMe or virtio-blk... or maybe a generic scheme that can be
reused by virtio-net and others too!) is a good idea for the third part
of the project.

>     In any case, I would very much like to mentor this project.=C2=A0 L=
et me know
>     if you have any more ideas on how to extend it!
>=20
>=20
> Great to know that you'd like to mentor the project! If so, can we make=
 it
> an official project idea and put it on QEMU GSoC page?

Submissions need not come from the QEMU GSoC page.  You are free to
submit any idea that you think can be worthwhile.

Paolo
