Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7311C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A92F206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="mpWIsXMJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsLmcwxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92F206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz5hH-0004hj-T7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 17:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jz5gY-0004IO-W7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:56:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jz5gW-000537-KZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:56:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 8321F5C0163;
 Fri, 24 Jul 2020 17:56:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 24 Jul 2020 17:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=0t1KiAVitErSvP3R7Gh+rRESQJ
 M3E3D9x3G6AXPPK6A=; b=mpWIsXMJN+mOrLLb+vamVZEHlfsnxhFMlO3dX9Jxv5
 oXs3HnU4W4FBpp++n+Ye2FgD7kqt2AWp2gL2/HjwBa8wgxk842wCONH9wSZnlL+s
 s5e+twa5e5lIUTYAhRNjza9eQg5DEqQxPcvDIiI+5tLUEhL93utVGQ8MHZ1hoDDx
 821LOdNzbg5bfQFAuuQTwLYFjpYt/7gW0EYKnAEt3W12UeEN64ZJd15R/3BRKB6D
 M7W+S6FPUZFLKPeSg3O0y7FDinx5j/3aWH+TlpGvfFM37tpAmqU63ichbd+F9JEf
 ffkKJ0I6WPafcJFEsN825CBl7NZhwOJTHvyTX6sE90LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0t1KiA
 VitErSvP3R7Gh+rRESQJM3E3D9x3G6AXPPK6A=; b=LsLmcwxCKbW1Q/ArcJSWL4
 hRhrQFlFefGnTDaI4rDYcKuyK8oqfRhy+Xp8Dl7cG4dKX0C7p5AECyXNJ35ZMSek
 or1NbgXk3EBG3qm2khU1zloaBl+yxUeedOu5aWlOTRzViiCeZLFChg/o8V+WEZ0s
 +KrUDU24M7yd3RQp+58989a/zOpfWlGTawbRBqif0d3/mQSoN2WLEDA6hOLTxX7s
 3L25AIcgusB4PkqAYsInbnejNuhfBPtZVvKH72wXfea3DPxqI4x4NC1aszo9cn9l
 CcQuD5Wl/TbcNAdeMR+PdXvqSL49ou7gzpnn2PQxQsaxNisL0vdIcgIRslCESTeQ
 ==
X-ME-Sender: <xms:JlkbX45jt3m1yYsSCXZ_yrx6ZjwdI-dzIClrJBTNhGg2mlkHQjfj0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeggddtvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
 fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffujghffffkgggtseht
 tdertddttddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrg
 drihhsqeenucggtffrrghtthgvrhhnpeehtdejffektedtkeethfetheetveeggfeugfel
 ueffheeuudejvdefgfeiiefgleenucffohhmrghinhepqhgvmhhurdhorhhgpdhgihhthh
 husgdrihhopdhgihhthhhusgdrtghomhenucfkphepgeeirdektddrudegvddrkeefnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlh
 ihshhsrgdrihhs
X-ME-Proxy: <xmx:JlkbX54TZcl1d9wcYacBh1Wjh8kq87kW7-sRids5bj6GgHHmTB3ZHQ>
 <xmx:JlkbX3emsaASgFP8uTgdy_aU35dYDyMFpd8wsCPcqkXmgA51blzupQ>
 <xmx:JlkbX9I2yvMAW1emgLrb5i6r1Cj8Gq27cerECzv-PLEEDqd-0URmOg>
 <xmx:J1kbXznc0CTQzgiI-0zWLRL7GLF1LbwtlINtNdcad_NxQxDqHpdUiA>
Received: from x220.qyliss.net (p2e508e53.dip0.t-ipconnect.de [46.80.142.83])
 by mail.messagingengine.com (Postfix) with ESMTPA id A81E830600A9;
 Fri, 24 Jul 2020 17:56:54 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 16E053BD; Fri, 24 Jul 2020 21:56:53 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Testing the virtio-vhost-user QEMU patch
