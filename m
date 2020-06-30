Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08296C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C971D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="cg6n6vsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C971D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIav-0006KH-4W
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqIXL-0001L6-LC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:51:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39092 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqIXJ-0005sE-1E
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:51:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 635F74C887;
 Tue, 30 Jun 2020 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593532260;
 x=1595346661; bh=TpRxcdZXJtBDxf1JRZHvytTHtVHdiqwf+1JKeOj6CpU=; b=
 cg6n6vsMlkw0nD8E86PUZitqCJTycgA2j/jYjy50YPIp2temyPpFLt8vbVPnW1v5
 MbM4jocz2cwe90rTjdocJOzwqx1zbUlKWGq1vgtB2EJjCoObSY1ZTMSVmhxO2015
 jFGltV3jJQyAlpK3gb870D+C4unpTASDv7sozs9z3CM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4IsUWqAXCspf; Tue, 30 Jun 2020 18:51:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 2CBB84B169;
 Tue, 30 Jun 2020 18:51:00 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 18:51:00 +0300
Date: Tue, 30 Jun 2020 18:50:59 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/9] i386: hvf: Implement CPU kick
Message-ID: <20200630155059.GA78555@SPB-NB-133.local>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-5-r.bolshakov@yadro.com>
 <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:51:01
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

On Tue, Jun 30, 2020 at 02:33:42PM +0200, Paolo Bonzini wrote:
> On 30/06/20 12:28, Roman Bolshakov wrote:
> > @@ -966,6 +964,20 @@ int hvf_vcpu_exec(CPUState *cpu)
> >      return ret;
> >  }
> >  
> > +void hvf_vcpu_kick(CPUState *cpu)
> > +{
> > +    X86CPU *x86_cpu = X86_CPU(cpu);
> > +    CPUX86State *env = &x86_cpu->env;
> > +    hv_return_t err;
> > +
> > +    atomic_set(&env->hvf_deadline, 0);
> > +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
> > +    if (err) {
> > +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
> > +        exit(1);
> > +    }
> 
> Can a signal interrupt hv_vcpu_run?  If so you actually don't need
> hv_vcpu_interrupt at all.

Existing signal masking and SIG_IPI didn't work IIRC when I tried to add
a primitive version of gdbstub support.

> You can also require the preemption time, all
> processor that support HVF have it, but never set it by default.  The
> deadline can be left at 0 all the time; instead, you toggle the bit in
> the pin-based controls.  In the signal handler you do:
> 
> 	if (atomic_xchg(&env->hvf_in_guest, false)) {
> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> 			| VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> 	}
> 
> In the main loop you do:
> 
> 	atomic_set(&env->hvf_guest_mode, true);
> 	smp_mb();
> 	hv_vcpu_run(...);
> 	atomic_set(&env->hvf_guest_mode, false);
> 
> and in the preemption timer vmexit handler:
> 	
> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> 			& ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> 

Ok, I'll look into that. Thanks for the advices!

-Roman

