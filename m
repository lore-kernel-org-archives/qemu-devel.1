Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56967C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266DB20693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8n53jCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266DB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NX6-0007hz-2f
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NVN-0005sr-B1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NVL-0000os-K8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8NVK-0000nD-2B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so7096794wme.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9dDaDuOvsqhm0Gued78IJbMi0icQ31IOeq6HnA/ClBc=;
 b=R8n53jCHvQtVwrG6j7A4FefFLL3fteeBTYwUkxdKItnx+lX7GQIkOW88aiaT1fha6P
 fUnjRtQf33tzOLa5hW5hypTnaa+L3qWxo4YRgzp1vT3TLWQQWTyUdYUmFYFJdcFlrFev
 waahaSner32Oc5a6NU5cxERxBUMPtboiAme9U2mm1Kk0qvV2B5umMGNaaAtb7y91ZgB/
 tbhJb9SHdrxDrTZgWoHWUgh7QSnoaod7z2dkcPsrnIBRBheBWcV2o50mV53EglALrQ4Z
 oeDBquQCEvkgQFcdBFLCW8QVm4idLsgBRx2+3TcT7t+a9Nd7TnmPJwXwtyw4dfzOi8o+
 neQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9dDaDuOvsqhm0Gued78IJbMi0icQ31IOeq6HnA/ClBc=;
 b=udZD2ZwJhJoZw1V+9/Lwv6rFHzr1LiqpG7Us+S2Jo1FnYSwZtPwEgmqtyPEVG0dJII
 J4KxpgPyxCI081vSsVNQPAoaV6wNttuCxppZeQ2tJ65GGs+vdaJqO5XacIjxAGtq+hD3
 PxW2OuLEPyU48hHuxMfwsStvxPCVu54wbETHp1Rze9z0rx3wzg+G79FxICs7Tu+lbrN5
 T+zCNg9ygjmQFbytfAKCYuE5MadrN4znteajwkcXH2GwZ7yBmKOvrnHlsfRx/CeJqiOm
 E3cSVhHIf3b8qJTtd8P6ivw8tezFUhW9CC/EXMYUsfw5beHBF54nzfLUbXQn6eDIKgVz
 4ZcQ==
X-Gm-Message-State: APjAAAX4rqw6Ji9FOSDeTVYJU3flVj4XBB9klpmBZUyNP29IjNl6BTQc
 ugHi24sd4ZiHGRx2bHPq+q8BvFWz+6o=
X-Google-Smtp-Source: APXvYqwhc+KQSHOzOnGynFN4EBp8QjrQxBU/EW+v0fmDxtR9P3yERWujercvG0b1gGrKPZdRSfAR2A==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr8748306wmj.25.1568288591056; 
 Thu, 12 Sep 2019 04:43:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c3sm35071056wrh.55.2019.09.12.04.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:43:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF0C91FF87;
 Thu, 12 Sep 2019 12:43:09 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-10-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910144428.32597-10-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:43:09 +0100
Message-ID: <87ef0lzqnm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 09/13] target/arm/arm-semi: Factor out
 implementation of SYS_SEEK
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Factor out the implementation of SYS_SEEK via the new function
> tables.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 64ed39fc075..c548ce849e7 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -350,6 +350,8 @@ typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *c=
pu, GuestFD *gf,
>  typedef uint32_t sys_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
>                              target_ulong buf, uint32_t len);
>  typedef uint32_t sys_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
> +typedef uint32_t sys_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong offset);
>
>  static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
> @@ -405,6 +407,16 @@ static uint32_t host_isattyfn(TaskState *ts, ARMCPU =
*cpu, GuestFD *gf)
>      return isatty(gf->hostfd);
>  }
>
> +static uint32_t host_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong offset)
> +{
> +    uint32_t ret =3D set_swi_errno(ts, lseek(gf->hostfd, offset, SEEK_SE=
T));
> +    if (ret =3D=3D (uint32_t)-1) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>  static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
>      return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -431,11 +443,19 @@ static uint32_t gdb_isattyfn(TaskState *ts, ARMCPU =
*cpu, GuestFD *gf)
>      return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
>  }
>
> +static uint32_t gdb_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                           target_ulong offset)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
> +                           gf->hostfd, offset);
> +}
> +
>  typedef struct GuestFDFunctions {
>      sys_closefn *closefn;
>      sys_writefn *writefn;
>      sys_readfn *readfn;
>      sys_isattyfn *isattyfn;
> +    sys_seekfn *seekfn;
>  } GuestFDFunctions;
>
>  static const GuestFDFunctions guestfd_fns[] =3D {
> @@ -444,12 +464,14 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>          .writefn =3D host_writefn,
>          .readfn =3D host_readfn,
>          .isattyfn =3D host_isattyfn,
> +        .seekfn =3D host_seekfn,
>      },
>      [GuestFDGDB] =3D {
>          .closefn =3D gdb_closefn,
>          .writefn =3D gdb_writefn,
>          .readfn =3D gdb_readfn,
>          .isattyfn =3D gdb_isattyfn,
> +        .seekfn =3D gdb_seekfn,
>      },
>  };
>
> @@ -625,15 +647,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, -1);
>          }
>
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
> -                                   gf->hostfd, arg1);
> -        } else {
> -            ret =3D set_swi_errno(ts, lseek(gf->hostfd, arg1, SEEK_SET));
> -            if (ret =3D=3D (uint32_t)-1)
> -              return -1;
> -            return 0;
> -        }
> +        return guestfd_fns[gf->type].seekfn(ts, cpu, gf, arg1);
>      case TARGET_SYS_FLEN:
>          GET_ARG(0);


--
Alex Benn=C3=A9e

