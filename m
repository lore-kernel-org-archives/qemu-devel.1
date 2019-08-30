Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17391C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E369921726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E369921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3dH0-0005hx-46
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i3dFT-0005Fm-Sv
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i3dFN-0003LB-0c
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i3dFJ-0003BQ-2s
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:31:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 649DC10C6979;
 Fri, 30 Aug 2019 09:31:00 +0000 (UTC)
Received: from localhost (unknown [10.36.118.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8847160F86;
 Fri, 30 Aug 2019 09:30:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Fri, 30 Aug 2019 10:30:56 +0100
Message-Id: <20190830093056.12572-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 30 Aug 2019 09:31:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] memory: fetch pmem size in get_file_size()
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Junyan He <junyan.he@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Neither stat(2) nor lseek(2) report the size of Linux devdax pmem
character device nodes.  Commit 314aec4a6e06844937f1677f6cba21981005f389
("hostmem-file: reject invalid pmem file sizes") added code to
hostmem-file.c to fetch the size from sysfs and compare against the
user-provided size=3DNUM parameter:

  if (backend->size > size) {
      error_setg(errp, "size property %" PRIu64 " is larger than "
                 "pmem file \"%s\" size %" PRIu64, backend->size,
                 fb->mem_path, size);
      return;
  }

It turns out that exec.c:qemu_ram_alloc_from_fd() already has an
equivalent size check but it skips devdax pmem character devices because
lseek(2) returns 0:

  if (file_size > 0 && file_size < size) {
      error_setg(errp, "backing store %s size 0x%" PRIx64
                 " does not match 'size' option 0x" RAM_ADDR_FMT,
                 mem_path, file_size, size);
      return NULL;
  }

This patch moves the devdax pmem file size code into get_file_size() so
that we check the memory size in a single place:
qemu_ram_alloc_from_fd().  This simplifies the code and makes it more
general.

This also fixes the problem that hostmem-file only checks the devdax
pmem file size when the pmem=3Don parameter is given.  An unchecked
size=3DNUM parameter can lead to SIGBUS in QEMU so we must always fetch
the file size for Linux devdax pmem character device nodes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Note that this patch conflicts with "[PATCH] hostmem-file: fix pmem file
size check" but it obsoletes that patch, so the conflict can be resolved
simply by taking this patch instead of the older one.

 include/qemu/osdep.h    | 13 ----------
 backends/hostmem-file.c | 22 -----------------
 exec.c                  | 34 +++++++++++++++++++++++++-
 util/oslib-posix.c      | 54 -----------------------------------------
 util/oslib-win32.c      |  6 -----
 5 files changed, 33 insertions(+), 96 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index af2b91f0b8..c7d242f476 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -570,19 +570,6 @@ void qemu_set_tty_echo(int fd, bool echo);
 void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
                      Error **errp);
=20
-/**
- * qemu_get_pmem_size:
- * @filename: path to a pmem file
- * @errp: pointer to a NULL-initialized error object
- *
- * Determine the size of a persistent memory file.  Besides supporting f=
iles on
- * DAX file systems, this function also supports Linux devdax character
- * devices.
- *
- * Returns: the size or 0 on failure
- */
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp);
-
 /**
  * qemu_get_pid_name:
  * @pid: pid of a process
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 29e55c9195..be64020746 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -58,28 +58,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, =
Error **errp)
         return;
     }
=20
-    /*
-     * Verify pmem file size since starting a guest with an incorrect si=
ze
-     * leads to confusing failures inside the guest.
-     */
-    if (fb->is_pmem) {
-        Error *local_err =3D NULL;
-        uint64_t size;
-
-        size =3D qemu_get_pmem_size(fb->mem_path, &local_err);
-        if (!size) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
-        if (backend->size > size) {
-            error_setg(errp, "size property %" PRIu64 " is larger than "
-                       "pmem file \"%s\" size %" PRIu64, backend->size,
-                       fb->mem_path, size);
-            return;
-        }
-    }
-
     backend->force_prealloc =3D mem_prealloc;
     name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
