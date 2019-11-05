Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30612C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE827214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYUy5g8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE827214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0W3-0008QN-5O
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS0VO-0007wm-Nc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS0VN-00018f-8Y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:12:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS0VN-00018C-3E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572966744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zcEBcSXmMs1+5LwOnm9xIuUQMVo51mCmvxKs2BdFsqE=;
 b=JYUy5g8hpkVrO0tsvGLsVuuq4FZ02K+PdJo2rRvPah7csou4yy9ymOERqN2lU+Jl16q1ve
 gzblyZb/Rh2h/kJLJK/AU1/NWPXeSGhUkIemOO1zQTtwxiSriKie7OwjLBno5HL7IUahcO
 WbenXFCcv0updlaiJkP0yd5CV++FvIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-4wfj1RMGMDyl9U-07bbh4A-1; Tue, 05 Nov 2019 10:12:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952908017DD;
 Tue,  5 Nov 2019 15:12:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-148.brq.redhat.com [10.40.204.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 618425C3F8;
 Tue,  5 Nov 2019 15:12:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
Date: Tue,  5 Nov 2019 16:12:09 +0100
Message-Id: <20191105151209.1814-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4wfj1RMGMDyl9U-07bbh4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
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
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
Simplify using the wildcard() function instead of calling `sed` (danpb)

You can see this tread where Peter reported the failure:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00125.html

How to reproduce:

  $ git checkout branch_modifying_kconfig
  $ make i386-softmmu/all
  $ make clean
  $ git checkout prev_branch
  $ make clean
  $ make i386-softmmu/all
    # error

If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
southbridge from i440FX northbridge" pull request.
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0e994a275d..f4fca08cd7 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,8 @@ MINIKCONF_ARGS =3D \
     CONFIG_LINUX=3D$(CONFIG_LINUX) \
     CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
=20
-MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
+                   $(wildcard $(SRC_PATH)/hw/*/Kconfig)
 MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
=20
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_INPUTS) $(BUILD_DIR)/config-host.mak
--=20
2.21.0


