Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7AFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFCA207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geWBiVS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFCA207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0mY-0006mz-E4
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0lq-0005lu-8X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0lo-00048R-HP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598468859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVep2B4rylS0bpaULAVyUSCm0CgEUUj39CpboLrO51k=;
 b=geWBiVS4Z8fmoJEXVUaM40sEBXiDP6enr9VMI8wGdyb8zZPs1uNjKZz9SJowsYGavKyYOr
 Qpwqn/yV9ACrztU7GyI8WoWI2pLgBHPRWhxcHZj2pvSqz4YlcvDsIM/j6hJf5CLdI5r+ed
 vEZfvxkwQfvwRiPQkF9udCICH6kQjtk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-4fpiQPntNPCmbMuYcARwUg-1; Wed, 26 Aug 2020 15:07:38 -0400
X-MC-Unique: 4fpiQPntNPCmbMuYcARwUg-1
Received: by mail-qk1-f198.google.com with SMTP id v16so2496082qka.18
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 12:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fVep2B4rylS0bpaULAVyUSCm0CgEUUj39CpboLrO51k=;
 b=riwefgD0+Po97pSX2QZAvR/jEHkIm9rG0+tyLIiwY5TJPtfXhlbTTa8baOE0qOqpus
 BECh1V5P98+jNZb7RrtOAi2AyWFKknrrD467iq8jxUB6CC1BAjq96rD+Mf/OqIOuuBB9
 OmmUvThZrcwdim7KJm+9FrGl9R6oVAMIzKEGFgbHXIXYYxBKP2itxVM6iABlGCRsHPiM
 uJ9P5+iOQ+GEaXKzatvWQ8LbKjSEoUC0QTQX37+jpx2A6Rh2DCI/Smc1QNMaJ2QKNq4+
 q81Rri8z7cJDJQfdIGLfV6EaLHD//36ZpH9JA0JG1+phvZkZ6uc6TCha/MANTywF02eE
 IL4Q==
X-Gm-Message-State: AOAM532gMIRhCLhsQjCKWFzygUKOs1Pp5D9BGkhaz8oiuGredw1SSChO
 vYawf8jW20VnJu8ML5z7Ciz/8YZR0yQhCKuQh9O+CrxS/gK33sRL0FweCkXHf95155SkOD/16zC
 XejlkiXr7dSOo/oU=
X-Received: by 2002:ac8:1084:: with SMTP id a4mr14612377qtj.83.1598468857706; 
 Wed, 26 Aug 2020 12:07:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbtnHxoGSfcMZAVv7fv0lcuMNBfecaNShlXNMgjz/Ckru2Tt4MhmjttcwCvlM5BTy/2lSDFQ==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr14612350qtj.83.1598468857391; 
 Wed, 26 Aug 2020 12:07:37 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 l5sm2376635qkk.134.2020.08.26.12.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 12:07:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] sev/i386: Add initial support for SEV-ES
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <cover.1598382343.git.thomas.lendacky@amd.com>
 <88dc46aaedd17a3509d7546a622a9754dad895cb.1598382343.git.thomas.lendacky@amd.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <9cd2e58f-dfa2-e2ae-4886-dc194318c411@redhat.com>
Date: Wed, 26 Aug 2020 14:07:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88dc46aaedd17a3509d7546a622a9754dad895cb.1598382343.git.thomas.lendacky@amd.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:05 PM, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Provide initial support for SEV-ES. This includes creating a function to
> indicate the guest is an SEV-ES guest (which will return false until all
> support is in place), performing the proper SEV initialization and
> ensuring that the guest CPU state is measured as part of the launch.
> 
> Co-developed-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Hi Tom!

Overall I think the patch set looks good. I mainly just have 1 question 
regarding some error handling and a couple of checkpatch related messages.

