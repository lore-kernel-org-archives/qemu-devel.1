Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9604C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBHaRncs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9604C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9Sn-0008Cp-TW
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8sq-0006ka-U6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8sm-0004UT-W0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:44:14 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iL8sm-0004UH-Ro; Thu, 17 Oct 2019 12:44:12 -0400
Received: by mail-qk1-x741.google.com with SMTP id z67so2455780qkb.12;
 Thu, 17 Oct 2019 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=h9q8Pc+WDp35mofry08Rs0+qfTQt4B5s1h/hLQXXb9E=;
 b=SBHaRncs3a0kSYLnMuDQ2muyXiWIgrUCkpK1KCiETHiI75NCpPWyLjXe6vK6HgoSEI
 fxEqyf3n+TpsGpuqPqsLEG3Wce6SbNZj6YTjLT4p5rOr86qbpI+MaYFCY8X2EuwUk2Xa
 1out+lWnpgvjdgyqe/kY7kuS4KOvaITi8XJv9SNkYtOV4KILPBXtMdLdbXj3lsGKy151
 uoRS48TlrhREY3qx19F84KCjJODd9lzfsPWiMgkCD9gNObAYaLZm3Ubve/XDzgc0Kc9W
 3pa3IrTr+0ZXpOEC6ZWgC+rLeW58y8+wq9jP5Q6BAlukaxgBgik2WfSuKPpceVWOOcSm
 ZOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h9q8Pc+WDp35mofry08Rs0+qfTQt4B5s1h/hLQXXb9E=;
 b=tSdsczA/pwD4XbN8fQMb+LaQWICXxPww0BQC+CFSsQc096iEBh46KTnMnZuM10/csd
 23iR6IrTPBGxsnLAR8BEi6iJepeRjMKWfFmsfYUEYzH34EGaKEOxM/8vrgcgxjxFqDBo
 WTGPu5Qt3SzmSbquULOuMyS3cnGRVAvraFf79iw6DWtwypVdZiv1YXn4lKXS4Q/yQVGP
 o9ShwEdwfE50ncV4SiOxvLA8o6ooWKcxsXj6ky5Rkd/KX5TQpbHRGOnxYxPwMerrs21+
 Y4mORL2dg08dqolZjcHIARk0mGWFQsx4DnPn0OorvncNXz6TYJ9Gf6122WYGivWBX8Bo
 Y9qQ==
X-Gm-Message-State: APjAAAUixrwKtuoggw/cH/LggSFUzaWc5Et3FEwGoFYAlm82LmS5c9i7
 ixRWUSQ23kTtouTACk9hCg==
X-Google-Smtp-Source: APXvYqw0Vpegw8MrL+WhVpa1I7mnkNgLDaaOE30Iz//GZDMH3rkNefouS7duIf10J5Dk5RZCSTz1lQ==
X-Received: by 2002:a05:620a:896:: with SMTP id
 b22mr4247013qka.216.1571330651957; 
 Thu, 17 Oct 2019 09:44:11 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id o38sm1871411qtc.39.2019.10.17.09.44.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 09:44:11 -0700 (PDT)
Date: Thu, 17 Oct 2019 12:44:08 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 7/9] target/arm/kvm: scratch vcpu: Preserve input
 kvm_vcpu_init features
Message-ID: <20191017164408.k56d2u3swgkvunyx@gabell>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-8-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016085408.24360-8-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:54:06AM +0200, Andrew Jones wrote:
> kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
> parameter. Rather than just using it as an output parameter to
> pass back the preferred target, use it also as an input parameter,
> allowing a caller to pass a selected target if they wish and to
> also pass cpu features. If the caller doesn't want to select a
> target they can pass -1 for the target which indicates they want
> to use the preferred target and have it passed back like before.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

This patch works well on aarch64 with SVE machine, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

- Masa

> ---
>  target/arm/kvm.c   | 20 +++++++++++++++-----
>  target/arm/kvm32.c |  6 +++++-
>  target/arm/kvm64.c |  6 +++++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index f07332bbda30..5b82cefef608 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -66,7 +66,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>                                        int *fdarray,
>                                        struct kvm_vcpu_init *init)
>  {
> -    int ret, kvmfd = -1, vmfd = -1, cpufd = -1;
> +    int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
>  
>      kvmfd = qemu_open("/dev/kvm", O_RDWR);
>      if (kvmfd < 0) {
> @@ -86,7 +86,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          goto finish;
>      }
>  
> -    ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, init);
> +    if (init->target == -1) {
> +        struct kvm_vcpu_init preferred;
> +
> +        ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
> +        if (!ret) {
> +            init->target = preferred.target;
> +        }
> +    }
>      if (ret >= 0) {
>          ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
>          if (ret < 0) {
> @@ -98,10 +105,12 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>           * creating one kind of guest CPU which is its preferred
>           * CPU type.
>           */
> +        struct kvm_vcpu_init try;
> +
>          while (*cpus_to_try != QEMU_KVM_ARM_TARGET_NONE) {
> -            init->target = *cpus_to_try++;
> -            memset(init->features, 0, sizeof(init->features));
> -            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
> +            try.target = *cpus_to_try++;
> +            memcpy(try.features, init->features, sizeof(init->features));
> +            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
>              if (ret >= 0) {
>                  break;
>              }
> @@ -109,6 +118,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>          if (ret < 0) {
>              goto err;
>          }
> +        init->target = try.target;
>      } else {
>          /* Treat a NULL cpus_to_try argument the same as an empty
>           * list, which means we will fail the call since this must
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 2451a2d4bbef..32bf8d6757c4 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -53,7 +53,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          QEMU_KVM_ARM_TARGET_CORTEX_A15,
>          QEMU_KVM_ARM_TARGET_NONE
>      };
> -    struct kvm_vcpu_init init;
> +    /*
> +     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
> +     * to use the preferred target
> +     */
> +    struct kvm_vcpu_init init = { .target = -1, };
>  
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>          return false;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 850da1b5e6aa..c7ecefbed720 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -502,7 +502,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          KVM_ARM_TARGET_CORTEX_A57,
>          QEMU_KVM_ARM_TARGET_NONE
>      };
> -    struct kvm_vcpu_init init;
> +    /*
> +     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
> +     * to use the preferred target
> +     */
> +    struct kvm_vcpu_init init = { .target = -1, };
>  
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>          return false;
> -- 
> 2.21.0
> 
> 

