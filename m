Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B96C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C450920726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FswM0EPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C450920726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a9d-00029D-Nm
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2p-00081e-Nb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2n-00026l-U4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:39 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6a2e-00021S-ST; Tue, 25 Feb 2020 08:14:29 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 1AC3F96F50;
 Tue, 25 Feb 2020 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582636466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=islzJ3dtZ7UUO4t6RapBooYgTjjRcixcXvr9KLyxFa4=;
 b=FswM0EPGhJv8+TdI65IJixlmJZJOL7Mi0yfyiBeSlmiVTJiifPcTw2Oz5v0CDaYT1jOsHW
 k5nX3FGUoc3DSf3OZFL1UqfVVjZC395PP7XEM4bxvv4Tsdiih5adtniIquKEgDc9Su282l
 slfTjlIRRsa0qJEN5Afb99e+bYovXSU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 2/9] hw/core/clock-vmstate: define a vmstate entry for
 clock state
Date: Tue, 25 Feb 2020 14:14:15 +0100
Message-Id: <20200225131422.53368-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225131422.53368-1-damien.hedde@greensocs.com>
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582636466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=islzJ3dtZ7UUO4t6RapBooYgTjjRcixcXvr9KLyxFa4=;
 b=0khKbIB7Jf/XHHfWa+WZKRqhZpW/JU11RKrv/IInegQje8aKBqHSqU9tdJks2MfnjzLxT8
 cu2Ei39dA7MVYPlgT38+rn1u2wHDL9zMQoELnMfqFgd9zDYlANoeKGotgg39vACwq+OV+m
 pgj/BXJ4T6vNQtulNSgQvQoNu0SbNnQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582636466; a=rsa-sha256; cv=none;
 b=vvamLY7PsCCemQifN4HqxX/xtN9ynJ5Ijjtzmtp4Fz8uQbvD91F/Ql64LjHgYeG+e/0tOa
 Rr3aBP9RZNyc3RZHFSN+f39xhOxk9DQJ3uEBd49pbgh10WMb6MtUIe8B/wemrOJD02iSrb
 PRks4bwf2gyyVcIih8x0TPHS09ybUPM=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
 berrange@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com,
 edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
--

v7: remove leading underscores in macro args
---
 include/hw/clock.h      |  9 +++++++++
 hw/core/clock-vmstate.c | 25 +++++++++++++++++++++++++
 hw/core/Makefile.objs   |  1 +
 3 files changed, 35 insertions(+)
 create mode 100644 hw/core/clock-vmstate.c

diff --git a/include/hw/clock.h b/include/hw/clock.h
index 82a7f3c698..f3e44e9460 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -74,6 +74,15 @@ struct Clock {
     QLIST_ENTRY(Clock) sibling;
 };
=20
+/*
+ * vmstate description entry to be added in device vmsd.
+ */
+extern const VMStateDescription vmstate_clock;
+#define VMSTATE_CLOCK(field, state) \
+    VMSTATE_CLOCK_V(field, state, 0)
+#define VMSTATE_CLOCK_V(field, state, version) \
+    VMSTATE_STRUCT_POINTER_V(field, state, version, vmstate_clock, Clock=
)
+
 /**
  * clock_setup_canonical_path:
  * @clk: clock
diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
new file mode 100644
index 0000000000..260b13fc2c
--- /dev/null
+++ b/hw/core/clock-vmstate.c
@@ -0,0 +1,25 @@
+/*
+ * Clock migration structure
+ *
+ * Copyright GreenSocs 2019-2020
+ *
+ * Authors:
+ *  Damien Hedde
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
+const VMStateDescription vmstate_clock =3D {
+    .name =3D "clock",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(period, Clock),
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1d9b0aa205..115df55087 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -21,6 +21,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
 common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
 common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
+common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
 obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
=20
 common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
--=20
2.25.1


