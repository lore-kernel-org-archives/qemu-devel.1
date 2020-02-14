Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8794C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DE324670
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiaSEgAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE324670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2csP-0000hQ-Pl
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j2cnj-0001lt-0n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j2cnh-0002vl-MR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:22:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25378
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j2cnh-0002vO-IV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581693760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7CZKFvtFbfLt9AaVAFJZtQQ9+l8gyhVhdTe2T2rcSg=;
 b=RiaSEgAvTumLzAnuk9O2s2H7oZRUTB5keDZbeuar3BIWp7dO0m9zg3trHDo2LibSNBEKnm
 DelC+W92qY5srvMqwxtPjX1qIqfDKQs2iRxbaX83idwoHeslLvchbSNZOkaZRoRJgQCg4n
 0hyoDogH41DwspPfccPLzRswxoT30ts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-OfRjywoMOR2df8xx4e9VNA-1; Fri, 14 Feb 2020 10:22:38 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so4177475wrn.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 07:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j8pkOtFy+XzItuL3W/aLXhe9j5ntVAMnKIPwQuoJRhI=;
 b=G9gZivbgmaJdulXX9YUoUFU+muEITJwArhjHq919rrXJltDaLUSC5WwrLqzKCELwrY
 pcMmVp5+j2jYluEKFkWXNZhVMokwQeehfoxEsIIgBfypzBwbxGoctgPj+SA170ijRuRr
 O41RqqgEVgb643m/6fvAIInja3HTKx/ozksEO/yFHiqjUcsStrO33qaYJUA5xySEX3kp
 Wen8foKaCHe5V+7LiOmYRixn7t6wS6WUYoSYwD0l4zuxMeY3GNo1F3OTPNLWjsYheXw0
 gN3Pe7tqy6xCpkrukXngSIQr894uIZEzr5dr75p0fqWccUcF25gPGH4H20jNy0sZiwlE
 vyKg==
X-Gm-Message-State: APjAAAX/Gfn/R1N5ayYq06q6RwK4K8WvHuK5wRRmNKy6HbFzEBE5So4E
 5yw5Mx2tGWAb58IvaRAzhtGuN/lMHmNSoYwOloEJmnuaAmpaOx30c5zv2AiKROGR6TWOd0K0UR4
 vKmo1A6RR0snOk0M=
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5505751wmj.54.1581693756948; 
 Fri, 14 Feb 2020 07:22:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyymV7+kU+ggGILwsK0dA0UkMAmILQMujOlIy+5+ujW0Iw/dm9tb9JSPJ5N4X1m+ydGcpHWaA==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5505680wmj.54.1581693755773; 
 Fri, 14 Feb 2020 07:22:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id b13sm7885424wrq.48.2020.02.14.07.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 07:22:35 -0800 (PST)
Subject: Re: [PATCH] accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200214144952.15502-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <244ec8f5-5f19-ca98-5cbe-c3ec39494222@redhat.com>
Date: Fri, 14 Feb 2020 16:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200214144952.15502-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: OfRjywoMOR2df8xx4e9VNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Bug 1863025 <1863025@bugs.launchpad.net>, Yifan <me@yifanlu.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/02/20 15:49, Alex Benn=C3=A9e wrote:
> The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
> which is invalidated by a tb_flush before we execute it. This doesn't
> affect the other cpu_exec modes as a tb_flush by it's nature can only
> occur on a quiescent system. The race was described as:
>=20
>   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
>   B3. tcg_tb_alloc obtains a new TB
>=20
>       C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
>           (same TB as B2)
>=20
>           A3. start_exclusive critical section entered
>           A4. do_tb_flush is called, TB memory freed/re-allocated
>           A5. end_exclusive exits critical section
>=20
>   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
>   B3. tcg_tb_alloc reallocates TB from B2
>=20
>       C4. start_exclusive critical section entered
>       C5. cpu_tb_exec executes the TB code that was free in A4
>=20
> The simplest fix is to widen the exclusive period to include the TB
> lookup. As a result we can drop the complication of checking we are in
> the exclusive region before we end it.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Yifan <me@yifanlu.com>
> Cc: Bug 1863025 <1863025@bugs.launchpad.net>
> ---
>  accel/tcg/cpu-exec.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 2560c90eec7..d95c4848a47 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -240,6 +240,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
>      uint32_t cf_mask =3D cflags & CF_HASH_MASK;
> =20
>      if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
> +        start_exclusive();
> +
>          tb =3D tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask)=
;
>          if (tb =3D=3D NULL) {
>              mmap_lock();
> @@ -247,8 +249,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
>              mmap_unlock();
>          }
> =20
> -        start_exclusive();
> -
>          /* Since we got here, we know that parallel_cpus must be true.  =
*/
>          parallel_cpus =3D false;
>          cc->cpu_exec_enter(cpu);
> @@ -271,14 +271,15 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          qemu_plugin_disable_mem_helpers(cpu);
>      }
> =20
> -    if (cpu_in_exclusive_context(cpu)) {
> -        /* We might longjump out of either the codegen or the
> -         * execution, so must make sure we only end the exclusive
> -         * region if we started it.
> -         */
> -        parallel_cpus =3D true;
> -        end_exclusive();
> -    }
> +
> +    /*
> +     * As we start the exclusive region before codegen we must still
> +     * be in the region if we longjump out of either the codegen or
> +     * the execution.
> +     */
> +    g_assert(cpu_in_exclusive_context(cpu));
> +    parallel_cpus =3D true;
> +    end_exclusive();
>  }
> =20
>  struct tb_desc {
>=20


