Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44748C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DAF2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO9Zkmc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DAF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiQj-0007sd-6X
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGiPt-0007G5-La
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGiPs-0004kO-Fd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:12:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGiPs-0004k2-43
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:12:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id d5so8775315wrn.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E0/swcLhJE4EaoC6Z3CoPkB0yEhoGd8GKliO/dHZIkY=;
 b=PO9Zkmc/+cRnS9P6bmjo1TcrSbko2mgwNoCGT79hWKw8uVvLZ7jwFAOHXy3rfRT53p
 bLvlLWj1Ua2Arody7AD6Ybn540DL9+GaIgevdtxbcrOJr0QMF2h8r6JjEQ7b6OTnqJv+
 oEXr5sz8yWrze819ltLEftV4g4f0XHpSirMgieV5oiO3JWgdtWCMkekLmCziTGdHVqjA
 5d7B527kbc8GkIT5Bw5vXSmYzAd3+xIwQ/v91mJ13nEiSr69qpUkD2cbvQ/OC1f+gtsh
 LHnqblS1s/O/T2jGn8eF218RcwrRSEi71gloNbH74MQuJcWS+5oVM3kQVy7U64FqFjUK
 8pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E0/swcLhJE4EaoC6Z3CoPkB0yEhoGd8GKliO/dHZIkY=;
 b=gvREiUOY0xycUyH3Jhn6/IsbUcplj3xMbaHnPaTVABMQUsFBPGxx5qashi5K40a8jy
 5zsVY4rqn+aVXuOMZluGbGgmg+gcIOt34qicK9eWLbc93vBIhOtsXNCuN9vZ7uCrZnB7
 AH0qD4itislJ8XBg+qQ57WSptsgi+tyzHRXdl04fZxphL3Vk3MpmOe94QTZ/MzUeLqVz
 u6HS0B7VXSV0kHG3i79ikBgiYPsel8pxN8eFhCfU7pRH9eweOsEWOgNtMg6YtNrPZLtx
 fdjBXKODTvx7b5F7ab84b71XIV5NLFyaZcB3kecGvPPUureNLeK2TDkkCPIy8LY6N3Zi
 FVVQ==
X-Gm-Message-State: ANhLgQ3b64sPL7NJCom2vLdqlW5qblFd8ViRQtMjWwZKcVpUzDCRnRvI
 rPOJW93PSQWgIg/do5Zz/fFQrzIsxKiPKw==
X-Google-Smtp-Source: ADFU+vu1Pd+Dvdmv3HMQJqhc+bMtdqlBkMTeiMDtDzBwP1CB0z+GcHx0uLk3Kql1T2hQ3rIXQJNxcg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr12551904wrq.172.1585051938669; 
 Tue, 24 Mar 2020 05:12:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t12sm12437362wrm.0.2020.03.24.05.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 05:12:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] hw/ppc/e500.c: Handle qemu_find_file() failure
Date: Tue, 24 Mar 2020 12:12:16 +0000
Message-Id: <20200324121216.23899-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If qemu_find_file() doesn't find the BIOS it returns NULL; we were
passing that unchecked through to load_elf(), which assumes a non-NULL
pointer and may misbehave. In practice it fails with a weird message:

  $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
  Bad address
  qemu-system-ppc: could not load firmware '(null)'

Handle the failure case better:

  $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
  qemu-system-ppc: could not find firmware/kernel file 'nonesuch'

Spotted by Coverity (CID 1238954).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/e500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 854cd3ac465..0d1f41197cf 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1047,6 +1047,10 @@ void ppce500_init(MachineState *machine)
     }
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
+    if (!filename) {
+        error_report("could not find firmware/kernel file '%s'", payload_name);
+        exit(1);
+    }
 
     payload_size = load_elf(filename, NULL, NULL, NULL,
                             &bios_entry, &loadaddr, NULL, NULL,
-- 
2.20.1


