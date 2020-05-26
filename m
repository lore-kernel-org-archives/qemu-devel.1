Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBF8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CE32070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ticrqhZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CE32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUpO-0007Vr-NI
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdUmi-00036e-TP; Tue, 26 May 2020 04:18:04 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:51184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdUmh-00070B-Qi; Tue, 26 May 2020 04:18:04 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DCE032E1510;
 Tue, 26 May 2020 11:18:01 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 VqyTYEYiK8-HwdKg7Su; Tue, 26 May 2020 11:18:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590481081; bh=OOGP43LCRnsl7Y4se3qA0Gu2DQeJS48XyBa7OTMtlzc=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=ticrqhZZEF/1NTroIUO4apUnIYG4rlI93QLQqmhHQbQmM9nsVkqi/7ckl3aaZoJN0
 M5qz7j+kwkXyWumtJ5i2efWOcLK8hUs2KCQu+YHY6fvojxdMeqf7K640fbZRA4E2fS
 uM3tRuuASpP0okMneHg+tUzqPf/lLlaOpExn4ApM=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:8909::1:0])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 eMCAEelUnS-HwXuju7Q; Tue, 26 May 2020 11:17:58 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/5] block: lift blocksize property limit to 2 MiB
Date: Tue, 26 May 2020 11:17:40 +0300
Message-Id: <20200526081740.256236-6-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526081740.256236-1-rvkagan@yandex-team.ru>
References: <20200526081740.256236-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Logical and physical block sizes in QEMU are limited to 32 KiB.

This appears unnecessary tight, and we've seen bigger block sizes handy
at times.

Lift the limitation up to 2 MiB which appears to be good enough for
everybody, and matches the qcow2 cluster size limit.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
v4 -> v5:
- split out into separate patch [Philippe]
- as this patch has changed significantly lose Eric's r-b

 hw/core/qdev-properties.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index fd945ce77f..01589e1ad6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1206,9 +1206,12 @@ const PropertyInfo qdev_prop_size = {
 /* lower limit is sector size */
 #define MIN_BLOCK_SIZE          512
 #define MIN_BLOCK_SIZE_STR      "512 B"
-/* upper limit is the max power of 2 that fits in uint16_t */
-#define MAX_BLOCK_SIZE          (32 * KiB)
-#define MAX_BLOCK_SIZE_STR      "32 KiB"
+/*
+ * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
+ * matches qcow2 cluster size limit
+ */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
 
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
-- 
2.26.2


