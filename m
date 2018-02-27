Received: from eggs.gnu.org ([2001:4830:134:3::10]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eqbDi-000252-18
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eqbDb-0005ws-0W
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:06:46 -0500
Received: from mx.cs.uchicago.edu ([128.135.164.214]:55824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1eqbDa-0005wO-NI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:06:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id C2BD360449
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 03:06:37 -0600 (CST)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id t98eSiGW4Yf9 for <qemu-devel@nongnu.org>;
	Tue, 27 Feb 2018 03:06:36 -0600 (CST)
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
	[209.85.213.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id 989C8602BA
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 03:06:36 -0600 (CST)
Received: by mail-vk0-f52.google.com with SMTP id k187so11692850vke.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 01:06:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
References: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
	<473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Tue, 27 Feb 2018 03:05:55 -0600
Message-ID: <CANr0WEc6F0_-bKgG4EMgBCpMsw7t6sx_fV=A1VXqnzDzu51Qyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>

Hi Paolo,

Slightly rephrased:
> (1) add shadow doorbell buffer and ioeventfd support into QEMU NVMe
> emulation, which will reduce # of VM-exits and make them less expensive
> (reduce VCPU latency.
> (2) add iothread support to QEMU NVMe emulation.  This can also be used
> to eliminate VM-exits because iothreads can do adaptive polling.
> (1) and (2) seem okay for at most 1.5 months, especially if you already
> have experience with QEMU.


Thanks a lot for rephrasing it to make it more clear.

Yes, I think (1)(2) should be achievable in 1-1.5month. What needs to be
added based on FEMU includes: ioeventfd support to QEMU NVMe, and
use iothread for polling (current FEMU implementation uses a periodic
timer to poll shadow buffer directly, moving to iothread would deliver
better
performance).

Including a RAM disk backend in QEMU would be nice too, and it may
> interest you as it would reduce the delta between upstream QEMU and
> FEMU.  So this could be another idea.


Glad you're also interested in this part. This can definitely be part of the
project.

For (3), there is work in progress to add multiqueue support to QEMU's
> block device layer.  We're hoping to get the infrastructure part in
> (removing the AioContext lock) during the first half of 2018.  As you
> say, we can see what the workload will be.


Thanks for letting me know this. Could you provide a link to the on-going
multiqueue implementation? I would like to learn how this is done. :)

However, the main issue that I'd love to see tackled is interrupt
> mitigation.  With higher rates of I/O ops and high queue depth (e.g.
> 32), it's common for the guest to become slower when you introduce
> optimizations in QEMU.  The reason is that lower latency causes higher
> interrupt rates and that in turn slows down the guest.  If you have any
> ideas on how to work around this, I would love to hear about it.


Yeah, indeed interrupt overhead (host-to-guest notification) is a headache.
I thought about this, and one intuitive optimization in my mind is to add
interrupt
coalescing support into QEMU NVMe. We may use some heuristic to batch
I/O completions back to guest, thus reducing # of interrupts. The heuristic
can be time-window based (i.e., for I/Os completed in the same time window,
we only do one interrupt for each CQ).

I believe there are several research papers that can achieve direct
interrupt
delivery without exits for para-virtual devices, but those need KVM side
modifications. It might be not a good fit here.


In any case, I would very much like to mentor this project.  Let me know
> if you have any more ideas on how to extend it!


Great to know that you'd like to mentor the project! If so, can we make it
an official project idea and put it on QEMU GSoC page?

Thank you so much for the feedbacks and agreeing to be a potential mentor
for this
project. I'm happy to see that you also think this is something that's worth
putting efforts into.

Best,
Huaicheng

On Mon, Feb 26, 2018 at 2:45 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 25/02/2018 23:52, Huaicheng Li wrote:
> > I remember there were some discussions back in 2015 about this, but I
> > don't see it finally done. For this project, I think we can go in three
> > steps: (1). add the shadow doorbell buffer support into QEMU NVMe
> > emulation, this will reduce # of VM-exits. (2). replace current timers
> > used by QEMU NVMe with a separate polling thread, thus we can completely
> > eliminate VM-exits. (3). Even further, we can adapt the architecture to
> > use one polling thread for each NVMe queue pair, thus it's possible to
> > provide more performance. (step 3 can be left for next year if the
> > workload is too much for 3 months).
>
> Slightly rephrased:
>
> (1) add shadow doorbell buffer and ioeventfd support into QEMU NVMe
> emulation, which will reduce # of VM-exits and make them less expensive
> (reduce VCPU latency.
>
> (2) add iothread support to QEMU NVMe emulation.  This can also be used
> to eliminate VM-exits because iothreads can do adaptive polling.
>
> (1) and (2) seem okay for at most 1.5 months, especially if you already
> have experience with QEMU.
>
> For (3), there is work in progress to add multiqueue support to QEMU's
> block device layer.  We're hoping to get the infrastructure part in
> (removing the AioContext lock) during the first half of 2018.  As you
> say, we can see what the workload will be.
>
> Including a RAM disk backend in QEMU would be nice too, and it may
> interest you as it would reduce the delta between upstream QEMU and
> FEMU.  So this could be another idea.
>
> However, the main issue that I'd love to see tackled is interrupt
> mitigation.  With higher rates of I/O ops and high queue depth (e.g.
> 32), it's common for the guest to become slower when you introduce
> optimizations in QEMU.  The reason is that lower latency causes higher
> interrupt rates and that in turn slows down the guest.  If you have any
> ideas on how to work around this, I would love to hear about it.
>
> In any case, I would very much like to mentor this project.  Let me know
> if you have any more ideas on how to extend it!
>
> Paolo
>
