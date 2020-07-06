Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63890C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB25206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKuVdECE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB25206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUeM-0004wd-B9
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCa-0004Cc-0A
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCX-0003Cz-93
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZYIuYhb+zYChQRuWbnOvJoxrja7P5iRG2waMsb5gLE=;
 b=ZKuVdECESUOsUkV4LuPbwvDaRw8CNXOFXIT3mao3/KoGqgo+AsDthHBvVYhrLpFC7AgKEJ
 fJnhEB3OseZs3HGQlOAiZ/lncaDyCBriO7IwAyF78HL9YJKrnERbctae5n8i/oR0hOhP8m
 cY6oBKkljMnUEAnD8DzeHx9VXjSZUKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-sbWzbLK2PIiDU71WEHtHPQ-1; Mon, 06 Jul 2020 12:42:28 -0400
X-MC-Unique: sbWzbLK2PIiDU71WEHtHPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC2A81937FC4;
 Mon,  6 Jul 2020 16:42:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3577F5F7D8;
 Mon,  6 Jul 2020 16:42:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/53] cpus: Move CPU code from exec.c to cpus-common.c
Date: Mon,  6 Jul 2020 12:41:41 -0400
Message-Id: <20200706164155.24696-40-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This code was introduced with SMP support in commit 6a00d60127,
later commit 267f685b8b moved CPU list management to common code
but forgot this code. Move now and simplify ifdef'ry.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200702104017.14057-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus-common.c | 18 ++++++++++++++++++
 exec.c        | 22 ----------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 8f5512b3d7..34044f4e4c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -72,6 +72,8 @@ static int cpu_get_free_index(void)
     return max_cpu_index;
 }
 
+CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+
 void cpu_list_add(CPUState *cpu)
 {
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
@@ -96,6 +98,22 @@ void cpu_list_remove(CPUState *cpu)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
 }
 
+CPUState *qemu_get_cpu(int index)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->cpu_index == index) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+/* current CPU in the current thread. It is only valid inside cpu_exec() */
+__thread CPUState *current_cpu;
+
 struct qemu_work_item {
     QSIMPLEQ_ENTRY(qemu_work_item) node;
     run_on_cpu_func func;
diff --git a/exec.c b/exec.c
index 21926dc9c7..997b7db15f 100644
--- a/exec.c
+++ b/exec.c
@@ -98,12 +98,6 @@ AddressSpace address_space_memory;
 static MemoryRegion io_mem_unassigned;
 #endif
 
-CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
-
-/* current CPU in the current thread. It is only valid inside
-   cpu_exec() */
-__thread CPUState *current_cpu;
-
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
@@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
     }
 };
 
-#endif
-
-CPUState *qemu_get_cpu(int index)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->cpu_index == index) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
-#if !defined(CONFIG_USER_ONLY)
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
-- 
2.26.2



