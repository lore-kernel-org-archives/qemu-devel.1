Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B61C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818D620828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eoye8JUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818D620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wo8-0004AT-BR
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlS-0002HK-R0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlR-0004DN-RI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wlR-0004D0-M0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p13so2380491wmh.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nivVSlDU65EgSfsWdJ1G12DLQkbSJ3s+gEF3tX+aC1s=;
 b=Eoye8JUwQbwICYPehlYdiYUGXsWQMu4k9P4VB71m74cckbVxMGvHFahx65wPUQ4KQw
 YOv9tEJCDp3GTEPftXjyFCOk6kR2/QPtzGnKYEExQijFKXGXDY1xMqn01f42FM6KvYQO
 5LzoonxJx15QdclomzitVTi+5iKNYFdineofMzsP8VrGEg6lkHhk9ibu3C6v5PCCQUvc
 ARVpzsPLg1t87jN/BLnMTYIEUsMnOGJL/NBWHevd9le8GF2FXFD/0HnxK010eUUHWtXW
 j+2kgMEZ5hWVs8CFTViIQh55T9imVfCMP0YkUDbuN5Ses1Pzh5S5yhb2PoymKbRTY4nO
 UuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nivVSlDU65EgSfsWdJ1G12DLQkbSJ3s+gEF3tX+aC1s=;
 b=e+ESQTnRzQZA6k4rEdEwS+NfgtvRb9sHUEBAUb9pMQrMD+F/gaSqdwLHxVOAGXMobT
 rhS7uF+f3EPxLI673H8kK1awZ9aT/c0l5+rvN7KkL2sa8J9loNwTN6rO5bltmX+Ou1w4
 +mf80dyqAqkY1zfAXoW28i+aU4xJ5nyjZwktqmgFMSkMyh9rfjbcaUfOX2NWAXsO6X6i
 4cPM/OSyjwB9AqlyXn9TtfbBVQn6GLgPqaECdYYOik6JPzYWIAY6IGYszr8FFj/gJLY1
 gVGjV/1imOLY82al7n28X4Yi2O4J25ELBUdVioAMINKNPOnGNUSrTFl2O+kjo+bhQb0N
 r7Nw==
X-Gm-Message-State: APjAAAUP21H0RXOr7uFRpEeM5Zl9pkR3mGUSLAZSu2lOVie0SYnk2DRX
 lJJO1GIR6ruYs3Q4lxNAXvSD5Q==
X-Google-Smtp-Source: APXvYqyB69/IssnvekVJcrOiiA++Exd2HnAfzOrHC1ApGJucYtK0KfaBdM68vsmwUiq45Az44bCQTg==
X-Received: by 2002:a1c:f103:: with SMTP id p3mr4340529wmh.18.1566994164625;
 Wed, 28 Aug 2019 05:09:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n14sm7051990wra.75.2019.08.28.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:09:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1049E1FF8F;
 Wed, 28 Aug 2019 13:09:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:09:15 +0100
Message-Id: <20190828120921.9586-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120921.9586-1-alex.bennee@linaro.org>
References: <20190828120921.9586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v1 2/8] contrib/gitdm: Add armbru@pond.sub.org
 to group-map-redhat
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Just to get the (few) accidental uses of my private e-mail address
attributed correctly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190822122350.29852-3-armbru@redhat.com>
---
 contrib/gitdm/group-map-redhat | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
index 6d05c6b54fd..d15db2d35e1 100644
--- a/contrib/gitdm/group-map-redhat
+++ b/contrib/gitdm/group-map-redhat
@@ -5,3 +5,4 @@
 david@gibson.dropbear.id.au
 laurent@vivier.eu
 pjp@fedoraproject.org
+armbru@pond.sub.org
-- 
2.20.1


