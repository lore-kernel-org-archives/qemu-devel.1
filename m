Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373BDC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13252086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="M5GtK5h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13252086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHYE-0008Rc-2x
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iBHWz-0007UB-Ax
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iBHWy-0007Rh-7y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:56:57 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:58814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iBHWr-0007Hw-3d; Fri, 20 Sep 2019 07:56:49 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id DBFB72E14D3;
 Fri, 20 Sep 2019 14:56:41 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net
 (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 t6yDCsn7xd-uf28JKOH; Fri, 20 Sep 2019 14:56:41 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568980601; bh=lOvcBWXZvYMMlNLfyAeOFlrAomKdbt0m4VflfPPuj34=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=M5GtK5h2hOLlkMjjjzg70+I/XLLIAyPpFBdzfQOS3LM02P1Z/0hojwSPCwI6JLouf
 m6j3xoIzJEC16s38BWRmschN8MHSOc6v59uO5nUTziM/91Scz8KA/ar5u5hDkqcrU1
 FE1X/EfhKW7LS89Jh/PXlZ9inHYu5VISJlkMRwks=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 3O334nXv8N-ueISkB8J; Fri, 20 Sep 2019 14:56:41 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
To: stefanha@redhat.com,
	mst@redhat.com,
	qemu-block@nongnu.org
Subject: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE is
 also advertised
Date: Fri, 20 Sep 2019 14:56:30 +0300
Message-Id: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtio spec 1.1 (and earlier), 5.2.5.1 Driver Requirements: Device
Initialization:

"Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
they offer VIRTIO_BLK_F_CONFIG_WCE.

It looks like currently F_CONFIG_WCE and F_WCE are not connected to each
other. qemu will advertise F_CONFIG_WCE if config-wce argument is
set for virtio-blk device. While F_WCE is advertised if underlying block
backend actually has it's caching enabled.
Those two things are not related to each other.

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/block/virtio-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 1885160..b45dc0c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -990,7 +990,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
 
-    if (blk_enable_write_cache(s->blk)) {
+    if (blk_enable_write_cache(s->blk) ||
+        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE)) {
         virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
     }
     if (blk_is_read_only(s->blk)) {
-- 
2.7.4


