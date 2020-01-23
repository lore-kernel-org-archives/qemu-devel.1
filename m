Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A1C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1F12253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEw+Slcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1F12253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaAr-0002GA-16
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 05:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuaA4-0001Q5-7O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuaA3-0002XL-3Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:56:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuaA2-0002W3-Uv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579776990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaOaicH6bRk3FSp2iZu1SQpC36iDD1sE8fB/0bIEj+k=;
 b=eEw+SlcqrTiiB75mZ2wsIF2mY4/b9qnD9id/STRvdlpTDfDmNd3bNWJ3Z19IBQgVKVscUH
 rqhhv1f4Iy7y7HIcRs7is9zIiBPzrRpifRzsH+pBpnvSo52VtMVz91jc4YrRpZvU1F4JWA
 K5iREQM6l+gJcjWgghtpyJjfZj132jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-juggWYIRNCCTdrrxbzrwLw-1; Thu, 23 Jan 2020 05:56:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C27108592B
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:56:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 704D51001920;
 Thu, 23 Jan 2020 10:56:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/80] machine: introduce memory-backend property
Date: Thu, 23 Jan 2020 11:52:46 +0100
Message-Id: <1579776844-163759-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579776844-163759-1-git-send-email-imammedo@redhat.com>
References: <1579776844-163759-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: juggWYIRNCCTdrrxbzrwLw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
v3:
 * rename property name from ram-memdev to memory-backend
   (Paolo Bonzini <pbonzini@redhat.com>)

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
index 3e288bf..bf30183 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -886,6 +886,15 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)", NULL);
     }
=20
+    object_property_add_link(obj, "memory-backend", TYPE_MEMORY_BACKEND,
+                             (Object **)&ms->ram_memdev,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
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


