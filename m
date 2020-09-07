Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723E921556
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723E921556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNts-0004GF-8j
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFNtK-0003rI-CE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:37:30 -0400
Received: from relay68.bu.edu ([128.197.228.73]:39766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kFNtH-00045O-O7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:37:29 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 087KZ516030171
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 7 Sep 2020 16:35:09 -0400
Date: Mon, 7 Sep 2020 16:35:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
Message-ID: <20200907203505.hpq5v32gayc5o5yd@mozz.bu.edu>
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 16:37:26
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200701 2135, Peter Maydell wrote:
> On Wed, 1 Jul 2020 at 19:21, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >
> > We can run I/O access with the 'i' or 'o' HMP commands in the
> > monitor. These commands are expected to run on a vCPU. The
> > monitor is not a vCPU thread. To avoid crashing, initialize
> > the 'current_cpu' variable with the first vCPU created. The
> > command executed on the monitor will end using it.
> 
> >
> > RFC because I believe the correct fix is to NOT use current_cpu
> > out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
> 
> Yes, I agree -- I don't think this is the correct fix.
> current_cpu is documented as "only valid inside cpu_exec()",
> ie if you're actually on a vcpu thread you can use it, but if
> you're not on a CPU thread, like the monitor, you need to
> say which vCPU you want to affect. For the monitor, that

Following up on this old thread.. Does qtest count as a pseudo-vCPU?
Since qtest already uses first_cpu for all of its address_space calls,
would it be appropriate to set current_cpu to first_cpu in qtest's
initialization? 
Thank you
-Alex


> would be the current "default cpu" as set by the "cpu"
> command (cf monitor_set_cpu()). The bug here will be that
> somewhere along the line we are probably missing plumbing
> sufficient to pass down "which CPU do we want".
> 
> https://bugs.launchpad.net/qemu/+bug/1602247 is a bug of
> a similar nature -- if the gdbstub does a memory access
> we know which CPU we're trying to do that memory access as,
> but it doesn't get plumbed through and so in the Arm GIC
> register read/write function that looks at current_cpu
> we get a segfault.
> 
> One way to fix this would be to do something akin to how
> real hardware works -- encode into the MemTxAttrs an
> indication of what the transaction master was (eg the
> CPU number for CPUs); then the handful of devices that
> care about which CPU was doing the transaction can use
> that, rather than directly looking at current_cpu, and
> when gdbstub or monitor perform an access that should
> act like it's from a particular CPU they can indicate
> that by supplying appropriate transaction attributes.
> That would potentially be quite a bit of work though
> (but I think it would be a neat design if we want to
> try to fix this kind of "segfault if the user prods
> a device via the monitor" bug).
> 
> +    if (!current_cpu) {
> +        current_cpu = cpu;
> +    }
> 
> Some more specific issues with this -- current_cpu is
> a thread-local variable, so this will set that for
> whatever thread happens to make this call, which
> might or might not be the one that ends up handling
> the monitor command. Also some code assumes that
> current_cpu is non-NULL only if this is a vCPU thread,
> eg sigbus_handler().
> 
> thanks
> -- PMM

