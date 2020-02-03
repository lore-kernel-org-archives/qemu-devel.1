Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41436C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3A020721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/M+xBql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3A020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaJe-0001En-5j
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyaIy-0000Tu-4c
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyaIw-0008VQ-UH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyaIw-0008V2-Qg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZXvJX3yw/zVElRuvQiE3JZKJUNwKybXn0H22uqrDsE=;
 b=V/M+xBqlCmXeDWrQOKUNA3WJoYE+hzKfLdssvXtPJWbJamGaUKGfwLfM6HxbuBwbm/pBbx
 7qhjdKdqbbYf+u9p39ea1fhCuS53ioybnKhmUE0mpXPP8Qd4t/zMKLG8V63mW4rqtLRzke
 fKVpVfPA8qZX3xZ+uSV6+GXqlHgyeOM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-5RByLlc_Pbq5cB14sMN9Fw-1; Mon, 03 Feb 2020 06:54:11 -0500
Received: by mail-wm1-f71.google.com with SMTP id y24so3912414wmj.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NCFPZubsvdjag2upWKRSxC3GO0O0ccVk5ismzP6tU2I=;
 b=C/ENwmyJa8mk+51hXFuJZ9ki7+WRCohmxhpkB0JpbBl3kuFa3ga44+mVaR++dzZqnq
 jLjiuk1b9V3YcPDQ3jZzaofW1f1cRFXSRn5UHoAIBGdaHdoeTUiGiR/hZhVEI+QNRaUS
 /GPf9qY9y4+CmJbHAr5H0K8ySJ4T6u+O3PSWe09xzPa9/sQ44UOtrt9vagbmHYTPcCbu
 ES/mjpUhJR/JuFxaggEM5TxwIa6Jj8Sfc+o+x4UJWCnDEf8qfsmnVvs8baS0i2py7xBn
 d70Y6Bh00sXoDxlu7z/tERrhpy7UcvjNmuQoHpBhFQMp8qet4tuTVjmrRCq89u2HouWs
 9Rdw==
X-Gm-Message-State: APjAAAU51V9dYycH8eJYAhvPybNbG0DOJcff8QEIg03zn4lPaYmuaOew
 9izhUivTTINkOUVk6zghpvQYcRNTOAbbkA+2t/1jYRNcVggMTPiQdoO7bZ7xV5ohRK5cP+ckzDW
 gvAO5aD7gPy+fqBM=
X-Received: by 2002:a7b:c088:: with SMTP id r8mr28918102wmh.18.1580730849621; 
 Mon, 03 Feb 2020 03:54:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmyT1YXWVytfWEYFD35GPVPXtPlXeSwN0sEBcFAUaOuxl2GcY0/+pajBzMQtLCrV/v6Zpmug==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr28918059wmh.18.1580730849201; 
 Mon, 03 Feb 2020 03:54:09 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id k7sm22582537wmi.19.2020.02.03.03.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 03:54:08 -0800 (PST)
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: Kamil Rytarowski <n54@gmx.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
Date: Mon, 3 Feb 2020 12:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128140945.929-5-n54@gmx.com>
Content-Language: en-US
X-MC-Unique: 5RByLlc_Pbq5cB14sMN9Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 1/28/20 3:09 PM, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Implements the NVMM accelerator cpu enlightenments to actually use the nv=
mm-all
> accelerator on NetBSD platforms.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> ---
>   cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
>   include/sysemu/hw_accel.h | 14 ++++++++++
>   target/i386/helper.c      |  2 +-
>   3 files changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index b472378b70..3c3f63588c 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -42,6 +42,7 @@
>   #include "sysemu/hax.h"
>   #include "sysemu/hvf.h"
>   #include "sysemu/whpx.h"
> +#include "sysemu/nvmm.h"
>   #include "exec/exec-all.h"
>=20
>   #include "qemu/thread.h"
> @@ -1666,6 +1667,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
>       return NULL;
>   }
>=20
> +static void *qemu_nvmm_cpu_thread_fn(void *arg)
> +{
> +    CPUState *cpu =3D arg;
> +    int r;
> +
> +    assert(nvmm_enabled());
> +
> +    rcu_register_thread();
> +
> +    qemu_mutex_lock_iothread();
> +    qemu_thread_get_self(cpu->thread);
> +    cpu->thread_id =3D qemu_get_thread_id();
> +    current_cpu =3D cpu;
> +
> +    r =3D nvmm_init_vcpu(cpu);
> +    if (r < 0) {
> +        fprintf(stderr, "nvmm_init_vcpu failed: %s\n", strerror(-r));
> +        exit(1);
> +    }
> +
> +    /* signal CPU creation */
> +    cpu->created =3D true;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +
> +    do {
> +        if (cpu_can_run(cpu)) {
> +            r =3D nvmm_vcpu_exec(cpu);
> +            if (r =3D=3D EXCP_DEBUG) {
> +                cpu_handle_guest_debug(cpu);
> +            }
> +        }
> +        qemu_wait_io_event(cpu);
> +    } while (!cpu->unplug || cpu_can_run(cpu));
> +
> +    nvmm_destroy_vcpu(cpu);
> +    cpu->created =3D false;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
>   #ifdef _WIN32
>   static void CALLBACK dummy_apc_func(ULONG_PTR unused)
>   {
> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
>   #endif
>   }
>=20
> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
> +{
> +    char thread_name[VCPU_THREAD_NAME_SIZE];
> +
> +    cpu->thread =3D g_malloc0(sizeof(QemuThread));
> +    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));

