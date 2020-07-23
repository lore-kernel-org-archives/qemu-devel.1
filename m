Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA4BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A262064B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A262064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycOA-0007VM-2i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jycNb-000756-R6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:39:27 -0400
Received: from thoth.sbs.de ([192.35.17.2]:36949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jycNZ-0000Rr-LJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:39:27 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06NEdMfN031748
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 16:39:22 +0200
Received: from [139.25.68.37] ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06NEdLRW023597;
 Thu, 23 Jul 2020 16:39:21 +0200
Subject: Re: [PATCH] KVM: fix CPU reset wrt HF2_GIF_MASK
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200723142701.2521161-1-vkuznets@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b5a9074-decd-bec1-b60f-db103660d8bd@siemens.com>
Date: Thu, 23 Jul 2020 16:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723142701.2521161-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.35.17.2; envelope-from=jan.kiszka@siemens.com;
 helo=thoth.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 10:39:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.07.20 16:27, Vitaly Kuznetsov wrote:
> HF2_GIF_MASK is set in env->hflags2 unconditionally on CPU reset
> (see x86_cpu_reset()) but when calling KVM_SET_NESTED_STATE,
> KVM_STATE_NESTED_GIF_SET is only valid for nSVM as e.g. nVMX code
> looks like
> 
> if (kvm_state->hdr.vmx.vmxon_pa == -1ull) {
>      if (kvm_state->flags & ~KVM_STATE_NESTED_EVMCS)
>          return -EINVAL;
> }
> 
> Also, when adjusting the environment after KVM_GET_NESTED_STATE we
> need not reset HF2_GIF_MASK on VMX as e.g. x86_cpu_pending_interrupt()
> expects it to be set.
> 
> Alternatively, we could've made env->hflags2 SVM-only.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: b16c0e20c742 ("KVM: add support for AMD nested live migration")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   target/i386/kvm.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 2b6b7443d273..3c4647fbfbf6 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3883,7 +3883,9 @@ static int kvm_put_nested_state(X86CPU *cpu)
>       } else {
>           env->nested_state->flags &= ~KVM_STATE_NESTED_GUEST_MODE;
>       }
> -    if (env->hflags2 & HF2_GIF_MASK) {
> +
> +    /* Don't set KVM_STATE_NESTED_GIF_SET on VMX as it is illegal */
> +    if (cpu_has_svm(env) && (env->hflags2 & HF2_GIF_MASK)) {
>           env->nested_state->flags |= KVM_STATE_NESTED_GIF_SET;
>       } else {
>           env->nested_state->flags &= ~KVM_STATE_NESTED_GIF_SET;
> @@ -3925,10 +3927,14 @@ static int kvm_get_nested_state(X86CPU *cpu)
>       } else {
>           env->hflags &= ~HF_GUEST_MASK;
>       }
> -    if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
> -        env->hflags2 |= HF2_GIF_MASK;
> -    } else {
> -        env->hflags2 &= ~HF2_GIF_MASK;
> +
> +    /* Keep HF2_GIF_MASK set on !SVM as x86_cpu_pending_interrupt() needs it */
> +    if (cpu_has_svm(env)) {
> +        if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
> +            env->hflags2 |= HF2_GIF_MASK;
> +        } else {
> +            env->hflags2 &= ~HF2_GIF_MASK;
> +        }
>       }
>   
>       return ret;
> 

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

