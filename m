Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4F7206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHhNUSQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3hK-0003sQ-2d
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3gY-0003QE-VH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:38:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3gW-0001S7-B3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:38:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id c15so927362wrs.11
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VKLlypz5dyUSFmj71mZfu5hbHwWvT6qYT7KdZQ6x5Lk=;
 b=aHhNUSQwOfv+M2z2EbZMaa2VPWaTVE25rZU2r0vpTO4laTMeq1mMJza9YeqFFpzhIq
 qypvZLNxR9UsyDeQmbOV9+3XT7csp33tl6coIdCtSUioUX2wk4dd4Wp5XniPbfeaLlJc
 2mLslOt9pSBPECCwETccOqJX3Ed6cC0xCf3cN0xWmWIb6dJrq9OB0Iuezu0+K8TCGvP/
 2vGwnw7022+We/Z/tGGsa3Ztx9SQ/uGL/tJsHLqVnRMV+4DfgHQWv7v33SobPwPeTWEy
 QWd0ad/Q6GtaWt0Ezzo4nzYdZdPlS0J6YnJJ7AHDb+7SWule6SUvkCoFN55htV5AlB7K
 EHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VKLlypz5dyUSFmj71mZfu5hbHwWvT6qYT7KdZQ6x5Lk=;
 b=E1ZiQHIHKCJCKypt+4rFPm6dqn5I94x1ulNFaKtWhEXh5OX7iF3xNg8tuZpzH09QA7
 uxZqz6MLrOUksrACqW3dsiWPxYpNswDNhuEomqLgVR1fFs/H3x3RZpqrXCqZQZTtYxJC
 RVoCXsQ+iZf8fs0+HwhKKPth8BVfn/qUnnxQxzOjn8UrzSPGEoV5Yrw1ajAJhW/0yIv3
 MKFT0Co2G7gTgZKZlqaHiAXgKFL1xrCLc6GUliSlAachDFUNYCkoplrLL/2pVPLhOZS0
 K3w6R7mSlmyDGMiujJTVGHgBoVcl0jTZVsftfT7jiTv77LdgFXSHVcl9HYODBL4R6xn9
 JNEA==
X-Gm-Message-State: AOAM531wzCz5twPsBeVG3dD6lBvp4z4dxbHz3GU4vbXM4APXcHl/oXUx
 5LtRv+CBexq2QMMuJknGximy8A==
X-Google-Smtp-Source: ABdhPJz1ls2UxmQUF0v5T/524B4RIoPivkRPPnhb/xrRXMGDmcM8c22eSL62nF1XNFvXYY43CuAFCQ==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr1131835wrf.309.1598956718500; 
 Tue, 01 Sep 2020 03:38:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a83sm1259313wmh.48.2020.09.01.03.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:38:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD0881FF7E;
 Tue,  1 Sep 2020 11:38:36 +0100 (BST)
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-4-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 03/16] cpus: prepare new CpusAccel cpu accelerator
 interface
In-reply-to: <20200901072201.7133-4-cfontana@suse.de>
Date: Tue, 01 Sep 2020 11:38:36 +0100
Message-ID: <87k0xd6atv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> The new interface starts unused, will start being used by the
> next patches.
>
> It provides methods for each accelerator to start a vcpu, kick a vcpu,
> synchronize state, get cpu virtual clock and elapsed ticks.
>
> In qemu_wait_io_event, make it clear that APC is used only for HAX
> on Windows.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
<snip>
>=20=20
>      /* signal CPU creation */
> -    cpu->created =3D true;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      do {
> @@ -482,8 +582,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      } while (!cpu->unplug || cpu_can_run(cpu));
>=20=20
>      qemu_kvm_destroy_vcpu(cpu);
> -    cpu->created =3D false;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_destroyed(cpu);
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
> @@ -511,8 +610,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>      sigaddset(&waitset, SIG_IPI);
>=20=20
>      /* signal CPU creation */
> -    cpu->created =3D true;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      do {
> @@ -660,8 +758,7 @@ static void deal_with_unplugged_cpus(void)
>      CPU_FOREACH(cpu) {
>          if (cpu->unplug && !cpu_can_run(cpu)) {
>              qemu_tcg_destroy_vcpu(cpu);
> -            cpu->created =3D false;
> -            qemu_cond_signal(&qemu_cpu_cond);
> +            cpu_thread_signal_destroyed(cpu);
>              break;
>          }
>      }
> @@ -688,9 +785,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>=20=20
>      cpu->thread_id =3D qemu_get_thread_id();
> -    cpu->created =3D true;
>      cpu->can_do_io =3D 1;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      /* wait for initial kick-off after machine start */
> @@ -800,11 +896,9 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>=20=20
>      cpu->thread_id =3D qemu_get_thread_id();
> -    cpu->created =3D true;
>      current_cpu =3D cpu;
> -
>      hax_init_vcpu(cpu);
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      do {
> @@ -843,8 +937,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
>      hvf_init_vcpu(cpu);
>=20=20
>      /* signal CPU creation */
> -    cpu->created =3D true;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      do {
> @@ -858,8 +951,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
>      } while (!cpu->unplug || cpu_can_run(cpu));
>=20=20
>      hvf_vcpu_destroy(cpu);
> -    cpu->created =3D false;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_destroyed(cpu);
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
> @@ -884,8 +976,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
>      }
>=20=20
>      /* signal CPU creation */
> -    cpu->created =3D true;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      do {
> @@ -902,8 +993,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
>      } while (!cpu->unplug || cpu_can_run(cpu));
>=20=20
>      whpx_destroy_vcpu(cpu);
> -    cpu->created =3D false;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_destroyed(cpu);
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
> @@ -936,10 +1026,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>=20=20
>      cpu->thread_id =3D qemu_get_thread_id();
> -    cpu->created =3D true;
>      cpu->can_do_io =3D 1;
>      current_cpu =3D cpu;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>=20=20
>      /* process any pending work */
> @@ -980,14 +1069,13 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      } while (!cpu->unplug || cpu_can_run(cpu));
>=20=20
>      qemu_tcg_destroy_vcpu(cpu);
> -    cpu->created =3D false;
> -    qemu_cond_signal(&qemu_cpu_cond);
> +    cpu_thread_signal_destroyed(cpu);
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;

