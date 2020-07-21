Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC41C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BCF208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Akv2H60q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPJLWkbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BCF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxmUp-0000zS-Tu
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 03:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jxmUB-0000Uf-1p
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:14:47 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1jxmU8-0002yL-BB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:14:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id C9522132C;
 Tue, 21 Jul 2020 03:14:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 21 Jul 2020 03:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:date:message-id:mime-version:content-type; s=
 fm3; bh=QwLAs3azXFARgMPLFmzqSwvsJvVdwGD5zxJrOLs0k2Q=; b=Akv2H60q
 bIpv78buygS54QgUDGNBKiTJnkDUqimZIpVq8AIwtm8RjGn92QO2MzN3T7ly1m6L
 LCHFeimVfJ1AMrKUJh3X0P7ytwUujuwoGpHTWwHnBvzs8s5yQKf5FZNX0KmsfL4D
 l7obPIFH9vhux9vbrMSbKSmhQbdmrLCTg0JIi0jyaThRkLbHfhLB+UeLXMV+Gtkx
 9DlNuKU61Egwe4Wd8Agf+ffdt7WUhx3KaycTXYBt7S9zP17WlQbuMW4JeoQi2x/+
 t0gQxF12/wLS03ocq52s93NbNiFgzU140rssbe4qY+CF8fdPA3Ab6zgAlDDT2KFO
 9aLV/k8cJs8OyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=QwLAs3azXFARgMPLFmzqSwvsJvVdw
 GD5zxJrOLs0k2Q=; b=UPJLWkbG0MG95+Qba9RKJQK870z3AHLAuwKGD0TvDlHuk
 oxDo7ieZIeHq7qkAGXY8hja+XzJJ4VY0WRrHR507NNjbHPvkGN9iSQxtpW1HV95R
 bU1Ec9dogY6dSLhlkg3Kxw5h2iDlzvJH0GM0YjmSXXguQVQhZhpIRmajw2MmdGrv
 M/ljEuTTwd0kc0gyV0lz67lYAASlTyip8gVkkP/57C7T2GMF73kf1oj7bJln9QVf
 3Z+JwcFoyLna6GBcfiIUO/VRDJphqIVpw8sw0Y1MgDgXU139m6pLVGBtmZBJigOv
 qCPkMy8oiI59vyh0+K5NEkfFKoyWkyBv3vggMoSNw==
X-ME-Sender: <xms:4JUWX8LYLtrWS6CBAqok9oBhIX1aGKigqwjVuodRh35i1rLyeVX66A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeehgdduudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvufffkfggtgesthdt
 redttddttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrd
 hisheqnecuggftrfgrthhtvghrnhephfffjefhieeiffeihfekueffieekledtuedttdel
 veejtdeggffffefgvdejheffnecuffhomhgrihhnpehqvghmuhdrohhrghdpghhithhhuh
 gsrdhiohdpghhithhhuhgsrdgtohhmpdhqvghmuhdqphhrohhjvggtthdrohhrghenucfk
 phepgeeirdektddrudegvddrkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:4JUWX8KyflNx0CIQZB5m3qSe9qo3mKf-0jytwBM6Q9DGcZyWaYnx6w>
 <xmx:4JUWX8vAxF_O77JXYKKxrOQPj0lkZEKWXqHvCpgKj36JtkuRPWQ0rA>
 <xmx:4JUWX5bkA5bYAbw6LNMuToeeU5WtuF0eob9DKd86BBqSo98TjTOyfw>
 <xmx:4JUWX927KTiODlWNWjw5i0TLRmTwBS55BYfZi8uGpuyME6JpoTNpJQ>
Received: from x220.qyliss.net (p2e508e53.dip0.t-ipconnect.de [46.80.142.83])
 by mail.messagingengine.com (Postfix) with ESMTPA id C9910328005E;
 Tue, 21 Jul 2020 03:14:39 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 3EB6C2AC; Tue, 21 Jul 2020 07:14:38 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Nikos Dragazis <ndragazis@arrikto.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Testing the virtio-vhost-user QEMU patch
Date: Tue, 21 Jul 2020 07:14:38 +0000
Message-ID: <87h7u1s5k1.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.24; envelope-from=hi@alyssa.is;
 helo=wout1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:14:41
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi -- I hope it's okay me reaching out like this.

I've been trying to test out the virtio-vhost-user implementation that's
been posted to this list a couple of times, but have been unable to get
it to boot a kernel following the steps listed either on
<https://wiki.qemu.org/Features/VirtioVhostUser> or
<https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.

Specifically, the kernel appears to be unable to write to the
virtio-vhost-user device's PCI registers.  I've included the full panic
output from the kernel at the end of this message.  The panic is
reproducible with two different kernels I tried (with different configs
and versions).  I tried both versions of the virtio-vhost-user I was
able to find[1][2], and both exhibited the same behaviour.

