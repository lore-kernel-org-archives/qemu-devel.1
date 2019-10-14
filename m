Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA258C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86541207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iY2hxnbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86541207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0uz-0004Pz-8n
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sR-0002V5-H4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sP-0007Bq-It
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sO-0007Ax-GE
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id o18so19823431wrv.13
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8sNzzUrqSU7ynCitVZpWHzCjwio6qKbTg5ye5QHbejY=;
 b=iY2hxnbK9HwMRxliWxIALXcigtTNTP4/PLm1IewKE4SGmpcZHar4aC0J2sjc8Y+P5A
 PkYiLcknUBlCOrVPEddQ2pf/Jvs4NbBXHrs1pyZ4wd7FVMp2m9g6zHYPGNDffDTbeUrE
 sAKJm66A9iReejgpbiupY02EI599IbYfBVbPMfuewVy+HMwmmAqUfT1z6wJ33LTm6OXM
 8A/8+cOAiXAq3PjpFd/ExNv7o2bIs04dxalXGMsnL/T0BXjr2f7Lunql9B+PT1LRlKL4
 EJ8pdeluAAWjASmxVdHhqZ/5Fk/Vg7orGwPjCtb3Fex732jJfJZP05xX5Ez6ghcE8kCy
 pcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8sNzzUrqSU7ynCitVZpWHzCjwio6qKbTg5ye5QHbejY=;
 b=k3P34yrx7WxmYiXxYRUavn0uSLy5r0oNtB3yUrYzlSo1Ng/23u8T8Rd70AisVOXi9Q
 IEIMEOnBpfvGaTIMMmPC17VJnjvPQrLnP8o3AZvs7KLeSYdzx/m+Pey/MycVH5J9AzOJ
 8IHaaqe/Ixw6PCKYd+ZxSwORK62TykE2X9QDezZQx0t1BAus6gvzn9qHFoQETYWNUYrc
 J7IuYqqlaAT11RRjqmfdNfzunvrAIVhPdIK4p3ZWet1OMlPOhVCpxZPl8z69UVnwANim
 8i7JsVSnOHip0ZlREGzzvKirqYaC+AgeYDBd3q19JCBrB3KpfWOmfA70k9BDEV9e2Kvl
 ekrg==
X-Gm-Message-State: APjAAAXRAHUZJwUynpAZzDHY/upX6I6ohUOZvE/d2eGAl2VbaYhRGYn1
 jXMYf19GbrVQFFggjFZeiQ8JvA==
X-Google-Smtp-Source: APXvYqwv8vLi/8v48BYvaxsRL6tzopNokY6P+m66aIfdMVevT0OuEmEoPoYcLpxPIYXD7xxkFpNY7w==
X-Received: by 2002:adf:ebd1:: with SMTP id v17mr18256539wrn.204.1571061546550; 
 Mon, 14 Oct 2019 06:59:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm35004884wmc.3.2019.10.14.06.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4BB441FF8C;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] contrib/gitdm: add more entries individuals and
 academics
Date: Mon, 14 Oct 2019 14:59:01 +0100
Message-Id: <20191014135905.24364-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014135905.24364-1-alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>,
 dirty.ice.hu@gmail.com,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Again this is guess work based on public websites. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: "Kővágó, Zoltán" <dirty.ice.hu@gmail.com>
Cc: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <liq3ea@163.com>
---
 contrib/gitdm/group-map-academics   | 3 +++
 contrib/gitdm/group-map-individuals | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 08f9d81d13..5cbb9d84c8 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -12,3 +12,6 @@ ispras.ru
 # Columbia University
 cs.columbia.edu
 cota@braap.org
+
+# University of Paderborn
+uni-paderborn.de
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 1c84717438..301071b98b 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -14,3 +14,7 @@ noring@nocrew.org
 samuel.thibault@ens-lyon.org
 aurelien@aurel32.net
 balaton@eik.bme.hu
+e.emanuelegiuseppe@gmail.com
+dirty.ice.hu@gmail.com
+liq3ea@163.com
+liq3ea@gmail.com
-- 
2.20.1