I suspect this clean-up could be a separate patch.

<snip>
>=20=20
> +/* signal CPU creation */
> +void cpu_thread_signal_created(CPUState *cpu)
> +{
> +    cpu->created =3D true;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +}
> +
> +/* signal CPU destruction */
> +void cpu_thread_signal_destroyed(CPUState *cpu)
> +{
> +    cpu->created =3D false;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +}
> +
> +
>  static bool all_vcpus_paused(void)
>  {
>      CPUState *cpu;
> @@ -1163,9 +1269,6 @@ void cpu_remove_sync(CPUState *cpu)
>      qemu_mutex_lock_iothread();
>  }
>=20=20
> -/* For temporary buffers for forming a name */
> -#define VCPU_THREAD_NAME_SIZE 16
> -

Lets kill this rather than move it around. The thread functions could
more cleanly do:

    g_autoptr(GString) thread_name =3D g_string_new(NULL);
    ...
    g_string_printf(thread_name, "CPU %d/DUMMY", cpu->cpu_index);
    qemu_thread_create(..., thread_name->str, ...);


>  static void qemu_tcg_init_vcpu(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
> @@ -1286,6 +1389,13 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
>  #endif
>  }
>=20=20
> +void cpus_register_accel(const CpusAccel *ca)
> +{
> +    assert(ca !=3D NULL);
> +    assert(ca->create_vcpu_thread !=3D NULL); /* mandatory */
> +    cpus_accel =3D ca;
> +}
> +
>  static void qemu_dummy_start_vcpu(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
> @@ -1316,7 +1426,10 @@ void qemu_init_vcpu(CPUState *cpu)
>          cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
>      }
>=20=20
> -    if (kvm_enabled()) {
> +    if (cpus_accel) {
> +        /* accelerator already implements the CpusAccel interface */
> +        cpus_accel->create_vcpu_thread(cpu);
> +    } else if (kvm_enabled()) {
>          qemu_kvm_start_vcpu(cpu);
>      } else if (hax_enabled()) {
>          qemu_hax_start_vcpu(cpu);
> diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
> new file mode 100644
> index 0000000000..d9211da66c
> --- /dev/null
> +++ b/stubs/cpu-synchronize-state.c
> @@ -0,0 +1,9 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/hw_accel.h"
> +
> +void cpu_synchronize_state(CPUState *cpu)
> +{
> +}
> +void cpu_synchronize_post_init(CPUState *cpu)
> +{
> +}
> diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-get-virtual-cloc=
k.c
> new file mode 100644
> index 0000000000..fd447d53f3
> --- /dev/null
> +++ b/stubs/cpus-get-virtual-clock.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/cpu-timers.h"
> +#include "qemu/main-loop.h"
> +
> +int64_t cpus_get_virtual_clock(void)
> +{
> +    return cpu_get_clock();
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 57fec4f8c8..54d4a3f6d4 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -5,6 +5,7 @@ stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
>  stub_ss.add(files('change-state-handler.c'))
>  stub_ss.add(files('cmos.c'))
>  stub_ss.add(files('cpu-get-clock.c'))
> +stub_ss.add(files('cpus-get-virtual-clock.c'))
>  stub_ss.add(files('qemu-timer-notify-cb.c'))
>  stub_ss.add(files('icount.c'))
>  stub_ss.add(files('dump.c'))
> @@ -45,6 +46,7 @@ stub_ss.add(files('vmgenid.c'))
>  stub_ss.add(files('vmstate.c'))
>  stub_ss.add(files('vm-stop.c'))
>  stub_ss.add(files('win32-kbd-hook.c'))
> +stub_ss.add(files('cpu-synchronize-state.c'))
>  if have_system
>    stub_ss.add(files('semihost.c'))
>  endif
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index db51e68f25..50b325c65b 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -635,13 +635,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
>          return get_clock();
>      default:
>      case QEMU_CLOCK_VIRTUAL:
> -        if (icount_enabled()) {
> -            return icount_get();
> -        } else if (qtest_enabled()) { /* for qtest_clock_warp */
> -            return qtest_get_virtual_clock();
> -        } else {
> -            return cpu_get_clock();
> -        }
> +        return cpus_get_virtual_clock();
>      case QEMU_CLOCK_HOST:
>          return REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
>      case QEMU_CLOCK_VIRTUAL_RT:

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

