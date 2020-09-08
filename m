Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ECC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD6F22527
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic3tYcvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD6F22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfzS-0005ue-U5
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyI-0004HZ-To
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyF-0003u4-N7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9MSzTqEXdEyImaMC4bb2Kv6juBLliyTUBhWiXmnlsA=;
 b=ic3tYcvyzyVRipYio/4hCGvoBA9rIUoFyi5tafvJd+WiXuk/lV8LayR4S5Rdd5Oz/KaRaP
 zUiOb3ZLFOMUZlDqFzOWJqURgWIYQFjXxaTahLNTQ5TRqCVfXy2mBXotkoP0aOs0TGNxv3
 kz6wj24GIyOWBf8+5s5Or+JPBwXZtAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-YGUgUnldN_CjQYxuYld5zg-1; Tue, 08 Sep 2020 11:55:44 -0400
X-MC-Unique: YGUgUnldN_CjQYxuYld5zg-1
Received: by mail-wm1-f71.google.com with SMTP id w3so4891909wmg.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9MSzTqEXdEyImaMC4bb2Kv6juBLliyTUBhWiXmnlsA=;
 b=hucSLw7uflfSCYh2Vvf1AenWwo/ZCNamWXBux+2P9NPe9VS9ncq+Ery/GFRbKo4AJP
 0FnXf9Zswbf3ymcL9SuP5BZbE+YieCPAEPrE61aEI1ehm9bQkSxZliAckXvF1SpdcVxr
 7wIkEOKRkKVY1LmbattN6myz3p77VC5Z94EXYwS+xWzhYhEJkQnstA3SiUGx49smBn74
 fIQhbQ2jGF+hB2JzJPMlTTIFfs79ezht4kmlB65DGUJnZ/70hR6+T31PbvLW3JMGLYMR
 J99hEvidiWkUZ++GZNwIfvah3Z85Sw+azpl+b9dSG+dE1WT2ZB9TXLqjcWS+yRUUZ/sN
 4/zA==
X-Gm-Message-State: AOAM530XVFgE+aaAqbsc8179WD3qG9KDML/TTGW8MkQrYheOttx5ROE8
 WnuZaFUjoeQVqS83Ffcb7APBsetyPskSjdgYuE2O3lknUYdS4j8KSjSQmWyDIBmxt0BIhxZ7EiS
 fPzLfDrS4X74Tuug=
X-Received: by 2002:adf:fa52:: with SMTP id y18mr317414wrr.264.1599580542937; 
 Tue, 08 Sep 2020 08:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU6NdtM/r+hGgVHJHbxUzLG0yEYCNZp/OUgIpECe7SNk6Rt9b7NXEaxP7j5zNjVZzl5NvrIA==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr317390wrr.264.1599580542761; 
 Tue, 08 Sep 2020 08:55:42 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x10sm34206389wmi.37.2020.09.08.08.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:55:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] hw/i386/xen: Rename X86/PC specific function as
 xen_hvm_init_pc()
Date: Tue,  8 Sep 2020 17:55:26 +0200
Message-Id: <20200908155530.249806-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
References: <20200908155530.249806-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

xen_hvm_init() is only meanful to initialize a X86/PC machine,
rename it as xen_hvm_init_pc().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/xen/xen.h   | 2 +-
 accel/stubs/xen-stub.c | 2 +-
 hw/i386/pc_piix.c      | 6 +++---
 hw/i386/xen/xen-hvm.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 771dd447f2b..b2b459964cb 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -30,7 +30,7 @@ qemu_irq *xen_interrupt_controller_init(void);
 
 void xenstore_store_pv_console_info(int i, struct Chardev *chr);
 
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index 8ae658acff5..fa3dddbce57 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -46,7 +46,7 @@ void xen_register_framebuffer(MemoryRegion *mr)
 {
 }
 
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
 }
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 32b1453e6a8..3e008bb0b1a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -117,8 +117,8 @@ static void pc_init1(MachineState *machine,
      *    so legacy non-PAE guests can get as much memory as possible in
      *    the 32bit address space below 4G.
      *
-     *  - Note that Xen has its own ram setp code in xen_ram_init(),
-     *    called via xen_hvm_init().
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
      *
      * Examples:
      *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
@@ -127,7 +127,7 @@ static void pc_init1(MachineState *machine,
      *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
      */
     if (xen_enabled()) {
-        xen_hvm_init(pcms, &ram_memory);
+        xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         if (!pcms->max_ram_below_4g) {
             pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index cde981bad66..49748cda3fb 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1395,7 +1395,7 @@ static int xen_map_ioreq_server(XenIOState *state)
     return 0;
 }
 
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     MachineState *ms = MACHINE(pcms);
     unsigned int max_cpus = ms->smp.max_cpus;
-- 
2.26.2


