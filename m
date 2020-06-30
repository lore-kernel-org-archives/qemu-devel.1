Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1270C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5A82073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="P6ps+ZCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5A82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDMX-00034T-UQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDFk-0002de-Sn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:12:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56202 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDFi-0006ET-Kx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:12:36 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id F28384C886;
 Tue, 30 Jun 2020 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593511950;
 x=1595326351; bh=nRfdTHkrrXY0LAEfhvcDRbsLe7NaPi6CbgUnnvy64D0=; b=
 P6ps+ZCxghTuI6MHdPlnDa49Hl46Q+qKcKdRhG0k5Xly48CUVd/fzYiDERmOE447
 bZFbfDUQJyP+Z73+y7aqgLdKbFGNRLqho+yXTvFpGjIN226N0bGd2VSjw8BJPkhp
 3EwM19zNgquMsq14wc0vMQgpWCSmfZ31uK621/dNbHM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNIQIYe2jm2C; Tue, 30 Jun 2020 13:12:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id C904A412C5;
 Tue, 30 Jun 2020 13:12:29 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:12:29 +0300
Date: Tue, 30 Jun 2020 13:12:28 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
Message-ID: <20200630101228.GA39334@SPB-NB-133.local>
References: <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
 <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
 <20200629132911.GN25104@SPB-NB-133.local>
 <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
 <20200629140433.GO25104@SPB-NB-133.local>
 <cb4a42b2-5bb7-5f69-64d1-cad6f4bb05df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb4a42b2-5bb7-5f69-64d1-cad6f4bb05df@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:12:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 04:18:46PM +0200, Paolo Bonzini wrote:
> On 29/06/20 16:04, Roman Bolshakov wrote:
> > My approach is based
> > hv_vcpu_run() and should hopefully work almost anywhere where
> > Hypervisor.framework is available because Hypervisor framework exposes
> > timer value
> > (https://developer.apple.com/documentation/hypervisor/vmcs_guest_vmx_timer_value)
> > since macOS 10.10.3+.
> 
> There are a few other constants for which it would be unwise to write
> from userspace, so that's not a big consolation. :)
> 

Hi Paolo,

So, I've tried Big Sur Beta and it has exactly the same performance
issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it
worked on 10.15.5. I've submitted FB7827341 to Apple wrt the issue.

> > I can also test how hv_vcpu_run_until() performs with HV_DEADLINE_FOREVER
> > on the Beta. And if the performance issues with VMX-preemption timer and
> > hv_vcpu_run_until() are fixed there.
> 
> Thanks!  The main thing to test on Big Sur would be: 1) whether the
> preemption timer bit in the pin controls "sticks" to 0 after setting it

It does not. If it's set, it stays there.

> 2) whether the bit reads back as zero after
> hv_vcpu_run_until(HV_DEADLINE_FOREVER).
> 

Likewise, it's not cleared if set.

As far as I understand, hv_vcpu_run_until(HV_DEADLINE_FOREVER) works
like hv_vcpu_run() without VMX-preemption timer. Otherwise
hv_vcpu_run_until() implicitly sets VMX-preemption timer Pin-based
control and sets the timer value.

Thanks,
Roman

Here's the patch over v2 that adds support of hv_vcpu_run_until() on Big Sur:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 317304aa1d..ad202f7358 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -72,8 +72,12 @@
 #include "sysemu/accel.h"
 #include "target/i386/cpu.h"
 
+#if defined(__MAC_10_16) && __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_16
+#define HVF_MAX_DEADLINE HV_DEADLINE_FOREVER
+#else
 /* Maximum value of VMX-preemption timer */
 #define HVF_MAX_DEADLINE UINT32_MAX
+#endif
 
 HVFState *hvf_state;
 
@@ -693,6 +697,7 @@ int hvf_vcpu_exec(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     int ret = 0;
     uint64_t rip = 0;
+    hv_return_t r;
 
     if (hvf_process_events(cpu)) {
         return EXCP_HLT;
@@ -718,10 +723,22 @@ int hvf_vcpu_exec(CPUState *cpu)
         /* Use VMX-preemption timer trick only if available */
         if (rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS) &
             VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER) {
+#if defined(__MAC_10_16) && __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_16
+            r = hv_vcpu_run_until(cpu->hvf_fd,
+                                  atomic_read(&env->hvf_deadline));
+        } else {
+            /*
+             * Equivalent to behaviour of hv_vcpu_run() with VMX-preemption
+             * timer disabled, prone to kick loss.
+             */
+            r = hv_vcpu_run_until(cpu->hvf_fd, HVF_MAX_DEADLINE);
+        }
+#else
             wvmcs(cpu->hvf_fd, VMCS_PREEMPTION_TIMER_VALUE,
                   atomic_read(&env->hvf_deadline));
         }
-        hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
+        r = hv_vcpu_run(cpu->hvf_fd);
+#endif
         atomic_set(&env->hvf_deadline, HVF_MAX_DEADLINE);
         assert_hvf_ok(r);
 


