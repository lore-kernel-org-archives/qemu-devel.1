Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C1520801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpuP9p3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C1520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfaA-0000Pq-46
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTZ-0006Yj-F0
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTX-0007AF-GB
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEBGBSENtvQqVBtd9DaoSVHe6pzGLtI0FdTlX7YOxdE=;
 b=XpuP9p3fL/vdILAovmJOwG/jcNwTA7oMbp5DZgPmDkIyHnW6VPJiia+6WOYIOJAy8iWE9U
 1y7Kci6fmN7ege1OTHyRDhO8DARE8hp7G4i9J+iesUG022QwNYZuvYA+td/3emrrspsyO6
 qtrvFbUE7JHo1TmEnl3zVM39FU7KYMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-wtbmc-rDP0-Eh2Ueu71NKQ-1; Fri, 12 Jun 2020 04:55:43 -0400
X-MC-Unique: wtbmc-rDP0-Eh2Ueu71NKQ-1
Received: by mail-wm1-f70.google.com with SMTP id k185so1678534wme.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OEBGBSENtvQqVBtd9DaoSVHe6pzGLtI0FdTlX7YOxdE=;
 b=UO6Qk+3yv6H6yr8cmdRxhGLFQx3zp+CjGofNd5opQwhTs1zsReNRdIEbzFJupYvbpd
 uCLIHqyFszlEt2/hardRsDtOwWX6EHzrgCkLfVG8Hd+Tqq9yOFAuEH91vI21M7SBPddb
 /D0Jmr3T1M56Ln/lSx/4JqshIAfml2vnbBNT/5hANvBRizKQtL/847TJwXsy6XWv+SgQ
 7hfqsuBaiWjDUv1eAmbCrGm/e6lG+QEX2wo0uwkZ8JBXDLdyy9m+8Jl5v/G9ZcZsFecr
 PGorEgHFBnQDcmL5zcrmMs2vgcB2ITiEFaayZ8V2XbA4G+6IcUdHv0GdU8ODm6VfjQ4w
 Ff+w==
X-Gm-Message-State: AOAM530NGbNxoWbLLrQgi7xCbwPBVbiIjLUbkGIHcy1kPF4eYo6SLvnE
 V/2LutvkiwSo8hfwGk0Jmr8n2u8Dg3vHAobW7zmG/Cii+0GtiX1ZeOVMj87TjF0wbxUfLhvfRFq
 G25lUbLfEs4hzd9c=
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr12588059wma.33.1591952141459; 
 Fri, 12 Jun 2020 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFY/m5AQtIAcilcRUYPHfC/lXiBCbq6fXKwRP9ToC/+wsEAe+Qcy1dtqD5HJTOHkiGaJ6GRw==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr12588037wma.33.1591952141189; 
 Fri, 12 Jun 2020 01:55:41 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j16sm10439181wre.21.2020.06.12.01.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] hw/tpm: Move DEFINE_PROP_TPMBE() macro to
 'tmp_prop.h' local header
Date: Fri, 12 Jun 2020 10:54:42 +0200
Message-Id: <20200612085444.8362-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to make "tpm_util.h" publicly accessible by
moving it to the include/ directory in the next commit.
The DEFINE_PROP_TPMBE() macro is only meaningful for the
TPM hardware files (in hw/tpm/), so keep this macro in a
local header.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_prop.h       | 31 +++++++++++++++++++++++++++++++
 hw/tpm/tpm_util.h       |  3 ---
 hw/tpm/tpm_crb.c        |  1 +
 hw/tpm/tpm_spapr.c      |  1 +
 hw/tpm/tpm_tis_isa.c    |  2 +-
 hw/tpm/tpm_tis_sysbus.c |  2 +-
 6 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 hw/tpm/tpm_prop.h

diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
new file mode 100644
index 0000000000..85e1ae5718
--- /dev/null
+++ b/hw/tpm/tpm_prop.h
@@ -0,0 +1,31 @@
+/*
+ * TPM utility functions
+ *
+ *  Copyright (c) 2010 - 2015 IBM Corporation
+ *  Authors:
+ *    Stefan Berger <stefanb@us.ibm.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef HW_TPM_PROP_H
+#define HW_TPM_PROP_H
+
+#include "sysemu/tpm_backend.h"
+#include "hw/qdev-properties.h"
+
+#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
+
+#endif /* HW_TPM_PROP_H */
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index d524935576..cf61d830d7 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -66,9 +66,6 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
     stl_be_p(b + 6, error);
 }
 
-#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
-
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 664ff70ef9..1cac4d671d 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -25,6 +25,7 @@
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/reset.h"
+#include "tpm_prop.h"
 #include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index ab1a86ad6e..65672048c7 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -21,6 +21,7 @@
 
 #include "sysemu/tpm_backend.h"
 #include "tpm_util.h"
+#include "tpm_prop.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 42f909ff1e..5faf6231c0 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -27,7 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
-#include "tpm_util.h"
+#include "tpm_prop.h"
 #include "tpm_tis.h"
 
 typedef struct TPMStateISA {
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index edca1dae0d..4a3bc70625 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -26,7 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
-#include "tpm_util.h"
+#include "tpm_prop.h"
 #include "hw/sysbus.h"
 #include "tpm_tis.h"
 
-- 
2.21.3


