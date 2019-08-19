Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E17C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 07:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72BF2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 07:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOza0JTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72BF2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbr1-000235-S3
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 03:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hzbqF-0001dD-On
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 03:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hzbqE-0000Ue-LK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 03:12:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hzbqE-0000ST-Cz
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 03:12:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id i63so616107wmg.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TgnyLPTiSdyp7pc/bceP/UZ9NfBgChQ19c6fAWjQ534=;
 b=SOza0JTYbJ1SRs6NhbPrkTYssjoY46YuhkcAtp4MuvV9M6NNIjCwA7L9fANAsNqiLy
 aLR9Xp86vKpfrChHPBmu0EUC7Iae6pN/VOHBDKq/tx/6nPe/UbV+6PM1/C1dWpyLAVRl
 wQrCt16T0XoYln8SqkBss1Y8hK43Qpk9bwPgnq3bB1nSzozVBYvnBUGZfo0FtbuXgkzf
 kEhKxfJ8K6caWRbHVxt8FyO9QLcOWyRK+6o8jfHbJ2dL5pBdd81x8IM3enmmnQKGjP/1
 evAweki2nVdpylzbKVetMqo4YWLm9BkxXIIswiT+w+oee2ag3RGkItb0GwMeLMuExgYd
 DTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TgnyLPTiSdyp7pc/bceP/UZ9NfBgChQ19c6fAWjQ534=;
 b=m7Wlf3hVbSV8TM+hAsiQTH/qjEVyq++XQhpgixfmD2syQnGBGgDP4rjkIO2XbSZA2j
 TyzBseF0DukpVFM5bCeirBhBNoqpw9Cd02Har6k+Yztde1aadN53rQFv/xwIOKXBRuli
 erqt1Vg0LGJUv0f83r9GkPMw9vp59QjJowki7xHT8BIYEdksZZk1Es8WP2I8Ml0MDeI0
 8cfS2PdeAZnju4QSv4jmXYTZrxLxw4ogtHSzB8j34AJGehf6Yw6TT6siYuodIbomdR90
 nHgNf3nCp+LXcw5mzXWoUcg1uBEsr10mAbyLcF2iP4pRw5JBLesFPuKnWQFFkoDTQ2sn
 7VYw==
X-Gm-Message-State: APjAAAWmzfru+cSEJ0wCiBXptZ4OohC12fNRoKCsHynBnkOtVTBtD91k
 Tf9SQ/uNlIYuycbNF6k982hMZ5SQSIanUEc6MW8=
X-Google-Smtp-Source: APXvYqzec3Z21UDpn4IwZmvmQMZy4WZZ0jjfO9sAuECf+1U0zCFX+TuwhSHHkuAO0wAk0lgle5Tq74xBr39doA6X1kU=
X-Received: by 2002:a1c:f702:: with SMTP id v2mr19196763wmh.114.1566198752767; 
 Mon, 19 Aug 2019 00:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190816211049.57317-1-scw@google.com>
In-Reply-To: <20190816211049.57317-1-scw@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 19 Aug 2019 11:12:20 +0400
Message-ID: <CAJ+F1CLGwaZiZUWFMSQJf8NvWhg6gzp1t4Gq=F4FHenHe=H9eA@mail.gmail.com>
To: Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] linux-user: add memfd_create
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
Cc: arunkaly@google.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 17, 2019 at 1:28 AM Shu-Chun Weng via Qemu-devel
<qemu-devel@nongnu.org> wrote:
>
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 11 +++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index d551c28b68..975b6bdb77 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -32,6 +32,10 @@
>  #define MFD_HUGE_SHIFT 26
>  #endif
>
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
> +int memfd_create(const char *name, unsigned int flags);
> +#endif
> +
>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error **=
errp);
>  bool qemu_memfd_alloc_check(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..b506c1f40e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/memfd.h"
>  #include <elf.h>
>  #include <endian.h>
>  #include <grp.h>
> @@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>          /* PowerPC specific.  */
>          return do_swapcontext(cpu_env, arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_memfd_create
> +    case TARGET_NR_memfd_create:
> +        p =3D lock_user_string(arg1);
> +        if (!p) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret =3D get_errno(memfd_create(p, arg2));
> +        unlock_user(p, arg1, 0);
> +        return ret;
> +#endif
>
>      default:
>          qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
> diff --git a/util/memfd.c b/util/memfd.c
> index 00334e5b21..4a3c07e0be 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -35,7 +35,7 @@
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
>
> -static int memfd_create(const char *name, unsigned int flags)
> +int memfd_create(const char *name, unsigned int flags)
>  {
>  #ifdef __NR_memfd_create
>      return syscall(__NR_memfd_create, name, flags);
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
>


--=20
Marc-Andr=C3=A9 Lureau

