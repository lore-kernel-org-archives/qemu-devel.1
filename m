Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA6C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF34C21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRTq3oiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF34C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZTc-0001xP-54
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl9-0001Sb-HA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl8-0000eW-0u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl7-0000Vp-PE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id a5so2686493wmb.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tbesqImFvmpm3pltFdWslFBFzZQAO9ySS/7MkWtV0SA=;
 b=cRTq3oiWzDfsZdA4aW7z933HGBhcB1LQSSNp4o9Ul5qQd7o7QOl+u9JJ0eP4/RQWNK
 KbpIgV6qb1Zv3Su+R05Ex99j9PcLJWO83Lt196R7b6L9ec0osUROqxQKmxM++OiVSYVO
 YIys69RTi4l+XtKqAc1mofxCT1AjLRnoZpKDdx2RlYNkvrbcxS8dHzdXhFs0zsBJ5fVm
 /0eVGD6e3pxFNe1HXw1XnveQcKPbkZS6zKroF4xXavnyRjuM4Lmrbg30g0JLtDv92OxP
 85usHvWSJOdE4pzYItN/VrfqHWKXdeaxAbymvYZHUYkxZv56mSD2YDd/TOgxar7Xl6Hs
 rvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=tbesqImFvmpm3pltFdWslFBFzZQAO9ySS/7MkWtV0SA=;
 b=ETJ87kZBk934qJzU7Q14XKGhWVnRU6090FlC1FIZNB7b3OkN8/zCl4VTH2MMP+Xctr
 VMdJhqNmQdvMPVFsO+PubG8htIlKe5mY5IqKqcNVg4rVWLrEs7vi80eWeNpAwaCHy8nm
 husylGup4/Tqasg4Qk7V26OoYzB7AaiuAl0hQ0AFtcm6P0or5n617MW97mGlyDJ0fTXc
 gNSNccgZnNkW4j1432L7hDlzuwYtlb+hiDe5Z72Yztweyv1OxiukVIJ8Sn/DZFYIOLLp
 gF04BB0Vy5JDMtqDZ6Ekxjca+8lAJMR0VuhxaU6IWp6fCQ74RPtN9EETyYT1WcO6yfcf
 YHHQ==
X-Gm-Message-State: APjAAAVjjl/opk1ZY3zxJ9EZfCHd/5ygUnUO6iGgn8Bm8EwkN8uBHQp8
 zzX3hbuZlo8wK85zCu18IjXPg8za
X-Google-Smtp-Source: APXvYqz2QJ2QaEYxUf58hFSd3hMJqnSlEEVERdysFuQgDOkMJlgHoejsDounGl+0HD60uVUMvntlPQ==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4866090wma.24.1582631536311; 
 Tue, 25 Feb 2020 03:52:16 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 076/136] hostmem: introduce "prealloc-threads" property
Date: Tue, 25 Feb 2020 12:50:06 +0100
Message-Id: <1582631466-13880-76-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

the property will allow user to specify number of threads to use
in pre-allocation stage. It also will allow to reduce implicit
hostmem dependency on current_machine.
On object creation it will default to 1, but via machine
compat property it will be updated to MachineState::smp::cpus
to keep current behavior for hostmem and main RAM (which is
now also hostmem based).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-77-imammedo@redhat.com>
---
 backends/hostmem.c       | 43 +++++++++++++++++++++++++++++++++++++++----
 include/sysemu/hostmem.h |  2 ++
 vl.c                     | 14 ++++++++++----
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index e773bdf..0988986 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -223,7 +223,6 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
 {
     Error *local_err = NULL;
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    MachineState *ms = MACHINE(qdev_get_machine());
 
     if (backend->force_prealloc) {
         if (value) {
@@ -243,7 +242,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        os_mem_prealloc(fd, ptr, sz, ms->smp.cpus, &local_err);
+        os_mem_prealloc(fd, ptr, sz, backend->prealloc_threads, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -252,14 +251,45 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
     }
 }
 
+static void host_memory_backend_get_prealloc_threads(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    visit_type_uint32(v, name, &backend->prealloc_threads, errp);
+}
+
+static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (value <= 0) {
+        error_setg(&local_err,
+                   "property '%s' of %s doesn't take value '%d'",
+                   name, object_get_typename(obj), value);
+        goto out;
+    }
+    backend->prealloc_threads = value;
+out:
+    error_propagate(errp, local_err);
+}
+
 static void host_memory_backend_init(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     MachineState *machine = MACHINE(qdev_get_machine());
 
+    /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
     backend->prealloc = mem_prealloc;
+    backend->prealloc_threads = 1;
 }
 
 static void host_memory_backend_post_init(Object *obj)
@@ -313,7 +343,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
-    MachineState *ms = MACHINE(qdev_get_machine());
     Error *local_err = NULL;
     void *ptr;
     uint64_t sz;
@@ -378,7 +407,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
          */
         if (backend->prealloc) {
             os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
-                            ms->smp.cpus, &local_err);
+                            backend->prealloc_threads, &local_err);
             if (local_err) {
                 goto out;
             }
@@ -456,6 +485,12 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         host_memory_backend_set_prealloc, &error_abort);
     object_class_property_set_description(oc, "prealloc",
         "Preallocate memory", &error_abort);
+    object_class_property_add(oc, "prealloc-threads", "int",
+        host_memory_backend_get_prealloc_threads,
+        host_memory_backend_set_prealloc_threads,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "prealloc-threads",
+        "Number of CPU threads to use for prealloc", &error_abort);
     object_class_property_add(oc, "size", "int",
         host_memory_backend_get_size,
         host_memory_backend_set_size,
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 5db0d66..bdf8666 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -61,6 +61,7 @@ struct HostMemoryBackendClass {
  * @parent: opaque parent object container
  * @size: amount of memory backend provides
  * @mr: MemoryRegion representing host memory belonging to backend
+ * @prealloc_threads: number of threads to be used for preallocatining RAM
  */
 struct HostMemoryBackend {
     /* private */
@@ -70,6 +71,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, force_prealloc, is_mapped, share;
+    uint32_t prealloc_threads;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
 
diff --git a/vl.c b/vl.c
index 15cc5bd..afc682e 100644
--- a/vl.c
+++ b/vl.c
@@ -2828,8 +2828,7 @@ static void configure_accelerators(const char *progname)
     }
 }
 
-static void create_default_memdev(MachineState *ms, const char *path,
-                                  bool prealloc)
+static void create_default_memdev(MachineState *ms, const char *path)
 {
     Object *obj;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -2838,7 +2837,6 @@ static void create_default_memdev(MachineState *ms, const char *path,
     if (path) {
         object_property_set_str(obj, path, "mem-path", &error_fatal);
     }
-    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
     object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
     object_property_add_child(object_get_objects_root(), mc->default_ram_id,
                               obj, &error_fatal);
@@ -3980,6 +3978,14 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    if (mem_prealloc) {
+        char *val;
+
+        val = g_strdup_printf("%d", current_machine->smp.cpus);
+        object_register_sugar_prop("memory-backend", "prealloc-threads", val);
+        g_free(val);
+    }
+
     /*
      * Get the default machine options from the machine if it is not already
      * specified either by the configuration file or by the command line.
@@ -4307,7 +4313,7 @@ int main(int argc, char **argv, char **envp)
 
     if (machine_class->default_ram_id && current_machine->ram_size &&
         numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
-        create_default_memdev(current_machine, mem_path, mem_prealloc);
+        create_default_memdev(current_machine, mem_path);
     }
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
-- 
1.8.3.1