In-Reply-To: <20200724123254.GB333683@stefanha-x1.localdomain>
References: <87h7u1s5k1.fsf@alyssa.is>
 <20200721083048.GB144170@stefanha-x1.localdomain> <87eep1yihf.fsf@alyssa.is>
 <87o8o5dvru.fsf@alyssa.is> <20200724123254.GB333683@stefanha-x1.localdomain>
Date: Fri, 24 Jul 2020 21:56:53 +0000
Message-ID: <87lfj8efve.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.27; envelope-from=hi@alyssa.is;
 helo=out3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 17:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Jul 24, 2020 at 10:58:45AM +0000, Alyssa Ross wrote:
>> Alyssa Ross <hi@alyssa.is> writes:
>> 
>> > Stefan Hajnoczi <stefanha@redhat.com> writes:
>> >
>> >> On Tue, Jul 21, 2020 at 07:14:38AM +0000, Alyssa Ross wrote:
>> >>> Hi -- I hope it's okay me reaching out like this.
>> >>> 
>> >>> I've been trying to test out the virtio-vhost-user implementation that's
>> >>> been posted to this list a couple of times, but have been unable to get
>> >>> it to boot a kernel following the steps listed either on
>> >>> <https://wiki.qemu.org/Features/VirtioVhostUser> or
>> >>> <https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.
>> >>> 
>> >>> Specifically, the kernel appears to be unable to write to the
>> >>> virtio-vhost-user device's PCI registers.  I've included the full panic
>> >>> output from the kernel at the end of this message.  The panic is
>> >>> reproducible with two different kernels I tried (with different configs
>> >>> and versions).  I tried both versions of the virtio-vhost-user I was
>> >>> able to find[1][2], and both exhibited the same behaviour.
>> >>> 
>> >>> Is this a known issue?  Am I doing something wrong?
>> >>
>> >> Hi,
>> >> Unfortunately I'm not sure what the issue is. This is an early
>> >> virtio-pci register access before a driver for any specific device type
>> >> (net, blk, vhost-user, etc) comes into play.
>> >
>> > Small update here: I tried on another computer, and it worked.  Made
>> > sure that it was exactly the same QEMU binary, command line, and VM
>> > disk/initrd/kernel, so I think I can fairly confidently say the panic
>> > depends on what hardware QEMU is running on.  I set -cpu value to the
>> > same on both as well (SandyBridge).
>> >
>> > I also discovered that it works on my primary computer (the one it
>> > panicked on before) with KVM disabled.
>> >
>> > Note that I've only got so far as finding that it boots on the other
>> > machine -- I haven't verified yet that it actually works.
>> >
>> > Bad host CPU:  Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
>> > Good host CPU: AMD EPYC 7401P 24-Core Processor
>> >
>> > May I ask what host CPUs other people have tested this on?  Having more
>> > data would probably be useful.  Could it be an AMD vs. Intel thing?
>> 
>> I think I've figured it out!
>> 
>> Sandy Bridge and Ivy Bridge hosts encounter this panic because the
>> "additional resources" bar size is too big, at 1 << 36.  If I change
>> this to 1 << 35, no more kernel panic.
>> 
>> Skylake and later are fine with 1 << 36.  In between Ivy Bridge and
>> Skylake were Haswell and Broadwell, but I couldn't find anybody who was
>> able to help me test on either of those, so I don't know what they do.
>> 
>> Perhaps related, the hosts that produce panics all seem to have a
>> physical address size of 36 bits, while the hosts that work have larger
>> physical address sizes, as reported by lscpu.
>
> I have run it successfully on Broadwell but never tried 64GB or larger
> shared memory resources.

To clarify, I haven't been using big shared memory resources either --
this has all been about getting the backend VM to start at all.  The
panic happens at boot, and the 1 << 36 BAR allocation comes from here,
during realization:
https://github.com/ndragazis/qemu/blob/f9ab08c0c8/hw/virtio/virtio-vhost-user-pci.c#L291

