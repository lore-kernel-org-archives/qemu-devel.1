Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D057F2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rvaQT5kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D057F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPUP-0004R8-4g
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joPTo-00041G-Ry
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:51:40 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56698 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joPTm-0000tN-Po
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:51:40 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B191D4C8B4;
 Thu, 25 Jun 2020 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593082294;
 x=1594896695; bh=YIHFpX7Wl/PNFlBMRH9m9ishLL0UcTxqOzHrnzEjPK8=; b=
 rvaQT5kgjtiNVafLmH+LjvEXUBMraL+I4PlXwo5+rl+DS+Sx5PK2NDmW1LYF8wx7
 7bz/3vf8S7GZfJ6ZREM0oRi23gREs863i2sUpT4nUacujxamsiIVipbkDe+rSk/A
 7wG8oC9lt73lyXLCwdv28yr4GOyscJ6hqcBeaFvs1kI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8vOuYDqZ1CR; Thu, 25 Jun 2020 13:51:34 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0E90541287;
 Thu, 25 Jun 2020 13:51:34 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 13:51:34 +0300
Date: Thu, 25 Jun 2020 13:51:33 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
Message-ID: <20200625105133.GF25104@SPB-NB-133.local>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <77df3139-501d-d4b9-c651-35de66474d57@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77df3139-501d-d4b9-c651-35de66474d57@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 06:51:35
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
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 09:07:04AM +0200, Claudio Fontana wrote:
> Hi Roman,
> 
> On 6/25/20 12:58 AM, Roman Bolshakov wrote:
> > HVF doesn't have a CPU kick and without it it's not possible to perform
> > an action on CPU thread until a VMEXIT happens. The kick is also needed
> > for timely interrupt delivery.
> > 
> > Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
> > thread, but it's different from what hv_vcpu_interrupt does. The latter
> > one results in invocation of mp_cpus_kick() in XNU kernel [1].
> > 
> > While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
> > compilation warnings.
> > 
> > 1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c
> > 
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  cpus.c                | 13 +++++++++----
> >  include/hw/core/cpu.h |  2 +-
> >  include/sysemu/hvf.h  |  1 +
> >  target/i386/hvf/hvf.c | 11 +++++++++++
> >  4 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/cpus.c b/cpus.c
> > index 26709677d3..36f38ce5c8 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1783,10 +1783,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
> >          return;
> >      }
> >      cpu->thread_kicked = true;
> > -    err = pthread_kill(cpu->thread->thread, SIG_IPI);
> > -    if (err && err != ESRCH) {
> > -        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> > -        exit(1);
> > +
> > +    if (hvf_enabled()) {
> > +        hvf_vcpu_kick(cpu);
> 
> could this be moved to qemu_cpu_kick, where we have already the ifs for accelerator types tcg and hax?
> 

Hi Claudio,

I did this because of cpu->thread_kicked which is not set or tested in
qemu_cpu_kick(). It's not used for tcg and mttcg but hax does seem to
use the qemu_cpu_kick_thread() and additionally sets cpu->exit_request
in qemu_cpu_kick(). There's a difference between hax/kvm and hvf, they
use different ways of siginalling the kick. hax/kvm use POSIX signals
while HVF sends an IPI from the host LAPIC to deliver the kick. The
patch highlights the difference.

As far as I understand if thread_kicked is set, multiple cpu kicks are
coalesced until thread_kicked is cleared. So, the answer to your
question: It could be moved to qemu_cpu_kick but then kick debouncing
should be duplicated inside hvf_vcpu_kick().

Regards,
Roman

> Not terribly important if then my cpus-refactoring goes forward, but on its own that should be the proper place for if (hvf_enabled()) I think.
> 
> 
> 
> > +    } else {
> > +        err = pthread_kill(cpu->thread->thread, SIG_IPI);
> > +        if (err && err != ESRCH) {
> > +            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> > +            exit(1);
> > +        }
> >      }
> >  #else /* _WIN32 */
> >      if (!qemu_cpu_is_self(cpu)) {

