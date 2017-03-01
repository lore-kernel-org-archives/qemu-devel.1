Received: from eggs.gnu.org ([2001:4830:134:3::10]:46464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj2Yp-0002iu-A5
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj2Ym-0002tZ-5n
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:36:47 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cj2Yl-0002tR-Vi
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:36:44 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v77so33795668wmv.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 03:36:43 -0800 (PST)
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
Date: Wed, 01 Mar 2017 11:36:42 +0000
Message-ID: <877f492ppx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> I got a make check failure on aarch64 host running a sparc64 test:
>
>
> TEST: tests/prom-env-test... (pid=13573)
>   /sparc64/prom-env/sun4u:                                             **
> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
> assertion failed: (qemu_mutex_iothread_locked())

So the assertions where added with MTTCG. The design specifies which
bits should be protected by the BQL and cpu->interrupt_request is one of
them. This is because cpu->interrupt_request is often a cross-vCPU
action (one vCPU triggering an interrupt on another) so there is a
chance of racing if not protected.

It's odd this is showing up on a aarch64 host though when it didn't hit
on my x86_64 host while testing.

As most of this stuff is triggered by hardware emulation the BQL should
be in effect when handling MMIO for device emulation. There where other
entry points in ARM which could trigger stuff which is why we add
locking for things like ARM_CP_IO which are co-processor register
accesses which trigger other things in the system.

What will be useful for all these reports is the backtrace. Then it's
fairly simple to identify the thing triggering the interrupt and
identify the correct place for the locking.

Having said that on some setups we are seeing very high BQL contention
so maybe it will be simpler to move this stuff to atomic updates. I
believe Paolo has some patches on the list.

> Broken pipe
> FAIL
> GTester: last random seed: R02Sa5fa983185fe5e65cfb5b7fcb39ed3d1
> (pid=13579)
> FAIL: tests/prom-env-test
>
> This is with commit 9514f2648ca05b3.
>
> It didn't reproduce on a rerun of 'make check' and it didn't
> look like the merge in question was particularly relevant to
> the failure, so I went ahead and pushed it to master.
>
> I'm (perhaps unfairly) assuming that this is fallout from MTTCG
> landing. (prom-env-test is one of the handful of tests in
> 'make check' that actually runs TCG code.)

Well I was hoping for a fairly incident free merge but I guess that's
why we have a softfreeze. The assertions where added so any areas where
the design is violated can be picked up pretty quickly which they seem
to be doing their job.

--
Alex Bennée
