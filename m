Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E6A206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXFrgQno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E6A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj71Y-0002OS-Lw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wb-00049x-GS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wa-0000Yr-E2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBmA6OUMALtJ8xKCCMlgV7Bdi6Khl1WaOLeqs/fgHnc=;
 b=ZXFrgQnoXk8g6Ab2uo23He3wx7BZiCAjCqL/hqpPQqyvaZqKv+c9MWi4IQ25XDygbkBAik
 wk6n0buab6FXygtG5x7FDBPHdjk7g3cEBUgyn0YybiXg3OJWvDSix5hHWu2S9n6mQgPXqO
 cSpmJXwQg7ZVjFBqp248+mBeSMkmK4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-g1MqwYADNMua87OORbkSJQ-1; Wed, 10 Jun 2020 16:03:26 -0400
X-MC-Unique: g1MqwYADNMua87OORbkSJQ-1
Received: by mail-wm1-f72.google.com with SMTP id 14so703482wmi.8
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YBmA6OUMALtJ8xKCCMlgV7Bdi6Khl1WaOLeqs/fgHnc=;
 b=BqamJ2AQ5pFZF/A/fx0iyCGj5nhfrfxva3ot5f8gcL86wcsQJ1mmG/1o+ed63cX9oj
 FFJae09JkPSU+1sf2iab772+eF0dVbPbbW+xiUdHIjowSM3Tn8aIpxwoVrWmoG3YCt4d
 bXYRn1vJhygRCHF1pGfWAcbdnHtB0eDlT6dKoO9v9elRICEGQCMJUGqmKnUINS8IXPGv
 nYIIE9rEhgQ2DiF9tKpTEtmoDHAO/MVfGtRlC6X4iUfBw+DdJS7RROK6m5TkxLb25bAC
 3+c9yg26ymD+ZQfSc6eyY5aJZNDeGxcsNOa/b41nvPWi4AzM6gUwncyOWTMw28BSS3K2
 kzvw==
X-Gm-Message-State: AOAM531qMCqEHvGh2oLrE0TjG7IB6JaSVsddOoxRpp2XVRFCMtEXnJC2
 D4OaJ2fglrZ8jEqi8AiUSAmu/s5FkQmzp8oCsUoxPUQdmFCpu3V02TKbdK500mttcTmwDu4YDG/
 6sbQOyCgjtdFCZmw=
X-Received: by 2002:adf:b697:: with SMTP id j23mr5862807wre.201.1591819404743; 
 Wed, 10 Jun 2020 13:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQUd1a+5qxOQ935HoLy0GDgZvXy0rT93TNPtQkZs5a+DhdP4ana7+FXWbZRVyGNb5+OmatFQ==
X-Received: by 2002:adf:b697:: with SMTP id j23mr5862788wre.201.1591819404547; 
 Wed, 10 Jun 2020 13:03:24 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o10sm1219823wrq.40.2020.06.10.13.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:03:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] hw/tpm: Make 'tpm_util.h' publicly accessible as
 "sysemu/tpm_util.h"
Date: Wed, 10 Jun 2020 22:02:46 +0200
Message-Id: <20200610200247.21378-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:41
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split the TPM backends from the TPM emulated
hardware in the next commit. Make the TPM util helpers accessible
by moving local "tpm_util.h" to global "sysemu/tpm_util.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 {hw/tpm => include/sysemu}/tpm_util.h | 6 +++---
 hw/tpm/tpm_crb.c                      | 2 +-
 hw/tpm/tpm_emulator.c                 | 2 +-
 hw/tpm/tpm_passthrough.c              | 2 +-
 hw/tpm/tpm_spapr.c                    | 2 +-
 hw/tpm/tpm_tis_common.c               | 2 +-
 hw/tpm/tpm_util.c                     | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename {hw/tpm => include/sysemu}/tpm_util.h (95%)

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


