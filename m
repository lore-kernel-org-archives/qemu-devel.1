Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eqgNA-0001qm-2P
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1eqgN4-000776-Ua
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:52 -0500
Received: from mx.cs.uchicago.edu ([128.135.164.214]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1eqgN4-00076Q-K9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id BF84760626
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:36:44 -0600 (CST)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JbONjMuIQgzi for <qemu-devel@nongnu.org>;
	Tue, 27 Feb 2018 08:36:44 -0600 (CST)
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
	[209.85.213.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id DA28260449
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:36:43 -0600 (CST)
Received: by mail-vk0-f44.google.com with SMTP id t201so12268400vke.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:36:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1cace15b-81b7-0217-72f9-92e451f370a3@redhat.com>
References: <CANr0WEcfzA7aibMaGeKC2RVr=s2g0z4-R6ZaSjKtRFQiSu4XLQ@mail.gmail.com>
	<473ee14f-a202-d283-afdf-01bb8d4d84e4@redhat.com>
	<CANr0WEc6F0_-bKgG4EMgBCpMsw7t6sx_fV=A1VXqnzDzu51Qyw@mail.gmail.com>
	<1cace15b-81b7-0217-72f9-92e451f370a3@redhat.com>
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Tue, 27 Feb 2018 08:36:02 -0600
Message-ID: <CANr0WEfEXYBH9k4k_kZbvBv-2kNw-zBpkcpUxzGC_gnTtGJwPQ@mail.gmail.com>
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

Sounds great. Thanks!

On Tue, Feb 27, 2018 at 5:04 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 27/02/2018 10:05, Huaicheng Li wrote:
> >     Including a RAM disk backend in QEMU would be nice too, and it may
> >     interest you as it would reduce the delta between upstream QEMU and
> >     FEMU.  So this could be another idea.
> >
> > Glad you're also interested in this part. This can definitely be part of
> the
> > project.
> >
> >     For (3), there is work in progress to add multiqueue support to
> QEMU's
> >     block device layer.  We're hoping to get the infrastructure part in
> >     (removing the AioContext lock) during the first half of 2018.  As you
> >     say, we can see what the workload will be.
> >
> > Thanks for letting me know this. Could you provide a link to the on-going
> > multiqueue implementation? I would like to learn how this is done. :)
>
> Well, there is no multiqueue implementation yet, but for now you can see
> a lot of work in block/ regarding making drivers and BlockDriverState
> thread safe.  We can't just do it for null-co:// so we have a little
> preparatory work to do. :)
>
> >     However, the main issue that I'd love to see tackled is interrupt
> >     mitigation.  With higher rates of I/O ops and high queue depth (e.g.
> >     32), it's common for the guest to become slower when you introduce
> >     optimizations in QEMU.  The reason is that lower latency causes
> higher
> >     interrupt rates and that in turn slows down the guest.  If you have
> any
> >     ideas on how to work around this, I would love to hear about it.
> >
> > Yeah, indeed interrupt overhead (host-to-guest notification) is a
> headache.
> > I thought about this, and one intuitive optimization in my mind is to add
> > interrupt coalescing support into QEMU NVMe. We may use some heuristic
> to batch
> > I/O completions back to guest, thus reducing # of interrupts. The
> heuristic
> > can be time-window based (i.e., for I/Os completed in the same time
> window,
> > we only do one interrupt for each CQ).
> >
> > I believe there are several research papers that can achieve direct
> interrupt
> > delivery without exits for para-virtual devices, but those need KVM side
> > modifications. It might be not a good fit here.
>
> No, indeed.  But the RAM disk backend and interrupt coalescing (for
> either NVMe or virtio-blk... or maybe a generic scheme that can be
> reused by virtio-net and others too!) is a good idea for the third part
> of the project.
>
> >     In any case, I would very much like to mentor this project.  Let me
> know
> >     if you have any more ideas on how to extend it!
> >
> >
> > Great to know that you'd like to mentor the project! If so, can we make
> it
> > an official project idea and put it on QEMU GSoC page?
>
> Submissions need not come from the QEMU GSoC page.  You are free to
> submit any idea that you think can be worthwhile.
>
> Paolo
>
