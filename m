Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8BCC3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E646C2469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EseKrCfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E646C2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7rIp-0004hK-3t
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j7qCq-00076w-0k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j7qCo-0008Q8-RC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:42:11 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j7qCo-0008Pk-MG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:42:10 -0500
Received: by mail-oi1-x243.google.com with SMTP id 2so4690507oiz.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 16:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bOTAZ72S4BxiMUVQGedOTo/Ps06UvEykG+uLwd9EUa4=;
 b=EseKrCfAuuZuX5rsUG+BlbcWBcYrhwAcfoXktNYiO3C0Ie+Vyvt4ve+luMJUEFRv7P
 IwcgWFMNrFTYWc+oGNYS8Jv6B2CyikEGze4JcYbrXTwK8UV+7StHMxi+q6u8E42xNV/k
 mdHZZ0mFMkNqRu3i/fPSUnhQfs+AGcjzM2Fs+DgUWofoKKyRSqf02NH4XqMgoVie7SnX
 rRx+DxG4hruS+q7jwS6gKtXpJZ89MMlG/1zGst7+y6f8A5HP+I9b33Mn+F0+bMzEhEIO
 uQlxj+vwiSHZobUvaIrZ8TNooxC6B845melXXZEg7TTAdSL/6eNQbeGI/mbFN2RrT6E8
 axIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bOTAZ72S4BxiMUVQGedOTo/Ps06UvEykG+uLwd9EUa4=;
 b=c+eXG0MQeumASykLJNEkcrg9gNdXMVBhG+693vDeAyPfs/t557A+3BqFyoCwzqijux
 udiM22/qWtL+OaviyDTv+3m4FXdHxwRcLzm/YL2U+6hs3bz0fnD7YOP716pJr8iRdddP
 1e4wU/EmHHyYp9N4DKY8Y0XfndusEqo5XsxEkRDjw5gZGXFBPBlVY5eiE8zC9AU2bDAW
 pWjR0dVVr6ojg1B74LD9D/sbjR79txega4Kl3VX3btUP6TEFTwSPBxBIZFA/z3S8qmWK
 O5uAcsPgyzFG7B0k5q0KgwQT7XuRlfaW05hIOv3DRlThhybOW74MlLhw2ktwKfVPTBkf
 lRSw==
X-Gm-Message-State: APjAAAXwB8iMUBvQ2G4jjE+gsWGjSb5scsieXj0qzQxiNSeBK3TipUDa
 A4F/l0k6CUDuEE/jNDSQCTAtpKZlXIcjMMlW1KKlXHYHiTY=
X-Google-Smtp-Source: APXvYqxQRgLB/F9XVRV9HyUXo6q5moy/43yeD27t2ZqNMOJLykoXA3CiRtdOkcBw8u2r+01P0GDcpDV88WFidMK+CXU=
X-Received: by 2002:aca:4a0b:: with SMTP id x11mr338077oia.37.1582936929036;
 Fri, 28 Feb 2020 16:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20200221202857.126170-1-yuanzi@google.com>
In-Reply-To: <20200221202857.126170-1-yuanzi@google.com>
From: Lirong Yuan <yuanzi@google.com>
Date: Fri, 28 Feb 2020 16:41:58 -0800
Message-ID: <CADjx4CLVufciu=Qtte7x6+JDDWeigzQ3XoepFQFeguJtfcHfYg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add AT_EXECFN and AT_EXECFD auxval
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
X-Mailman-Approved-At: Fri, 28 Feb 2020 20:51:37 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 12:29 PM Lirong Yuan <yuanzi@google.com> wrote:
>
> This change adds the support for AT_EXECFN and AT_EXECFD auxval.
>
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>  linux-user/elfload.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3080a1635..7e0f3042f1 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1568,7 +1568,7 @@ struct exec
>                                   ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
>  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
>
> -#define DLINFO_ITEMS 15
> +#define DLINFO_ITEMS 17
>
>  static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
>  {
> @@ -1888,11 +1888,14 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
>      return sp;
>  }
>
> -static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
> +static abi_ulong create_elf_tables(struct linux_binprm *bprm,
>                                     struct elfhdr *exec,
>                                     struct image_info *info,
>                                     struct image_info *interp_info)
>  {
> +    abi_ulong p = bprm->p;
> +    int argc = bprm->argc;
> +    int envc = bprm->envc;
>      abi_ulong sp;
>      abi_ulong u_argc, u_argv, u_envp, u_auxv;
>      int size;
> @@ -2032,6 +2035,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
>      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
>      NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
> +    NEW_AUX_ENT(AT_EXECFN, info->file_string);
> +    NEW_AUX_ENT(AT_EXECFD, bprm->fd);
>
>  #ifdef ELF_HWCAP2
>      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> @@ -2870,8 +2875,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>  #endif
>      }
>
> -    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
> -                                info, (elf_interpreter ? &interp_info : NULL));
> +    bprm->p = create_elf_tables(bprm, &elf_ex, info,
> +                                (elf_interpreter ? &interp_info : NULL));
>      info->start_stack = bprm->p;
>
>      /* If we have an interpreter, set that as the program's entry point.
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Friendly ping~

Link to the page for the patch on patchwork:
http://patchwork.ozlabs.org/patch/1242331/

