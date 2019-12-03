Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D51C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C049206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRQqEZZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C049206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1j5-0000A0-NS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1gt-00078i-Oy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1gr-0006Jt-GM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:29:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1gr-0006IY-2f
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nU9PR0uajs4cxHZnUrTqPXNlB77BVKgH5+uS2meuUc=;
 b=hRQqEZZa05c+jrc3YYc2pFNY7yytBmRuBVzARX5FoAS/Kx43ZkbdC5h3Mroz1xsjsvC7H4
 ZuAFVLTKedpokHORI3IQXz++y76dmQJXgaduUrg7fbcgg4dg6uRtiaR2kVtiJ1gz+RBG3B
 RCY7f6TJNpDJt9pjAWhPqdW9eHCf8/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-5oVwH7opNHWbGATtpsmybg-1; Tue, 03 Dec 2019 01:29:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so1234516wrp.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oIBiYj0qsvyWA7TxxW08MKKQqm6NdBpfbJiKSMYfDAo=;
 b=mhBjJdWbkWAyMEdEqc3saazwvNCN/s9HG2HQmCRvi/jXglEDTPhvCiXpyDtsU5CHye
 aJ57R0tDoMzlSXHAvoHYCsFkpQlVm7fmXzrfYrxJdmOBQbXf2iIPbvwM9aaIZw7/BRw9
 Tm6N+USWqzu+0XFCA4MGOp+qh82/8uyfFhw0eV3Z8kNhBZMK6eqAhV2bx24+4D9rc/2y
 pM3UG9IUVjoISqgLAL8yCGJeTyZUAFW5xiQ8LzrjJgBoe6i6M6YXG0J+X5JkWDnWI6qA
 UU9Q+14VZ0YtEOlulI08wfVaKQAv5OT5u99yHOOJaK5KLchno0kb+sf5ec6P33Iwm2g/
 K8Vg==
X-Gm-Message-State: APjAAAWCHulpPv9eyx4hriXDMzVLo/kdWiXR19U+l8+0wOtzYgP3a6bA
 5l1FJPC1pLCtnAQC8BT03r4JhVPhn1JOgVHpq676hJ4qt/tdO+8JJmAr3SWhgv9MJ7w7Mq/RO+e
 3Izoskh3gl+CU0Q8=
X-Received: by 2002:adf:eb46:: with SMTP id u6mr3232557wrn.239.1575354577522; 
 Mon, 02 Dec 2019 22:29:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbAWCVwgiQOB9mlfLyNbeCPKAaiixSxlK8b5cdjqAkcGbCQim4AovGMNsqOECeOjYUYqFMww==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr3232541wrn.239.1575354577348; 
 Mon, 02 Dec 2019 22:29:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p5sm2161066wrt.79.2019.12.02.22.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:29:36 -0800 (PST)
Subject: Re: [PATCH v4 38/40] target/arm: Pass more cpu state to
 arm_excp_unmasked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70810930-85d3-82a0-8917-39277d84c5c6@redhat.com>
Date: Tue, 3 Dec 2019 07:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-39-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 5oVwH7opNHWbGATtpsmybg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> Avoid redundant computation of cpu state by passing it in
> from the caller, which has already computed it for itself.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/arm/cpu.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a36344d4c7..7a1177b883 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -411,14 +411,13 @@ static void arm_cpu_reset(CPUState *s)
>   }
>  =20
>   static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_id=
x,
> -                                     unsigned int target_el)
> +                                     unsigned int target_el,
> +                                     unsigned int cur_el, bool secure,
> +                                     uint64_t hcr_el2)
>   {
>       CPUARMState *env =3D cs->env_ptr;
> -    unsigned int cur_el =3D arm_current_el(env);
> -    bool secure =3D arm_is_secure(env);
>       bool pstate_unmasked;
>       int8_t unmasked =3D 0;
> -    uint64_t hcr_el2;
>  =20
>       /*
>        * Don't take exceptions if they target a lower EL.
> @@ -429,8 +428,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, un=
signed int excp_idx,
>           return false;
>       }
>  =20
> -    hcr_el2 =3D arm_hcr_el2_eff(env);
> -
>       switch (excp_idx) {
>       case EXCP_FIQ:
>           pstate_unmasked =3D !(env->daif & PSTATE_F);
> @@ -535,6 +532,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>       CPUARMState *env =3D cs->env_ptr;
>       uint32_t cur_el =3D arm_current_el(env);
>       bool secure =3D arm_is_secure(env);
> +    uint64_t hcr_el2 =3D arm_hcr_el2_eff(env);
>       uint32_t target_el;
>       uint32_t excp_idx;
>       bool ret =3D false;
> @@ -542,7 +540,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>       if (interrupt_request & CPU_INTERRUPT_FIQ) {
>           excp_idx =3D EXCP_FIQ;
>           target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, sec=
ure);
> -        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
>               cs->exception_index =3D excp_idx;
>               env->exception.target_el =3D target_el;
>               cc->do_interrupt(cs);
> @@ -552,7 +551,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>       if (interrupt_request & CPU_INTERRUPT_HARD) {
>           excp_idx =3D EXCP_IRQ;
>           target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, sec=
ure);
> -        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
>               cs->exception_index =3D excp_idx;
>               env->exception.target_el =3D target_el;
>               cc->do_interrupt(cs);
> @@ -562,7 +562,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>       if (interrupt_request & CPU_INTERRUPT_VIRQ) {
>           excp_idx =3D EXCP_VIRQ;
>           target_el =3D 1;
> -        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
>               cs->exception_index =3D excp_idx;
>               env->exception.target_el =3D target_el;
>               cc->do_interrupt(cs);
> @@ -572,7 +573,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>       if (interrupt_request & CPU_INTERRUPT_VFIQ) {
>           excp_idx =3D EXCP_VFIQ;
>           target_el =3D 1;
> -        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
>               cs->exception_index =3D excp_idx;
>               env->exception.target_el =3D target_el;
>               cc->do_interrupt(cs);
>=20


