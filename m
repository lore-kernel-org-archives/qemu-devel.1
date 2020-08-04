Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACCA2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZdjL/bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACCA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2riW-0001mP-N4
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rhh-0000qq-Lz
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:49:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rhg-0003XL-2G
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596527382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DubP2PHuYgedFkG9BnFDW3kZHoveZWoPNSRntSxbcE8=;
 b=IZdjL/bfSbMpdPokTYdRnI73fWJ2nF6dFOdvf7aDMzI1fqJxOp8Y6i66VCuLssNg2HnCiO
 359UJHpZsIg3tGYHuk8Z9v07rvHFfS78XPG2MAf9NCzBCYE1SxvKzQP1he+DVaB4/gduZV
 l1I3XhO7CyMbCcSv9T7jevwP77ImW4M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-BJxV1MUKMkGgO5GGexx0nw-1; Tue, 04 Aug 2020 03:49:39 -0400
X-MC-Unique: BJxV1MUKMkGgO5GGexx0nw-1
Received: by mail-wr1-f70.google.com with SMTP id t3so11300608wrr.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DubP2PHuYgedFkG9BnFDW3kZHoveZWoPNSRntSxbcE8=;
 b=rgJrf+wVEEBYSwrp471QFUx4WiQZp8d986UmCOMAc5GBD3d/Qayxa1ooGSWsPWY8Hw
 pnQV+BWGKUF0JAU4cQi4Hw1Gy3veF9sJEHlVAWtQ7ig0ZtOfMUn/U1RUi4/vaSBMFlmi
 zlUAlRLOYKoh6nxVem/alIOdECJUknVM1Iom8Hc9it538b7oCdNF43AV3uyhF8YtLvrK
 T1T8b7MufgCtU/zQK6C1Xa5Jr/+3MDRBaLsk1pJrkmOrXNcOAclgxYJ1Pto7bVg8sktm
 YUUw2AkULudcAYuh752FnxPrtgInWMCeZVQg4DbWNUG33yi27jaemL2a6IZvRpw9Wpdc
 /tPA==
X-Gm-Message-State: AOAM532UnHCaqsGVW9RoLtpvlBbbanAzOgs6V59JwR/BdWBHTQQVFPwH
 bm1uMNOKVeb0vmxrujFyeDgVTmEu2PGyf9jRCkgDARZcjd6MHk+zTedLZGSrxjfjZtFpi53/LB9
 gvROndCmntTVGqcs=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr2831212wmc.138.1596527377724; 
 Tue, 04 Aug 2020 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNZ4uQ4vB8a5aJh7I4ZPsgC9K6vuCsuWWzRpjP2pDwPhZtBykcSfO33F9dwpNAm2EMiOXt+A==
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr2831191wmc.138.1596527377467; 
 Tue, 04 Aug 2020 00:49:37 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 8sm30384185wrl.7.2020.08.04.00.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 00:49:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Date: Tue,  4 Aug 2020 09:49:30 +0200
Message-Id: <20200804074930.13104-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804074930.13104-1-philmd@redhat.com>
References: <20200804074930.13104-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CONFIG_XEN is generated by configure and stored in "config-target.h",
which is (obviously) only include for target-specific objects.
This is a problem for target-agnostic objects as CONFIG_XEN is never
defined and xen_enabled() is always inlined as 'false'.

Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
when we don't know to force the call of the non-inlined function,
returning the xen_allowed boolean.

Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
Reported-by: Paul Durrant <pdurrant@amazon.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/xen.h   | 18 ++++++++++++++----
 accel/stubs/xen-stub.c |  2 ++
 accel/xen/xen-all.c    |  7 +------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 1ca292715e..2c2c429ea8 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -8,9 +8,19 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
-#ifdef CONFIG_XEN
+#ifdef NEED_CPU_H
+# ifdef CONFIG_XEN
+#  define CONFIG_XEN_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_XEN_IS_POSSIBLE
+#endif
 
-bool xen_enabled(void);
+#ifdef CONFIG_XEN_IS_POSSIBLE
+
+extern bool xen_allowed;
+
+#define xen_enabled()           (xen_allowed)
 
 #ifndef CONFIG_USER_ONLY
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
@@ -18,7 +28,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 #endif
 
-#else /* !CONFIG_XEN */
+#else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
 #ifndef CONFIG_USER_ONLY
@@ -33,6 +43,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 }
 #endif
 
-#endif /* CONFIG_XEN */
+#endif /* CONFIG_XEN_IS_POSSIBLE */
 
 #endif
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index dcca4e678a..8ae658acff 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -9,6 +9,8 @@
 #include "hw/xen/xen.h"
 #include "qapi/qapi-commands-misc.h"
 
+bool xen_allowed;
+
 void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
 }
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 0c24d4b191..60b971d0a8 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -32,12 +32,7 @@
     do { } while (0)
 #endif
 
-static bool xen_allowed;
-
-bool xen_enabled(void)
-{
-    return xen_allowed;
-}
+bool xen_allowed;
 
 xc_interface *xen_xc;
 xenforeignmemory_handle *xen_fmem;
-- 
2.21.3


