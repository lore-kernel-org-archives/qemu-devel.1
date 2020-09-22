Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778CC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAA92395B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAA92395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scieneer.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcs1-00088u-5x
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtc-ubuntu@scieneer.com>)
 id 1kKcrB-0007h0-WE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:36:58 -0400
Received: from gw1.scieneer.com ([2001:470:5:c1c::1]:37992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtc-ubuntu@scieneer.com>)
 id 1kKcr9-0000Xn-Dw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:36:57 -0400
Received: from dtc-pc.scieneer.com (dtc-pc.scieneer.com [192.168.2.100])
 by gw1.scieneer.com (8.14.7/8.14.7) with ESMTP id 08M7alW6010978
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 22 Sep 2020 17:36:50 +1000
To: qemu-devel@nongnu.org
From: Douglas Crosher <dtc-ubuntu@scieneer.com>
Subject: [PATCH] linux user i386 fork: clone the GDT for each thread to,
 separate TLS
Message-ID: <74c9f1d9-4497-31c2-34a7-e21bef7932bd@scieneer.com>
Date: Tue, 22 Sep 2020 17:36:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:470:5:c1c::1;
 envelope-from=dtc-ubuntu@scieneer.com; helo=gw1.scieneer.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel i386 maintains three GDT entries for TLS, and these
are the same three indexes for all threads. The kernel swaps the GDT
entries at these indexes before running each thread so each thread can
have separate TLS.

Current qemu linux user i386 implements a single GDT per process so
shared by all threads. While it does cache the GDT entries per thread
this cache can need to be reloaded from the GDT entry. Other threads
are likely to have overwritten the GDT entry and so the thread TLS
can become inconsistent.

For example, the segment registers are reloaded on a signal return
path, so threaded coding returning from signals breaks.

This patch clones the GDT for each thread, to separate the TLS
entries. It mmaps space from the target for this, just as the initial
GDT is currently allocated. This memory is unmapped on thread exit.

The Linux x86_64 kernel offers a different strategy for TLS, so this
patch is limited to Linux user i386.

If there were some code relying on a global GDT then this patch might 
break that and a correct fix might be more involved and might need to 
add separate per-thread GDT state for just the TLS entries and for just 
Linux user. Would anyone be aware of such uses?

Signed-off-by: Douglas Crosher <dtc-ubuntu@scieneer.com>
---
  linux-user/syscall.c | 15 +++++++++++++++
  1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 55ac5c3208..099e4f875a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6424,6 +6424,15 @@ static int do_fork(CPUArchState *env, unsigned 
int flags, abi_ulong newsp,
              ts->child_tidptr = child_tidptr;
          }

+#if defined(TARGET_I386) && defined(TARGET_ABI32)
+        new_env->gdt.base = target_mmap(0, sizeof(uint64_t) * 
TARGET_GDT_ENTRIES,
+                                        PROT_READ|PROT_WRITE,
+                                        MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+        new_env->gdt.limit = sizeof(uint64_t) * TARGET_GDT_ENTRIES - 1;
+        memcpy(g2h(new_env->gdt.base), g2h(env->gdt.base),
+               sizeof(uint64_t) * TARGET_GDT_ENTRIES);
+#endif
+
          if (flags & CLONE_SETTLS) {
              cpu_set_tls (new_env, newtls);
          }
@@ -8193,6 +8202,12 @@ static abi_long do_syscall1(void *cpu_env, int 
num, abi_long arg1,
          if (CPU_NEXT(first_cpu)) {
              TaskState *ts = cpu->opaque;

+#if defined(TARGET_I386) && defined(TARGET_ABI32)
+            CPUX86State *env = cpu_env;
+            target_munmap(env->gdt.base, sizeof(uint64_t) * 
TARGET_GDT_ENTRIES);
+            env->gdt.base = 0;
+#endif
+
              object_property_set_bool(OBJECT(cpu), "realized", false, 
NULL);
              object_unref(OBJECT(cpu));
              /*
-- 
2.25.4


