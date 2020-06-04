Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C333F206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="m+3CCjSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C333F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglfU-0001Mp-Vm
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleM-00081I-Py
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:58 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleL-0002DH-DW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nUSbl6/B4wKxrG9q03+aLAyJuI8ugX83LZNVy9GhyP8=; b=m+3CCjSffJ99fswlVw1g5Cy4Op
 5ImNfJj1A1dNk1C/MmfhF/y7cVUpY9lSyCCZV/0PfyAa+OG0RHF+cxI8ffHpiir0dRrEtBOot19pC
 tTrl7UhpzWQqq2W9iNcTFkhkv+NqkH0LcuEGVQmFo90DGHIJN1U/gZOoJEHktgKvUCSA=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] docker/tricore: Use stretch-slim as a base image
Date: Thu,  4 Jun 2020 10:54:27 +0200
Message-Id: <20200604085441.103087-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898277, da=78869958,
 mc=172, sc=3, hc=169, sp=1, fso=6898277, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.3.5740001
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

we get an authentication errror when trying to pull qemu:debian9. Thus
just start from a plain debian image.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 .../dockerfiles/debian-tricore-cross.docker      | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 4a0f7706a3..544d7814f8 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,10 +7,22 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM qemu:debian9
-
+FROM debian:stretch-slim
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        curl \
+        flex \
+        gettext \
+        git \
+        python3-minimal
+
 RUN git clone --single-branch \
         https://github.com/bkoppelmann/tricore-binutils.git \
         /usr/src/binutils && \
-- 
2.26.2


