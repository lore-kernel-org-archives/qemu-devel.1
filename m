Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C1C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF06206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhVHcOTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF06206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVzO-0001Au-0D
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr4-0001z5-Eo
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr2-0002mP-3x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr1-0002k3-Tq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so486578wrt.7
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cuu6Mf6C0OvH1MFPrRMIl5kc5c6SX3CKL/Tap4IxIuM=;
 b=dhVHcOTsNa6LYJStTvLUBOZZ1iF+829dP+797919V6+SX4+DAbfIaXZWyGomJiMorU
 N7Pr6MAOVy34D3eg51lO4Y2JCX6IMW2ciZf5gFk0EMscdTh/naB5+yPTlxmmuktWVQtr
 6+1UQINB8Za1c+I92XxBoQ6Alj/qj27hQ0X5vJqKFDTY6yGCKYyXdpyIPvWbF2uR2/6u
 2AoKWGn4I8nSaTXcoisqyk7hPbVzFCK5jUdxzcRT6ygtXCG+k2ePtehs+MWGn6zjgftP
 Xjm4z1fft/VYIK+0zwt21Y/qAotrSP5ditecEPpryPbK6Lj4xxOmayYA07Iv+6e7CXhk
 cVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cuu6Mf6C0OvH1MFPrRMIl5kc5c6SX3CKL/Tap4IxIuM=;
 b=BiBpIZRwKNoo0yYLsfX45y2rpH9gTgzKlF2XzdeTAjKT+UIOalEBiefq8nVP4Gzi8P
 eK3ffQYa58kbvG6BdA8hD4OtGOHLdM+YCwh4JzUCtRWbPTd2LXc3ln8ND/i4Gv6H4T3f
 oxz5jDIog8BKz2ljuVNS+B91+z7Tz6Q4pBpw+Sjimf1tGZ+fSGlzkTwH7a4e09botRRh
 K/M6jbMa3xLHRq2N77QdWISeUSXgTY9qOABi6nCd2LHvkVM2XsilESXjE7BJGSQ3tcIY
 ZKwQtJwZ7LjH+p9ZzkJKyZ7CUgFPlLYqxNseSNLlBjOcMU2fobd+T7tWYsJHTRgddiT8
 js1Q==
X-Gm-Message-State: AGi0Puazy3sWdCB9AMN3GUN2IPBo9yzXcRf/UX3qaU/lU9UmzNkGkOT4
 kXFzPXH/1jOl5LajUgw+ESeWCfsye0w=
X-Google-Smtp-Source: APiQypLvJE0XJfrgReEsqMri9XgZGfYbQED/+0wha9HYj3DQ81Yoq+T/sd6XaHY5MpSIbzNgKbFC/Q==
X-Received: by 2002:adf:ed0b:: with SMTP id a11mr362197wro.344.1586195290662; 
 Mon, 06 Apr 2020 10:48:10 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 18/54] hw/pci-host/pnv_phb3: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:47:07 +0200
Message-Id: <20200406174743.16956-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/pci-host/pnv_phb3.c
  >>> possible moves from pnv_phb3_instance_init() to pnv_phb3_realize() in ./hw/pci-host/pnv_phb3.c:992

Move the calls using &error_abort which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/pnv_phb3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 74618fadf0..57d717ed23 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -970,6 +970,8 @@ static void pnv_phb3_instance_init(Object *obj)
     /* LSI sources */
     object_initialize_child(obj, "lsi", &phb->lsis, sizeof(phb->lsis),
                              TYPE_ICS, &error_abort, NULL);
+    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
+                            &error_abort);
 
     /* Default init ... will be fixed by HW inits */
     phb->lsis.offset = 0;
@@ -977,6 +979,8 @@ static void pnv_phb3_instance_init(Object *obj)
     /* MSI sources */
     object_initialize_child(obj, "msi", &phb->msis, sizeof(phb->msis),
                             TYPE_PHB3_MSI, &error_abort, NULL);
+    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
+                            &error_abort);
 
     /* Power Bus Common Queue */
     object_initialize_child(obj, "pbcq", &phb->pbcq, sizeof(phb->pbcq),
@@ -1005,8 +1009,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     /* LSI sources */
     object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
                                    &error_abort);
-    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
-                            &error_abort);
     object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1024,8 +1026,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
                                    &error_abort);
-    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
-                            &error_abort);
     object_property_set_bool(OBJECT(&phb->msis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.21.1


