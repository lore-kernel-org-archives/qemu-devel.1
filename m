Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD2C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEA220659
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRQ7d1AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEA220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44889 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLL6-0005yZ-Kw
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFLAx-0003Z4-LA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFLAu-0006qj-GE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:38:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFLAu-0006lj-6X
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569947935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=eLo6y7P9wWutG/AzkdfHzKvz6ZPn9YVerqiabOJ0Qtk=;
 b=SRQ7d1AYgtTc2DxzsejiKIyxPv5FBqpE8n9PHmUYSC6mLERBXGtcVQxAYTsR8WR/2i2TmI
 Pzoz3IBbX9RteKC4MKJpiRpLXiHTbildoAzSZbhqvQOaXogcRcCnJ/jgtxrSHnYcdxsNPs
 tEkq8w6XoyXkUX7bgSvVUyvBQpUZacI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-5JRVJk2ePTKLTHmMbrE-dg-1; Tue, 01 Oct 2019 12:38:53 -0400
Received: by mail-wm1-f69.google.com with SMTP id 4so1130396wmj.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G+Et154Enf8PbvLJ9MTjHiSYW1wXd4Tz/scWbKu38Vc=;
 b=Fx3aM3Lm3fDfuuKTnJdX8e7MiAarb2aB9pG4VZU2MQGbaioH4aXwFb0NylMd99de7Q
 wHMpMDfri6WjB7vBB31YNIQ/eVW049+W5oOudkXkcus4ucXn/lU/uGhGI0pNC6fh4Dq1
 EliZjyZSoWyWRa7IJuH9VNPjXpA1CflwwJ1PXng7n0mJciliF+xNiTVNSUXcu3YhDfVm
 o/WG38snHMprbMRbYWOCpmW2EHZiLyokMbIyqbV5bjbl/bo0K2ApBDOUb5xa1JGVt9PU
 UfA9JZb0izuKnU/7m+K2p/Td3ZKs/ZHQ5G47tVs2moYVx6jXbLkB40SvoQla/V6CA6EC
 evMA==
X-Gm-Message-State: APjAAAXxnf586b2c0KMJlYAs4DRsJcLYC/MbRMmn826vuk/Nts2HCu4x
 VCTCCIyjdxBiLyiutd9VxXaxwXJ1aTUYxxWoPs9AkcbJxlwJ5z7F6Jv3HDbWWcpdLLR/sIPvRYe
 SeXC9dOKOYbGgCHQ=
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4364276wmg.33.1569947932312; 
 Tue, 01 Oct 2019 09:38:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMdV8TmY8pkF3oLIIfM6731+8NPp1BzdYo9eINUcBQTq2P380B57h8g8uDHYzzNRem46P+Jg==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4364259wmg.33.1569947932010; 
 Tue, 01 Oct 2019 09:38:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id w18sm4227122wmc.9.2019.10.01.09.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 09:38:51 -0700 (PDT)
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191001160426.26644-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com>
Date: Tue, 1 Oct 2019 18:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001160426.26644-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 5JRVJk2ePTKLTHmMbrE-dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 18:04, Alex Benn=C3=A9e wrote:
> qemu_cpu_kick is used for a number of reasons including to indicate
> there is work to be done. However when thread=3Dsingle the old
> qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
> which can lead to a hang in the case that:
>=20
>   a) the kick is from outside the vCPUs (e.g. iothread)
>   b) the timers are paused (i.e. iothread calling run_on_cpu)
>=20
> To avoid this lets split qemu_cpu_kick_rr into two functions. One for
> the timer which continues to advance to the next timeslice and another
> for all other kicks.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Doug Gale <doug16k@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  cpus.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Looks good to me.  Single-threaded TCG is not going to have high vCPU
counts anyway.

Paolo

> diff --git a/cpus.c b/cpus.c
> index d2c61ff155..bee7209134 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
>  }
> =20
> -/* Kick the currently round-robin scheduled vCPU */
> -static void qemu_cpu_kick_rr_cpu(void)
> +/* Kick the currently round-robin scheduled vCPU to next */
> +static void qemu_cpu_kick_rr_next_cpu(void)
>  {
>      CPUState *cpu;
>      do {
> @@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
>      } while (cpu !=3D atomic_mb_read(&tcg_current_rr_cpu));
>  }
> =20
> +/* Kick all RR vCPUs */
> +static void qemu_cpu_kick_rr_cpus(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_exit(cpu);
> +    };
> +}
> +
>  static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
>  {
>  }
> @@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockTyp=
e type)
>  static void kick_tcg_thread(void *opaque)
>  {
>      timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
> -    qemu_cpu_kick_rr_cpu();
> +    qemu_cpu_kick_rr_next_cpu();
>  }
> =20
>  static void start_tcg_kick_timer(void)
> @@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
>  {
>      qemu_cond_broadcast(cpu->halt_cond);
>      if (tcg_enabled()) {
> -        cpu_exit(cpu);
> -        /* NOP unless doing single-thread RR */
> -        qemu_cpu_kick_rr_cpu();
> +        if (qemu_tcg_mttcg_enabled()) {
> +            cpu_exit(cpu);
> +        } else {
> +            qemu_cpu_kick_rr_cpus();
> +        }
>      } else {
>          if (hax_enabled()) {
>              /*
>=20


