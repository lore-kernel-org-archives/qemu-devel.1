Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E795BC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03492465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2/e9Ttb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03492465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkLA-00006O-08
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkJF-0006OT-MF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkJE-0007hX-GA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkJE-0007h7-Cb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uey6M6hazpMMRttL+/DT8NISXwTDzqjE/9zWd7+CaJA=;
 b=d2/e9TtbNWD1GuVTRPU+RjWRGFAZjUPi2rKoMYxBQvo5ALG3Fu9hT4qSBpSPYts2qMlhXc
 yxKNnhe6DaEPGFl+zK3gbHaW4JEswTXOWePfOOKUsduxIXoqvDZUiwZ3L17iqmRjdkE03m
 O9hPpa5N5ITtJYwMocuFtlYfx3PxS2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-OlNA-AkPPVOhR317mYhlWw-1; Wed, 15 Jan 2020 10:10:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65EC1102290F
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20762899E;
 Wed, 15 Jan 2020 15:10:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/86] machine: introduce ram-memdev property
Date: Wed, 15 Jan 2020 16:06:17 +0100
Message-Id: <1579100861-73692-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OlNA-AkPPVOhR317mYhlWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com
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
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
---
 include/hw/boards.h | 2 ++
 hw/core/machine.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index fb1b43d..6aa01b8 100644
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
+    HostMemoryBackend *ram_memdev;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bf..fd573d2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -886,6 +886,15 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)", NULL);
     }
=20
+    object_property_add_link(obj, "ram-memdev", TYPE_MEMORY_BACKEND,
+                             (Object **)&ms->ram_memdev,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+    object_property_set_description(obj, "ram-memdev",
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


