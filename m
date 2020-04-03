Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31FC2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF5E2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/LfmVtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF5E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNFC-0007ds-OY
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKNEI-0006Ji-2w
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKNEG-00082B-Ca
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKNEG-0007zb-1l
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id 65so8777116wrl.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=d/LfmVtOmkm0hb2iNgVJOZYipm4j465uGS0uc75JfqyN4WLCLqqIKtJuRY2rJMvrEX
 8vQQAARUplmuqgtL4/Ik0g2zC60Yq4oCaKc8x7mAC3xLKdNYFT2B1+6YnQYoLLJhk7ma
 Njmr9DUc06G2Ex8TRzZ/UGBC5wWW2/HZktCIZIl/oQSg4nXmfFiOJzIu3U2co3wz9Qy8
 01fvjxP43Ra8ctY+fxotb0GS8UL0muOHuUlhkFVuhBktlkszqJIUto21mK24DXS0GIoN
 9onVSRZJX1kjOL0W6fKc6bk/1PSZmy3qtkJElYF32c7280X5mmV+wDFHwcVEZe8MGaE6
 uMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=DW3B2cj5CU/cBkCPkbUUhJ0SLKCM3IIhKg/gz2LnGo4JjBJ2KZbCiWXNsHc+ZA73+u
 onE9kxB/ZqsIk2GNEmvbxNgVWXHP2+Wls/F18HKk6DaLAPvCa3UsatCJvzm0675UTTEc
 hLjSG9oo/TLHAbCAb9/Ksv3BNGjJ/wmMwvQcWT9bDeX4oC32bk3rWk0Mpvn0LL8uyAL2
 jd/rbX/L/rjWKi3+CpP7ttEZkQZT33iMRkzruh40/9S0dV4CgT/d+6jsfaiYrQ8WgIcD
 bGK2y9XehLa2IcElQtiVWZ5QO4zMntzsekuaE1OKu2Fxoli+IbNNyLenPW8sn8Tovq0V
 ZZpw==
X-Gm-Message-State: AGi0PuaYGU6J1iMN5vx+55CwedIfZ55mMd5aPJtj0Sg0UTFQhUKqsAr4
 brqRCJT2R6ckqlghuYvc72kNYK2HdQQ=
X-Google-Smtp-Source: APiQypLYRMQScoicmnsieQh3flyhWsmMgd7oJ0En4xlLKpAGylHiB31/yhLxRJm1Mtwwx19H1flBkg==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr9927824wrm.217.1585923805482; 
 Fri, 03 Apr 2020 07:23:25 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-167.inter.net.il. [84.229.154.167])
 by smtp.gmail.com with ESMTPSA id i2sm12218646wrx.22.2020.04.03.07.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:23:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] hyperv: expose API to determine if synic is enabled
Date: Fri,  3 Apr 2020 17:23:04 +0300
Message-Id: <20200403142308.82990-2-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403142308.82990-1-arilou@gmail.com>
References: <20200403142308.82990-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, ehabkost@redhat.com,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/hyperv.c         | 8 ++++++++
 include/hw/hyperv/hyperv.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8ca3706f5b..ddf4f32c60 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -37,6 +37,13 @@ typedef struct SynICState {
 #define TYPE_SYNIC "hyperv-synic"
 #define SYNIC(obj) OBJECT_CHECK(SynICState, (obj), TYPE_SYNIC)
 
+static bool synic_enabled;
+
+bool hyperv_is_synic_enabled(void)
+{
+    return synic_enabled;
+}
+
 static SynICState *get_synic(CPUState *cs)
 {
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
@@ -133,6 +140,7 @@ void hyperv_synic_add(CPUState *cs)
     object_property_add_child(OBJECT(cs), "synic", obj, &error_abort);
     object_unref(obj);
     object_property_set_bool(obj, true, "realized", &error_abort);
+    synic_enabled = true;
 }
 
 void hyperv_synic_reset(CPUState *cs)
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 597381cb01..a63ee0003c 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -79,5 +79,6 @@ void hyperv_synic_add(CPUState *cs);
 void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
+bool hyperv_is_synic_enabled(void);
 
 #endif
-- 
2.24.1


