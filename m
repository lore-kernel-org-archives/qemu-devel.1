Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589DAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DEB20767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="KOPJcT61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAcM+x0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DEB20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyvQR-0001su-F3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jyvPh-0001Jq-3b
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 06:58:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jyvPd-00054k-Jj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 06:58:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 564D05C00CA;
 Fri, 24 Jul 2020 06:58:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 24 Jul 2020 06:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=qah2nb41Fw6UeTLVpYDD8itbw1
 BVxbHiDPUTwiMMyGQ=; b=KOPJcT61SSHOkTeWrJ5T7ka4B0eLTg/Pf4SlKxPRSU
 9vKjx3KUD5zglOgwo9Bcfh1LRQwURxUzFttOfE+WBHxgY2i50fCEaJVRX8FwK0kt
 war/6/LDguAQFLKzYhlNL60hdYfNOp2z/PQ5RruYsNDHPUIfZwEPE9nMAjmBu0CW
 j9e0PGuVrK0yUKfrhbgfSbSqKmhQu9x6gJRqFjJnpPSC83qWdtHIl4QuigauRJwm
 Jh6JLBO2onH3OVPGGEj4tgZSlvD078T5cbNdOP044JnkkAPyM6XFsl++uIuB2Lat
 9Ju89n+SQaLysbQuEgeGxz1zYuTNuA5m3699ioHA8/ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qah2nb
 41Fw6UeTLVpYDD8itbw1BVxbHiDPUTwiMMyGQ=; b=WAcM+x0e40qeTLqNhYNHqV
 fGxA4O9LZAYGgYh0G+1L1W06gbLVXtIo9MHYb/YjnS08UYfKFXBXUNiZnoez6Pvc
 F3ovs8qcFXCKhCDBgzBb4ekrofQjAbzuTdgr452NY2rHsE2EW5FlYBX+GObqRMle
 nlmJR3GZ+RtgCV5mxmIgA3apNv2DGv9wxePllhNmR3vs6Iv8UpjgOvH6Rv1Qa0dS
 VFG8RDNJ83iPPJpHh3PPDPmsYwifPSFYeB7WqSAFm5xR5eV08pl7f8uvGHU3y1gU
 +u+x6yov0Iifs8YQJp93tOOjBuYgkD2SX2/OardjHu6N76sWJU7lF9Gpf+P4wMfw
 ==
X-ME-Sender: <xms:574aX-zAwdwtdUbYtyGN-kWyWNmreF4T94HCELqFFRcSbeyytHEKNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheefgdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
 fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffujghffffkgggtseht
 tdertddttddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrg
 drihhsqeenucggtffrrghtthgvrhhnpeelkeduleelgeefhffgffeuffeguddtjeffgfdt
 tdegleekieevheettdevfeduleenucffohhmrghinhepqhgvmhhurdhorhhgpdhgihhthh
 husgdrihhonecukfhppeegiedrkedtrddugedvrdekfeenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:574aX6RIWdvUCJZkiuYzRVk6foj0EjhadbFSurvt50qVjjX3PufSnw>
 <xmx:574aXwWe18LNQMG5GxkanMwMoQeISF9GRwxAB5z3ench3rH_YLj3Qw>
 <xmx:574aX0gyRvXOzhVb-VkSXktHjTWhEZbWnKHSHJ8f-2X6cXT_mDzDEQ>
 <xmx:6L4aX_9rGIbvW0DJGGy23GOJQyNSLCX28GTwQk6wUevg5Kci7n520A>
Received: from x220.qyliss.net (p2e508e53.dip0.t-ipconnect.de [46.80.142.83])
 by mail.messagingengine.com (Postfix) with ESMTPA id A55243280059;
 Fri, 24 Jul 2020 06:58:47 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id E72E42E7; Fri, 24 Jul 2020 10:58:45 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Testing the virtio-vhost-user QEMU patch
In-Reply-To: <87eep1yihf.fsf@alyssa.is>
References: <87h7u1s5k1.fsf@alyssa.is>
 <20200721083048.GB144170@stefanha-x1.localdomain> <87eep1yihf.fsf@alyssa.is>
Date: Fri, 24 Jul 2020 10:58:45 +0000
Message-ID: <87o8o5dvru.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.26; envelope-from=hi@alyssa.is;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:58:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Nikos Dragazis <ndragazis@arrikto.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alyssa Ross <hi@alyssa.is> writes:

> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
>> On Tue, Jul 21, 2020 at 07:14:38AM +0000, Alyssa Ross wrote:
>>> Hi -- I hope it's okay me reaching out like this.
>>> 
>>> I've been trying to test out the virtio-vhost-user implementation that's
>>> been posted to this list a couple of times, but have been unable to get
>>> it to boot a kernel following the steps listed either on
>>> <https://wiki.qemu.org/Features/VirtioVhostUser> or
>>> <https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.
>>> 
>>> Specifically, the kernel appears to be unable to write to the
>>> virtio-vhost-user device's PCI registers.  I've included the full panic
>>> output from the kernel at the end of this message.  The panic is
>>> reproducible with two different kernels I tried (with different configs
>>> and versions).  I tried both versions of the virtio-vhost-user I was
>>> able to find[1][2], and both exhibited the same behaviour.
>>> 
>>> Is this a known issue?  Am I doing something wrong?
>>
>> Hi,
>> Unfortunately I'm not sure what the issue is. This is an early
>> virtio-pci register access before a driver for any specific device type
>> (net, blk, vhost-user, etc) comes into play.
>
> Small update here: I tried on another computer, and it worked.  Made
> sure that it was exactly the same QEMU binary, command line, and VM
> disk/initrd/kernel, so I think I can fairly confidently say the panic
> depends on what hardware QEMU is running on.  I set -cpu value to the
> same on both as well (SandyBridge).
>
> I also discovered that it works on my primary computer (the one it
> panicked on before) with KVM disabled.
>
> Note that I've only got so far as finding that it boots on the other
> machine -- I haven't verified yet that it actually works.
>
> Bad host CPU:  Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
> Good host CPU: AMD EPYC 7401P 24-Core Processor
>
> May I ask what host CPUs other people have tested this on?  Having more
> data would probably be useful.  Could it be an AMD vs. Intel thing?

I think I've figured it out!

Sandy Bridge and Ivy Bridge hosts encounter this panic because the
"additional resources" bar size is too big, at 1 << 36.  If I change
this to 1 << 35, no more kernel panic.

Skylake and later are fine with 1 << 36.  In between Ivy Bridge and
Skylake were Haswell and Broadwell, but I couldn't find anybody who was
able to help me test on either of those, so I don't know what they do.

Perhaps related, the hosts that produce panics all seem to have a
physical address size of 36 bits, while the hosts that work have larger
physical address sizes, as reported by lscpu.

