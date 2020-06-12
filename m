Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87472206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI7o7Cpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87472206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfVl-0002ta-RE
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT5-0005Xu-Ky
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT3-0006yu-Vv
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShKU7OwwvJdTi39LcBZXKgzHPvYAnCTLu/v0xUKYxK8=;
 b=DI7o7Cpt2CkQ9VrpZM8BCGX4Z3ly6N3NahPWU3cNTje5kAe1kt5G+fJSm/tX71CSUiC19k
 drr+6aHgJN8VI+PXwKlJG9tpK2k/2Gr+eLUkY3ZoKWFhaq1VfovzpVQ0KJOkCSPSLSEW53
 FuNRPmE0nxxgcpHgVitM16VMySKP/aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-0kPVnHzDNaiJVwXQxbQHlQ-1; Fri, 12 Jun 2020 04:55:05 -0400
X-MC-Unique: 0kPVnHzDNaiJVwXQxbQHlQ-1
Received: by mail-wm1-f69.google.com with SMTP id j128so2182099wmj.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ShKU7OwwvJdTi39LcBZXKgzHPvYAnCTLu/v0xUKYxK8=;
 b=ixeLRhkLuC3Rig8GUvMCo668maEsWuORzDNJ8IxxL+ayUGyB59lnwCcsBPSlT3roel
 3bRp6vrxKA0HrbFUuZjH3hwbbPRz5Hha/wDtxLTEU3GlC0fq6nNxWiCtOe/+HQ4mUTIJ
 1PGQDs3IBSHjAc1bTa72FJnxqx9KN1tUDl7rgczNeUI62A0Y0pQNazy+5fQKiGivkTqf
 BBUORW0nrn3d3nJZPUCd8Rp/OddTHS7Eqpni17o93IZSN8s3DL4aDaQs+KQKBP+tG18H
 ttvsm+l7MNr1+9BxpywadHWc1bhwHrvV+Fy6ELUcJQYYdYGuE0iZS515ItG4wAzIMk42
 WhBg==
X-Gm-Message-State: AOAM530p4LWz6uYQERWlPQlYCWwxEX4CRGyKK95JHHNmwGsbowJyzjL2
 nBqiH46JWq5hKPEiT+wGoLni3CjGzXPmheDXS8SPu0CJ1m0WjlutiltKsn7XL7169n5dnAAEwfU
 C9UajKcAx02SZ3IA=
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr13496655wrp.305.1591952104495; 
 Fri, 12 Jun 2020 01:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylG+S1WFf1YotXIn5EIY1fJ+xMXDJu8slr1UYOL/LUsGasKeBIXqJKMQkdL9JVpNqL5eRC9w==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr13496640wrp.305.1591952104280; 
 Fri, 12 Jun 2020 01:55:04 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l204sm8372355wmf.19.2020.06.12.01.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
Date: Fri, 12 Jun 2020 10:54:35 +0200
Message-Id: <20200612085444.8362-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:01
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

The TPMDEV describe TPM backends. Use the TPM_BACKEND config
name which is self-explicit.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 4794e7fe28..5028fd8880 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,4 +1,4 @@
-config TPMDEV
+config TPM_BACKEND
     bool
     depends on TPM
 
@@ -15,26 +15,26 @@ config TPM_TIS_SYSBUS
 config TPM_TIS
     bool
     depends on TPM
-    select TPMDEV
+    select TPM_BACKEND
 
 config TPM_CRB
     bool
     depends on TPM && PC
-    select TPMDEV
+    select TPM_BACKEND
 
 config TPM_PASSTHROUGH
     bool
     default y
     # FIXME: should check for x86 host as well
-    depends on TPMDEV && LINUX
+    depends on TPM_BACKEND && LINUX
 
 config TPM_EMULATOR
     bool
     default y
-    depends on TPMDEV
+    depends on TPM_BACKEND
 
 config TPM_SPAPR
     bool
     default y
     depends on TPM && PSERIES
-    select TPMDEV
+    select TPM_BACKEND
-- 
2.21.3