Is this a known issue?  Am I doing something wrong?

Thanks in advance -- I'm excitedly following the progress of this
feature.

Alyssa Ross

[1]: https://github.com/ndragazis/qemu/commits/virtio-vhost-user
[2]: https://github.com/stefanha/qemu/commits/virtio-vhost-user


[    1.287979] BUG: unable to handle page fault for address: ffffb8ca40025014
[    1.288311] #PF: supervisor write access in kernel mode
[    1.288311] #PF: error_code(0x000b) - reserved bit violation
[    1.288311] PGD 3b128067 P4D 3b128067 PUD 3b129067 PMD 3b12a067 PTE 8000002000000073
[    1.288311] Oops: 000b [#1] SMP PTI
[    1.288311] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.28 #1-NixOS
[    1.288311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[    1.288311] RIP: 0010:iowrite8+0xe/0x30
[    1.288311] Code: fe ff ff 48 c7 c0 ff ff ff ff c3 48 8b 3f 48 89 f8 c3 66 2e 0f 1f 84 00 00 00 00 00 89 f8 48 89 f7 48 81 fe ff ff 3
[    1.288311] RSP: 0000:ffffb8ca40013cd8 EFLAGS: 00010292
[    1.288311] RAX: 0000000000000000 RBX: ffffb8ca40013d60 RCX: 0000000000000000
[    1.288311] RDX: 000000000000002f RSI: ffffb8ca40025014 RDI: ffffb8ca40025014
[    1.288311] RBP: ffff9c742ea20400 R08: ffff9c742f0a60af R09: 0000000000000000
[    1.288311] R10: 0000000000000018 R11: ffff9c742f0a60af R12: 0000000000000000
[    1.288311] R13: ffff9c742ea20410 R14: 0000000000000000 R15: 0000000000000000
[    1.288311] FS:  0000000000000000(0000) GS:ffff9c743b700000(0000) knlGS:0000000000000000
[    1.288311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.288311] CR2: ffffb8ca40025014 CR3: 0000000037a0a001 CR4: 0000000000060ee0
[    1.288311] Call Trace:
[    1.288311]  vp_reset+0x1b/0x50
[    1.288311]  register_virtio_device+0x74/0xe0
[    1.288311]  virtio_pci_probe+0xaf/0x140
[    1.288311]  local_pci_probe+0x42/0x80
[    1.288311]  pci_device_probe+0x104/0x1b0
[    1.288311]  really_probe+0x147/0x3c0
[    1.288311]  driver_probe_device+0xb6/0x100
[    1.288311]  device_driver_attach+0x53/0x60
[    1.288311]  __driver_attach+0x8a/0x150
[    1.288311]  ? device_driver_attach+0x60/0x60
[    1.288311]  bus_for_each_dev+0x78/0xc0
[    1.288311]  bus_add_driver+0x14d/0x1f0
[    1.288311]  driver_register+0x6c/0xc0
[    1.288311]  ? dma_bus_init+0xbf/0xbf
[    1.288311]  do_one_initcall+0x46/0x1f4
[    1.288311]  kernel_init_freeable+0x176/0x200
[    1.288311]  ? rest_init+0xab/0xab
[    1.288311]  kernel_init+0xa/0x105
[    1.288311]  ret_from_fork+0x35/0x40
[    1.288311] Modules linked in:
[    1.288311] CR2: ffffb8ca40025014
[    1.288311] ---[ end trace 5164b2fa531e028f ]---
[    1.288311] RIP: 0010:iowrite8+0xe/0x30
[    1.288311] Code: fe ff ff 48 c7 c0 ff ff ff ff c3 48 8b 3f 48 89 f8 c3 66 2e 0f 1f 84 00 00 00 00 00 89 f8 48 89 f7 48 81 fe ff ff 3
[    1.288311] RSP: 0000:ffffb8ca40013cd8 EFLAGS: 00010292
[    1.288311] RAX: 0000000000000000 RBX: ffffb8ca40013d60 RCX: 0000000000000000
[    1.288311] RDX: 000000000000002f RSI: ffffb8ca40025014 RDI: ffffb8ca40025014
[    1.288311] RBP: ffff9c742ea20400 R08: ffff9c742f0a60af R09: 0000000000000000
[    1.288311] R10: 0000000000000018 R11: ffff9c742f0a60af R12: 0000000000000000
[    1.288311] R13: ffff9c742ea20410 R14: 0000000000000000 R15: 0000000000000000
[    1.288311] FS:  0000000000000000(0000) GS:ffff9c743b700000(0000) knlGS:0000000000000000
[    1.288311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.288311] CR2: ffffb8ca40025014 CR3: 0000000037a0a001 CR4: 0000000000060ee0
[    1.288311] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    1.288311] Kernel Offset: 0x21200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.288311] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

