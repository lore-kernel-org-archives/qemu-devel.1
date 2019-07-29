Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5252C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7474A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="OktRKzwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7474A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7DX-0006S4-NA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77D-00048M-J0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77C-0004ZP-AA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs775-0004S8-Mq; Mon, 29 Jul 2019 10:58:59 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 7518996F5B;
 Mon, 29 Jul 2019 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLHBAamQpnZuSEihCn2XlqNPDj9zeHn+BmvmCqsNNyM=;
 b=OktRKzwpS4DGsPujyFvuHWxHoOiFQMYuec2mEyCqFhQhRqVsx6iRQUmV9yM+GJgjBB1VV2
 rVU4tTsNKIOKz47aSvmkoNvjINRdD07upaDMw1OASDTHj/1Z3kzShIIzY5VjU5bP8fpe1/
 SqO10qi/lYTArxhx4bV4ozRANh0QWOg=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:27 +0200
Message-Id: <20190729145654.14644-7-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLHBAamQpnZuSEihCn2XlqNPDj9zeHn+BmvmCqsNNyM=;
 b=7FvqhxfHd9nIiRQiKCyoJA5jR+lY+zCsfj/Kt4pNUPP7NB4JZNThXE4fwdVqR7E50vS95J
 MzyI949VESJBVix+7dyB3nUWQJqmczcRrvEKJ1f8BXPzWvV2uEhsYv1EqZhqwyr6n/04gW
 hdTHl6Ah5853jF80pMOYu0ims4PzXcs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412338; a=rsa-sha256; cv=none;
 b=3ZEilZd31eZOE/WYaB9XrZNwsUgjcBOsCQbFYa5WECMb+IwBMXujJnoun+SIEXbnoJsbkF
 IogGDT9L+lKtNZ3VjmNW60NFhBcUJmdAGKBOxSJVn/9vktMXyTu1S7dlHjHG3Zn+B20Xh6
 axzuVGCpwNJMToS0ZxInyb9JE+TuvYU=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 06/33] add the vmstate description for
 device reset state
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It contains the resetting counter and cold flag status.

At this point, migration of bus reset related state (counter and cold/war=
m
flag) is handled by parent device. This done using the post_load
function in the vmsd subsection.

This is last point allow to add an initial support of migration with part=
 of
qdev/qbus tree in reset state under the following condition:
+ time-lasting reset are asserted on Device only

Note that if this condition is not respected, migration will succeed and
no failure will occurs. The only impact is that the resetting counter
of a bus may lower afer a migration.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/Makefile.objs  |  1 +
 hw/core/qdev-vmstate.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 hw/core/qdev-vmstate.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index d9234aa98a..49e9be0228 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-y +=3D bus.o reset.o
 common-obj-y +=3D resettable.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
+common-obj-$(CONFIG_SOFTMMU) +=3D qdev-vmstate.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y +=3D irq.o
 common-obj-y +=3D hotplug.o
diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
new file mode 100644
index 0000000000..07b010811f
--- /dev/null
+++ b/hw/core/qdev-vmstate.c
@@ -0,0 +1,45 @@
+/*
+ * Device vmstate
+ *
+ * Copyright (c) 2019 GreenSocs
+ *
+ * Authors:
+ *   Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "migration/vmstate.h"
+
+static bool device_vmstate_reset_needed(void *opaque)
+{
+    DeviceState *dev =3D (DeviceState *) opaque;
+    return dev->resetting !=3D 0;
+}
+
+static int device_vmstate_reset_post_load(void *opaque, int version_id)
+{
+    DeviceState *dev =3D (DeviceState *) opaque;
+    BusState *bus;
+    QLIST_FOREACH(bus, &dev->child_bus, sibling) {
+        bus->resetting =3D dev->resetting;
+        bus->reset_is_cold =3D dev->reset_is_cold;
+    }
+    return 0;
+}
+
+const struct VMStateDescription device_vmstate_reset =3D {
+    .name =3D "device_reset",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .needed =3D device_vmstate_reset_needed,
+    .post_load =3D device_vmstate_reset_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(resetting, DeviceState),
+        VMSTATE_BOOL(reset_is_cold, DeviceState),
+        VMSTATE_END_OF_LIST()
+    },
+};
--=20
2.22.0


