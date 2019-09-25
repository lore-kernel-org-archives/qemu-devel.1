Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA10DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A425021D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhWcOIZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A425021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD90G-00051I-Re
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD8ta-0007Do-TG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD8tZ-0006RX-0x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:07:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD8tY-0006Qm-IC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569424075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AR141VPGaTgjlKgQg5iHGwptln2o8PUGUGUagOuiYYQ=;
 b=OhWcOIZOCnBHr71oG5P/VhgMk6PgDvltgozzQ/OBZWF8cjeNzEBtarftR/P1kUXdp7eUKJ
 bqLbLk3I/Gs0q0GEZYKzt5nGSq8aMQcITq8KBwHwiCwiQsnGdkt0h31rO+uIE6FdW+Tle6
 b/0eKJ1D0S1xRjUDSxyNH29JZjwgeNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-x3SEec-xPLW6TBv3-4vQlA-1; Wed, 25 Sep 2019 11:07:52 -0400
Received: by mail-wm1-f70.google.com with SMTP id c188so2195523wmd.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+7wPetL7nBirW3u8DwBGpxa4+II+BRyVzUr5zPHp+4I=;
 b=L6ElAGewOuBQgjhzLWZVW+WXthlv6at109nqg47OSI8gezAI7obb9c7rUPOwnowDkw
 0xFibdvy8pL1oDPtksfUbJBjMa6e/fr6aJzpSqSsEIECGYkRUA/5N2p8hFvWYSY7ER+m
 7I69g8zJPM2Ge3qm8NRFBEosPhGymjy/Wv+OaCnhif8g4D9vBKZo7rhHNIsFDLO56InU
 d70BbcIRgSy/XweN1UwX/+5waw1l1GPRR528w80vZwxo4ZmJW+yYpCYWEZ1hYNRU2vxH
 4tZFaHVWzlvuAXUeMuXYGFmpWTySmPAY0N18AxiKFK6uiNi49OggTlE+orP9vNpIwszX
 4u9w==
X-Gm-Message-State: APjAAAVf8mgOQ+r0Qiss0phM2PWrDxzyXj6OQ5HbtCHaYU5rpjo9w2iy
 p8JDA05t65ekKnxYOpQtKOPDHq83J1qJnlL92ILmaWh1QA6+ecjL7w1HVEdec2WrTXiHKiUziw8
 tdIPx26NhBmZfnfo=
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr8280806wma.102.1569424071101; 
 Wed, 25 Sep 2019 08:07:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMJzHBQjiAfvhqRRjEjnD/we0t++YsY4rSZ/VjyejDqOP3F5w5S5jw31GZ+h/lu3oLDtCFbg==
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr8280778wma.102.1569424070871; 
 Wed, 25 Sep 2019 08:07:50 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id c10sm8761315wrf.58.2019.09.25.08.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 08:07:49 -0700 (PDT)
