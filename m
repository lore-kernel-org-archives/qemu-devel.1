Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FAC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C951E20661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjA6+cl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C951E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXzS-00063R-UY
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXy2-0003qV-Qu
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXy0-0003ZC-Bd
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXxz-0003WN-Tb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiTH3RCZbiNiyeo52IdgEALm97v/0+Rpq/gsC0EpHEo=;
 b=LjA6+cl22oqTpPzc63qNN7htWW1YnXCj99E4zaT/HEJKuFE4Aik3YFw2R6dQi2Cc6WuhNr
 s+9HJTAyZNX9/iVxl8LFNYOAkwT/ppOjDsOgA7Og/F20T+Kuw7Hw7RLoZF/FoAP/EcVCaB
 y5x7JrbM1U1ulSo6sVkhdQfLlHmnu6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-6YfG3V8TNVe5UjD41iTvVQ-1; Fri, 31 Jan 2020 10:12:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDEE91005512;
 Fri, 31 Jan 2020 15:12:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C278B8887E;
 Fri, 31 Jan 2020 15:12:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/80] machine: introduce memory-backend property
Date: Fri, 31 Jan 2020 16:08:32 +0100
Message-Id: <1580483390-131164-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6YfG3V8TNVe5UjD41iTvVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Property will contain link to memory backend that will be
used for backing initial RAM.
Follow up commit will alias -mem-path and -mem-prealloc
CLI options into memory backend options to make memory
handling consistent (using only hostmem backend family
for guest RAM allocation).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
 * make property a string, instead of a link.
   Fixes -M memory-backend=3Dfoo: foo not found error
   since foo creation is delayed well beyond point
   where machine's properties are set
v3:
 * rename property name from ram-memdev to memory-backend
   (Paolo Bonzini <pbonzini@redhat.com>)

CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: pasic@linux.ibm.com
---
 include/hw/boards.h |  2 ++
 hw/core/machine.c   | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index fb1b43d..7b4b6b7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -4,6 +4,7 @@
 #define HW_BOARDS_H
=20
 #include "exec/memory.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "qapi/qapi-types-machine.h"
@@ -285,6 +286,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
+    char *ram_memdev_id;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bf..752a227 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -505,6 +505,22 @@ static void validate_sysbus_device(SysBusDevice *sbdev=
, void *opaque)
     }
 }
=20
+static char *machine_get_memdev(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return g_strdup(ms->ram_memdev_id);
+}
+
+static void machine_set_memdev(Object *obj, const char *value, Error **err=
p)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    g_free(ms->ram_memdev_id);
+    ms->ram_memdev_id =3D g_strdup(value);
+}
+
+
 static void machine_init_notify(Notifier *notifier, void *data)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
@@ -886,6 +902,14 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)", NULL);
     }
=20
+    object_property_add_str(obj, "memory-backend",
+                            machine_get_memdev, machine_set_memdev,
+                            &error_abort);
+    object_property_set_description(obj, "memory-backend",
+                                    "Set RAM backend"
+                                    "Valid value is ID of hostmem based ba=
ckend",
+                                     &error_abort);
+
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
     qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
--=20
2.7.4