> ---
>   target/i386/cpu.c      |  1 +
>   target/i386/sev-stub.c |  5 +++++
>   target/i386/sev.c      | 46 ++++++++++++++++++++++++++++++++++++++++--
>   target/i386/sev_i386.h |  1 +
>   4 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..bbbe581d35 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5969,6 +5969,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x8000001F:
>           *eax = sev_enabled() ? 0x2 : 0;
> +        *eax |= sev_es_enabled() ? 0x8 : 0;
>           *ebx = sev_get_cbit_position();
>           *ebx |= sev_get_reduced_phys_bits() << 6;
>           *ecx = 0;
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 88e3f39a1e..040ac90563 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
>       error_setg(errp, "SEV is not available in this QEMU");
>       return NULL;
>   }
> +
> +bool sev_es_enabled(void)

I don't think this bothers checkpatch, but it'd be consistent with the 
rest of your series if this function put the return type on the line above.

> +{
> +    return false;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c3ecf86704..6c9cd0854b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -359,6 +359,12 @@ sev_enabled(void)
>       return !!sev_guest;
>   }
>   
> +bool
> +sev_es_enabled(void)
> +{
> +    return false;
> +}
> +
>   uint64_t
>   sev_get_me_mask(void)
>   {
> @@ -578,6 +584,22 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
>       return ret;
>   }
>   
> +static int
> +sev_launch_update_vmsa(SevGuestState *sev)
> +{
> +    int ret, fw_error;
> +
> +    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
> +    if (ret) {
> +        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +err:
> +    return ret;
> +}
> +
>   static void
>   sev_launch_get_measure(Notifier *notifier, void *unused)
>   {
> @@ -590,6 +612,14 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
>           return;
>       }
>   
> +    if (sev_es_enabled()) {
> +        /* measure all the VM save areas before getting launch_measure */
> +        ret = sev_launch_update_vmsa(sev);
> +        if (ret) {
> +            exit(1);

Disclaimer: I'm still learning the QEMU source code, sorry if this comes 
across as naive.

Is exit() what we want here? I was looking around the rest of the source 
code and unfortunately the machine_init_done_notifiers mechanism doesn't 
allow for a return value to indicate an error, so I'm wondering if 
there's a more appropriate place in the initialization code to handle 
these fallible operations and if so, propagate the error down. This way 
if there are other resources that need to be cleaned up on the way out, 
they can be. Thoughts?

> +        }
> +    }
> +
>       measurement = g_new0(struct kvm_sev_launch_measure, 1);
>   
>       /* query the measurement blob length */
> @@ -684,7 +714,7 @@ sev_guest_init(const char *id)
>   {
>       SevGuestState *sev;
>       char *devname;
> -    int ret, fw_error;
> +    int ret, fw_error, cmd;
>       uint32_t ebx;
>       uint32_t host_cbitpos;
>       struct sev_user_data_status status = {};
> @@ -745,8 +775,20 @@ sev_guest_init(const char *id)
>       sev->api_major = status.api_major;
>       sev->api_minor = status.api_minor;
>   
> +    if (sev_es_enabled()) {
> +        if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> +            error_report("%s: guest policy requires SEV-ES, but "
> +                         "host SEV-ES support unavailable",
> +                         __func__);
> +            goto err;
> +        }
> +        cmd = KVM_SEV_ES_INIT;
> +    } else {
> +        cmd = KVM_SEV_INIT;
> +    }
> +
>       trace_kvm_sev_init();
> -    ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
> +    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
>       if (ret) {
>           error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
>                        __func__, ret, fw_error, fw_error_to_str(fw_error));
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 4db6960f60..4f9a5e9b21 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -29,6 +29,7 @@
>   #define SEV_POLICY_SEV          0x20
>   
>   extern bool sev_enabled(void);
> +extern bool sev_es_enabled(void);
>   extern uint64_t sev_get_me_mask(void);
>   extern SevInfo *sev_get_info(void);
>   extern uint32_t sev_get_cbit_position(void);
> 


