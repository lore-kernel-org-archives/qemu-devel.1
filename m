Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783223B22
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="sBLoaXWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783223B22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jps10-00015Q-BV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jps0L-0000ZY-Le
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:31:18 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:41344 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jps0J-0003eD-4y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:31:17 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 8E9B84C88A;
 Mon, 29 Jun 2020 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593430270;
 x=1595244671; bh=Y841P+4iE0Ivxo+4cUIj8j0QhlKebf3lGagFi1INxJI=; b=
 sBLoaXWEn7u0FjKJp7BMvZ4kCEF53LLhrKwNNdXJELkHv6UMgnCtDG8ZtN2eokgC
 EKuDakgO9k1nr240W5EcYISecxFs3QOO1Z9VF0P/dBTxCvyVEkKuAfw0VtpqO4to
 VXBbbpqHhwJqUVoI8tUiaitggMGhqgRMJ/cSFxMK/Zg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1cFOb_w9plY; Mon, 29 Jun 2020 14:31:10 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 997804C83C;
 Mon, 29 Jun 2020 14:31:08 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 29
 Jun 2020 14:31:08 +0300
Date: Mon, 29 Jun 2020 14:31:07 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
Message-ID: <20200629113107.GL25104@SPB-NB-133.local>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:31:11
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

On Thu, Jun 25, 2020 at 08:34:14PM +0200, Paolo Bonzini wrote:
> On 25/06/20 17:57, Roman Bolshakov wrote:
> > So, the kick is not delivered to self and in case if destination cpu is
> > not running. I think it can't interrupt subsequent hv_vcpu_run.
> 
> Yes.
> 
> >> If not, you can reduce a bit the race window by setting a variable in
> >> cpu, like
> >>
> >> 	atomic_set(&cpu->deadline, 0);
> >> 	hv_vcpu_interrupt(...)
> >>
> >> and in the vCPU thread
> >>
> >> 	hv_vcpu_run_until(..., atomic_read(&cpu->deadline));
> >> 	atomic_set(&cpu->deadline, HV_DEADLINE_FOREVER);
> >>
> > 
> > Sure, could you please explain who'll be racing? There's a race if a
> > kick was sent after VMEXIT, right? So essentially we need a way to
> > "requeue" a kick that was received outside of hv_vcpu_run to avoid loss
> > of it?
> 
> Yes.  Note that this is not a new bug, it's pre-existing and it's common
> to all hypervisors except KVM/WHPX.  I mean not the QEMU code, it's the
> kernel APIs that are broken. :)
> 
> One way to do so is to keep the signal, and have the signal handler
> enable the preemption timer (with a deadline of 0) in the pin-based
> interrupt controls.  Hopefully macOS allows that, especially on 10.15+
> where hv_vcpu_run_until probably uses the preemption timer.
> 
> > hv_vcpu_run_until is only available on macOS 10.15+ and we can't use yet
> > because of three release support rule.
> > (https://developer.apple.com/documentation/hypervisor/3181548-hv_vcpu_run_until?language=objc)
> > 
> > BTW, I'm totally okay to send v2 if kicks are lost and/or the patch
> > needs improvements. (and I can address EFER to VMCS Entry Controls
> > synchronization as well)
> > 
> > Paolo, do you know any particular test in kvm-unit-tests that can
> > exhibit the issue?
> 
> No, it's a race and it's extremely rare, but I point it out because it's
> a kernel issue that Apple might want to fix anyway.  It might also be
> (depending on how the kernel side is written) that the next scheduler
> tick will end up unblocking the vCPU and papering over it.
> 

Hi Paolo,

I implemented what you proposed using VMX-preemption timer in Pin-based
controls and regular hv_vcpu_run(). It works fine without noticable
regressions, I'll send that in v2.

hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrades
VM performance significantly compared to explicit setting of
VMX-preepmtion timer value and hv_vcpu_run(). The performance issue was
observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook
Pro.

macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
declaration for hv_vcpu_run_until(), that's not available 10.15 -
HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
VMX-preeemption counter). Perhaps the performance issue is addressed
there.

Regards,
Roman