diff --git a/exec.c b/exec.c
index 1df966d17a..80150420a8 100644
--- a/exec.c
+++ b/exec.c
@@ -1814,7 +1814,39 @@ long qemu_maxrampagesize(void)
 #ifdef CONFIG_POSIX
 static int64_t get_file_size(int fd)
 {
-    int64_t size =3D lseek(fd, 0, SEEK_END);
+    int64_t size;
+#if defined(__linux__)
+    struct stat st;
+
+    if (fstat(fd, &st) < 0) {
+        return -errno;
+    }
+
+    /* Special handling for devdax character devices */
+    if (S_ISCHR(st.st_mode)) {
+        g_autofree char *subsystem_path =3D NULL;
+        g_autofree char *subsystem =3D NULL;
+
+        subsystem_path =3D g_strdup_printf("/sys/dev/char/%d:%d/subsyste=
m",
+                                         major(st.st_rdev), minor(st.st_=
rdev));
+        subsystem =3D g_file_read_link(subsystem_path, NULL);
+
+        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
+            g_autofree char *size_path =3D NULL;
+            g_autofree char *size_str =3D NULL;
+
+            size_path =3D g_strdup_printf("/sys/dev/char/%d:%d/size",
+                                    major(st.st_rdev), minor(st.st_rdev)=
);
+
+            if (g_file_get_contents(size_path, &size_str, NULL, NULL)) {
+                return g_ascii_strtoll(size_str, NULL, 0);
+            }
+        }
+    }
+#endif /* defined(__linux__) */
+
+    /* st.st_size may be zero for special files yet lseek(2) works */
+    size =3D lseek(fd, 0, SEEK_END);
     if (size < 0) {
         return -errno;
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5fda67dedf..f8693384fc 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -514,60 +514,6 @@ void os_mem_prealloc(int fd, char *area, size_t memo=
ry, int smp_cpus,
     }
 }
=20
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
-{
-    struct stat st;
-
-    if (stat(filename, &st) < 0) {
-        error_setg(errp, "unable to stat pmem file \"%s\"", filename);
-        return 0;
-    }
-
-#if defined(__linux__)
-    /* Special handling for devdax character devices */
-    if (S_ISCHR(st.st_mode)) {
-        char *subsystem_path =3D NULL;
-        char *subsystem =3D NULL;
-        char *size_path =3D NULL;
-        char *size_str =3D NULL;
-        uint64_t ret =3D 0;
-
-        subsystem_path =3D g_strdup_printf("/sys/dev/char/%d:%d/subsyste=
m",
-                                         major(st.st_rdev), minor(st.st_=
rdev));
-        subsystem =3D g_file_read_link(subsystem_path, NULL);
-        if (!subsystem) {
-            error_setg(errp, "unable to read subsystem for pmem file \"%=
s\"",
-                       filename);
-            goto devdax_err;
-        }
-
-        if (!g_str_has_suffix(subsystem, "/dax")) {
-            error_setg(errp, "pmem file \"%s\" is not a dax device", fil=
ename);
-            goto devdax_err;
-        }
-
-        size_path =3D g_strdup_printf("/sys/dev/char/%d:%d/size",
-                                    major(st.st_rdev), minor(st.st_rdev)=
);
-        if (!g_file_get_contents(size_path, &size_str, NULL, NULL)) {
-            error_setg(errp, "unable to read size for pmem file \"%s\"",
-                       size_path);
-            goto devdax_err;
-        }
-
-        ret =3D g_ascii_strtoull(size_str, NULL, 0);
-
-devdax_err:
-        g_free(size_str);
-        g_free(size_path);
-        g_free(subsystem);
-        g_free(subsystem_path);
-        return ret;
-    }
-#endif /* defined(__linux__) */
-
-    return st.st_size;
-}
-
 char *qemu_get_pid_name(pid_t pid)
 {
     char *name =3D NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 9583fb4ca4..c62cd4328c 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -562,12 +562,6 @@ void os_mem_prealloc(int fd, char *area, size_t memo=
ry, int smp_cpus,
     }
 }
=20
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
-{
-    error_setg(errp, "pmem support not available");
-    return 0;
-}
-
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
--=20
2.21.0


