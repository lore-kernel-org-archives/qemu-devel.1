Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B1C2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A96520659
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="A7eXZKND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A96520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLAOJ-00062K-Lr
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 14:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jLAMm-0004kk-70
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jLAMj-0005e6-Qn
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:51:31 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:54358 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jLAMj-0005d8-Ee
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:51:29 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id C69F7412CF;
 Sun,  5 Apr 2020 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1586112685;
 x=1587927086; bh=qV60+A+1jkSEYUd4XFKZW5RdoatXXnE/Rzlpx3dSd/E=; b=
 A7eXZKNDZ7vk+VPz0qgY2rc0ejBS830tEtjPDyWIhTyvDuXzkdz51ldePHQmJ+ov
 0L0v32f9QHjv7+6R4IRQqc/wJPHVz07DvSbeTMLZoiuS8fe8Gq3nHi5+PAx9SkRu
 o3gXSlwpk/uKr5eST+2sxTGxEry4P5Tmt9/dThNsy6M=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVdGf5T8gkTM; Sun,  5 Apr 2020 21:51:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 12CD941287;
 Sun,  5 Apr 2020 21:51:25 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 5 Apr
 2020 21:51:25 +0300
Date: Sun, 5 Apr 2020 21:51:25 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v1 2/3] hvf: Make long mode enter and exit code clearer.
Message-ID: <20200405185125.GD74346@SPB-NB-133.local>
References: <cover.1585607927.git.dirty@apple.com>
 <17777cc82122d29903bad7268b4c33e83b27d9a6.1585607927.git.dirty@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <17777cc82122d29903bad7268b4c33e83b27d9a6.1585607927.git.dirty@apple.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 05:16:05PM -0700, Cameron Esfahani wrote:
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
>  target/i386/hvf/vmx.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 8ec2e6414e..1a1b150c97 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -121,6 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      uint64_t pdpte[4] = {0, 0, 0, 0};
>      uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
>      uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
> +    uint64_t changed_cr0 = old_cr0 ^ cr0;
>      uint64_t mask = CR0_PG_MASK | CR0_CD_MASK | CR0_NW_MASK |
>                      CR0_NE_MASK | CR0_ET_MASK;
>  
> @@ -139,11 +140,12 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
>  
>      if (efer & MSR_EFER_LME) {
> -        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
> -            enter_long_mode(vcpu, cr0, efer);
> -        }
> -        if (!(cr0 & CR0_PG_MASK)) {
> -            exit_long_mode(vcpu, cr0, efer);
> +        if (changed_cr0 & CR0_PG_MASK) {
> +            if (cr0 & CR0_PG_MASK) {
> +                enter_long_mode(vcpu, cr0, efer);
> +            } else {
> +                exit_long_mode(vcpu, cr0, efer);
> +            }
>          }
>      }
>  
> -- 
> 2.24.0
> 

The changes look good but I have a few nitpicks.

The summary line should not have "." at the end, please see
(https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message):
> Whether the "single line summary of change" starts with a capital is a
> matter of taste, but we prefer that the summary does not end in "."

Also, it would be good to mention in the title/commit message that with the
change QEMU is skipping unconditional writes to the guest IA32_EFER.LMA
and VMCS Entry Controls in compatibility mode, instead it does so only
when the actual switch out of long mode happens. (It's worth to mention
any other issues the patch helps to address, if any).

The comment in the previous patch may be dropped here IMO.

Besides that,
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

