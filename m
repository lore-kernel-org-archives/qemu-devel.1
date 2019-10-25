Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ECECA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EE821928
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOyfKRa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EE821928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpMS-0000v8-30
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIp-0002C5-Ml
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIn-0007aQ-AM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIn-0007aJ-7D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1cNalAwrJV0DyhikBx4irI+M0/L+czcaXHTP5IwohM=;
 b=YOyfKRa0H7IFl+E/q7Cj8tM1depHFU7OLjGxZAwAFz3mFJQbgXHSCb8O+ns+Pm5Xsa5Z77
 5CBKNjeOY0h7FATlpRbA61cjZhgoGg9uzEacqhdwd+Bc2YWANYWjVaXEJPU49u8unvE80d
 ZmFI5uZms+9LQDZ/cdutFevq7lBW4NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-YOZEUWc6MEeymIB4zKdGuA-1; Thu, 24 Oct 2019 22:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9374547B;
 Fri, 25 Oct 2019 02:26:04 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF64D600C6;
 Fri, 25 Oct 2019 02:26:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] machine: machine_find_class() function
Date: Thu, 24 Oct 2019 23:25:50 -0300
Message-Id: <20191025022553.25298-5-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YOZEUWc6MEeymIB4zKdGuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move find_machine() from vl.c to core/machine.c and rename it to
machine_find_class(), so it can be reused by other code.

The function won't reuse the results of the previous
object_class_get_list() call like it did in vl.c, but this
shouldn't be a problem because the function is expected to be
called only once during regular QEMU usage.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/core/machine.c   | 16 ++++++++++++++++
 vl.c                | 17 +----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087f34..0ab7138c63 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -76,6 +76,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
=20
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *=
type);
+MachineClass *machine_find_class(const char *name);
=20
=20
 /**
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..53dae1cd08 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1143,6 +1143,22 @@ void machine_run_board_init(MachineState *machine)
     machine_class->init(machine);
 }
=20
+MachineClass *machine_find_class(const char *name)
+{
+    g_autoptr(GSList) machines =3D object_class_get_list(TYPE_MACHINE, fal=
se);
+    GSList *el;
+
+    for (el =3D machines; el; el =3D el->next) {
+        MachineClass *mc =3D el->data;
+
+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            return mc;
+        }
+    }
+
+    return NULL;
+}
+
 static const TypeInfo machine_info =3D {
     .name =3D TYPE_MACHINE,
     .parent =3D TYPE_OBJECT,
diff --git a/vl.c b/vl.c
index 4489cfb2bb..8901455ee7 100644
--- a/vl.c
+++ b/vl.c
@@ -1306,21 +1306,6 @@ static int usb_parse(const char *cmdline)
=20
 MachineState *current_machine;
=20
-static MachineClass *find_machine(const char *name, GSList *machines)
-{
-    GSList *el;
-
-    for (el =3D machines; el; el =3D el->next) {
-        MachineClass *mc =3D el->data;
-
-        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
-            return mc;
-        }
-    }
-
-    return NULL;
-}
-
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
@@ -2485,7 +2470,7 @@ static MachineClass *machine_parse(const char *name, =
GSList *machines)
         exit(0);
     }
=20
-    mc =3D find_machine(name, machines);
+    mc =3D machine_find_class(name);
     if (!mc) {
         error_report("unsupported machine type");
         error_printf("Use -machine help to list supported machines\n");
--=20
2.21.0


