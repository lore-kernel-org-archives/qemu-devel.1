Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56803C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E342133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E342133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTt9N-0003AH-FW
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 15:13:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTt81-0002Jy-Fl
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTsuX-0000dk-5e
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hTsuW-0000cu-VD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:57:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFF7DC0885FD;
	Thu, 23 May 2019 18:57:44 +0000 (UTC)
Received: from work-vm (ovpn-117-235.ams2.redhat.com [10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1501600C1;
	Thu, 23 May 2019 18:57:40 +0000 (UTC)
Date: Thu, 23 May 2019 19:57:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Bernhard M. Wiedemann" <bwiedemann@suse.de>, ehabkost@redhat.com,
	bsd@redhat.com
Message-ID: <20190523185737.GB2994@work-vm>
References: <20190516125807.17025-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516125807.17025-1-bwiedemann@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 23 May 2019 18:57:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Fix nested SVM on older Opterons
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bernhard M. Wiedemann (bwiedemann@suse.de) wrote:
> Without this patch, a VM on a Opteron G3 host will have the svm flag, but
> the kvm-amd module fails to load in there, complaining that it needs
> cpuid 0x8000000a
> 
> I have successfully built and tested this for 3+ years in production
> on Opteron G3 servers.
> 
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> ---
>  target/i386/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 722c5514d4..df1d81ded8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2723,7 +2723,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT_SSE3,
>          .features[FEAT_8000_0001_EDX] =
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> -        .xlevel = 0x80000008,
> +        .xlevel = 0x8000000A,
>          .model_id = "AMD Opteron 240 (Gen 1 Class Opteron)",
>      },
>      {
> @@ -2745,7 +2745,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>          .features[FEAT_8000_0001_ECX] =
>              CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> -        .xlevel = 0x80000008,
> +        .xlevel = 0x8000000A,
>          .model_id = "AMD Opteron 22xx (Gen 2 Class Opteron)",
>      },
>      {
> @@ -2770,7 +2770,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .features[FEAT_8000_0001_ECX] =
>              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
>              CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> -        .xlevel = 0x80000008,
> +        .xlevel = 0x8000000A,
>          .model_id = "AMD Opteron 23xx (Gen 3 Class Opteron)",
>      },
>      {

cc'ing in Bandan and Eduardo,

I suspect these need to have compatibility entries on the machine types
so that old machine types don't notice the improvement.

Dave

> -- 
> 2.16.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

