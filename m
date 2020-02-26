Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82CC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB1220656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d55aFFsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB1220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zgk-0007ZZ-0x
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6zf5-00064R-6I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6zf3-0003Wo-Ho
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:35:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6zf3-0003UB-CO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582734948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/XmbZl5hVxf9mBKle2so7WaYK9uC/KlUOAGiDFJdeFA=;
 b=d55aFFsHx8LwP+G6oWOnz34xeYlRGHY1iNGi2cXPW5B9fwseHwPKdKTUrTC5b84l/kuqma
 7BkAzGlh3HYHtTNEe4nPXhNp4BGZjeWxgblH68SUYT1gKaFPH8J6TGrpX2hO8S1HSzbKJn
 +r9G2fhb+bjAH8PzDN1paMhRvZV5Twk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-d9NOFpIANIGhU_wESnBNMA-1; Wed, 26 Feb 2020 11:35:45 -0500
X-MC-Unique: d9NOFpIANIGhU_wESnBNMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 041A8800EBB;
 Wed, 26 Feb 2020 16:35:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 568F219C69;
 Wed, 26 Feb 2020 16:35:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu/vl.c: fix too slow TCG regression
Date: Wed, 26 Feb 2020 11:35:39 -0500
Message-Id: <20200226163539.31960-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, nieklinnenbank@gmail.com,
 hsp.cat7@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
that broke TCG accelerator initialization which accesses global ram_size
from size_code_gen_buffer() which is equal to 0 at that moment.

Partially revert a1b18df9a4, by returning set_memory_options() to its
original location and only keep 32-bit host VA check and 'memory-backend'
size check introduced by fe64d06afc at current place.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---

PS:
This should take care of regression and give more time to think about
how to remove size_code_gen_buffer() dependency on ram_size
---
 softmmu/vl.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index a9cce78f45..da7577129c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2634,29 +2634,6 @@ static void set_memory_options(uint64_t *ram_slots, =
ram_addr_t *maxram_size,
         exit(EXIT_FAILURE);
     }
=20
-    if (current_machine->ram_memdev_id) {
-        Object *backend;
-        ram_addr_t backend_size;
-
-        backend =3D object_resolve_path_type(current_machine->ram_memdev_i=
d,
-                                           TYPE_MEMORY_BACKEND, NULL);
-        backend_size =3D object_property_get_uint(backend, "size",  &error=
_abort);
-        if (mem_str && backend_size !=3D ram_size) {
-                error_report("Size specified by -m option must match size =
of "
-                             "explicitly specified 'memory-backend' proper=
ty");
-                exit(EXIT_FAILURE);
-        }
-        ram_size =3D backend_size;
-    }
-
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
-            error_report("at most 2047 MB RAM can be simulated");
-            exit(1);
-        }
-    }
-
     loc_pop(&loc);
 }
=20
@@ -3821,6 +3798,8 @@ void qemu_init(int argc, char **argv, char **envp)
     machine_class =3D select_machine();
     object_set_machine_compat_props(machine_class->compat_props);
=20
+    set_memory_options(&ram_slots, &maxram_size, machine_class);
+
     os_daemonize();
=20
     /*
@@ -4296,7 +4275,29 @@ void qemu_init(int argc, char **argv, char **envp)
         current_machine->cpu_type =3D parse_cpu_option(cpu_option);
     }
=20
-    set_memory_options(&ram_slots, &maxram_size, machine_class);
+    if (!xen_enabled()) {
+        /* On 32-bit hosts, QEMU is limited by virtual address space */
+        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
+            error_report("at most 2047 MB RAM can be simulated");
+            exit(1);
+        }
+    }
+
+    if (current_machine->ram_memdev_id) {
+        Object *backend;
+        ram_addr_t backend_size;
+
+        backend =3D object_resolve_path_type(current_machine->ram_memdev_i=
d,
+                                           TYPE_MEMORY_BACKEND, NULL);
+        backend_size =3D object_property_get_uint(backend, "size",  &error=
_abort);
+        if (backend_size !=3D ram_size) {
+                error_report("Size specified by -m option must match size =
of "
+                             "explicitly specified 'memory-backend' proper=
ty");
+                exit(EXIT_FAILURE);
+        }
+        ram_size =3D backend_size;
+    }
+
     current_machine->ram_size =3D ram_size;
     current_machine->maxram_size =3D maxram_size;
     current_machine->ram_slots =3D ram_slots;
--=20
2.18.1


