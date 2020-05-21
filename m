Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6F320759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5ZpjIYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6F320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboo4-0003Is-5c
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ1-0004Ia-No
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:29 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d]:37756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ1-0006h6-1g
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:27 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id z5so3375396qvw.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rdoJqb1IBk9SgvYZUNMM+KSW8M0ZuxcTTKuiIiIMCBs=;
 b=v5ZpjIYGOvlPCrZUyNTyCt6JWDyWc3FctG1uKuwFMq/oFAcQLPRSG3lM8g/KdEKCnU
 5j4hCb+6fotCXd6RUDlwoUqAYVHNZlZlP/atalJIJpW0nRJtxemhdeQ/MydYJmzlvGsB
 LxpjxKjk1veQQqQ1XfO4qrUxjVcwkVpVZsUk+ruwG0wkzrfGxG5dpMgM12g1kT7yF0jo
 bztlncEi3L0X4CWeHN6ZenhqmP2RU0iFZ4TM1uMhfdtIQg8+Jpn7/E+fZ6Gvw4AqzCR6
 YY4+QFC+Y/U4MCaUvpiMPoGXHyjvWg8NSM1W72KZyy8UMzKBFjf3BabvozC0SMUgl02/
 nw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rdoJqb1IBk9SgvYZUNMM+KSW8M0ZuxcTTKuiIiIMCBs=;
 b=Q2j0ogNGatzT1ZoYDuMaVBRH/NBK1McPDK6lTga02Ip2nOtBWfBpdA3YnC9lz01nqM
 55rHYRFJ4kmYvpnFGdqPAGl6hGCjTkNVqzAeUzbs81BJjQEJBI8JDe/lccoB9vvnqmFc
 PDz2SeKcxo05RAdH8THjbCEV117cGNdb6uvSvLOM7h48LyTKzs44UwaalWKniPnM0cl6
 k0QVpxqASbQvqkusj0iWCQaE5lWMtJ9zs1FuaDT4xdlwIMOmmoXJ/PlD+5VQUHawNhV6
 0FFpLyxAD2NOy6FqSp0+ZV2r0bvZanfUYH9xkq0J1/oAR4MDpSyl+0vDaPbQPZ8thjf6
 sKOA==
X-Gm-Message-State: AOAM533mE5VRdV4U38R1AM7RPTQQ6X+pw/jxNgLSnLA0QxHjzktXA1GP
 cyD4z2lcb0jg/Dyhk2xiygrqtBzyX66YFw==
X-Google-Smtp-Source: ABdhPJwXHdqedXKFL1D/wKc3KhFF0h4/83SSDqa5vR2yunPozcJaGcVLxE1urNGeSGLZIxeZAUyl8w==
X-Received: by 2002:a0c:90e7:: with SMTP id p94mr11208478qvp.219.1590079465710; 
 Thu, 21 May 2020 09:44:25 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:25 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 53/74] s390x: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:50 -0400
Message-Id: <20200521164011.638-54-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, David Hildenbrand <david@redhat.com>,
 richard.henderson@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/intc/s390_flic.c | 2 +-
 target/s390x/cpu.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a1c6b8a6f6..40b1a5b940 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -191,7 +191,7 @@ static void qemu_s390_flic_notify(uint32_t type)
     CPU_FOREACH(cs) {
         S390CPU *cpu = S390_CPU(cs);
 
-        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
         if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4b1961694e..490644e12b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -65,7 +65,7 @@ static bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
         return false;
     }
 
-- 
2.17.1


