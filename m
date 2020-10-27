Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5062A20760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1g1Lj1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5062A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTxI-0007IF-E8
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbz-0004K5-QB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbi-00031U-AP
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk+F3ovluK3r02ObD8p6OXsJo5xPHhpV/0lfYt+FM60=;
 b=E1g1Lj1Em8UrT9ZoK0XmauX3skTkPoqD1I/lBHnnYn7s79yzEqwbGNyhNTyOxzDnHmclIp
 vhvCSFNMSUfBtszwi0OvKFC+mPVCvzSWDm7VORn71zc7zHtUu9vPVm8XiHO+v8LjZjSqRU
 CYTTfURwJ9GihWx/NDIJZ0182zuF/Y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-u1x6EuLqN2C5FRsQGsEUnA-1; Tue, 27 Oct 2020 14:22:03 -0400
X-MC-Unique: u1x6EuLqN2C5FRsQGsEUnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5DA108597D
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BA6B50B44
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/29] vl: separate qemu_resolve_machine_memdev
Date: Tue, 27 Oct 2020 14:21:36 -0400
Message-Id: <20201027182144.3315885-22-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit nasty: the machine is storing a string and later
resolving it.  We probably want to remove the memdev property
and instead make this a memory-set command.  "-M memdev" can be
handled as a legacy option that is special cased by
machine_set_property.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 70 +++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 9a3c92387e..1485aba8be 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2834,6 +2834,42 @@ static bool have_custom_ram_size(void)
     return !!qemu_opt_get(opts, "size");
 }
 
+static void qemu_resolve_machine_memdev(void)
+{
+    if (current_machine->ram_memdev_id) {
+        Object *backend;
+        ram_addr_t backend_size;
+
+        backend = object_resolve_path_type(current_machine->ram_memdev_id,
+                                           TYPE_MEMORY_BACKEND, NULL);
+        if (!backend) {
+            error_report("Memory backend '%s' not found",
+                         current_machine->ram_memdev_id);
+            exit(EXIT_FAILURE);
+        }
+        backend_size = object_property_get_uint(backend, "size",  &error_abort);
+        if (have_custom_ram_size() && backend_size != ram_size) {
+                error_report("Size specified by -m option must match size of "
+                             "explicitly specified 'memory-backend' property");
+                exit(EXIT_FAILURE);
+        }
+        if (mem_path) {
+            error_report("'-mem-path' can't be used together with"
+                         "'-machine memory-backend'");
+            exit(EXIT_FAILURE);
+        }
+        ram_size = backend_size;
+    }
+
+    if (!xen_enabled()) {
+        /* On 32-bit hosts, QEMU is limited by virtual address space */
+        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
+            error_report("at most 2047 MB RAM can be simulated");
+            exit(1);
+        }
+    }
+}
+
 static void set_memory_options(MachineClass *mc)
 {
     uint64_t sz;
@@ -4476,39 +4512,7 @@ void qemu_init(int argc, char **argv, char **envp)
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
 
-    if (current_machine->ram_memdev_id) {
-        Object *backend;
-        ram_addr_t backend_size;
-
-        backend = object_resolve_path_type(current_machine->ram_memdev_id,
-                                           TYPE_MEMORY_BACKEND, NULL);
-        if (!backend) {
-            error_report("Memory backend '%s' not found",
-                         current_machine->ram_memdev_id);
-            exit(EXIT_FAILURE);
-        }
-        backend_size = object_property_get_uint(backend, "size",  &error_abort);
-        if (have_custom_ram_size() && backend_size != ram_size) {
-                error_report("Size specified by -m option must match size of "
-                             "explicitly specified 'memory-backend' property");
-                exit(EXIT_FAILURE);
-        }
-        if (mem_path) {
-            error_report("'-mem-path' can't be used together with"
-                         "'-machine memory-backend'");
-            exit(EXIT_FAILURE);
-        }
-        ram_size = backend_size;
-    }
-
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
-            error_report("at most 2047 MB RAM can be simulated");
-            exit(1);
-        }
-    }
-
+    qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
 
     /* do monitor/qmp handling at preconfig state if requested */
-- 
2.26.2



