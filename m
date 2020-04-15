Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12D0C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80753206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="op6bXEKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80753206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOqUj-0005AQ-GV
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 18:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTU-0003pF-UQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTS-0003rw-2x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:39 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jOqTR-0003rF-H0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:38 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5A2192E1637;
 Thu, 16 Apr 2020 01:25:34 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 AWUzQZhoYe-PYnuoUB4; Thu, 16 Apr 2020 01:25:34 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586989534; bh=J8KEj1qqYEkcKxKcOIAHOdFAmeDh/so0wxgaEPhaNZc=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=op6bXEKv4ssoz7oU+W2Q/GNbpritkOFL4llKvlLQ72+binys4Ds8ocR3dNn2/Qx6z
 0CgG8N2xHbTLBY6esGqE9taPgOcI8IF4tv/xWubDklfNuomfzSmGR4LGlo8tL6sWGP
 vo96OT5GZho4LhZQrOdsnCnRnW/Oc2Kl81f8z+IM=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:e])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 0wmBaV4yMk-PYXawdG5; Thu, 16 Apr 2020 01:25:34 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/5] crypto/secret: rename to secret_interface.
Date: Thu, 16 Apr 2020 01:25:21 +0300
Message-Id: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Rename for future division into subclasses. Most part of the interface
  will remain in basic common class.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 crypto/{secret.c => secret_interface.c}         | 0
 include/crypto/{secret.h => secret_interface.h} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename crypto/{secret.c => secret_interface.c} (100%)
 rename include/crypto/{secret.h => secret_interface.h} (100%)

diff --git a/crypto/secret.c b/crypto/secret_interface.c
similarity index 100%
rename from crypto/secret.c
rename to crypto/secret_interface.c
diff --git a/include/crypto/secret.h b/include/crypto/secret_interface.h
similarity index 100%
rename from include/crypto/secret.h
rename to include/crypto/secret_interface.h
-- 
2.17.1


