Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B9C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 23:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 23:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBkCXseu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1fBZ-0000DN-Jm
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 18:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j1fAu-0008Dw-6O
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 18:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j1fAs-0000m5-Q8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 18:42:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j1fAs-0000ku-Kf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 18:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581464556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVtmc0YZxZzG3t8TIjPyTYNp9XXYYmd/sCqa8wCWB1k=;
 b=gBkCXseuEm/eLTXWnDETPZN5eLDL15oOV1xQ4heSbniPehn7kuaKqBrAxgP7qLmpBLyAl+
 CW1Qy1Ms3ty634khYr3ALz4sYuO/R4mE6FaJ+o207hxLSFkCtYTgIw5XJEGZqYVE4VV14U
 D9bKkskhyn7phAPu6WJ4NGoUC1XNIJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-tj-TeCS9MuyE87uwlsWTjQ-1; Tue, 11 Feb 2020 18:42:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2849F10054E3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:42:34 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D824E8ED02;
 Tue, 11 Feb 2020 23:42:33 +0000 (UTC)
Date: Tue, 11 Feb 2020 16:42:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: check for availability of
 MSR_IA32_UCODE_REV as an emulated MSR
Message-ID: <20200211164232.30c840a9@w520.home>
In-Reply-To: <20200211175516.10716-1-pbonzini@redhat.com>
References: <20200211175516.10716-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tj-TeCS9MuyE87uwlsWTjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 18:55:16 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Even though MSR_IA32_UCODE_REV has been available long before Linux 5.6,
> which added it to the emulated MSR list, a bug caused the microcode
> version to revert to 0x100000000 on INIT.  As a result, processors other
> than the bootstrap processor would not see the host microcode revision;
> some Windows version complain loudly about this and crash with a
> fairly explicit MICROCODE REVISION MISMATCH error.
> 
> [If running 5.6 prereleases, the kernel fix "KVM: x86: do not reset
>  microcode version on INIT or RESET" should also be applied.]
> 
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/kvm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)


Fixed!  Thanks,

Alex


> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6ef291d580..69eb43d796 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -105,6 +105,7 @@ static bool has_msr_smi_count;
>  static bool has_msr_arch_capabs;
>  static bool has_msr_core_capabs;
>  static bool has_msr_vmx_vmfunc;
> +static bool has_msr_ucode_rev;
>  
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -2056,6 +2057,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>              case MSR_IA32_VMX_VMFUNC:
>                  has_msr_vmx_vmfunc = true;
>                  break;
> +            case MSR_IA32_UCODE_REV:
> +                has_msr_ucode_rev = true;
> +                break;
>              }
>          }
>      }
> @@ -2696,8 +2700,7 @@ static void kvm_init_msrs(X86CPU *cpu)
>                            env->features[FEAT_CORE_CAPABILITY]);
>      }
>  
> -    if (kvm_arch_get_supported_msr_feature(kvm_state,
> -                                           MSR_IA32_UCODE_REV)) {
> +    if (has_msr_ucode_rev) {
>          kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
>      }
>  


