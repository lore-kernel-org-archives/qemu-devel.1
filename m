Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318FD207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW93CUan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318FD207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmLr-0006mS-9T
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irmKk-0005Rg-3D
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irmKg-0005Cs-Cj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irmKg-0005CH-8o
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579108793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JH3EdUWj3wKoobIwk2gw4sJP5WMzJ8ZeLGYEUoVbZs=;
 b=XW93CUanoC9z0GfTWXn6QBreyLvs6uhbNB8piJ9ZaLlWhZShF0nlaEiOcd/8x+7CDPSh2e
 9ft1GNNyhZQrOlWcOOnvJl8N83gBXDBM4q8Xyx5TdRZDVjzg9Asp5hiNBt8pl1HyEvR2Kd
 hJaIBVPyn+gxaqZB3NAKVM7s1oeX1vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-bc0pbWHQM72S1bTGk5SGiw-1; Wed, 15 Jan 2020 12:19:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF8E802B6D;
 Wed, 15 Jan 2020 17:19:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F19D60BE0;
 Wed, 15 Jan 2020 17:19:45 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 81/86] hostmem: fix strict bind policy
Date: Wed, 15 Jan 2020 18:17:24 +0100
Message-Id: <1579108644-162327-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-82-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-82-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bc0pbWHQM72S1bTGk5SGiw-1
X-Mimecast-Spam-Score: 0
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
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
index bdf8666..8276e53 100644
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
index 8de9065..b72c773 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -53,7 +53,6 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
-extern int mem_prealloc;
=20
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index cb319a9..c8c355f 100644
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
index 26070b4..74ba987 100644
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
index 4c23c77..1f09ade 100644
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
     /* TODO: convert this compat properties */
     backend->merge =3D machine_mem_merge(machine);
     backend->dump =3D machine_dump_guest_core(machine);
-    backend->prealloc =3D mem_prealloc;
-    backend->prealloc_threads =3D 1;
 }
=20
 static void host_memory_backend_post_init(Object *obj)
diff --git a/exec.c b/exec.c
index d0a7e7e..cbe5bc5 100644
--- a/exec.c
+++ b/exec.c
@@ -1802,8 +1802,6 @@ static void *file_ram_alloc(RAMBlock *block,
                             bool truncate,
                             Error **errp)
 {
-    Error *err =3D NULL;
-    MachineState *ms =3D MACHINE(qdev_get_machine());
     void *area;
=20
     block->page_size =3D qemu_fd_getpagesize(fd);
@@ -1859,15 +1857,6 @@ static void *file_ram_alloc(RAMBlock *block,
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
index 8a047bd..7b3203f 100644
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
@@ -2874,6 +2873,7 @@ int main(int argc, char **argv, char **envp)
     const char *mem_path =3D NULL;
     BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue=
);
     QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list);
+    int mem_prealloc =3D 0; /* force preallocation of physical target memo=
ry */
=20
     os_set_line_buffering();
=20
@@ -3977,6 +3977,7 @@ int main(int argc, char **argv, char **envp)
         val =3D g_strdup_printf("%d", current_machine->smp.cpus);
         object_register_sugar_prop("memory-backend", "prealloc-threads", v=
al);
         g_free(val);
+        object_register_sugar_prop("memory-backend", "prealloc", "on");
     }
=20
     /*
--=20
2.7.4


