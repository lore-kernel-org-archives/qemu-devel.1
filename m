Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA4C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2BD20708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKqFpQSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2BD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49233 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6JD-00046z-Sl
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6I6-0002zq-KD
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6I5-000642-7L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6I5-00063c-3A
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2c82wNOQ/9q42lcEoai5Hl7gvYRPknDahrR0e3Fg1I=;
 b=bKqFpQSIWxv4m16tCesrMIHV8wRZlT/8cKb99YfZjDL3ADdtdUcHP5JvN1Rihje7Nvrh7O
 k0XVYVZm72qV9fbg6UXpTNqT7kJFp1ubtd/tqbEiKQt626P4Wbt9SO3qD1d/CIDUFq51Em
 jinClpZV3XylK2EKOIChUW4svnEdYsk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-kOnLESSLPSO93vL42Z91lw-1; Fri, 22 Nov 2019 05:35:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id u14so3647038wrq.19
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jJAYpu0MJLhZ1Lzlua9Iqb/kwOKa2AJB8mzoTr90AjM=;
 b=GFG60VG/yGsIrNQgsb0/tslXjU3jByfnVTuGBokeVY58H3i+AJqth3hMfger/da+wU
 xmfNlSb2RNN/dXupXJ5041Z549DMJ/ZOe9um/Pk3ViQhHF/LCsgqsBHbFC5rUqKMFzv0
 QQzznKTpMf2LqkERM9ZU3kfyfcNIAMeO1x+ljgTJjKdTeof3AHJpRM7/Q8TJorxs5mVX
 cYhL3KWsG/+CkxFm8bH7z6JWoNC1Y4OU4n/mSgRL5jRF9V3dnTGD65bGTpWXh99fJITX
 fAu/HBmADojv0Uy8t4sZq75h0tm60ABcwWWm8W8qghpe8A9Ah08SAxipZnh59EocpLpQ
 qGJQ==
X-Gm-Message-State: APjAAAUhIgTviqjRnjUNur/wwmsupnXeeLF7SOQM1zthNMrY6vZFJQg5
 /T6KxAajAxiqbnf4CXdV6oWMJ5gmgRi3v8nvcZ6FMj8PzFVYvoDjPh8ZSQ/m/2773kogrCcwqa/
 dOe/r6e4XPi+k2Oo=
X-Received: by 2002:a05:6000:1286:: with SMTP id
 f6mr13748448wrx.44.1574418948747; 
 Fri, 22 Nov 2019 02:35:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVKX9uYMYThQd4E+0IWi4qDBmkNGLjhxS826Hc6uJbAbB3uuZUpkhJLE/GdoiTErICIKSweQ==
X-Received: by 2002:a05:6000:1286:: with SMTP id
 f6mr13748427wrx.44.1574418948517; 
 Fri, 22 Nov 2019 02:35:48 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id c1sm5679312wrs.24.2019.11.22.02.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:35:48 -0800 (PST)
Subject: Re: [PATCH 2/4] s390x: Cleanup cpu resets
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-3-frankja@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a57741a5-81ba-0a62-aaf5-ad903f7d1848@redhat.com>
Date: Fri, 22 Nov 2019 11:35:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122075218.23935-3-frankja@linux.ibm.com>
Content-Language: en-US
X-MC-Unique: kOnLESSLPSO93vL42Z91lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Janosh,