Subject: Re: [PATCH v2 02/20] target/mips: Clean up internal.h
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <305a6c4f-9688-535e-18a5-5bd650167828@redhat.com>
Date: Wed, 25 Sep 2019 17:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569415572-19635-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: x3SEec-xPLW6TBv3-4vQlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/internal.h | 60 +++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>=20
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 685e8d6..3f435b5 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -1,4 +1,5 @@
> -/* mips internal definitions and helpers
> +/*
> + * MIPS internal definitions and helpers
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
> @@ -9,8 +10,10 @@
> =20
>  #include "fpu/softfloat-helpers.h"
> =20
> -/* MMU types, the first four entries have the same layout as the
> -   CP0C0_MT field.  */
> +/*
> + * MMU types, the first four entries have the same layout as the
> + * CP0C0_MT field.
> + */
>  enum mips_mmu_types {
>      MMU_TYPE_NONE,
>      MMU_TYPE_R4000,
> @@ -160,9 +163,11 @@ static inline bool cpu_mips_hw_interrupts_enabled(CP=
UMIPSState *env)
>          !(env->CP0_Status & (1 << CP0St_EXL)) &&
>          !(env->CP0_Status & (1 << CP0St_ERL)) &&
>          !(env->hflags & MIPS_HFLAG_DM) &&
> -        /* Note that the TCStatus IXMT field is initialized to zero,
> -           and only MT capable cores can set it to one. So we don't
> -           need to check for MT capabilities here.  */
> +        /*
> +         * Note that the TCStatus IXMT field is initialized to zero,
> +         * and only MT capable cores can set it to one. So we don't
> +         * need to check for MT capabilities here.
> +         */
>          !(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_IXMT));
>  }
> =20
> @@ -177,14 +182,18 @@ static inline bool cpu_mips_hw_interrupts_pending(C=
PUMIPSState *env)
>      status =3D env->CP0_Status & CP0Ca_IP_mask;
> =20
>      if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
> -        /* A MIPS configured with a vectorizing external interrupt contr=
oller
> -           will feed a vector into the Cause pending lines. The core tre=
ats
> -           the status lines as a vector level, not as indiviual masks.  =
*/
> +        /*
> +         * A MIPS configured with a vectorizing external interrupt contr=
oller
> +         * will feed a vector into the Cause pending lines. The core tre=
ats
> +         * the status lines as a vector level, not as indiviual masks.
> +         */
>          r =3D pending > status;
>      } else {
> -        /* A MIPS configured with compatibility or VInt (Vectored Interr=
upts)
> -           treats the pending lines as individual interrupt lines, the s=
tatus
> -           lines are individual masks.  */
> +        /*
> +         * A MIPS configured with compatibility or VInt (Vectored Interr=
upts)
> +         * treats the pending lines as individual interrupt lines, the s=
tatus
> +         * lines are individual masks.
> +         */
>          r =3D (pending & status) !=3D 0;
>      }
>      return r;
> @@ -275,12 +284,14 @@ static inline int mips_vpe_active(CPUMIPSState *env=
)
>          active =3D 0;
>      }
> =20
> -    /* Now verify that there are active thread contexts in the VPE.
> -
> -       This assumes the CPU model will internally reschedule threads
> -       if the active one goes to sleep. If there are no threads availabl=
e
> -       the active one will be in a sleeping state, and we can turn off
> -       the entire VPE.  */
> +    /*
> +     * Now verify that there are active thread contexts in the VPE.
> +     *
> +     * This assumes the CPU model will internally reschedule threads
> +     * if the active one goes to sleep. If there are no threads availabl=
e
> +     * the active one will be in a sleeping state, and we can turn off
> +     * the entire VPE.
> +     */
>      if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
>          /* TC is not activated.  */
>          active =3D 0;
> @@ -326,7 +337,8 @@ static inline void compute_hflags(CPUMIPSState *env)
>      if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
>          !(env->CP0_Status & (1 << CP0St_ERL)) &&
>          !(env->hflags & MIPS_HFLAG_DM)) {
> -        env->hflags |=3D (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU=
;
> +        env->hflags |=3D (env->CP0_Status >> CP0St_KSU) &
> +                       MIPS_HFLAG_KSU;
>      }
>  #if defined(TARGET_MIPS64)
>      if ((env->insn_flags & ISA_MIPS3) &&
> @@ -403,10 +415,12 @@ static inline void compute_hflags(CPUMIPSState *env=
)
>              env->hflags |=3D MIPS_HFLAG_COP1X;
>          }
>      } else if (env->insn_flags & ISA_MIPS4) {
> -        /* All supported MIPS IV CPUs use the XX (CU3) to enable
> -           and disable the MIPS IV extensions to the MIPS III ISA.
> -           Some other MIPS IV CPUs ignore the bit, so the check here
> -           would be too restrictive for them.  */
> +        /*
> +         * All supported MIPS IV CPUs use the XX (CU3) to enable
> +         * and disable the MIPS IV extensions to the MIPS III ISA.
> +         * Some other MIPS IV CPUs ignore the bit, so the check here
> +         * would be too restrictive for them.
> +         */
>          if (env->CP0_Status & (1U << CP0St_CU3)) {
>              env->hflags |=3D MIPS_HFLAG_COP1X;
>          }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


