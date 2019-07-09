Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E6C73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 00:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04542081C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8fGVnjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04542081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl0Fg-0008VK-TY
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 20:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <carenas@gmail.com>) id 1hkzqE-0002Sp-9g
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <carenas@gmail.com>) id 1hkzqC-0004Ds-13
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:48:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <carenas@gmail.com>)
 id 1hkzq9-0003cN-2n; Tue, 09 Jul 2019 19:48:06 -0400
Received: by mail-pf1-x441.google.com with SMTP id g2so146164pfq.0;
 Tue, 09 Jul 2019 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vX9bV5hRrwaasQcUnY50N332WP/OyMV+dT8T59hv888=;
 b=b8fGVnjlS0yQo5xbP4wM4EuaBdA4ylKjWF0NmaW14UYL4icd/JQCDr1bzy7TZla3vZ
 YhbtMjRh0nLfi8AiWUda07QZ74AnLvTPYowVLI3soSjI2Ti/WVEKs3J/eLBGXnAruM2U
 IFwE1kzp1Eq7dp6gKcwfqUhkDgHPsVdWuGVcJ1m8WREbSpaPIj815cxYkqaE0fWts4dm
 5gn9y7QoeenLsyrCTAZpCBipy/Q1aq5iFAzDHkiEeKXRGrl/mO+1NtAAz7aCQHzPMa7x
 4Y5pkPUbeM7fJG3m57ltDaRaGD3fTll3oazYlibTf6pZPJGDSBUvpraE6nJC9RDdMDNI
 gQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vX9bV5hRrwaasQcUnY50N332WP/OyMV+dT8T59hv888=;
 b=f2p7AasHjmX8NjunG6UKNOx+kW25RCMasyHc+bcTioDMBhJuTtmrh+RHYB6h1P8bEm
 8OXtSDV5fww9h92S6yDJjV3dEa9VFLk2GHJdR2vknBTYRVIrFe3IaZVwSjR/YegawJHA
 i7kHjx8eM9E/qnId0Hk0v5X4XpjywzqT6/CdeeEok9L6pohd2bp3yMu4uTVQt/SJvhNQ
 T3AkzhxyvDUDPTZwChKla3eq6seWQIjkPrgaIJiQoI4Q8+39dvBy9IKoVDcj0TQ2ahmO
 QUpUqnqKflwVia+ajCKuBcKpHVcvt4eTfGyf/Z6ZqQPg1fpJcxH3zZ0/clDDSa8AQQ96
 jnGQ==
X-Gm-Message-State: APjAAAVz+4W0dT6LwTwFgrWzMFEYbpuC0juPvg1m3+JWZnriNEq14M0r
 GbejCqLAigiEQ+Y8DF7oJm3aWlOU
X-Google-Smtp-Source: APXvYqy+oKDs33wmGjUDJDEQbOetAi3IlraQDR1JhQ6VzvG4urZpGJU1z/ut21TyAn8HYv2xcQ6q6g==
X-Received: by 2002:a17:90a:ad89:: with SMTP id
 s9mr3033146pjq.41.1562715992712; 
 Tue, 09 Jul 2019 16:46:32 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
 by smtp.gmail.com with ESMTPSA id 185sm173685pfa.170.2019.07.09.16.46.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 09 Jul 2019 16:46:32 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:43:30 -0700
Message-Id: <20190709234330.89699-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH] configure: remove obsoleted $sparc_cpu variable
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
Cc: qemu-trivial@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

9b9c37c364 ("tcg-sparc: Assume v9 cpu always, i.e. force v8plus in
32-bit mode.", 2012-09-21) removed the need for this variable and
most of the references to it, but this one.

Remove defunct code, no effect or functionality change expected.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 configure | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configure b/configure
index 4983c8b533..7518f201ab 100755
--- a/configure
+++ b/configure
@@ -6378,9 +6378,6 @@ if test "$vnc" = "yes" ; then
     echo "VNC JPEG support  $vnc_jpeg"
     echo "VNC PNG support   $vnc_png"
 fi
-if test -n "$sparc_cpu"; then
-    echo "Target Sparc Arch $sparc_cpu"
-fi
 echo "xen support       $xen"
 if test "$xen" = "yes" ; then
   echo "xen ctrl version  $xen_ctrl_version"
-- 
2.22.0


