Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3231FCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F008C21D7D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPmTZy6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F008C21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRZ6F-0004GF-33
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRZ5c-0003mS-2d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRZ5a-00042q-5r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:55:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRZ5a-00042h-2G
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572861357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=POxRkUG655NJzLBqwtEqRjBLA5mg+aMk7f+i316mJ4Y=;
 b=GPmTZy6LKlw6RzlkOpd+Jx8V002i5mbociquOyz7Qkzc8tpsNoIo/5PaF+LNltcSDxF1qZ
 TuraYzPHYHo3ht5J5EpdjoE/7ih2h3VkIsO+InE8UA9+ILxcac4c8YOcDA5GV7vrpgnKk1
 EaHclqS4jxTitO981GOtcujb6yt6Rjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-SDDdOPOkPiiPIGksIwcuFg-1; Mon, 04 Nov 2019 04:55:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B3F18017DD;
 Mon,  4 Nov 2019 09:55:45 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 755175C28C;
 Mon,  4 Nov 2019 09:55:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] Makefile: Fix config-devices.mak not regenerated when Kconfig
 updated
Date: Mon,  4 Nov 2019 10:55:30 +0100
Message-Id: <20191104095530.22091-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SDDdOPOkPiiPIGksIwcuFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When hw/$DIR/Kconfig is changed, the corresponding generated
hw/$DIR/config-devices.mak is not being updated.
Fix this by including all the hw/*/Kconfig files to the prerequisite
names of the rule generating the config-devices.mak files.

Fixes: e0e312f3525a (build: switch to Kconfig)
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
southbridge from i440FX northbridge" pull request.
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0e994a275d..c1461b21e8 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,10 @@ MINIKCONF_ARGS =3D \
     CONFIG_LINUX=3D$(CONFIG_LINUX) \
     CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
=20
-MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
+                   $(patsubst %,$(SRC_PATH)/hw/%,$(shell sed -ne \
+                                                    's/source \(.*\)/\1/p'=
 \
+                                                    < $(SRC_PATH)/hw/Kconf=
ig))
 MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
=20
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_INPUTS) $(BUILD_DIR)/config-host.mak
--=20
2.21.0


