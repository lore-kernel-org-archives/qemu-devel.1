Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48056C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BF4206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYJAscNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BF4206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTij-0005AS-NR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbq-0004Dl-Ic
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbg-00030Y-Nn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/ntxoogpIBJG2Ygammh62juf0lSV6vtWVYBDWDr8rg=;
 b=JYJAscNF4sVbIJo336b7Tbg/AEpVF+5OC395paCdSKNO8LMIoWvJ9GFOIEn5BLOSXeDoDa
 uN4R9jUQua/XO14rQ5gItufINo1atoZZlyZ9JsmCs/u9GninrMt9QXkyef029ujijGkjYG
 ceVgW+TkeQLsjYPvMuzSlrPdHu0bUMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-YJZDJnVaPguHi5mydWAPrA-1; Tue, 27 Oct 2020 14:22:01 -0400
X-MC-Unique: YJZDJnVaPguHi5mydWAPrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 023B7ACE91
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB9E660C07
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/29] vl: extract validation of -smp to machine.c
Date: Tue, 27 Oct 2020 14:21:18 -0400
Message-Id: <20201027182144.3315885-4-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Once smp_parse is done, the validation operates on the MachineState.
There is no reason for that code to be in vl.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 23 +++++++++++++++++++++++
 include/hw/boards.h |  1 +
 softmmu/vl.c        | 20 ++------------------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5e0e79e6d..baea4e8613 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1072,6 +1072,29 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
     return ret;
 }
 
+bool machine_smp_parse(MachineState *ms, QemuOpts *opts, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    mc->smp_parse(ms, opts);
+
+    /* sanity-check smp_cpus and max_cpus against mc */
+    if (ms->smp.cpus < mc->min_cpus) {
+        error_setg(errp, "Invalid SMP CPUs %d. The min CPUs "
+                   "supported by machine '%s' is %d",
+                   ms->smp.cpus,
+                   mc->name, mc->min_cpus);
+        return false;
+    } else if (ms->smp.max_cpus > mc->max_cpus) {
+        error_setg(errp, "Invalid SMP CPUs %d. The max CPUs "
+                   "supported by machine '%s' is %d",
+                   current_machine->smp.max_cpus,
+                   mc->name, mc->max_cpus);
+        return false;
+    }
+    return true;
+}
+
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a49e3a6b44..4537cfb5c6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -26,6 +26,7 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
+bool machine_smp_parse(MachineState *ms, QemuOpts *opts, Error **errp);
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0ccfd750a..7f39ebdfee 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3971,24 +3971,8 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(0);
     }
 
-    machine_class->smp_parse(current_machine,
-        qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
-
-    /* sanity-check smp_cpus and max_cpus against machine_class */
-    if (current_machine->smp.cpus < machine_class->min_cpus) {
-        error_report("Invalid SMP CPUs %d. The min CPUs "
-                     "supported by machine '%s' is %d",
-                     current_machine->smp.cpus,
-                     machine_class->name, machine_class->min_cpus);
-        exit(1);
-    }
-    if (current_machine->smp.max_cpus > machine_class->max_cpus) {
-        error_report("Invalid SMP CPUs %d. The max CPUs "
-                     "supported by machine '%s' is %d",
-                     current_machine->smp.max_cpus,
-                     machine_class->name, machine_class->max_cpus);
-        exit(1);
-    }
+    machine_smp_parse(current_machine,
+        qemu_opts_find(qemu_find_opts("smp-opts"), NULL), &error_fatal);
 
     if (mem_prealloc) {
         char *val;
-- 
2.26.2



