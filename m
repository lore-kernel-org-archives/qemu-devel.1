Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25917C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07D621787
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fctopaUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07D621787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLsr-0003rp-Jv
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKab-0003ix-0c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKaT-0001gn-TH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iaKaS-0001Ut-U8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgnpYoryusYSkHCOF8hvM58bDZMeirroeyZIwZLJWCA=;
 b=fctopaUXrH/9SFBG0wLTlM9gwqXNi21h1Rk0oBneMwf5Kt5FVft6Zf9yvBebZob6v1GshQ
 Vhg7/G0M3nAx9bk6ZfFslll/diDsXk1vvAPq2Vcs7dMBSTW/u+3x0pQElKQOWmU7v6oYDx
 fXgstAq9Sftb09HHCLL8wXZgrEFuljI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Q0ZrvZ_vMsuwe9JUMflljQ-1; Thu, 28 Nov 2019 09:15:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85CB107ACC4;
 Thu, 28 Nov 2019 14:15:55 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8ED2608BF;
 Thu, 28 Nov 2019 14:15:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] Add -mem-shared option
Date: Thu, 28 Nov 2019 18:15:18 +0400
Message-Id: <20191128141518.628245-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Q0ZrvZ_vMsuwe9JUMflljQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option to simplify shared memory / vhost-user setup.

Currently, using vhost-user requires NUMA setup such as:
-m 4G -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,sh=
are=3Don -numa node,memdev=3Dmem

As there is no other way to allocate shareable RAM, afaik.

-mem-shared aims to have a simple way instead: -m 4G -mem-shared

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 exec.c                  | 11 ++++++++++-
 hw/core/numa.c          | 16 +++++++++++++++-
 include/sysemu/sysemu.h |  1 +
 qemu-options.hx         | 10 ++++++++++
 vl.c                    |  4 ++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index ffdb518535..4e53937eaf 100644
--- a/exec.c
+++ b/exec.c
@@ -72,6 +72,10 @@
 #include "qemu/mmap-alloc.h"
 #endif
=20
+#ifdef CONFIG_POSIX
+#include "qemu/memfd.h"
+#endif
+
 #include "monitor/monitor.h"
=20
 //#define DEBUG_SUBPAGE
@@ -2347,7 +2351,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, =
MemoryRegion *mr,
     bool created;
     RAMBlock *block;
=20
-    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, errp)=
;
+    if (mem_path) {
+        fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, e=
rrp);
+    } else {
+        fd =3D qemu_memfd_open(mr->name, size,
+                             F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL, er=
rp);
+    }
     if (fd < 0) {
         return NULL;
     }
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a984f..6f72cddb1c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -493,7 +493,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion=
 *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err =3D NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
+                                         mem_shared ? RAM_SHARED : 0,
                                          mem_path, &err);
         if (err) {
             error_report_err(err);
@@ -513,6 +514,19 @@ static void allocate_system_memory_nonnuma(MemoryRegio=
n *mr, Object *owner,
 #else
         fprintf(stderr, "-mem-path not supported on this host\n");
         exit(1);
+#endif
+    } else if (mem_shared) {
+#ifdef CONFIG_POSIX
+        Error *err =3D NULL;
+        memory_region_init_ram_from_file(mr, owner, NULL, ram_size, 0,
+                                         RAM_SHARED, NULL, &err);
+        if (err) {
+            error_report_err(err);
+            exit(1);
+        }
+#else
+        fprintf(stderr, "-mem-shared not supported on this host\n");
+        exit(1);
 #endif
     } else {
         memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error=
_fatal);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 80c57fdc4e..80db8465a9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -55,6 +55,7 @@ extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
 extern int mem_prealloc;
+extern int mem_shared;
=20
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b73..4c69b03ad3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -394,6 +394,16 @@ STEXI
 Preallocate memory when using -mem-path.
 ETEXI
=20
+DEF("mem-shared", 0, QEMU_OPTION_mem_shared,
+    "-mem-shared     allocate shared memory\n", QEMU_ARCH_ALL)
+STEXI
+@item -mem-shared
+@findex -mem-shared
+Allocate guest RAM with shared mapping.  Whether the allocation is
+anonymous or not (with -mem-path), QEMU will allocate a shared memory that
+can be shared by unrelated processes, such as vhost-user backends.
+ETEXI
+
 DEF("k", HAS_ARG, QEMU_OPTION_k,
     "-k language     use keyboard layout (for example 'fr' for French)\n",
     QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index 6a65a64bfd..53b1155455 100644
--- a/vl.c
+++ b/vl.c
@@ -143,6 +143,7 @@ const char* keyboard_layout =3D NULL;
 ram_addr_t ram_size;
 const char *mem_path =3D NULL;
 int mem_prealloc =3D 0; /* force preallocation of physical target memory *=
/
+int mem_shared =3D 0;
 bool enable_mlock =3D false;
 bool enable_cpu_pm =3D false;
 int nb_nics;
@@ -3172,6 +3173,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc =3D 1;
                 break;
+            case QEMU_OPTION_mem_shared:
+                mem_shared =3D 1;
+                break;
             case QEMU_OPTION_d:
                 log_mask =3D optarg;
                 break;
--=20
2.24.0