Nitpick, we prefer g_new0().

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    qemu_cond_init(cpu->halt_cond);
> +    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
> +             cpu->cpu_index);
> +    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn=
,
> +                       cpu, QEMU_THREAD_JOINABLE);
> +}
> +
>   static void qemu_dummy_start_vcpu(CPUState *cpu)
>   {
>       char thread_name[VCPU_THREAD_NAME_SIZE];
> @@ -2069,6 +2125,8 @@ void qemu_init_vcpu(CPUState *cpu)
>           qemu_tcg_init_vcpu(cpu);
>       } else if (whpx_enabled()) {
>           qemu_whpx_start_vcpu(cpu);
> +    } else if (nvmm_enabled()) {
> +        qemu_nvmm_start_vcpu(cpu);
>       } else {
>           qemu_dummy_start_vcpu(cpu);
>       }
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index 0ec2372477..dbfa7a02f9 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -15,6 +15,7 @@
>   #include "sysemu/hax.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/whpx.h"
> +#include "sysemu/nvmm.h"
>=20
>   static inline void cpu_synchronize_state(CPUState *cpu)
>   {
> @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
>       if (whpx_enabled()) {
>           whpx_cpu_synchronize_state(cpu);
>       }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_state(cpu);
> +    }
>   }
>=20
>   static inline void cpu_synchronize_post_reset(CPUState *cpu)
> @@ -40,6 +44,10 @@ static inline void cpu_synchronize_post_reset(CPUState=
 *cpu)
>       if (whpx_enabled()) {
>           whpx_cpu_synchronize_post_reset(cpu);
>       }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_post_reset(cpu);
> +    }
> +
>   }
>=20
>   static inline void cpu_synchronize_post_init(CPUState *cpu)
> @@ -53,6 +61,9 @@ static inline void cpu_synchronize_post_init(CPUState *=
cpu)
>       if (whpx_enabled()) {
>           whpx_cpu_synchronize_post_init(cpu);
>       }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_post_init(cpu);
> +    }
>   }
>=20
>   static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> @@ -66,6 +77,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState =
*cpu)
>       if (whpx_enabled()) {
>           whpx_cpu_synchronize_pre_loadvm(cpu);
>       }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_pre_loadvm(cpu);
> +    }
>   }
>=20
>   #endif /* QEMU_HW_ACCEL_H */
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c3a6e4fabe..2e79d61329 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -981,7 +981,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAcces=
s access)
>       X86CPU *cpu =3D env_archcpu(env);
>       CPUState *cs =3D env_cpu(env);
>=20
> -    if (kvm_enabled() || whpx_enabled()) {
> +    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
>           env->tpr_access_type =3D access;
>=20
>           cpu_interrupt(cs, CPU_INTERRUPT_TPR);
> --
> 2.24.1
>=20


