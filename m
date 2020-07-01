Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58391C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296D620748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="WM43L6eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhbs-00088f-B6
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqhbJ-0007fj-Tb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:36:53 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48930 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqhbI-0005uy-2f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:36:53 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 769524C8B7;
 Wed,  1 Jul 2020 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593628607;
 x=1595443008; bh=PYiUX3s2auMM4mlJr4K5hNQ5a87GAOa9Sf+2kweapxE=; b=
 WM43L6eI4cHwaNKk+JLqIXs5DUrJw/tZ49CQhEW9DxSGU9D04qi6s8YEnc9PzQ0i
 JWZ1OFDvDWfKd2XfPoNmitfZPE2d+9LpBN7kzieGX51FtUqWh/w/CgJCg6N+hOnW
 MdoZZKCkczqdvw8vlMjURnpfiqC+Ka9nQqTSPnXIvUk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTIbFjx-jSND; Wed,  1 Jul 2020 21:36:47 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 12E034C8B2;
 Wed,  1 Jul 2020 21:36:46 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 1 Jul
 2020 21:36:46 +0300
Date: Wed, 1 Jul 2020 21:36:45 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/9] i386: hvf: Implement CPU kick
Message-ID: <20200701183645.GC78555@SPB-NB-133.local>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-5-r.bolshakov@yadro.com>
 <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
 <20200630155059.GA78555@SPB-NB-133.local>
 <2ba7aa12-9eba-1cef-93e0-5561f50629b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ba7aa12-9eba-1cef-93e0-5561f50629b9@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:36:48
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 06:04:23PM +0200, Paolo Bonzini wrote:
> On 30/06/20 17:50, Roman Bolshakov wrote:
> > On Tue, Jun 30, 2020 at 02:33:42PM +0200, Paolo Bonzini wrote:
> >> Can a signal interrupt hv_vcpu_run?  If so you actually don't need
> >> hv_vcpu_interrupt at all.
> > 
> > Existing signal masking and SIG_IPI didn't work IIRC when I tried to add
> > a primitive version of gdbstub support.
> 
> You can try pthread_kill followed by hv_vcpu_interrupt if it doesn't.
> The signal would be delivered after return to userspace.
> 

I looked at the signal setup for HVF again. I was wrong with regards to
SIG_IPI. It isn't delivered to vCPU because the signal is masked, this
fixes it:

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d81f569aed..7bf05bca21 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -479,6 +479,7 @@ int hvf_init_vcpu(CPUState *cpu)

     pthread_sigmask(SIG_BLOCK, NULL, &set);
     sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);

     init_emu();
     init_decoder();

But the signal is delivered only after vmxexit, perhaps a sequence of
pthread_kill() and hv_vcpu_interrupt() is really needed.

So, there are two race windows on kernel-to-user border in v2: just
before checking the deadline and vmenter and just after vmxexit and
re-arm of preemption timer, that's two places where kicks could be lost.
The approach you proposed seems to address them.

Thanks,
Roman

> >> You can also require the preemption time, all
> >> processor that support HVF have it, but never set it by default.  The
> >> deadline can be left at 0 all the time; instead, you toggle the bit in
> >> the pin-based controls.  In the signal handler you do:
> >>
> >> 	if (atomic_xchg(&env->hvf_in_guest, false)) {
> >> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> >> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> >> 			| VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> >> 	}
> >>
> >> In the main loop you do:
> >>
> >> 	atomic_set(&env->hvf_guest_mode, true);
> >> 	smp_mb();
> >> 	hv_vcpu_run(...);
> >> 	atomic_set(&env->hvf_guest_mode, false);
> >>
> >> and in the preemption timer vmexit handler:
> >> 	
> >> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> >> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> >> 			& ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> >>
> > 

