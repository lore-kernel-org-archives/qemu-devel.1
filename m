Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CD02086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PJuDZU7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CD02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tEH-0005gg-1f
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2tDU-0004r8-Kh
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:26:40 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:6701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2tDQ-0000Cq-AN
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1596533196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q3ReqT69K9XKGGN+e8ZybiqO+/keDcz0thRqBcGSR3M=;
 b=PJuDZU7YA6QqQuVLD61DtRbbfcqZDDdEOwfPjaqAc2iFCW4u8ihUzPPO
 C8/WviHaDu7wdqDy78Fd0ns+e6s/gEdv0xCJxboRG0oh5ZuJYpcYEgPc+
 IKXcjifPfjDD0cPBwp/QeD80U5h37KlmNbwAyuhZyIGvHH7LQICkIW2EB s=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: Eq+gN6YFmS3ohlQqKPhOe2NcoL+vSDTiKtV8jXYqR+o7M3gFioVAeSG2I1hriVOiye0+/6X/8h
 OqfLandO1LO14rrROu8L9enqiFcL2gLkDkVY+0SVwQ6ouPLhjJ41HSoB/Qi0BogF5/OcytdetB
 mIxVAeP0V93Qzse3rdr+TlFOhU7KTCfEYYrsOz+4vM5iLXQmyRRmWkuGRVB86HgBJEBdrB0JOH
 +TH3asiD+AJ9QUYIWOd4nz/Tv3VItzy03bKZLluN7MhPuT0A74mPOv+nNCXvrOKAsNJs2wTgDE
 6C4=
X-SBRS: 3.7
X-MesageID: 24124488
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,433,1589256000"; d="scan'208";a="24124488"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 1/1] accel/xen: Fix xen_enabled() behavior on target-agnostic
 objects
Date: Tue, 4 Aug 2020 10:26:24 +0100
Message-ID: <20200804092624.1126013-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200804092624.1126013-1-anthony.perard@citrix.com>
References: <20200804092624.1126013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=anthony.perard@citrix.com; helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 05:26:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

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
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200804074930.13104-2-philmd@redhat.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 accel/stubs/xen-stub.c |  2 ++
 accel/xen/xen-all.c    |  7 +------
 include/sysemu/xen.h   | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index dcca4e678a13..8ae658acff5f 100644
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
index 0c24d4b191a4..60b971d0a82f 100644
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
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 1ca292715e69..2c2c429ea8bf 100644
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
+
+#ifdef CONFIG_XEN_IS_POSSIBLE
+
+extern bool xen_allowed;
 
-bool xen_enabled(void);
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
-- 
Anthony PERARD


