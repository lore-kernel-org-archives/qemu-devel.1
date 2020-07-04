Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF017208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQAD4Su3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF017208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkIC-0003O3-6u
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGK-0000zk-6Z
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGI-0007U9-3M
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuGL8s6Y6URpcSNtr04xteyMjyUSDj0tV/o+btZV9Wk=;
 b=gQAD4Su3QAYn/HnnmdZ8m7L6td6RXinkyj1+nF0OYI3npbKV8UWa1oWl59MnwnP8/CbImi
 QRbtO52bkQPkihDpgi9tVxu+49bCD0t49d7G0jCdZy7szWr5/X19bIu8nTZxcUzrQi8hP6
 2N/Vf76ILNW070PCa9VPy4vdg8SPXSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-S2J_Yr8UMUugQz6J38B_-g-1; Sat, 04 Jul 2020 11:39:24 -0400
X-MC-Unique: S2J_Yr8UMUugQz6J38B_-g-1
Received: by mail-wm1-f70.google.com with SMTP id g6so33903116wmk.4
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GuGL8s6Y6URpcSNtr04xteyMjyUSDj0tV/o+btZV9Wk=;
 b=Zp65qnrBgqREqyyH19E/fG0bqS6bxLZ4bOJ6mPDA+KIetZ53VZv3L0UEhZIF+xWFoM
 6QmMWuPrPbDqX+g45FycdjpU5ZXCePkneWEo8jCctI+gf1/QAj/hf6xB26zJ4XehLDg7
 rT/mcbXbdjEo64dgnwP5HDecK8UnZZczPl/l7j6EvIMzUECy7u1z8BfGOqM5lFG7gRsT
 Cba7olwY2kMfcugl7YPM2Cc3Wg6ygx44wlhRmmaJaukiX7HygZ4t4/rjP0wAEb2FbBVA
 111IV6KSmBopVfQNmQayiY9QgnoCcN+Gc2KiOvEDQpFcuU0eje8IFVii83XCmAV/wOAG
 9m/Q==
X-Gm-Message-State: AOAM532fFt6lUDcZyoti3dxwTwitrV7afBG648ljLRgsnqrwHf3ujEGa
 FNbiuqMJO449E6AJmBnLTWYXhoDOrpzaC+QGkOPUFjqKNnSHmJ8T9+WpREIaW626oyOOxlawB7s
 G8V5OJQqQxc8Gnmc=
X-Received: by 2002:adf:fac8:: with SMTP id a8mr12152865wrs.368.1593877162695; 
 Sat, 04 Jul 2020 08:39:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZRv9/lwGDgzqtfWRi8evJQZCpRLoZKGzZD2as3kqahxAbsMaLzXOum5g8F2YJmelnvLmX8Q==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr12152843wrs.368.1593877162442; 
 Sat, 04 Jul 2020 08:39:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f16sm16564180wmh.27.2020.07.04.08.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 02/23] hw/core/qdev: Add
 qdev_warn_deprecated_function_used() helper
Date: Sat,  4 Jul 2020 17:38:47 +0200
Message-Id: <20200704153908.12118-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When built with --enable-qdev-deprecation-warning, calling
qdev_warn_deprecated_function_used() will emit a warning such:

  $ qemu-system-arm -M verdex ...
  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa2xx_lcdc_init()
  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa2xx_i2s_init()
  qemu-system-arm: warning: use of deprecated non-qdev/non-qom code in pxa27x_keypad_init()

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
I'd rather use --enable-qdev-debug suggested here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg719802.html
---
 configure                    |  8 ++++++++
 include/hw/qdev-deprecated.h | 26 ++++++++++++++++++++++++++
 hw/core/qdev.c               |  8 ++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 include/hw/qdev-deprecated.h

diff --git a/configure b/configure
index 8a65240d4a..aac3dc0767 100755
--- a/configure
+++ b/configure
@@ -441,6 +441,7 @@ edk2_blobs="no"
 pkgversion=""
 pie=""
 qom_cast_debug="yes"
+qdev_deprecation_warning="no"
 trace_backends="log"
 trace_file="trace"
 spice=""
@@ -1124,6 +1125,8 @@ for opt do
   ;;
   --enable-qom-cast-debug) qom_cast_debug="yes"
   ;;
+  --enable-qdev-deprecation-warning) qdev_deprecation_warning="yes"
+  ;;
   --disable-virtfs) virtfs="no"
   ;;
   --enable-virtfs) virtfs="yes"
@@ -1915,6 +1918,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
   qom-cast-debug  cast debugging support
+  qdev-deprecation-warning display qdev deprecation warnings
   tools           build qemu-io, qemu-nbd and qemu-img tools
   vxhs            Veritas HyperScale vDisk backend support
   bochs           bochs image format support
@@ -6966,6 +6970,7 @@ echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh support    $libssh"
 echo "QOM debugging     $qom_cast_debug"
+echo "QDEV deprecation warnings $qdev_deprecation_warning"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
@@ -7594,6 +7599,9 @@ fi
 if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
+if test "$qdev_deprecation_warning" = "yes" ; then
+  echo "CONFIG_QDEV_DEPRECATION_WARNING=y" >> $config_host_mak
+fi
 if test "$rbd" = "yes" ; then
   echo "CONFIG_RBD=m" >> $config_host_mak
   echo "RBD_CFLAGS=$rbd_cflags" >> $config_host_mak
diff --git a/include/hw/qdev-deprecated.h b/include/hw/qdev-deprecated.h
new file mode 100644
index 0000000000..b815f62dae
--- /dev/null
+++ b/include/hw/qdev-deprecated.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU QOM qdev deprecation helpers
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef HW_QDEV_DEPRECATED_H
+#define HW_QDEV_DEPRECATED_H
+
+/**
+ * qdev_warn_deprecated_function_used:
+ *
+ * Display a warning that deprecated code is used.
+ */
+#define qdev_warn_deprecated_function_used() \
+    qdev_warn_deprecated_function(__func__)
+void qdev_warn_deprecated_function(const char *function);
+
+#endif
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..1134f46631 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -35,6 +35,7 @@
 #include "hw/hotplug.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-deprecated.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-clock.h"
@@ -838,6 +839,13 @@ void qdev_alias_all_properties(DeviceState *target, Object *source)
     } while (class != object_class_by_name(TYPE_DEVICE));
 }
 
+void qdev_warn_deprecated_function(const char *function)
+{
+#ifdef CONFIG_QDEV_DEPRECATION_WARNING
+    warn_report("use of deprecated non-qdev/non-qom code in %s()", function);
+#endif
+}
+
 static bool device_get_realized(Object *obj, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-- 
2.21.3


