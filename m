Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7421C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83435206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKYvIaB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83435206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj74y-0007HO-RB
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wa-00048M-Na
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wZ-0000Yf-LD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/5UhBc1iPrxzhHD36gZev3Sa1aP8yuUYEtevuhDJHg=;
 b=BKYvIaB30kqCinn8E42y2iFRLJ0LsQre27OdpZ/x2kTl9iKyVnXP51+tV1nJM5BmwMgNZd
 C4tOQP2/l+HKA2LQuXGNBTdeGx3eAT8GJ7ndd0u0CGlyKZfaJ24J+FvlQTEHd5aN27Bprs
 O8iYEO2CtPODukWncUxnQNo9fgcLEUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-0tPdxLhzM8eujLQT5B19DA-1; Wed, 10 Jun 2020 16:03:21 -0400
X-MC-Unique: 0tPdxLhzM8eujLQT5B19DA-1
Received: by mail-wm1-f69.google.com with SMTP id j128so734140wmj.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3/5UhBc1iPrxzhHD36gZev3Sa1aP8yuUYEtevuhDJHg=;
 b=kNrr/egqwGYyi3/RbjaiwvsBkfy67RcQCm4HF2vnDUBd1JLa0/ADzmDIYod2rc6BeM
 QcnT/trHROX1GyG4d8zY/Vubevb8eLUWNJwNtPDCEHiTGPhL8hAFXr/cNI9Si8PkuCM+
 ic/0iHOaorpVehcput9hmTtdIFTnBzs0D4RczyTfRDq51O9LVL6Cw0Q7M0wwbzKff/IV
 V+i1pOJYYscgs0KtSflspi6I42sOBalJLG9XFZ97eCI14dBzgOTdNmkFFHNbdIQKbKPL
 RiQVONaT7Rk3lC+6aXRMpbJci3BwPuD7NR19dJTdQMtawRxNCaM8iOgs4vlEHUOrFntc
 GW8g==
X-Gm-Message-State: AOAM5335qq/X4ibDpvp5q4KLqc1tfoYvOT0s8JTxhnI4JSnA1V8DVfqw
 vyDzLP6e+i1mQYyS5ZTEPZf1fYP1Zu8J2aYORXvXWZnbrosSB9oa3+/1oEy6rVWOyfj6SEhvAz9
 o0V6I2z+m4CpIiTM=
X-Received: by 2002:adf:9205:: with SMTP id 5mr5246501wrj.232.1591819400007;
 Wed, 10 Jun 2020 13:03:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMs7oVP6rAs/70ZjLoyG8AlDe1sLXg1KFwZKoUgrozu0Z7A3jukcwIVib6hDvBzIH5DWpwZg==
X-Received: by 2002:adf:9205:: with SMTP id 5mr5246479wrj.232.1591819399786;
 Wed, 10 Jun 2020 13:03:19 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s8sm1317963wrg.50.2020.06.10.13.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:03:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h'
 local header
Date: Wed, 10 Jun 2020 22:02:45 +0200
Message-Id: <20200610200247.21378-7-philmd@redhat.com>
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

We are going to make "tpm_util.h" publicly accessible by
moving it to the include/ directory in the next commit.
The DEFINE_PROP_TPMBE() macro is only meaningful for the
TPM hardware files (in hw/tpm/), so keep this macro in a
local header.

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


