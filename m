Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB4C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D57E20693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fwk8fgb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D57E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NZa-0001Dm-Bp
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NVs-0006WM-4B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NVr-0000wk-07
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8NVq-0000wS-QO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:43:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so23378554wrx.10
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+ud2toHVyaidm/fyL8X5uXkJcHv8qZjq/K3D/NLbDKs=;
 b=Fwk8fgb5sH3AIe8IEfHZsUT4ghGwuK+qyz+Z3fts4bhWCyWuW88TAywmaGVQa/xkYv
 Rei9OlRdQExxYS8I8oL2wvtp1Iol19z9EBSXBHe/leb8P3ms7RcOZobA4rtvHCamVvyy
 uLIVjqC+3yLuiHqKMm/vxwM1WadxMO9fMYz4JM4WxP/6y/y2EBuhzsAWYT1izd1u7G8f
 6vNxvcA8qHO40q05krd28pyXEsC1ami7baiB2Ds1puoBw2W12a34QjYQC0cr2ISyrXf0
 bpkZ1tLHfCxuIJE85RgM9isgp8X+Bm0BktetwKkD51x8Xk7gZyZlKTr8u0bH8JJPzFkT
 Z7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+ud2toHVyaidm/fyL8X5uXkJcHv8qZjq/K3D/NLbDKs=;
 b=FqzwdI0LQgbxR4Fi+Mp52uFwj9BZqNi8CVuCdQKww7VzVzqI7CyrHMuDlVguHkwy3I
 jiTRSXAvW2RYux0zwAaf3s+Pll8e433YQiAdkWk7EtC26Qi0ZowKFaNiPLPghO6GRKvK
 9u3g+jbum43ZlBYEdnO0zsmzaYEiObgSrOBCOzcLX4YeTZTja9nnHkAB0tY9LlkTjTbm
 NrMfZPFKhMvmgg5fe5RfkJB5oqd+JcXiNo+lZiLzHuaTZzvyfUF05pcyrPIwiwAv5aAp
 LVd6pFfokIREw8QHFpTrC7c3xChFH5Wc2YWAOFq9oNX1zhNlNVIVdJPHa7fSCYF6V2Xv
 coCQ==
X-Gm-Message-State: APjAAAUZa+E1wU4uDPVOSlTgq1qAqL0ZuUrVT3bBXFsobHabXeXC19Dh
 51Dlqd7Dby64sDlHHYquA0nAWg==
X-Google-Smtp-Source: APXvYqwjC5tClUeEi7VQ0SS39vRRNiLZ82Glh5IPrfo+pqnoDm9EcvYhbq8dp+6p+gFzyWP/l3GCUg==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr29493380wrr.322.1568288625801; 
 Thu, 12 Sep 2019 04:43:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm9516261wmf.42.2019.09.12.04.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:43:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A19EB1FF87;
 Thu, 12 Sep 2019 12:43:44 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-11-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-11-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:43:44 +0100
Message-ID: <87d0g5zqmn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 10/13] target/arm/arm-semi:
 Factor out implementation of SYS_FLEN
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Factor out the implementation of SYS_FLEN via the new
> function tables.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index c548ce849e7..f9019b00b8d 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -352,6 +352,7 @@ typedef uint32_t sys_readfn(TaskState *ts, ARMCPU *cp=
u, GuestFD *gf,
>  typedef uint32_t sys_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
>  typedef uint32_t sys_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
>                              target_ulong offset);
> +typedef uint32_t sys_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
>
>  static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
> @@ -417,6 +418,16 @@ static uint32_t host_seekfn(TaskState *ts, ARMCPU *c=
pu, GuestFD *gf,
>      return 0;
>  }
>
> +static uint32_t host_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
> +{
> +    struct stat buf;
> +    uint32_t ret =3D set_swi_errno(ts, fstat(gf->hostfd, &buf));
> +    if (ret =3D=3D (uint32_t)-1) {
> +        return -1;
> +    }
> +    return buf.st_size;
> +}
> +
>  static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
>  {
>      return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> @@ -450,12 +461,19 @@ static uint32_t gdb_seekfn(TaskState *ts, ARMCPU *c=
pu, GuestFD *gf,
>                             gf->hostfd, offset);
>  }
>
> +static uint32_t gdb_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
> +                           gf->hostfd, arm_flen_buf(cpu));
> +}
> +
>  typedef struct GuestFDFunctions {
>      sys_closefn *closefn;
>      sys_writefn *writefn;
>      sys_readfn *readfn;
>      sys_isattyfn *isattyfn;
>      sys_seekfn *seekfn;
> +    sys_flenfn *flenfn;
>  } GuestFDFunctions;
>
>  static const GuestFDFunctions guestfd_fns[] =3D {
> @@ -465,6 +483,7 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>          .readfn =3D host_readfn,
>          .isattyfn =3D host_isattyfn,
>          .seekfn =3D host_seekfn,
> +        .flenfn =3D host_flenfn,
>      },
>      [GuestFDGDB] =3D {
>          .closefn =3D gdb_closefn,
> @@ -472,6 +491,7 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>          .readfn =3D gdb_readfn,
>          .isattyfn =3D gdb_isattyfn,
>          .seekfn =3D gdb_seekfn,
> +        .flenfn =3D gdb_flenfn,
>      },
>  };
>
> @@ -657,16 +677,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, -1);
>          }
>
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
> -                                   gf->hostfd, arm_flen_buf(cpu));
> -        } else {
> -            struct stat buf;
> -            ret =3D set_swi_errno(ts, fstat(gf->hostfd, &buf));
> -            if (ret =3D=3D (uint32_t)-1)
> -                return -1;
> -            return buf.st_size;
> -        }
> +        return guestfd_fns[gf->type].flenfn(ts, cpu, gf);
>      case TARGET_SYS_TMPNAM:
>          qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __fun=
c__);
>          return -1;


--
Alex Benn=C3=A9e

