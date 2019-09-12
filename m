Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C84C4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9975F20684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSd3kxYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9975F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8N81-0004G7-PQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N7A-0003lH-Ck
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N79-00016R-2A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:18:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8N78-00015T-P2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:18:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id q14so27966439wrm.9
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=shAur5HTPhnDBRuhKypOdqutUtjgWcN27WTvZmV33K8=;
 b=kSd3kxYBPCvewGrlaaa0HYbGj02URU+eM66/DX9i9TNS/2orzorw+aMI7ndfVxPyXK
 DyMNG2Hl9OvgbyxFpdHkGhUWkBpztsG9dq0m7eQSspBTf7yTg4n1X68rhDCoQCoAJvDk
 aM7Lx3pdmTsu8fB2j81Huldgr/UnvHuBwu5proOzhGjsiQpC5D55NkbRIWZFnIZQzuQA
 JKaq+P8gaqMsNpGQVZ3EI33vRhJkW3TR2EP9ezuv2apl7sxVvBA3bn0IG254db/VpQLR
 nAx8cTCQaq9YGeHD83Pv3SIxuQoOv03QNozhh/jpTMTbSzm4M+BiYdGTMmXPu1gLdAQX
 Pi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=shAur5HTPhnDBRuhKypOdqutUtjgWcN27WTvZmV33K8=;
 b=jC7PkT9Z15KH72WSYadTw1PfHhv4E0qwxusC8T1BzYfhdlB5M5VcZP9JYbU2HfZWCj
 wB2NSmFyMG8s3sCFjK6iZo91Kf5OGcwKeDsz8AXbeUfaiMss/KT+jBGp5x4tRAtVTWMs
 mdIaP0y3jmydNI5oURBJtvpC4pFG3uT8tMvzPfEkeZg0StenfKXvfaqBHaQkJY5JdgXM
 Frpp/Pirbb58I1jvag/6KPgsOc3ffSss6q3LCKETFUsiERFMinAnjtQLXKrnVPoPuvw1
 7w2Sr+9omWf/0/18OWbeVSB1FSmp8mzz6/S7xouoAr+unPKC4aWi6Rs8fvtdwN/+E6Bh
 VZbg==
X-Gm-Message-State: APjAAAXUEAX9D0i8dSpE1s3UDNsdwMHPufQmlZHOjWe7lAMKHWR1zZgI
 5U3ef233opVuuAQ9QCJjemHjaQ==
X-Google-Smtp-Source: APXvYqw9h09iMBZiU1x7e2NH+KW8s7EVh1AxizD2UVTpIpfXKaDARHBHD6tOO+GZJN4BJzUTM/B+mg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr5339434wrv.327.1568287093006; 
 Thu, 12 Sep 2019 04:18:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a6sm15423797wrr.85.2019.09.12.04.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:18:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8848C1FF87;
 Thu, 12 Sep 2019 12:18:11 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-7-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910144428.32597-7-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:18:11 +0100
Message-ID: <87lfutzrt8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 06/13] target/arm/arm-semi: Factor out
 implementation of SYS_WRITE
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

> Factor out the implementation of SYS_WRITE via the
> new function tables.
>
> The #ifdef around the declaration/initialization of the
> local 'env' variable is unfortunate but necessary, because
> the softmmu-semi.h version of lock_user implicitly uses 'env',
> but the user-only version doesn't need it.

heh - one reason I rewrote a local lock_user_string for semihost.c
although of course it only has to worry about the softmmu case as you
don't have re-direct-able char devices in linux-user.

> Without the ifdefs
> we'd get a warning about the unused variable for the user-only
> compilation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 53 ++++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index f3e0bf77cd3..0dec4c04e2f 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -345,27 +345,61 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gd=
b_syscall_complete_cb cb,
>   * setting the guest errno if appropriate.
>   */
>  typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
> +typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                             target_ulong buf, uint32_t len);
>
>  static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
>      return set_swi_errno(ts, close(gf->hostfd));
>  }
>
> +static uint32_t host_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                             target_ulong buf, uint32_t len)
> +{
> +    uint32_t ret;
> +#ifndef CONFIG_USER_ONLY
> +    CPUARMState *env =3D &cpu->env;
> +#endif
> +    char *s =3D lock_user(VERIFY_READ, buf, len, 1);
> +    if (!s) {
> +        /* Return bytes not written on error */
> +        return len;
> +    }
> +    ret =3D set_swi_errno(ts, write(gf->hostfd, s, len));
> +    unlock_user(s, buf, 0);
> +    if (ret =3D=3D (uint32_t)-1) {
> +        ret =3D 0;
> +    }
> +    /* Return bytes not written */
> +    return len - ret;
> +}
> +
>  static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
>      return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
>  }
>
> +static uint32_t gdb_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
> +                            target_ulong buf, uint32_t len)
> +{
> +    arm_semi_syscall_len =3D len;
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
> +                           gf->hostfd, buf, len);
> +}
> +
>  typedef struct GuestFDFunctions {
>      sys_closefn *closefn;
> +    sys_writefn *writefn;
>  } GuestFDFunctions;
>
>  static const GuestFDFunctions guestfd_fns[] =3D {
>      [GuestFDHost] =3D {
>          .closefn =3D host_closefn,
> +        .writefn =3D host_writefn,
>      },
>      [GuestFDGDB] =3D {
>          .closefn =3D gdb_closefn,
> +        .writefn =3D gdb_writefn,
>      },
>  };
>
> @@ -504,24 +538,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, -1);
>          }
>
> -        if (use_gdb_syscalls()) {
> -            arm_semi_syscall_len =3D len;
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
> -                                   gf->hostfd, arg1, len);
> -        } else {
> -            s =3D lock_user(VERIFY_READ, arg1, len, 1);
> -            if (!s) {
> -                /* Return bytes not written on error */
> -                return len;
> -            }
> -            ret =3D set_swi_errno(ts, write(gf->hostfd, s, len));
> -            unlock_user(s, arg1, 0);
> -            if (ret =3D=3D (uint32_t)-1) {
> -                ret =3D 0;
> -            }
> -            /* Return bytes not written */
> -            return len - ret;
> -        }
> +        return guestfd_fns[gf->type].writefn(ts, cpu, gf, arg1, len);
>      case TARGET_SYS_READ:
>          GET_ARG(0);
>          GET_ARG(1);


--
Alex Benn=C3=A9e

