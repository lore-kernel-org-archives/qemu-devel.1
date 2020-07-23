Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0096C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993F82068F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ZDHDcM7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7q50bw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993F82068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyji4-0001Hs-Tz
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 18:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jyjh9-0000k5-Bn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:28:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jyjh6-0000oQ-KX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:28:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 78B71544;
 Thu, 23 Jul 2020 18:27:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 23 Jul 2020 18:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=gIVsmJqRVx49Uxnan7dBG9qSgI
 u0KzFY23S6P45U9LE=; b=ZDHDcM7B/nKll/QyVKFSU3ejATYe8fWA350qTMwWft
 3P4v02fO+IMPJA/vRcXbh9eFLCFKMxvGpKwbbpLPQHjAQPFnsTbxgZglA77F4dr/
 bWHUkk3BBb+DaAaf8dmNmBNHu3anYIk/yrul+2fPljP02SL+lj5U4pP4nw3oALoT
 CGXGjPlM4FPjcXeZCXVj8jqPYgtWjvmkZRIhQ92JQ+1hsm57i379gUO6EOx7SJnA
 Mb+8NpPmY+jTsnxBpmgRwBqsw6F929Ys1rRtOMUgcUtmdH5iFv1+58A3qZkE/gr/
 M/7Oh/C2J4ZntNjBEn3SiFtMlltrGQPNLisFZL75VehQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gIVsmJ
 qRVx49Uxnan7dBG9qSgIu0KzFY23S6P45U9LE=; b=p7q50bw5jXqDK2/FhIshiW
 Y7iJVhiNN+SohgR4QL2vxoOC4YE0i/hE9oLjapCGrzt+LsLUUktbTDZwYpr82kRB
 5/i4vY/Q+Z05e9mrYboQISqsUHDDzRLdUtRUBdGCno3DHJpjRZqXZ220+3P9lTf6
 s2q+CG6T2ZWTKet8HeJWIAxoOxMdwiUn6NCl5vBLhsGhdXk0bWVPCIWtDdRw9AB2
 HlvBI9wPexN8ng5b6VliyOchDXqZf5kbcVUJKcc4ITsVxbFRPFjF9LOtB6mvR873
 Pc29YHkypacTdDHGvCr8LksjspMTZnZ6oWd8COPUmvOGWunyIL6KMZZ1doKPr+lw
 ==
X-ME-Sender: <xms:7g4aX-pcfgHQnjdqP6iW3QJDIhelRQXcXw-G2wB_a8171Go2l-a5BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrhedvgddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
 fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffujghffffkgggtseht
 tdertddttddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrg
 drihhsqeenucggtffrrghtthgvrhhnpeelkeduleelgeefhffgffeuffeguddtjeffgfdt
 tdegleekieevheettdevfeduleenucffohhmrghinhepqhgvmhhurdhorhhgpdhgihhthh
 husgdrihhonecukfhppeegiedrkedtrddugedvrdekfeenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:7g4aX8rn9QVqO9Wj1YwGr8wP_IXCmpbfz0Sse7PAZQ8QMAQqT_e1mw>
 <xmx:7g4aXzOFi0l3ri4F5gc6ANo3scS-Ed5sNJM7P8Sw8cuw0_IU6GD8Ig>
 <xmx:7g4aX970-vN1w1ZA1y7ltaAayrRIWfHV4x6LQYWmo1qNbOU3CFWqhw>
 <xmx:7w4aX-WJn-XXSTtwjw5QWUc7HViszyyCXwGrlYSU5AiQVFe2VICehg>
Received: from x220.qyliss.net (p2e508e53.dip0.t-ipconnect.de [46.80.142.83])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8740930600A6;
 Thu, 23 Jul 2020 18:27:58 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 98D2742D; Thu, 23 Jul 2020 22:27:56 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Testing the virtio-vhost-user QEMU patch
In-Reply-To: <20200721083048.GB144170@stefanha-x1.localdomain>
References: <87h7u1s5k1.fsf@alyssa.is>
 <20200721083048.GB144170@stefanha-x1.localdomain>
Date: Thu, 23 Jul 2020 22:27:56 +0000
Message-ID: <87eep1yihf.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.19; envelope-from=hi@alyssa.is;
 helo=wout3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 18:28:00
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Jul 21, 2020 at 07:14:38AM +0000, Alyssa Ross wrote:
>> Hi -- I hope it's okay me reaching out like this.
>> 
>> I've been trying to test out the virtio-vhost-user implementation that's
>> been posted to this list a couple of times, but have been unable to get
>> it to boot a kernel following the steps listed either on
>> <https://wiki.qemu.org/Features/VirtioVhostUser> or
>> <https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.
>> 
>> Specifically, the kernel appears to be unable to write to the
>> virtio-vhost-user device's PCI registers.  I've included the full panic
>> output from the kernel at the end of this message.  The panic is
>> reproducible with two different kernels I tried (with different configs
>> and versions).  I tried both versions of the virtio-vhost-user I was
>> able to find[1][2], and both exhibited the same behaviour.
>> 
>> Is this a known issue?  Am I doing something wrong?
>
> Hi,
> Unfortunately I'm not sure what the issue is. This is an early
> virtio-pci register access before a driver for any specific device type
> (net, blk, vhost-user, etc) comes into play.

Small update here: I tried on another computer, and it worked.  Made
sure that it was exactly the same QEMU binary, command line, and VM
disk/initrd/kernel, so I think I can fairly confidently say the panic
depends on what hardware QEMU is running on.  I set -cpu value to the
same on both as well (SandyBridge).

I also discovered that it works on my primary computer (the one it
panicked on before) with KVM disabled.

Note that I've only got so far as finding that it boots on the other
machine -- I haven't verified yet that it actually works.

Bad host CPU:  Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
Good host CPU: AMD EPYC 7401P 24-Core Processor

May I ask what host CPUs other people have tested this on?  Having more
data would probably be useful.  Could it be an AMD vs. Intel thing?

