Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99665C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6678D206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He4oEeTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6678D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPnl-0000eg-MW
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgY-0006mC-Re
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgU-0000wU-Dx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEzGP/ZApkAb2DZHP89viWXOV6fIUAQzfhGOYXXmOvs=;
 b=He4oEeTzc7yadVk8pvw6nhBi+a8N4OSYNceixEOvzyeSoErFk7bkEtWbLBZR3SYN2eEYJT
 ubpMPT7kNhYfKPk0ESzALoWpD57WDfe4OarQ8P/um9YaGlg3DmE74Y/SzaUvmIFoy6Op/K
 5vVaGKPBAm06VSMZaU4VACKtJ0Ngqt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-rp4wuXG2MqWrubnld8rDUg-1; Thu, 11 Jun 2020 12:04:02 -0400
X-MC-Unique: rp4wuXG2MqWrubnld8rDUg-1
Received: by mail-wr1-f69.google.com with SMTP id c14so2717952wrm.15
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LEzGP/ZApkAb2DZHP89viWXOV6fIUAQzfhGOYXXmOvs=;
 b=oYOPM1MGHysQrpWyM1SuJ1y+udDxZoABLxdnINNCqDesXyKQ94jIgrzpJJn8WyHaQ+
 8/6oUpRr1TSvE7fveX+V1bywYo6WqSba1IaYsVXcKNGnNaW01WU9GJGLHYsDJ4EwiVBb
 iB/ZgPazi4qm/pdeiZ2OAYx+cAOfvBBFDxXpsddlD15xfQDcT2zWMUKlP94T4Ug++XdB
 tvYDsV6HoU+cX6hZWLS9KdXHf1pwKLVg06GjkR8P9kfGfU3GZSiJ9hstsmtVUdfubqEG
 isZyBX4p5hxtmoQzBM3Q1nyaJjco5Zrbdybwz+AoQbtsbqDYA85CJHTE4rg31LscutPU
 xT8g==
X-Gm-Message-State: AOAM5313Y6qCxqWlpuXd1cSQY3eazDCec/ijtOEf3QXV44m/8b580joa
 KHSguWpc+2PTtD9sYMlQxn2GJIRID2Aisp1bmp5Kid8E0xjLC2hvEimb+mMNaN4uWG55plBlJvX
 kSbMy7l6rU9hGfGE=
X-Received: by 2002:adf:e592:: with SMTP id l18mr10885064wrm.175.1591891440570; 
 Thu, 11 Jun 2020 09:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr6hsSerWY3PPXj2dXIsrjsSKE/2HnUUReffRoeH4BpmSH+d6lxlEDiR1+vJ9Bv/TEyvV7qw==
X-Received: by 2002:adf:e592:: with SMTP id l18mr10885029wrm.175.1591891440324; 
 Thu, 11 Jun 2020 09:04:00 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r12sm5903519wrc.22.2020.06.11.09.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/11] hw/tpm: Make 'tpm_util.h' publicly accessible as
 "sysemu/tpm_util.h"
Date: Thu, 11 Jun 2020 18:03:05 +0200
Message-Id: <20200611160306.2751-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split the TPM backends from the TPM emulated
hardware in the next commit. Make the TPM util helpers accessible
by moving local "tpm_util.h" to global "sysemu/tpm_util.h".

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/specs/tpm.rst                    | 4 ++--
 {hw/tpm => include/sysemu}/tpm_util.h | 6 +++---
 hw/tpm/tpm_crb.c                      | 2 +-
 hw/tpm/tpm_emulator.c                 | 2 +-
 hw/tpm/tpm_passthrough.c              | 2 +-
 hw/tpm/tpm_spapr.c                    | 2 +-
 hw/tpm/tpm_tis_common.c               | 2 +-
 hw/tpm/tpm_util.c                     | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)
 rename {hw/tpm => include/sysemu}/tpm_util.h (95%)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 9e48e3b981..0200fdac68 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -234,7 +234,7 @@ PCRs.
 QEMU files related to the TPM passthrough device:
  - ``hw/tpm/tpm_passthrough.c``
  - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``include/sysemu/tpm_util.h``
 
 
 Command line to start QEMU with the TPM passthrough device using the host's
@@ -294,7 +294,7 @@ command.
 QEMU files related to the TPM emulator device:
  - ``hw/tpm/tpm_emulator.c``
  - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``include/sysemu/tpm_util.h``
 
 The following commands start the swtpm with a UnixIO control channel over
 a socket interface. They do not need to be run as root.
diff --git a/hw/tpm/tpm_util.h b/include/sysemu/tpm_util.h
similarity index 95%
rename from hw/tpm/tpm_util.h
rename to include/sysemu/tpm_util.h
index cf61d830d7..63e872c3b2 100644
--- a/hw/tpm/tpm_util.h
+++ b/include/sysemu/tpm_util.h
@@ -19,8 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#ifndef TPM_TPM_UTIL_H
-#define TPM_TPM_UTIL_H
+#ifndef SYSEMU_TPM_UTIL_H
+#define SYSEMU_TPM_UTIL_H
 
 #include "sysemu/tpm.h"
 #include "qemu/bswap.h"
@@ -69,4 +69,4 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
-#endif /* TPM_TPM_UTIL_H */
+#endif /* SYSEMU_TPM_UTIL_H */
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 1cac4d671d..60247295d4 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -24,9 +24,9 @@
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "sysemu/reset.h"
 #include "tpm_prop.h"
-#include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 3a0fc442f3..9605339f93 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -32,8 +32,8 @@
 #include "qemu/sockets.h"
 #include "io/channel-socket.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_int.h"
-#include "tpm_util.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f67244b5d4..7403807ec4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -28,10 +28,10 @@
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_int.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-tpm.h"
-#include "tpm_util.h"
 #include "trace.h"
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 65672048c7..cb4dfd1e6a 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -20,7 +20,7 @@
 #include "migration/vmstate.h"
 
 #include "sysemu/tpm_backend.h"
-#include "tpm_util.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_prop.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 94704870f6..64206a6a3b 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -33,7 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
-#include "tpm_util.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index c0a0f3d71f..d0ec2a8235 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -23,11 +23,11 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "tpm_util.h"
 #include "tpm_int.h"
 #include "exec/memory.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "trace.h"
 
 /* tpm backend property */
-- 
2.21.3


