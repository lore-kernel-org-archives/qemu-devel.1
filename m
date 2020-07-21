Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E021C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD5206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="GnXJkpFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3Tg4X1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD5206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxulY-0000VA-G8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jxujC-0006pr-4s
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:02:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jxuj4-0003Uz-PJ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:02:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 7B5135C00EB;
 Tue, 21 Jul 2020 12:02:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 21 Jul 2020 12:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=0w1LD0KFP5BTQIS+DKFw60Ddzd
 qtjnSiVyCQNJt8I88=; b=GnXJkpFR9H3L+SLpkGzVT5mIHthLgwQ4lslwUrA0dQ
 Fy2qww2kzHGudduodhA/c+e7fKmRbYqKFQI3BRu9KQfgDuAIRTtesVKjKBbYno5v
 0d0jmyXK54J/MI4tyc+L4hwcGLm41F4DTIqe0RXMfHRlWYZobKhTEJ2vFznWiQtN
 SQeiq32EOooz8qCdedn21gHkR7kw6IeuEyiezdR+ONA5hRrD+O36OojvxDU5XAhV
 1J6yPdHPd+FlKoqGiAjxVCm4i03hjEdTdfOxTCttn72C/bfaX+J8ODEcN7oA5nB2
 biqOffbZHZ7ooVvdd0hhy7VKOvpkC0qZF4Z7OTPXcyrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0w1LD0
 KFP5BTQIS+DKFw60DdzdqtjnSiVyCQNJt8I88=; b=R3Tg4X1Hl/pdhup3QDD1t7
 VTLybZYQk+NLEeluokdMa7j8aT7cjsCmfh878N2l3CimsZLRK698j0EerLEui2Vc
 B4cC+fSrvW6oUUeiJ6MTbKomgarnOKgjk1T87skalvf79pWcSUDDhf71kz5cdkBM
 i77QVbisyK8nuE62wYWC22ZoItJEaFgGJp838Q3+xLWsDuTfv0a0r3VIhGndjydm
 +zICluzt3Qopc1JnvS9eqJO8574IZ+I1yCqY1hE40PiDepghnRir9kV3XcI58K1j
 dMY63k6FAYjf5ejgGPq79N8XvHijAMJTmELLqL7SWpf0klBixuyA1IvatseuoyDA
 ==
X-ME-Sender: <xms:oBEXX0pDmPwXfkexuTNHEJXtoadONnSFw7gAMC5zkpIaAwtlt1QUGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeigdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
 fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffujghffffkgggtseht
 tdertddttddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrg
 drihhsqeenucggtffrrghtthgvrhhnpeehgeffhfduhfejheffveelkeettedtleduueff
 ieejtdeuhffhudejffehgeeivdenucffohhmrghinhepqhgvmhhurdhorhhgpdhgihhthh
 husgdrihhopdhkvghrnhgvlhdrohhrghenucfkphepgeeirdektddrudegvddrkeefnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlh
 ihshhsrgdrihhs
X-ME-Proxy: <xmx:oBEXX6o-d9UX_4c46exreZT-MMscm5IqFC0X7TwNUoJTSvDEcADgTg>
 <xmx:oBEXX5PCKi5EwEoOY_JI0gcPc0UdRN9mcoDTBjfZbGtdHs6mZa_rNA>
 <xmx:oBEXX75WbDG7lGvFNZzf5W9jPWYZ50API-V1aFYYGjNBWGnHAgdR1A>
 <xmx:oREXX8XcoKicmXnhfiRYk-yRCC9iWSRV6s5HEjedpGia6baPUGw61A>
Received: from x220.qyliss.net (p2e508e53.dip0.t-ipconnect.de [46.80.142.83])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2A523306005F;
 Tue, 21 Jul 2020 12:02:40 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 9541D2E6; Tue, 21 Jul 2020 16:02:38 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Testing the virtio-vhost-user QEMU patch
In-Reply-To: <20200721083048.GB144170@stefanha-x1.localdomain>
References: <87h7u1s5k1.fsf@alyssa.is>
 <20200721083048.GB144170@stefanha-x1.localdomain>
Date: Tue, 21 Jul 2020 16:02:38 +0000
Message-ID: <87d04osvoh.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.27; envelope-from=hi@alyssa.is;
 helo=out3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 12:02:41
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
>
> Did you test the git trees linked below or did you rebase the commits
> on top of your own QEMU tree?

I tested the git trees.  For your one I had to make a slight
modification to delete the memfd syscall wrapper in util/memfd.c, since
it conflicted with the one that is now provided by Glibc.  Nikos's tree
I used totally unmodified.

> Is your guest kernel a stock kernel.org/distro kernel or has it been
> modified (especially with security patches)?

I tried a slightly modified Chromium OS kernel (5.4.23), and a stock
Ubuntu 18.10 kernel (4.15.0).  I think the most "normal" setup I tried
was building QEMU on Fedora 32, and then attempting to boot a freshly
installed Ubuntu Server 18.10 VM with

    -chardev socket,id=chardev0,path=vhost-user.sock,server,nowait \
    -device virtio-vhost-user-pci,chardev=chardev0

(The crash was reproducible with the full QEMU command lines in the
write-ups, but these seemed to be the load-bearing bits.)

> If no one else knows what is wrong here then it will be necessary to
> check the Intel manuals to figure out the exact meaning of
> "error_code(0x000b) - reserved bit violation" and why Linux triggers it
> with "PGD 3b128067 P4D 3b128067 PUD 3b129067 PMD 3b12a067 PTE
> 8000002000000073".

Thanks for your insight.  Now I at least have a place to start if nobody
else knows what's up. :)

