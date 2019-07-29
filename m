Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E3C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3638C206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxlJOlLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3638C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5fo-0006BZ-IM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs5fN-0005mO-Gh
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs5fM-0005Nk-58
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:26:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hs5fL-0005LH-Vp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:26:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id j19so24032849otq.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eVYifojs1/K+bqVEZaKx4B5wvlPkpP2+BLgVTCEn3OM=;
 b=VxlJOlLOnrOZ3y1D9fFANnxqsXPCWp36LoiYE5lstijI3CL4a9vV7DyiKY3Cmc2gdp
 Pa+WKmxzRz2wii013//tYKZCcu795iQNSS6d1b7eDU4W57b94Ij6Y/r7Io1BiTXUZg7m
 YiVdFKsMktC+VeYaXnPo7YGDsjgyFdCzvMjYPLregOOeplS9kRZT6yOwtFgcJ84IT8oZ
 zfqHG+knrfe7Kzd+D0MUn3l1A/x4QHsgA9bOXa0jf8PDZoPW8Qu1f8cUG/wkIGQMLNY1
 exIUbwUg53kdAvOmE4wOkTrqMEr08F6lbsOvxhg4ZpFMcPGg3BKbQ7IPXrZw8Rby9Luq
 uB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eVYifojs1/K+bqVEZaKx4B5wvlPkpP2+BLgVTCEn3OM=;
 b=ArK+HV/WnpmtxYwCyi762UiRVHsJvKqIUGqT1RqyKVGF/A5uoVnxqkral+dQE8pp20
 aVWvFQu4/cH683kTmcazsmrO1IlnwFfSlI2xLdlzGA5H4n2p9Ih58PayTw4Po/lGumF5
 7XnBA8g+kxYsGh/ZUpHRWhYkcT9GfaWnhS5mSKQ08+WLB61vimPQI3qNdNJeNugxl1GE
 fRiE0SL4L3yCtYKYrYRVI/wQnHR/fBs9fA3BxwQzSkXYmTHLcTjIK7DvbrCns91Z57Vk
 s0EiQCj/9+0o+Vm2EVlGFA0lyt2z22+vVNa5raoUNJnCYJrT+yKra8MLeqOZ1MaEqqcf
 IfNg==
X-Gm-Message-State: APjAAAWF9SyL42JWU7Yu/2GDUTylgmRqzYSnrE+XKPvy1TTucMN+FGox
 yAQLUSD6U+L7bsgiHqJsIIr9yogGq9XuNGf5tdkiiqTofdQ=
X-Google-Smtp-Source: APXvYqyzqLAqIn5qsblOZQ+c6yjaMvm3UrARidXWY36rDgAOJuZa/v+8as39Qhr4u01AWukEvKZw11Qcm5OFuwWZNHw=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr79946696otq.306.1564406774797; 
 Mon, 29 Jul 2019 06:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <1564405791-9147-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564405791-9147-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1564405791-9147-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 29 Jul 2019 15:26:04 +0200
Message-ID: <CAL1e-=jCQ_Fe++XQh7jYoZqAxro9rH6Mo0jj7FZV_Pd7ezCHYA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH for 4.1 v2 7/7] linux-user: Add support for
 semtimedop() syscall
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 3:11 PM Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>
> Add support for semtimedop() emulation. It is based on invocation
> of safe_semtimedop().
>
> Conversion is left out of safe_semtimedop(), since other safe_xxx()
> usually don't contain similar conversions.
>
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>

Aleksandar R., Laurent,

Please note that I just rebased the patch compared to its last incarnation
- no code change.

Laurent's hints were as follows last time:

"To avoid duplicate code (and cleanup the stack allocation), you should

remove do_semop()  and call do_semtimedop(..., NULL) from IPCOP_semop
and TARGET_NR_semop.

Thanks, Laurent"

 I guess they are still valid.

Thanks,
Aleksandar



>  linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ee80175..c7b08f5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6650,7 +6650,39 @@ static inline abi_long host_to_target_statx(struct
> target_statx *host_stx,
>      return 0;
>  }
>  #endif
> +#ifdef TARGET_NR_semtimedop
> +static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned
> nsops,
> +                                     abi_long timeout)
> +{
> +    struct sembuf *sops;
> +    struct timespec ts, *pts;
> +    abi_long ret;
> +
> +    if (timeout) {
> +        pts = &ts;
> +        if (target_to_host_timespec(pts, timeout)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else {
> +        pts = NULL;
> +    }
>
> +    sops = g_malloc(sizeof(struct sembuf) * nsops);
> +    if (sops == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    if (target_to_host_sembuf(sops, ptr, nsops)) {
> +        g_free(sops);
> +        return -TARGET_EFAULT;
> +    }
> +
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
> +    g_free(sops);
> +
> +    return ret;
> +}
> +#endif
>
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
> @@ -9194,6 +9226,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
> abi_long arg1,
>      case TARGET_NR_semop:
>          return do_semop(arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_semtimedop
> +    case TARGET_NR_semtimedop:
> +        return do_semtimedop(arg1, arg2, arg3, arg4);
> +#endif
>  #ifdef TARGET_NR_semctl
>      case TARGET_NR_semctl:
>          return do_semctl(arg1, arg2, arg3, arg4);
> --
> 2.7.4
>
>
>
