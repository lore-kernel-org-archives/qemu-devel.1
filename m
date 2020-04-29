Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FDC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA99120731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw4eV43T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA99120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiIO-0003sJ-VU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTiHT-0002cm-9c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTiGm-0007II-SJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:41:23 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jTiGm-0007Hb-FZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:40:40 -0400
Received: by mail-lf1-x143.google.com with SMTP id r17so958222lff.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B2NgeWWOeliBEjTQ/Jt1BYYwrZptCmWauQnrBKJMdZQ=;
 b=Pw4eV43TuOJfMeOmwUFEuyTGkdUyifVksydMWe7PJSycLxpAjhyNeZkH0Ig1EDb7jW
 ZCCEasbceMVi/Qx/JPNq6vUN3bX0FjWAFNpl72jR/NIocXTdVmZGN0UUQ9ytMQtObDdR
 PcGxBAWpThwIyI3u0rsSVb6D41WI5ClIMD5a/MVa0yhYrFmbevhHyEFUM1gWGjF4c4yw
 1THhOs4nTYQ7jGjmP6szq900hrWrPiDTfnjYRI4mbCJs5hHG5zfXaY2tRwp+f6RORV8V
 xjVJNCvgUHi15Y0ne+fmqelNtagKGYLmF9QdGhOZZLaFgztNpjGWUhfLiOV/xhLSuDZq
 VxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B2NgeWWOeliBEjTQ/Jt1BYYwrZptCmWauQnrBKJMdZQ=;
 b=f2qoGNNRd3UzJN0OJC4RjoWlBdMz3S5aAW9bd4qOzZ0XMlS0Y1tL/t3NK+0+TZhKbH
 D5YpC/abEeSZSX42fKsjv/uA0fCXUV9CW9+tf7QjAuXvDjOGxZBIMQuUg+7/GWl1CHQi
 6BvGDyMnPhpSAYjCYzqjn22WjxDEt5bQ+WVSpEhuet6+WTyCDFP6zA/75rykcBPSLUV2
 2zH2W6JJZgleAVcpjpX6QkHO8hX3i8ks11UIpe6kQU6yoSgCAFANIOd14aNdm36mrWkw
 qCRG2Oy2J/hcP3qJek5B259AWzjAzZmBWF6p9K0LV37VW2YePmPLRz6jdmQY24ijoAZf
 v2CA==
X-Gm-Message-State: AGi0PuYyMA0VadZfkN6jEEvCZ+7Yi4w7AHa22dUEYRJBabNreFWDs77M
 p6RkCNBPAAQZBDABVjyhh7hTakqyBW4/dDqtnes=
X-Google-Smtp-Source: APiQypLjBNdRZEsaPq48Nqoh9x74DG5PssihBC5hSCEGJSJ8nDiPInStC835Oo6V1ZE4sH4wKhUcQ7TBr70mIXYQ0I0=
X-Received: by 2002:ac2:58f6:: with SMTP id v22mr21341927lfo.146.1588149638252; 
 Wed, 29 Apr 2020 01:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200429082916.10669-1-f4bug@amsat.org>
 <20200429082916.10669-2-f4bug@amsat.org>
In-Reply-To: <20200429082916.10669-2-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Wed, 29 Apr 2020 16:48:08 +0800
Message-ID: <CABDp7VoyvX2vD6awEC-GwnEu8SW=pMPPR7mrfKCSzamrnomPKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/mips/mips_int: De-duplicate KVM interrupt delivery
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Apr 29, 2020 at 4:30 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Refactor duplicated code in a single place.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_int.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 796730b11d..4a1bf846da 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque, int ir=
q, int level)
>
>      if (level) {
>          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
> -
> -        if (kvm_enabled() && irq =3D=3D 2) {
> -            kvm_mips_set_interrupt(cpu, irq, level);
> -        }
> -
>      } else {
>          env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
> +    }
Since the if-else has become one line, so can we remove { and } here?

>
> -        if (kvm_enabled() && irq =3D=3D 2) {
> -            kvm_mips_set_interrupt(cpu, irq, level);
> -        }
> +    if (kvm_enabled() && irq =3D=3D 2) {
> +        kvm_mips_set_interrupt(cpu, irq, level);
>      }
>
>      if (env->CP0_Cause & CP0Ca_IP_mask) {
> --
> 2.21.1
>
>


--=20
Huacai Chen

