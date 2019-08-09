Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D471C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA832085A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrZ5TpXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA832085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw21h-0007Sv-51
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw21G-00073J-UP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw21D-0007Gu-Gx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:21:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hw21D-0007GW-8t
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:21:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id o101so130642264ota.8
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8QPqTSjr/rWA52AnA93YLdu2PUshWGzNCQNrtGLvUc4=;
 b=IrZ5TpXQmwMmnDGBvTXESIewS729PfAVjf1g6ym475/7+MO0kXBmHsw1uXnymfbyPr
 2NqeXApEsvThaLcA+6CUsFVklSUoHN56wRfvApJjDpL7XirmJrjEkPUL1Vhdeu9SCo9q
 zba+C6PlPfhCShtZIZeAuaNAz6VQlSEimph8kkSAesympdvoXqrfmgFTUe5QdwDyeZl6
 whcty1diem7pwomLANysLF9/1CRCio9RGyopb+3m1Yw6VvBFO7tlAFeRPXxaWUdHP5if
 yF1VeKV1hGQAu7kLG1mn0iX0Jj/WKuFzSxPzm5XDjyKnES1CtpJyoZBV6keNowOytGqw
 rZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8QPqTSjr/rWA52AnA93YLdu2PUshWGzNCQNrtGLvUc4=;
 b=rfJufKyge2nxuJhV4Scwnr3qKnNd8l7K6qaOvc++bIHFQ4IWG4T7aApzb+iA3LuTfy
 TQTTxKRB6QEytHcPXn1i3SsmuL0iktRn5vkyUGOt7HDGTGo0EEIfoSkKM7b5kmhntHJa
 Dl8BfIjnCVeITv6vbPpD3z8lrxnut1NsR9IytOqJhF1x5QpsOwxI8JYY0lNyfPWDqmfI
 VMvQoX+covZ4Y1ND+I3D13nlSV5ghlTWM1ixpngTXCkzI7E9KNY3Pv+qD796Eu9TyyUP
 Xk44cEp1RsBVL+r8QLxFBjpDMLj0bpL/YQH9PFkJzB5JZBUG4htHvJW0mbYsWfycmkNG
 Mmfg==
X-Gm-Message-State: APjAAAUNdOoxILxT5c45KppWlkkwxLg9CeNvAnHOYuxeKXlXuGNG9cmx
 YEFRzHvkUM31zlOqf24dtmVJtxIDdPw2JB4w0UE=
X-Google-Smtp-Source: APXvYqzxXyAwxd+oB9V1MwGkMAyWv8DQBHxbf7/6XGcZsonVIcd3q9ng2yS6vZPJV1AxGPfnfsTD2VVkuTRVmnJc6S4=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr2526272oti.121.1565346066405; 
 Fri, 09 Aug 2019 03:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190809091940.1223-1-alex.bennee@linaro.org>
 <20190809091940.1223-6-alex.bennee@linaro.org>
In-Reply-To: <20190809091940.1223-6-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 9 Aug 2019 12:20:55 +0200
Message-ID: <CAL1e-=jTTnjYX6FwysiBQfRMiixy7ijJR9=gAYNW4PSNv=B4Wg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/mips: rationalise softfloat
 includes
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 11:23 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> We should avoid including the whole of softfloat headers in cpu.h and
> explicitly include it only where we will be calling softfloat
> functions. We can use the -types.h in cpu.h for the few bits that are
> global. We also move the restore_snan_bit_mode into internal.h and
> include -helpers.h there.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - move restore_snan_bit_mode to internal.h
> ---
>

OK, yes, this is cleaner compared to the current code organization, and
also cleaner than v1. Thanks.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

 linux-user/mips/cpu_loop.c | 1 +
>  target/mips/cpu.h          | 8 +-------
>  target/mips/internal.h     | 7 +++++++
>  target/mips/msa_helper.c   | 1 +
>  target/mips/op_helper.c    | 1 +
>  5 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 0ba894fa7aa..39915b3fde2 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -22,6 +22,7 @@
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
>  #include "elf.h"
> +#include "internal.h"
>
>  # ifdef TARGET_ABI_MIPSO32
>  #  define MIPS_SYS(name, args) args,
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 21c0615e020..d235117dab3 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -5,7 +5,7 @@
>
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
>  #include "mips-defs.h"
>
>  #define TCG_GUEST_DEFAULT_MO (0)
> @@ -1195,12 +1195,6 @@ void itc_reconfigure(struct MIPSITUState *tag);
>  /* helper.c */
>  target_ulong exception_resume_pc(CPUMIPSState *env);
>
> -static inline void restore_snan_bit_mode(CPUMIPSState *env)
> -{
> -    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) =
=3D=3D
> 0,
> -                        &env->active_fpu.fp_status);
> -}
> -
>  static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong
> *pc,
>                                          target_ulong *cs_base, uint32_t
> *flags)
>  {
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index b2b41a51ab4..49a7a7d8f56 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -7,6 +7,7 @@
>  #ifndef MIPS_INTERNAL_H
>  #define MIPS_INTERNAL_H
>
> +#include "fpu/softfloat-helpers.h"
>
>  /* MMU types, the first four entries have the same layout as the
>     CP0C0_MT field.  */
> @@ -226,6 +227,12 @@ static inline void restore_flush_mode(CPUMIPSState
> *env)
>                        &env->active_fpu.fp_status);
>  }
>
> +static inline void restore_snan_bit_mode(CPUMIPSState *env)
> +{
> +    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) =
=3D=3D
> 0,
> +                        &env->active_fpu.fp_status);
> +}
> +
>  static inline void restore_fp_status(CPUMIPSState *env)
>  {
>      restore_rounding_mode(env);
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a5a86572b4a..f24061e2af7 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -22,6 +22,7 @@
>  #include "internal.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
>
>  /* Data format min and max values */
>  #define DF_BITS(df) (1 << ((df) + 3))
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 9e2e02f8586..f88a3ab9043 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -25,6 +25,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "sysemu/kvm.h"
> +#include "fpu/softfloat.h"
>
>
>  /***********************************************************************=
******/
>  /* Exceptions processing helpers */
> --
> 2.20.1
>
>
>
