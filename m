Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C9C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D6B218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCNh0YY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D6B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiI57-0000e7-D1
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiI4O-00009D-NR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiI4M-00038X-RB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:11:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiI4M-0002zN-By
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:11:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so9360480wrm.11
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lmMfutrJegQapcpEgPmD+gykgrA/xoupSs8XTFA1LlY=;
 b=WCNh0YY1AN3HUAmoeEYUYBbu99eLRZl1NDFxHmouR+JZZKvPNSFPCZIxXWSRQIasLz
 WGnS5c8BAOLluJuIvzGYIKzV3Gyo/lLC9pdCKDQu9Ps4dXgfBPHKo6UrSHabXnRRoArF
 ntApoybKKPNzHLjXx8bVOh+2aAmpTd8BHgtPgFtp7jk+lpSsKjVshXXnLFECAWLfjW3z
 ECRbFmWgawauKpaVfJYZARGowKtPc6p8JDFSBivsXV+aWxue2yFPX2VmQIk9lf5DBWbx
 rhPcAbqbX3/IY9GlKLF0UbVUhE0+RZAKuTtmEfyM0Zzk4uxXZ2iV5UU62Dforz7Jvi8Q
 ckJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lmMfutrJegQapcpEgPmD+gykgrA/xoupSs8XTFA1LlY=;
 b=S+wd8EjuKKR52qJWvRzoSaUcckHHJVnVrsgUCl/bzztLYgagBHes8Ki9Y9cR6FnAbQ
 6Gj0K8ikw3fVnp8KP/OBKiix/YuEDsc2+YW49bgyfupS/aUzyyRftOaJZGcA3zUlxYXx
 YHDALcoprNVdywViWv3Geht8dbiAbv5ebzbTbPSJfkqWL79TAALVsEW3yeBeXzT6vjJW
 gLjAoRVIdeq04PEJt+JYbjGF3bPL4CdNnB2xuPek3HFGR6IdMvnvgPg1kbThDIm/dFB+
 f+FP9uKA08O1ZvmHaqOrHwC9AVQXRs3DJ1OrYcS1/UVjb3aDftz3WLH8EA14NQrsWgEl
 4CRA==
X-Gm-Message-State: APjAAAUYTP1gEXr9r/iD211xEAJajohD/ftWQTt+yHvFu0dyV8I7ccg9
 2mzmuUrvWCVnyQl4A1j05HTRug==
X-Google-Smtp-Source: APXvYqwgYWql+iGQOTM9i+x0ml7nEFzf6LkxzDmdqV/sejbsFTR6HEHCMGZhF0KEgZVTiPPaYIaCqw==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr16171023wrj.68.1576847508149; 
 Fri, 20 Dec 2019 05:11:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 16sm9470047wmi.0.2019.12.20.05.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:11:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB8041FF87;
 Fri, 20 Dec 2019 13:11:45 +0000 (GMT)
References: <20190717054655.14104-1-npiggin@gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
In-reply-to: <20190717054655.14104-1-npiggin@gmail.com>
Date: Fri, 20 Dec 2019 13:11:45 +0000
Message-ID: <87h81vdtv2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Nicholas Piggin <npiggin@gmail.com> writes:

> This is a bit of proof of concept in case mttcg becomes more important
> yield could be handled like this. You can have by accident or deliberately
> force vCPUs onto the same physical CPU and cause inversion issues when the
> lock holder was preempted by the waiter. This is lightly tested but not
> to the point of measuring performance difference.

Sorry I'm so late replying.

Really this comes down to what EXCP_YIELD semantics are meant to mean.
For ARM it's a hint operation because we also have WFE which should halt
until there is some sort of change of state. In those cases exiting the
main-loop and sitting in wait_for_io should be the correct response. If
a vCPU is suspended waiting on the halt condition doesn't it have the
same effect?

>
> I really consider the previous confer/prod patches more important just to
> provide a more complete guest environment and better test coverage, than
> performance, but maybe someone wants to persue this.
>
> Thanks,
> Nick
> ---
>  cpus.c                   |  6 ++++++
>  hw/ppc/spapr_hcall.c     | 14 +++++++-------
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c |  5 +++++
>  util/qemu-thread-win32.c |  4 ++++
>  5 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index 927a00aa90..f036e062d9 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1760,6 +1760,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                  qemu_mutex_unlock_iothread();
>                  cpu_exec_step_atomic(cpu);
>                  qemu_mutex_lock_iothread();
> +                break;
> +            case EXCP_YIELD:
> +                qemu_mutex_unlock_iothread();
> +                qemu_thread_yield();
> +                qemu_mutex_lock_iothread();
> +                break;
>              default:
>                  /* Ignore everything else? */
>                  break;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57c1ee0fe1..9c24a64dfe 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1162,13 +1162,13 @@ static target_ulong h_confer(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>              return H_SUCCESS;
>          }
>=20=20
> -        /*
> -         * The targeted confer does not do anything special beyond yield=
ing
> -         * the current vCPU, but even this should be better than nothing.
> -         * At least for single-threaded tcg, it gives the target a chanc=
e to
> -         * run before we run again. Multi-threaded tcg does not really do
> -         * anything with EXCP_YIELD yet.
> -         */
> +       /*
> +        * The targeted confer does not do anything special beyond yieldi=
ng
> +        * the current vCPU, but even this should be better than nothing.
> +        * For single-threaded tcg, it gives the target a chance to run
> +        * before we run again, multi-threaded tcg will yield the CPU to
> +        * another vCPU.
> +        */
>      }
>=20=20
>      cs->exception_index =3D EXCP_YIELD;
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 55d83a907c..8525b0a70a 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -160,6 +160,7 @@ void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  void qemu_thread_exit(void *retval);
>  void qemu_thread_naming(bool enable);
> +void qemu_thread_yield(void);
>=20=20
>  struct Notifier;
>  /**
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 1bf5e65dea..91b12a1082 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -573,3 +573,8 @@ void *qemu_thread_join(QemuThread *thread)
>      }
>      return ret;
>  }
> +
> +void qemu_thread_yield(void)
> +{
> +    pthread_yield();
> +}
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 572f88535d..72fe406bef 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -442,3 +442,7 @@ bool qemu_thread_is_self(QemuThread *thread)
>  {
>      return GetCurrentThreadId() =3D=3D thread->tid;
>  }
> +
> +void qemu_thread_yield(void)
> +{
> +}


--=20
Alex Benn=C3=A9e

