Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032AEC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D632469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6B/29+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D632469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LpR-0008NC-VU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j7Loa-0007n3-50
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j7LoY-0003rR-VU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:15:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j7LoY-0003pD-R4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582820105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bNyLWGNE9kHvATz4mfxT7EoBsctiuGSIGJTwvnhyKCg=;
 b=P6B/29+aE+zCcR4DQ1338Sx7QUKVQBnNNhsVrqhsGHlQ+FLwwtvdxY/b3bUKFJNhLesNX1
 6Q04Qr2yXQ9N7AMpOXGZFzn8x9jsWVa+D6FxSCO6rxpergKQR24tRjNXfsrR9l4eDTFXA3
 e2ROA8rQu8bIbtoSx1+n/1/9+paxwY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Xs5MJBz-PUCTCtM5OL4DrQ-1; Thu, 27 Feb 2020 11:15:02 -0500
X-MC-Unique: Xs5MJBz-PUCTCtM5OL4DrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67193DB61;
 Thu, 27 Feb 2020 16:15:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A07D460BE2;
 Thu, 27 Feb 2020 16:14:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] softmmu/vl.c: fix too slow TCG regression
Date: Thu, 27 Feb 2020 11:14:54 -0500
Message-Id: <20200227161454.32368-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
v2:
  * check if user used -m SZ before comparing ram_size with backend's size.
    Fixes case where qemu exits with error when backend's size doesn't matc=
h
    dafault ram_size (i.e. user haven't used -m option  at all)
    (Peter Maydell <peter.maydell@linaro.org>)
  * keep order addr space size check for 32-bit host after
    backend size check. So it would be affected by backend's size as well.
---
 softmmu/vl.c | 54 ++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index a9cce78f45..16ff5a16a3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2558,7 +2558,7 @@ static bool object_create_delayed(const char *type, Q=
emuOpts *opts)
 }
=20
=20
-static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_siz=
e,
+static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_siz=
e,
                                MachineClass *mc)
 {
     uint64_t sz;
@@ -2634,30 +2634,8 @@ static void set_memory_options(uint64_t *ram_slots, =
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
+    return !!mem_str;
 }
=20
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -2861,6 +2839,7 @@ void qemu_init(int argc, char **argv, char **envp)
     bool list_data_dirs =3D false;
     char *dir, **dirs;
     const char *mem_path =3D NULL;
+    bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue=
);
     QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list);
     int mem_prealloc =3D 0; /* force preallocation of physical target memo=
ry */
@@ -3821,6 +3800,9 @@ void qemu_init(int argc, char **argv, char **envp)
     machine_class =3D select_machine();
     object_set_machine_compat_props(machine_class->compat_props);
=20
+    have_custom_ram_size =3D set_memory_options(&ram_slots, &maxram_size,
+                                              machine_class);
+
     os_daemonize();
=20
     /*
@@ -4296,7 +4278,29 @@ void qemu_init(int argc, char **argv, char **envp)
         current_machine->cpu_type =3D parse_cpu_option(cpu_option);
     }
=20
-    set_memory_options(&ram_slots, &maxram_size, machine_class);
+    if (current_machine->ram_memdev_id) {
+        Object *backend;
+        ram_addr_t backend_size;
+
+        backend =3D object_resolve_path_type(current_machine->ram_memdev_i=
d,
+                                           TYPE_MEMORY_BACKEND, NULL);
+        backend_size =3D object_property_get_uint(backend, "size",  &error=
_abort);
+        if (have_custom_ram_size && backend_size !=3D ram_size) {
+                error_report("Size specified by -m option must match size =
of "
+                             "explicitly specified 'memory-backend' proper=
ty");
+                exit(EXIT_FAILURE);
+        }
+        ram_size =3D backend_size;
+    }
+
+    if (!xen_enabled()) {
+        /* On 32-bit hosts, QEMU is limited by virtual address space */
+        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
+            error_report("at most 2047 MB RAM can be simulated");
+            exit(1);
+        }
+    }
+
     current_machine->ram_size =3D ram_size;
     current_machine->maxram_size =3D maxram_size;
     current_machine->ram_slots =3D ram_slots;
--=20
2.18.1


