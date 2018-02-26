Received: from eggs.gnu.org ([2001:4830:134:3::10]:46243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqEQ2-00048G-Fc
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqEPz-0002HS-Cl
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eqEPz-0002HC-90
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:45:55 -0500
References: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
Date: Mon, 26 Feb 2018 09:45:37 +0100
MIME-Version: 1.0
In-Reply-To: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
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
To: Huaicheng Li <huaicheng@cs.uchicago.edu>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>

On 25/02/2018 23:52, Huaicheng Li wrote:
> I remember there were some discussions back in 2015 about this, but I
> don't see it finally done. For this project, I think we can go in three
> steps: (1). add the shadow doorbell buffer support into QEMU NVMe
> emulation, this will reduce # of VM-exits. (2). replace current timers
> used by QEMU NVMe with a separate polling thread, thus we can completel=
y
> eliminate VM-exits. (3). Even further, we can adapt the architecture to
> use one polling thread for each NVMe queue pair, thus it's possible to
> provide more performance. (step 3 can be left for next year if the
> workload is too much for 3 months).

Slightly rephrased:

(1) add shadow doorbell buffer and ioeventfd support into QEMU NVMe
emulation, which will reduce # of VM-exits and make them less expensive
(reduce VCPU latency.

(2) add iothread support to QEMU NVMe emulation.  This can also be used
to eliminate VM-exits because iothreads can do adaptive polling.

(1) and (2) seem okay for at most 1.5 months, especially if you already
have experience with QEMU.

For (3), there is work in progress to add multiqueue support to QEMU's
block device layer.  We're hoping to get the infrastructure part in
(removing the AioContext lock) during the first half of 2018.  As you
say, we can see what the workload will be.

Including a RAM disk backend in QEMU would be nice too, and it may
interest you as it would reduce the delta between upstream QEMU and
FEMU.  So this could be another idea.

However, the main issue that I'd love to see tackled is interrupt
mitigation.  With higher rates of I/O ops and high queue depth (e.g.
32), it's common for the guest to become slower when you introduce
optimizations in QEMU.  The reason is that lower latency causes higher
interrupt rates and that in turn slows down the guest.  If you have any
ideas on how to work around this, I would love to hear about it.

In any case, I would very much like to mentor this project.  Let me know
if you have any more ideas on how to extend it!

Paolo
