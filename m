Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB821239CF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB821239CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scieneer.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcyN-0002ho-9a
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtc-ubuntu@scieneer.com>)
 id 1kKcws-0002Gy-0P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:42:50 -0400
Received: from gw1.scieneer.com ([2001:470:5:c1c::1]:37996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtc-ubuntu@scieneer.com>)
 id 1kKcwo-0001Gl-FE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:42:49 -0400
Received: from dtc-pc.scieneer.com (dtc-pc.scieneer.com [192.168.2.100])
 by gw1.scieneer.com (8.14.7/8.14.7) with ESMTP id 08M7gfah011025
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 22 Sep 2020 17:42:44 +1000
To: qemu-devel@nongnu.org
From: Douglas Crosher <dtc-ubuntu@scieneer.com>
Subject: [PATCH] cpu_exec_step_atomic: update the cpu running flag
Message-ID: <a272c656-f7c5-019d-1cc0-499b8f80f2fc@scieneer.com>
Date: Tue, 22 Sep 2020 17:42:41 +1000
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
Cc: pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The cpu_exec_step_atomic() function is called with the cpu->running
clear and proceeds to run target code without setting this flag. If
this target code generates an exception then handle_cpu_signal() will
unnecessarily abort.

For example if atomic code generates a memory protection fault.

This patch at least sets and clears this running flag.

The related code paths look rather convoluted and it is not immediately 
clear that this patch comprehensively addresses the issue, but it might 
at least direct people to a problem, and it might be an incremental 
improvement, and it gets some code running here. The patch adds some 
assertions to help detect other cases.

Signed-off-by: Douglas Crosher <dtc-ubuntu@scieneer.com>
---
  accel/tcg/cpu-exec.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 66d38f9d85..c1cf1a01cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -241,6 +241,9 @@ void cpu_exec_step_atomic(CPUState *cpu)

      if (sigsetjmp(cpu->jmp_env, 0) == 0) {
          start_exclusive();
+        g_assert(cpu == current_cpu);
+        g_assert(!cpu->running);
+        cpu->running = true;

          tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
          if (tb == NULL) {
@@ -279,6 +282,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
       */
      g_assert(cpu_in_exclusive_context(cpu));
      parallel_cpus = true;
+    cpu->running = false;
      end_exclusive();
  }

-- 
2.25.4


