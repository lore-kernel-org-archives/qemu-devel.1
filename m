Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11C8C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFDC206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=phystech-edu.20150623.gappssmtp.com header.i=@phystech-edu.20150623.gappssmtp.com header.b="Gcr/mDzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFDC206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phystech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9vjd-0005nT-MM
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <viktor.prutyanov@phystech.edu>) id 1j9viC-0004iS-8q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <viktor.prutyanov@phystech.edu>) id 1j9vi9-0000JJ-Li
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:59:10 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1j9vi9-0000Fv-2S
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:59:09 -0500
Received: by mail-lj1-x244.google.com with SMTP id e18so7310896ljn.12
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phystech-edu.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=6ctMZbT0iX5dwuANiokz+Sby/9fJ8AvTdWSX4ROvYbg=;
 b=Gcr/mDzZuAsJurFgzb/OEw0IXr8qAmLvjqRk41k+Cg3KKIjbZAbjlcxElwJE3zY2M2
 5EEjmZ2hwASG4IXVBAWhZn0YaoDL7vAhocHD/CGpQIllYkvr/6vGBvmKhq8YjbWi4i3B
 fHaLULRf60xBfuwggFU+vgGuGpqtLdGzp65Zlb6QsScFiVpmJMdVG+LEiFQyEKEqjY+f
 Qqmj7GWlzzV22eSNsaEEzummn6M9vYDSxQMiv7eMQTO+Wdc232JesKX4daL/Niamp/qi
 3vmimgdgJ2RuB0wUCzG8sqqSQ339Bc0DNW48ya1cbHUSGDDzn77Hibc8E7tAa2Ye3fTJ
 Ohyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=6ctMZbT0iX5dwuANiokz+Sby/9fJ8AvTdWSX4ROvYbg=;
 b=FHrKMvmWQv9zvIGHHMABSnPbPJh79M5Edny19jyFzq1HfhRiJBGDRu4rBU6/arHzuo
 loSbafETQaI5EjntABWQ/ZNuqAafaGtqc5/N3n2RAoz8OhGQzI7S/zT2qRAqRovkWPEe
 vhUooMnCAtPnCPtNzfcjWQOyZD4AF50bqDHP+yW41kUBRAMGQ2n4yPfORwJ4OGm7ORus
 ycIfTxBUQ/mGMuUw3n0CXw7bH4Fr5LWBWdL0u5p+IF+br89/u6cnCepvvHfAAUM1arMN
 BnKbHSEHJB1U1iflbCwKsFALShS/WAJ97Nw8hQJQGc/1ZllnI/aNy7Crw32chczQy894
 cC4g==
X-Gm-Message-State: ANhLgQ18Q7fi+L1UcYtlzNNjPQ2pxDQmWOlcf/iLRjVbdX4til/niZ2O
 HiE5fxfho/XBqRl7EO/ELGC1oQ==
X-Google-Smtp-Source: ADFU+vvYP15BC4RlolCUBDWr9rDG22YG6kSKpnGmFbIoJmfPEasONKjyo0NgkhBDVI5KqlXv7/oxBQ==
X-Received: by 2002:a2e:9110:: with SMTP id m16mr6072280ljg.42.1583434746956; 
 Thu, 05 Mar 2020 10:59:06 -0800 (PST)
Received: from localhost ([93.175.11.132])
 by smtp.gmail.com with ESMTPSA id j6sm15718532lfk.88.2020.03.05.10.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 10:59:06 -0800 (PST)
Date: Thu, 5 Mar 2020 21:59:02 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH] contrib/elf2dmp: prevent uninitialized warning
Message-ID: <20200305215902.24bbe6ce@phystech.edu>
In-Reply-To: <20200207041601.89668-1-kuhn.chenqun@huawei.com>
References: <20200207041601.89668-1-kuhn.chenqun@huawei.com>
Organization: MIPT
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 12:16:01 +0800
<kuhn.chenqun@huawei.com> wrote:

> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Fix compilation warnings:
> contrib/elf2dmp/main.c:66:17: warning: =E2=80=98KdpDataBlockEncoded=E2=80=
=99 may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>          block =3D __builtin_bswap64(block ^ kdbe) ^ kwa;
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> contrib/elf2dmp/main.c:78:24: note: =E2=80=98KdpDataBlockEncoded=E2=80=99=
 was
> declared here uint64_t kwn, kwa, KdpDataBlockEncoded;
>                         ^~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  contrib/elf2dmp/main.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index 9a2dbc2902..203b9e6d04 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -76,6 +76,7 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t
> KernBase, struct pdb_reader *pdb, DBGKD_DEBUG_DATA_HEADER64 kdbg_hdr;
>      bool decode =3D false;
>      uint64_t kwn, kwa, KdpDataBlockEncoded;
> +    uint64_t KiWaitNever, KiWaitAlways;
> =20
>      if (va_space_rw(vs,
>                  KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64,
> Header), @@ -84,21 +85,19 @@ static KDDEBUGGER_DATA64
> *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb, return NULL;
>      }
> =20
> -    if (memcmp(&kdbg_hdr.OwnerTag, OwnerTag, sizeof(OwnerTag))) {
> -        uint64_t KiWaitNever, KiWaitAlways;
> -
> -        decode =3D true;
> +    if (!SYM_RESOLVE(KernBase, pdb, KiWaitNever) ||
> +            !SYM_RESOLVE(KernBase, pdb, KiWaitAlways) ||
> +            !SYM_RESOLVE(KernBase, pdb, KdpDataBlockEncoded)) {
> +        return NULL;
> +    }
> =20
> -        if (!SYM_RESOLVE(KernBase, pdb, KiWaitNever) ||
> -                !SYM_RESOLVE(KernBase, pdb, KiWaitAlways) ||
> -                !SYM_RESOLVE(KernBase, pdb, KdpDataBlockEncoded)) {
> -            return NULL;
> -        }
> +    if (va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
> +            va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0)) {
> +        return NULL;
> +    }
> =20
> -        if (va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
> -                va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0))
> {
> -            return NULL;
> -        }
> +    if (memcmp(&kdbg_hdr.OwnerTag, OwnerTag, sizeof(OwnerTag))) {
> +        decode =3D true;
> =20
>          printf("[KiWaitNever] =3D 0x%016"PRIx64"\n", kwn);
>          printf("[KiWaitAlways] =3D 0x%016"PRIx64"\n", kwa);

Hi!

I suppose the problem is in your compiler, because kdbg_decode() is
only used when KdpDataBlockEncoded is already initialized by
SYM_RESOLVE().=20

--=20
Viktor Prutyanov