On 11/22/19 8:52 AM, Janosch Frank wrote:
> Let's move the resets into one function and switch by type, so we can
> use fallthroughs for shared reset actions.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   target/s390x/cpu.c | 110 ++++++++++++++++++++-------------------------
>   1 file changed, 48 insertions(+), 62 deletions(-)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd..556afecbc1 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,67 +82,52 @@ static void s390_cpu_load_normal(CPUState *s)
>   }
>   #endif
>  =20
> -/* S390CPUClass::cpu_reset() */
> -static void s390_cpu_reset(CPUState *s)
> +typedef enum cpu_reset_type {
> +    S390_CPU_RESET_NORMAL,
> +    S390_CPU_RESET_INITIAL,
> +    S390_CPU_RESET_CLEAR,
> +} cpu_reset_type;
> +
> +static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>   {
>       S390CPU *cpu =3D S390_CPU(s);
>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>       CPUS390XState *env =3D &cpu->env;
>  =20
> -    env->pfault_token =3D -1UL;
> -    env->bpbc =3D false;
>       scc->parent_reset(s);
>       cpu->env.sigp_order =3D 0;
>       s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
> -}
>  =20
> -/* S390CPUClass::initial_reset() */
> -static void s390_cpu_initial_reset(CPUState *s)
> -{
> -    S390CPU *cpu =3D S390_CPU(s);
> -    CPUS390XState *env =3D &cpu->env;
> +    /* Set initial values after clearing */
> +    switch (type) {
> +    case S390_CPU_RESET_CLEAR:
> +        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_field=
s));
> +        /* Fallthrough */
> +    case S390_CPU_RESET_INITIAL:
> +        memset(&env->start_initial_reset_fields, 0,
> +               offsetof(CPUS390XState, end_reset_fields) -
> +               offsetof(CPUS390XState, start_initial_reset_fields));
> +        /* architectured initial values for CR 0 and 14 */
> +        env->cregs[0] =3D CR0_RESET;
> +        env->cregs[14] =3D CR14_RESET;
>  =20
> -    s390_cpu_reset(s);
> -    /* initial reset does not clear everything! */
> -    memset(&env->start_initial_reset_fields, 0,
> -        offsetof(CPUS390XState, end_reset_fields) -
> -        offsetof(CPUS390XState, start_initial_reset_fields));
> -
> -    /* architectured initial values for CR 0 and 14 */
> -    env->cregs[0] =3D CR0_RESET;
> -    env->cregs[14] =3D CR14_RESET;
> -
> -    /* architectured initial value for Breaking-Event-Address register *=
/
> -    env->gbea =3D 1;
> -
> -    env->pfault_token =3D -1UL;
> -
> -    /* tininess for underflow is detected before rounding */
> -    set_float_detect_tininess(float_tininess_before_rounding,
> -                              &env->fpu_status);
> +        /* architectured initial value for Breaking-Event-Address regist=
er */
> +        env->gbea =3D 1;
> +        /* tininess for underflow is detected before rounding */
> +        set_float_detect_tininess(float_tininess_before_rounding,
> +                                  &env->fpu_status);
> +        /* Fallthrough */
> +    case S390_CPU_RESET_NORMAL:
> +        env->pfault_token =3D -1UL;
> +        env->bpbc =3D false;
> +        break;
> +    }
>  =20
>       /* Reset state inside the kernel that we cannot access yet from QEM=
U. */
> -    if (kvm_enabled()) {
> -        kvm_s390_reset_vcpu(cpu);
> +    if (kvm_enabled() && (type =3D=3D S390_CPU_RESET_CLEAR ||
> +                          type =3D=3D S390_CPU_RESET_INITIAL)) {
> +            kvm_s390_reset_vcpu(cpu);
>       }
> -}
> -
> -/* CPUClass:reset() */
> -static void s390_cpu_full_reset(CPUState *s)
> -{
> -    S390CPU *cpu =3D S390_CPU(s);
> -    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
> -    CPUS390XState *env =3D &cpu->env;
> -
> -    scc->parent_reset(s);
> -    cpu->env.sigp_order =3D 0;
> -    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
> -
> -    memset(env, 0, offsetof(CPUS390XState, end_reset_fields));
> -
> -    /* architectured initial values for CR 0 and 14 */
> -    env->cregs[0] =3D CR0_RESET;
> -    env->cregs[14] =3D CR14_RESET;
>  =20
>   #if defined(CONFIG_USER_ONLY)
>       /* user mode should always be allowed to use the full FPU */
> @@ -151,20 +136,21 @@ static void s390_cpu_full_reset(CPUState *s)
>           env->cregs[0] |=3D CR0_VECTOR;
>       }
>   #endif
> +}
>  =20
> -    /* architectured initial value for Breaking-Event-Address register *=
/
> -    env->gbea =3D 1;
> +static void s390_cpu_reset_normal(CPUState *s)
> +{
> +    return s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
> +}
>  =20
> -    env->pfault_token =3D -1UL;
> +static void s390_cpu_reset_initial(CPUState *s)
> +{
> +    return s390_cpu_reset(s, S390_CPU_RESET_INITIAL);
> +}
>  =20
> -    /* tininess for underflow is detected before rounding */
> -    set_float_detect_tininess(float_tininess_before_rounding,
> -                              &env->fpu_status);
> -
> -    /* Reset state inside the kernel that we cannot access yet from QEMU=
. */
> -    if (kvm_enabled()) {
> -        kvm_s390_reset_vcpu(cpu);
> -    }
> +static void s390_cpu_reset_clear(CPUState *s)
> +{
> +    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
>   }
>  =20
>   #if !defined(CONFIG_USER_ONLY)
> @@ -473,9 +459,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>   #if !defined(CONFIG_USER_ONLY)
>       scc->load_normal =3D s390_cpu_load_normal;
>   #endif
> -    scc->cpu_reset =3D s390_cpu_reset;
> -    scc->initial_cpu_reset =3D s390_cpu_initial_reset;
> -    cc->reset =3D s390_cpu_full_reset;
> +    scc->cpu_reset =3D s390_cpu_reset_normal;
> +    scc->initial_cpu_reset =3D s390_cpu_reset_initial;
> +    cc->reset =3D s390_cpu_reset_clear;
>       cc->class_by_name =3D s390_cpu_class_by_name,
>       cc->has_work =3D s390_cpu_has_work;
>   #ifdef CONFIG_TCG
>=20

This is a nice cleanup, but the patch is hard to digest.
Maybe you can split it in 3, one patch for each cpu_reset_type.

Regards,

Phil.


