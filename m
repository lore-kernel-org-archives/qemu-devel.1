Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4512E206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA3iewRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4512E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfW9-0003od-Ix
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTB-0005hL-Lw
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTA-0006zZ-5c
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2Oz/tFoTbJgZ+hpQsGEbztQQnHjY/PR/LdJBtph6qw=;
 b=DA3iewRt4nme0elNNPvNt2fQkhFuSSGJG+USUXkbL/TWyhqFPn8huOzN/8qVwZEi9JGkC9
 wCT4AJg7EYCwpqZfzQXeVkK8u3IWjl4Jq6Lei9Af9Gn22ZnwpvHKVu4JIE+t9HoNNCF7VX
 fcyBu1TKzCt2OoKRp9dMeV2ZMIBu2dM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-AH0Gpw2gMiCgLqv2OfgvmA-1; Fri, 12 Jun 2020 04:55:21 -0400
X-MC-Unique: AH0Gpw2gMiCgLqv2OfgvmA-1
Received: by mail-wm1-f71.google.com with SMTP id 11so1679300wmj.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D2Oz/tFoTbJgZ+hpQsGEbztQQnHjY/PR/LdJBtph6qw=;
 b=sHriVZCHHr+KF792JZfr/Zrp6NPcgux5Y5puhNcuGC1ot7R48+OYJpQrlSgtyXiM9A
 ufp9scJdlJ/htO7grnbV/54qMU529iI09MBOir037FvGDtkNRCazWT/6tXEMl1KMt1be
 Xw3W8nQiDIl6r8WSb8S1OUYsdG5ExoloH3/wOECmjlCLAtGYCdxZIUJMA4SrN/4AyI7Y
 uFRVl1UP+TQE6ATinLcO+0H8Ji5Qa9tLRr7lVbGT7NfKsoRE5LTJGs9+Wy5VihT/83mK
 Os5JeygzGERYLz8gfLPA77/1Hhw2QbweZE5r2H3o9FryNRZHB3jd2Y0D5qCVOfrU+x/I
 1yVA==
X-Gm-Message-State: AOAM530tB+F+o+lbD+zs00b8LlHkPOZpfSbrl5OFECetQwqzU39XtEYC
 HvjLq6Hf1wvomaIbYUdRYod/tMI70elwyN9Z+JLa4hTc7BtXFYZZtBDBGr4io8rL5VUmqnF+KKv
 x+0A0N5aPsXrY828=
X-Received: by 2002:adf:e78a:: with SMTP id n10mr14398809wrm.114.1591952120151; 
 Fri, 12 Jun 2020 01:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnvjuTk03GTBGqHJhBe5MexDr/FYhNrw/G/+3BZOUOL1xtoOARpcs73NL/JfjjwO4rMvTZ9w==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr14398795wrm.114.1591952119928; 
 Fri, 12 Jun 2020 01:55:19 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t7sm8396164wrq.41.2020.06.12.01.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/12] hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header
 to sources
Date: Fri, 12 Jun 2020 10:54:38 +0200
Message-Id: <20200612085444.8362-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:54:57
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
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nothing in "tpm_ppi.h" require declarations from "hw/acpi/tpm.h".
Reduce dependencies and include it only in the files requiring it.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_ppi.h        | 1 -
 hw/tpm/tpm_ppi.c        | 1 +
 hw/tpm/tpm_tis_isa.c    | 1 +
 hw/tpm/tpm_tis_sysbus.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index d33ef27de6..6f773c25a0 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -12,7 +12,6 @@
 #ifndef TPM_TPM_PPI_H
 #define TPM_TPM_PPI_H
 
-#include "hw/acpi/tpm.h"
 #include "exec/address-spaces.h"
 
 typedef struct TPMPPI {
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 6d9c1a3e40..72d7a3d926 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -17,6 +17,7 @@
 #include "cpu.h"
 #include "sysemu/memory_mapping.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/tpm.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 30ba37079d..42f909ff1e 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/tpm.h"
 #include "tpm_util.h"
 #include "tpm_tis.h"
 
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index eced1fc843..edca1dae0d 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/tpm.h"
 #include "tpm_util.h"
 #include "hw/sysbus.h"
 #include "tpm_tis.h"
-- 
2.21.3


