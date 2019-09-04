Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF3C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ED422CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FpzhLdV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ED422CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5V3o-0002LC-82
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Upa-0006Tv-Lv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5UpZ-0005Yt-Gs
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:56:14 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:45908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i5UpW-0005WQ-Tz; Wed, 04 Sep 2019 08:56:11 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 87F8896F65;
 Wed,  4 Sep 2019 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1567601770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1cYSywxsNjFTbyO7aWViJMbAww4xP344l5lA8bvklQ=;
 b=FpzhLdV1/pkM4IfvexiVv2kMoSjWDI1jcgcZLHg9tnz4ocOkihTkBte1hq07fTr3mLnkJ/
 NqIU5OF2N0I4tXuhMtEdLFv9MSDTyiEZgiXov7m9ONoFHLPZscu8ruAMQCxL07xd9QUKpw
 jC4QrRStYnYgJdqpJd9PWIO60yvhuN0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:55:24 +0200
Message-Id: <20190904125531.27545-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904125531.27545-1-damien.hedde@greensocs.com>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1567601770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1cYSywxsNjFTbyO7aWViJMbAww4xP344l5lA8bvklQ=;
 b=fV/ccsRfVBAx9ltMid7Bl4D5Pc4fchLwCmZIfa2GutHCRluL/ERVjZIT9pK0gZNCtcDSSO
 qys4JdUsZCflEcLoieYzzjiDTrokA1t+axxGKlhAlbhClkql5ZOS//Xi1Cgrg0XmQGmCIr
 4pLgO4RKHGx7FuHD6YzBnu5ODrnea2o=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1567601770; a=rsa-sha256; cv=none;
 b=PyRokgH1uWH1zed9Pc729W8qXFWKLt7J1XYK6S9ide8COsIoSsnbHmb2QFyxhh4vLlqr51
 AjQL+yKQ3fWUBGZloy1FG0GF56+x50iG/glrQ6DCqXiX3lptU3HRPzmYyFwQ5cErJuHsQl
 34CpTKgfoVQx6lUCYz/ng2Z/2rrvkKk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v6 2/9] hw/core/clock-vmstate: define a vmstate
 entry for clock state
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
This was in the previous reviewed commit. But it can't be in the
clock.c file in order to allow linux-user builds.
---
 hw/core/Makefile.objs   |  1 +
 hw/core/clock-vmstate.c | 25 +++++++++++++++++++++++++
 include/hw/clock.h      |  9 +++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 hw/core/clock-vmstate.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index c66a5b2c6b..8fcebf2e67 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-y +=3D bus.o reset.o
 common-obj-y +=3D resettable.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
+common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y +=3D irq.o
 common-obj-y +=3D hotplug.o
diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
new file mode 100644
index 0000000000..c781369c15
--- /dev/null
+++ b/hw/core/clock-vmstate.c
@@ -0,0 +1,25 @@
+/*
+ * Clock migration structure
+ *
+ * Copyright GreenSocs 2019
+ *
+ * Authors:
+ *  Damien Hedde <damien.hedde@greensocs.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "hw/clock.h"
+
+const VMStateDescription vmstate_clockin =3D {
+    .name =3D "clock",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(frequency, ClockIn),
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/include/hw/clock.h b/include/hw/clock.h
index fd11202ba4..e7efb6ad17 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -34,6 +34,15 @@ struct ClockOut {
     QLIST_HEAD(, ClockIn) followers; /* list of registered clocks */
 };
=20
+/*
+ * vmstate description entry to be added in device vmsd.
+ */
+extern const VMStateDescription vmstate_clockin;
+#define VMSTATE_CLOCKIN(_field, _state) \
+    VMSTATE_CLOCKIN_V(_field, _state, 0)
+#define VMSTATE_CLOCKIN_V(_field, _state, _version) \
+    VMSTATE_STRUCT_POINTER_V(_field, _state, _version, vmstate_clockin, =
ClockIn)
+
 /**
  * clock_out_setup_canonical_path:
  * @clk: clock
--=20
2.22.0


