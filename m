Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3677C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3D520873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3D520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGHn-0008OR-R7
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hdFSg-0003qV-Ar
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hdFSd-0005SF-DW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hdFSc-00053S-By
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:51:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FD983087931;
 Tue, 18 Jun 2019 14:51:22 +0000 (UTC)
Received: from xz-x1 (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E4382F40;
 Tue, 18 Jun 2019 14:51:20 +0000 (UTC)
Date: Tue, 18 Jun 2019 22:51:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Cosmin Marin <cosmin.marin@nutanix.com>
Message-ID: <20190618145116.GA3793@xz-x1>
References: <20190614161106.218854-1-cosmin@nutanix.com>
 <20190617034628.GA12456@xz-x1>
 <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 18 Jun 2019 14:51:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 12:25:43PM +0000, Cosmin Marin wrote:
> 	Hi Peter,
> 
> 	thanks for reviewing the patch. Indeed, I agree that it's almost impossible to determine which solution it's better from the scalability perspective. However, I feel that using per-vCPU timers is the only way for ensuring correctness of the throttling ratio.

The thing is that your patch actually contains two changes:

1. use N timers instead of one.

2. remove throttle_thread_scheduled check, so we do the throttle
   always

Here what I'm worried is that _maybe_ the 2nd item is the one that
really helped.

Note that there is a side effect that we might queue more than one
work on one specific cpu if we queue it too fast, but it does not
block us from trying it out to identify which item (1 or 2 or both)
really helped here.  Then if we think that (queuing too much) is an
issue then we can discuss on how to fix it since current patch will
have this problem as well.

> 
> 	It's a bit unclear to me how the throttling ratio inconsistency can be fixed by using a single timer even avoiding the conditional timer re-arming.  Could you provide more details about the use of a single timer ?
  
It'll be simply a patch only contains the changes for item (2) above.
To be explicit, it is:

-------------------------------------------------------------------
diff --git a/cpus.c b/cpus.c
index dde3b7b981..bb59675b98 100644
--- a/cpus.c
+++ b/cpus.c
@@ -792,7 +792,6 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
     qemu_mutex_unlock_iothread();
     g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
     qemu_mutex_lock_iothread();
-    atomic_set(&cpu->throttle_thread_scheduled, 0);
 }

 static void cpu_throttle_timer_tick(void *opaque)
@@ -805,10 +804,7 @@ static void cpu_throttle_timer_tick(void *opaque)
         return;
     }
     CPU_FOREACH(cpu) {
-        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
-            async_run_on_cpu(cpu, cpu_throttle_thread,
-                             RUN_ON_CPU_NULL);
-        }
+        async_run_on_cpu(cpu, cpu_throttle_thread, RUN_ON_CPU_NULL);
     }

     pct = (double)cpu_throttle_get_percentage()/100;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..0bd34fbb70 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -439,11 +439,6 @@ struct CPUState {
     /* shared by kvm, hax and hvf */
     bool vcpu_dirty;

-    /* Used to keep track of an outstanding cpu throttle thread for migration
-     * autoconverge
-     */
-    bool throttle_thread_scheduled;
-
     bool ignore_memory_transaction_failures;

     struct hax_vcpu_state *hax_vcpu;
-------------------------------------------------------------------

Regards,

-- 
Peter Xu

