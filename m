Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77276C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491272070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHPz8a/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3koL-0005Gh-DW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kK8-0004GH-1D
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kK6-0002mj-GZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kK6-0002mO-Cb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581961006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3WBhgws+9q12DLm3vWAGIUjNMO7VThSDD1VZwcJLcQ=;
 b=OHPz8a/m2lTLEkbiQRFdgsM1Co7K4Lff8z0G94dCMCkfNg4zbEpQECmni/fY7cOW68+4uE
 mIWtNbepwAWYk26F0bFhHEDhDq45XZ/7sWpJecTWJ8r7CqreN4wCLWeTUyu9uX3Hv51mLz
 DBUe6uxBtW8fdjKA6E9WtE2toMeGPNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-GoybkBNwNHa0e_x1vFXxTw-1; Mon, 17 Feb 2020 12:36:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2BBC107ACCA;
 Mon, 17 Feb 2020 17:36:40 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7ED090526;
 Mon, 17 Feb 2020 17:36:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 77/79] hostmem: fix strict bind policy
Date: Mon, 17 Feb 2020 12:34:50 -0500
Message-Id: <20200217173452.15243-78-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: GoybkBNwNHa0e_x1vFXxTw-1
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When option -mem-prealloc is used with one or more memory-backend
objects, created backends may not obey configured bind policy or
creation may fail after kernel attempts to move pages according
to bind policy.
Reason is in file_ram_alloc(), which will pre-allocate
any descriptor based RAM if global mem_prealloc !=3D 0 and that
happens way before bind policy is applied to memory range.

One way to fix it would be to extend memory_region_foo() API
and add more invariants that could broken later due implicit
dependencies that's hard to track.

Another approach is to drop adhoc main RAM allocation and
consolidate it around memory-backend. That allows to have
single place that allocates guest RAM (main and memdev)
in the same way and then global mem_prealloc could be
replaced by backend's property[s] that will affect created
memory-backend objects but only in correct order this time.

With main RAM now converted to hostmem backends, there is no
point in keeping global mem_prealloc around, so alias
 -mem-prealloc to "memory-backend.prealloc=3Don"
machine compat[*] property and make mem_prealloc a local
variable to only stir registration of compat property.

*) currently user accessible -global works only with DEVICE
   based objects and extra work is needed to make it work
   with hostmem backends. But that is convenience option
   and out of scope of this already huge refactoring.
   Hence machine compat properties were used.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  - use object_register_sugar_prop() instead of directly hacking
        compat_props (Paolo Bonzini <pbonzini@redhat.com>)

CC: pbonzini@redhat.com
CC: ehabkost@redhat.com
CC: rth@twiddle.net
CC: pasic@linux.ibm.com
---
 include/sysemu/hostmem.h |  2 +-
 include/sysemu/sysemu.h  |  1 -
 backends/hostmem-file.c  |  1 -
 backends/hostmem-memfd.c |  1 -
 backends/hostmem.c       | 12 +-----------
 exec.c                   | 11 -----------
 vl.c                     |  3 ++-
 7 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index bdf86665ab..8276e53683 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -70,7 +70,7 @@ struct HostMemoryBackend {
     /* protected */
     uint64_t size;
     bool merge, dump, use_canonical_path;
-    bool prealloc, force_prealloc, is_mapped, share;
+    bool prealloc, is_mapped, share;
     uint32_t prealloc_threads;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ae78b2a122..55bdd57a9b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -50,7 +50,6 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
-extern int mem_prealloc;
=20
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index cb319a9157..c8c355f5aa 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -51,7 +51,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Err=
or **errp)
         return;
     }
=20
-    backend->force_prealloc =3D mem_prealloc;
     name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                      name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 26070b425e..74ba9879c4 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -45,7 +45,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Er=
ror **errp)
         return;
     }
=20
-    backend->force_prealloc =3D mem_prealloc;
     fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                            m->hugetlb, m->hugetlbsize, m->seal ?
                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 0988986016..a70867b255 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -215,7 +215,7 @@ static bool host_memory_backend_get_prealloc(Object *ob=
j, Error **errp)
 {
     HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
=20
-    return backend->prealloc || backend->force_prealloc;
+    return backend->prealloc;
 }
=20
 static void host_memory_backend_set_prealloc(Object *obj, bool value,
@@ -224,14 +224,6 @@ static void host_memory_backend_set_prealloc(Object *o=
bj, bool value,
     Error *local_err =3D NULL;
     HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
=20
-    if (backend->force_prealloc) {
-        if (value) {
-            error_setg(errp,
-                       "remove -mem-prealloc to use the prealloc property"=
);
-            return;
-        }
-    }
-
     if (!host_memory_backend_mr_inited(backend)) {
         backend->prealloc =3D value;
         return;
@@ -288,8 +280,6 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge =3D machine_mem_merge(machine);
     backend->dump =3D machine_dump_guest_core(machine);
-    backend->prealloc =3D mem_prealloc;
-    backend->prealloc_threads =3D 1;
 }
=20
 static void host_memory_backend_post_init(Object *obj)
diff --git a/exec.c b/exec.c
index 6ebff8bd3a..8c0258a7ae 100644
--- a/exec.c
+++ b/exec.c
@@ -1801,8 +1801,6 @@ static void *file_ram_alloc(RAMBlock *block,
                             bool truncate,
                             Error **errp)
 {
-    Error *err =3D NULL;
-    MachineState *ms =3D MACHINE(qdev_get_machine());
     void *area;
=20
     block->page_size =3D qemu_fd_getpagesize(fd);
@@ -1858,15 +1856,6 @@ static void *file_ram_alloc(RAMBlock *block,
         return NULL;
     }
=20
-    if (mem_prealloc) {
-        os_mem_prealloc(fd, area, memory, ms->smp.cpus, &err);
-        if (err) {
-            error_propagate(errp, err);
-            qemu_ram_munmap(fd, area, memory);
-            return NULL;
-        }
-    }
-
     block->fd =3D fd;
     return area;
 }
diff --git a/vl.c b/vl.c
index afc682e168..54857f7afa 100644
--- a/vl.c
+++ b/vl.c
@@ -140,7 +140,6 @@ enum vga_retrace_method vga_retrace_method =3D VGA_RETR=
ACE_DUMB;
 int display_opengl;
 const char* keyboard_layout =3D NULL;
 ram_addr_t ram_size;
-int mem_prealloc =3D 0; /* force preallocation of physical target memory *=
/
 bool enable_mlock =3D false;
 bool enable_cpu_pm =3D false;
 int nb_nics;
@@ -2883,6 +2882,7 @@ int main(int argc, char **argv, char **envp)
     const char *mem_path =3D NULL;
     BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue=
);
     QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list);
+    int mem_prealloc =3D 0; /* force preallocation of physical target memo=
ry */
=20
     os_set_line_buffering();
=20
@@ -3984,6 +3984,7 @@ int main(int argc, char **argv, char **envp)
         val =3D g_strdup_printf("%d", current_machine->smp.cpus);
         object_register_sugar_prop("memory-backend", "prealloc-threads", v=
al);
         g_free(val);
+        object_register_sugar_prop("memory-backend", "prealloc", "on");
     }
=20
     /*
--=20
2.18.1


