Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4AAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4AA206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ1bmmLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4AA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKHg-0001WU-JO
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCy-00060E-4T
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCv-0007Sg-4B
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qtqeym41wYPVUNcQP0hBuZd3ZN8CptiJr597zGfRw0=;
 b=ZJ1bmmLC8MzdFyhdJ/AYRnrDCyOMjqlp8Q3RNPHP7aw673+RFfO7MAjat4egBPWFlRoMh5
 KlHhjiLzfymReJojXx53IxMXyUGhDC0Q6sYBvyofF8yCZCYEuoHuDCuVigj6NumCRljMpS
 QBJbsDReAANM/DWECAyami/OuifkIMs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-ejv9qRkTPNqTR5-ir2nueQ-1; Mon, 08 Jun 2020 12:01:00 -0400
X-MC-Unique: ejv9qRkTPNqTR5-ir2nueQ-1
Received: by mail-wr1-f69.google.com with SMTP id e1so7365935wrm.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5qtqeym41wYPVUNcQP0hBuZd3ZN8CptiJr597zGfRw0=;
 b=l4oB4BjVI388rSNJWLyI0yKRGmPqxt1ZQJ/2SYEnk0gnirMMeGmECDpXxlyljoaJE5
 fLxqhiz1BjqIc2dlLdA5djfaooe1GoH0CZ22DGb9d17kARSrzSq+sz8NnhhohTwCGXiT
 7ByukbZxGbMglwuHoBScJoOZDEXYV1PdtBIrEJjR7mHRvAVRcK5pdEP4j5sYnxkYqOYj
 ZolK5tkV/EpLIVElv7hg4wCtmEHw88lLaubcSMgN99OGhnpZOXhdbuy7wlmL4vaaEftX
 +a8dL2360R8iu1R1fsrHdqe1VF/mhD+MuR4DUdOAn8Rbkv7KlZiVGAuhf6drq+hW1Rm6
 60jg==
X-Gm-Message-State: AOAM531RmPCcg24GQEtEC6AiOiorI3KosdL0EWEF+4EjhxxtoPkba6z+
 BsBQ5e7Bxu2zitmINF1buHPOsS0Y1qcY4VLMu/OpYzlYC0tZ6T2XP6oyMawWRR+Omg7OCtYhBs9
 wHGy/FBOATDlEJ+U=
X-Received: by 2002:adf:de0b:: with SMTP id b11mr24236302wrm.346.1591632059268; 
 Mon, 08 Jun 2020 09:00:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCLkZjArfyp0BDfLlr7paJJyNdZb8aPEICM5cLMV+w6rNjL53A+D/YIALTIycqApB88KkdKg==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr24236267wrm.346.1591632059025; 
 Mon, 08 Jun 2020 09:00:59 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z12sm227313wrg.9.2020.06.08.09.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:00:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/35] hw/core/qdev: Add
 qdev_warn_deprecated_function_used() helper
Date: Mon,  8 Jun 2020 18:00:11 +0200
Message-Id: <20200608160044.15531-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
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
 configure                    |  8 ++++++++
 include/hw/qdev-deprecated.h | 26 ++++++++++++++++++++++++++
 hw/core/qdev.c               |  8 ++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 include/hw/qdev-deprecated.h

diff --git a/configure b/configure
index 597e909b53..9b7a8927c6 100755
--- a/configure
+++ b/configure
@@ -434,6 +434,7 @@ edk2_blobs="no"
 pkgversion=""
 pie=""
 qom_cast_debug="yes"
+qdev_deprecation_warning="no"
 trace_backends="log"
 trace_file="trace"
 spice=""
@@ -1114,6 +1115,8 @@ for opt do
   ;;
   --enable-qom-cast-debug) qom_cast_debug="yes"
   ;;
+  --enable-qdev-deprecation-warning) qdev_deprecation_warning="yes"
+  ;;
   --disable-virtfs) virtfs="no"
   ;;
   --enable-virtfs) virtfs="yes"
@@ -1882,6 +1885,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
   qom-cast-debug  cast debugging support
+  qdev-deprecation-warning display qdev deprecation warnings
   tools           build qemu-io, qemu-nbd and qemu-img tools
   vxhs            Veritas HyperScale vDisk backend support
   bochs           bochs image format support
@@ -6723,6 +6727,7 @@ echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh support    $libssh"
 echo "QOM debugging     $qom_cast_debug"
+echo "QDEV deprecation warnings $qdev_deprecation_warning"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
@@ -7345,6 +7350,9 @@ fi
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
index 9e5538aeae..901fa93657 100644
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
@@ -819,6 +820,13 @@ void qdev_alias_all_properties(DeviceState *target, Object *source)
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


