Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63656C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BC020774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxt5Cw3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BC020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnIT-0002ja-Cm
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmiQ-0003S6-8g
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmiP-0007u9-AH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:46 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:41717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGmiP-0007tW-5p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:45 -0400
Received: by mail-oi1-x234.google.com with SMTP id k9so6476939oia.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WZwD83D9KTX1uO8cXedRJd4vyXXnAoxqc7Y/V7iuhWE=;
 b=Wxt5Cw3MmT9nr/AJwJ+2oNXZzFTqnx3JUIgmQG4IUJ6rlCGcxa2ccIk2051uXdoTkS
 Ki4Vfx7sxV4xJWL+tOnp2EsVG7n2zpJDNcH+sws4p7ghwpOiFbWmDmfMO30omM2FyMdn
 8njSrLoQHA+vuy3KaH3E4sJuwei1IEz2aZ/Jeq3+kfnPtWKsq35xYy4eGbYIdyRPWklh
 qfyCwnhR3/npT/4eFEEvQ5EblglSqresVBQpI0zpDXcH8hbzQlr5kp2Zw4MoBCJGTZ42
 sG16G3UpSEcpQ2XcQEPB7W1f3BiHxp/ZfvVY1EnFEP5DPEEtcMBy+uAi6k7AZHvz4nlI
 WVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WZwD83D9KTX1uO8cXedRJd4vyXXnAoxqc7Y/V7iuhWE=;
 b=g/HBI9HoG2KFVczFo3sdm6akFI21MrIZogK/1k7xfoqBYRxys9oAAg7stJUFqpQ52x
 B6vVxFchA9vTpN1EepUiK4ZZXw34sHDV2adlaxtcAlnSp3e2u5kzJ4XKrNfbqxNHhlne
 10T9z+VYi1KUUoCicOuarMz2au0ET8x0B0fNL+DADSm8Wjst3x3GdHcCAywsp18CU2ob
 ktLAdXTUcyJ25vnVEtQAv5qEAu6e1adcQYjxAd5x28HvCqouFPBuhsB62I72913mQx9+
 13YH0xbnQ5n2lzJ/mkwT/ROhP8qAQk0AAVhFMHlbYPBs9oCIaBVJkl3t5pvdpo3xrDVr
 L5xQ==
X-Gm-Message-State: ANhLgQ1FoUuQb1PgGNxdVMlEDDSl3LX10En+i4fbbIYGMEdMS39eoqj7
 edA6zDuiaBN7tbUEWa4cqYWx5aojlyU=
X-Google-Smtp-Source: ADFU+vs35On4tbN/D2d4gao0vsJKJktgz3Sx63Pk6XnbXpDGAhEPiGJpwT0ozTUgN75ZopWVvlTbjw==
X-Received: by 2002:a05:6808:56:: with SMTP id
 v22mr3914893oic.116.1585068463565; 
 Tue, 24 Mar 2020 09:47:43 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id u199sm6426273oif.25.2020.03.24.09.47.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:47:42 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 2/5] qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED
 error
Date: Tue, 24 Mar 2020 11:46:50 -0500
Message-Id: <20200324164653.19449-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
References: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:16 -0400
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
Cc: Sameeh Jubran <sjubran@redhat.com>, peter.maydell@linaro.org,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sameeh Jubran <sjubran@redhat.com>

This patch handles the case where VSS Provider is already registered,
where in such case qga uninstalls the provider and registers it again.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/install.cpp | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6713e58670..a456841360 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -443,6 +443,17 @@ STDAPI DllRegisterServer(void)
                                      VSS_PROV_SOFTWARE,
                                      const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
                                      g_gProviderVersion);
+    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
+        DllUnregisterServer();
+        hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_LNAME),
+                                         VSS_PROV_SOFTWARE,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_VERSION),
+                                         g_gProviderVersion);
+    }
+
     if (FAILED(hr)) {
         errmsg_dialog(hr, "RegisterProvider failed");
     }
-- 
2.17.1


