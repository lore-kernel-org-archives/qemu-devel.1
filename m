Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01548C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2303214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYK5UNlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2303214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04zE-0004YS-U6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j04qP-0001oG-Fj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j04qO-0001Na-2w
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j04qN-0001KY-QP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so3040307wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iAUzFj3fmEhENjTkDryCRd9rZ+G3UllLcbcBlt9mvDg=;
 b=FYK5UNlBLG092vHPnL2fJ2OT3n28yF6P2WjKxI+TIhDHgsFr87Ukf8xRU72sBFz4WI
 SiRW73L2dJgU0z8dVK1xoCpi8ieA0fUq3+IobRz9ZPdemChudgzRM49v5eTbNhJ5c/9X
 gIn9mBEQxbLBuaejcyQpHtZsOby3hx0faTayxopuN+M0g3aoM2R+JXCQs+KJUjB3pSus
 WFBw+IfOfIohh76SlwaNX7sCKfOz3SuHm97IADENzc26DrUF/LXlozfdWiS26/gzjljX
 LgI6baGfIyJsJ6NjN6OaS2TbLXgCA3uTIeyPOU19XVFdHjpSb7OnxraczuT6TBdkEzm0
 OYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iAUzFj3fmEhENjTkDryCRd9rZ+G3UllLcbcBlt9mvDg=;
 b=szIhTGbMHOpG6PPR47v5LJ321H5U7BixTXCSZxgR4Rqz30mIsvSwNIDZF0ZKTpKxTZ
 3pnEBM+4gQ0OOg2HyPbMCOMjG5Zl9i59RnA26OuMS8G3zXcyg39rJmmjcKJLnGb2B/wn
 bxejwjqSmjgz+n+hrh04qHjlaJcnhU858bR2X2zzG/Ew7AxCMSdZDjALTfyessZWBSiJ
 mQ7833yVgN9YFUvcKfKg6XAHIJQJJPBvvpfxHcdXKNkJVJ1yS5xC2mdWySV7M2g3hqSz
 a6GzSgqLIIiAixdF8HliRqRuhSsGP6AFf+U/JVwUvOn6b1inYwB+lC2QSgDjPB2GwQmA
 wajQ==
X-Gm-Message-State: APjAAAV9G+DKjoJr67TbkeQ0DEaVJsc+K/ezKEK5YapBHiZYClxuEEdk
 B3gFpvhsgFvp0RMJxfRaZGliFcPd1etgDGVwLss=
X-Google-Smtp-Source: APXvYqypKGG2AUWeBNdV4tzCj9aRONOC7hnGDUnECtHiU23o3GvnHKXLVqFLAaNlZL9IfDImH7s5hrXOJhefODaF42E=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr4755418wml.55.1581086574561; 
 Fri, 07 Feb 2020 06:42:54 -0800 (PST)
MIME-Version: 1.0
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-76-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-76-git-send-email-imammedo@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Feb 2020 15:42:42 +0100
Message-ID: <CAJ+F1C+4orCn2nf_0e4Z_GpZH6M=24wZPNHGo0yVnB9gimsdVA@mail.gmail.com>
Subject: Re: [PATCH v4 75/80] exec: drop bogus mem_path from
 qemu_ram_alloc_from_fd()
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jan 31, 2020 at 4:45 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> Function will report error that will mention global mem_path,
> which was valid the only if legacy -mem-path was used and
> only in case of main RAM.
>
> However it doesn't work with hostmem backends
> (for example:
> "
>   qemu: -object memory-backend-file,id=3Dram0,size=3D128M,mem-path=3Dfoo:
>     backing store (null) size 0x200000 does not match 'size' option 0x800=
0000
> ")
> and couldn't possibly work in general FD case the function
> is supposed to handle.
>
> Taking in account that main RAM was converted into
> memory-backend-foo object, there is no point in printing
> file name (from inappropriate place) as failing path is
> a part of backend's error message.
>
> Hence drop bogus mem_path usage from qemu_ram_alloc_from_fd(),
> it's a job of its user to add file name to error message if applicable.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

As you pointed out, left over from commit 8d37b030fe "exec: split
file_ram_alloc()"

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> ---
>  exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 9f5421c..d827fac 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2308,9 +2308,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, M=
emoryRegion *mr,
>      size =3D HOST_PAGE_ALIGN(size);
>      file_size =3D get_file_size(fd);
>      if (file_size > 0 && file_size < size) {
> -        error_setg(errp, "backing store %s size 0x%" PRIx64
> +        error_setg(errp, "backing store size 0x%" PRIx64
>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
> -                   mem_path, file_size, size);
> +                   file_size, size);
>          return NULL;
>      }
>
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau

