Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18712C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E05206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHJSZaBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E05206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPlL-0004j7-V1
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgA-0006Gz-Kh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPg8-0000rT-Mk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2Oz/tFoTbJgZ+hpQsGEbztQQnHjY/PR/LdJBtph6qw=;
 b=PHJSZaBf2B0ZiV9U1W9EJQQseyVaMKgJZLec7/F7IdPJHpCQgUBPXe2xhxpITT5aQO//Sc
 LmNqwtCMeWkuUuNJNEdEsRC4lmpQhTaJ0G4cekFRtiBgSVFfn02NrNJsB0Y9swG8Vf/NnW
 zBkzYTJDHkiTF7eE5dbwZffkwe2XafY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-TC3R5MoVPAau_FYHOwOT6g-1; Thu, 11 Jun 2020 12:03:42 -0400
X-MC-Unique: TC3R5MoVPAau_FYHOwOT6g-1
Received: by mail-wm1-f72.google.com with SMTP id a18so1228369wmm.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D2Oz/tFoTbJgZ+hpQsGEbztQQnHjY/PR/LdJBtph6qw=;
 b=Geyuoz4AZk4rEF4PeEPKhfvoYd16/stB6XxEL27GfDtBz6tE6KVmHhapicDYIZJZFP
 LYd7T9RqYtlWIJhmWPHgM8w7QV8ku4ALTYKcFemaCkAcOV2UiIVPLXOeZrhk9djJWRpq
 0ZPyCd9pw5T3lPxCL7FLg4bLijAUTHXOgvXvktj0jqd/TwgH7L0hD6szvFdQngh0TDhc
 1kExap6rrtbdmYQV9Jsg48FAYMicQVxcalK7VvTRlOTrkedEO/kPsaM5Jp03hnk5H+cV
 gDtFZutRDJOg8wntyPH9gWj5MWRLoECEzzrczLdeRBlN+8WEI/IJMjlhZPQpumTHLzv1
 gSsA==
X-Gm-Message-State: AOAM530eeNF3tBoGzBQ2fLgIpknW69UVUIWu0LyqVQWNjU5CGtVlLea8
 w+C1e0YsVyjR3s/zOxsqiW7yyi0CdgCFyrX6FZFhDI5hnd2Rr73W4EYvGTzv/e5dt3CZJkr/83c
 21EDUQNAKgS4LE1c=
X-Received: by 2002:adf:a396:: with SMTP id l22mr10088073wrb.24.1591891420960; 
 Thu, 11 Jun 2020 09:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+92LqUlLMF4TaKWAxAo/OkPvnUh1NRTmPyoijjDW83gvwHj4TyOtFB/+bmHGpwQzZqv2JGQ==
X-Received: by 2002:adf:a396:: with SMTP id l22mr10088046wrb.24.1591891420708; 
 Thu, 11 Jun 2020 09:03:40 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o10sm5515821wrj.37.2020.06.11.09.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header
 to sources
Date: Thu, 11 Jun 2020 18:03:01 +0200
Message-Id: <20200611160306.2751-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
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


