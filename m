Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D17C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DB620717
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="wDvIKIbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DB620717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCHw-0002F3-Sb
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:27:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFu-0000Wi-DK
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFt-0003Xc-7r
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:46 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFq-0003SF-9q; Tue, 04 Jun 2019 12:25:42 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id C358896F59;
	Tue,  4 Jun 2019 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=Ids2q0cvMSkPKHjRd29FbMXZAla1JGKMnzTb1AHd7kk=;
	b=wDvIKIbtw7KbHs24sz2MFMX/4p3m2tz1fdFstnYxsUllAhCp3Za3QJywjFUgf9YLKqQczh
	d3lsL5jY/W4P50DnkVhtbjyaGsdCqMqcuNzB1cTf61XXDwf5611p/yQYs8jjeXWOaUdqnF
	HPFnyZEzZ+zOsztlTfnvnE4FpFbfpvE=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:16 +0200
Message-Id: <20190604162526.10655-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=Ids2q0cvMSkPKHjRd29FbMXZAla1JGKMnzTb1AHd7kk=;
	b=O2yerfsa6l1tkSheTrLuMBgnNrJZRs7nO3HHO+8llpENrJLpuVcadUyJPvQu4c4H9mEYdg
	MsASPJKeRqQ08kfclszBpj+XD5njNDaFI8PsQsd+12irOvsscWHne/SlRL8oWgwDi/MnVx
	gWjqv/10hel3zq1vMdxl5rIg4LJ2/GA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665541; a=rsa-sha256; cv=none;
	b=O6BoFYZx65ItStlafQplUy2dfpL2UzMVcVphlTu4TMJHnFu7LZMP1CAsBNMLX0Lul+pPIy
	hyjU2ICY8JS/Kd3rQYz/tEoBtWlr6DTDmXwMaoX+wTr5VaKypxoymRBiSu11lMM28+GXK2
	uG7y1kI+IE4nonYKDwQRAojxjx3hOTM=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 02/12] add device_legacy_reset function
 to do the transition with device_reset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function has device_reset behavior and will allow to change
device_reset prototype while keeping the functionality.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev.c         | 2 +-
 include/hw/qdev-core.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9b6efe509..90037ba70c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1086,7 +1086,7 @@ void device_class_set_parent_unrealize(DeviceClass =
*dc,
     dc->unrealize =3D dev_unrealize;
 }
=20
-void device_reset(DeviceState *dev)
+void device_legacy_reset(DeviceState *dev)
 {
     DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
=20
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fa55dc10ae..537dd0054d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -406,11 +406,16 @@ char *qdev_get_own_fw_dev_path_from_handler(BusStat=
e *bus, DeviceState *dev);
 void qdev_machine_init(void);
=20
 /**
- * @device_reset
+ * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
  */
-void device_reset(DeviceState *dev);
+void device_legacy_reset(DeviceState *dev);
+
+static inline void device_reset(DeviceState *dev)
+{
+    device_legacy_reset(dev);
+}
=20
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
--=20
2.21.0


