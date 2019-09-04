Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9FCC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B232339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmP4dKz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B232339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VZs-00019r-PI
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5V9E-00087n-6T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5V9B-0002bT-Al
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:16:31 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i5V9B-0002a6-5B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:16:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id b2so1166433otq.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XcIFrR8q9TBnn9EQbn2c9eGHujiMtazLJVMVukr6j5g=;
 b=pmP4dKz2GFg+mdM1b60DoGHZUjyYpgH0nl0Yf7a7tTcqukmL5JY0BgLAc/ObI6ZxUw
 NRmlT2vTXLkWYk8OGEvPaHBMbRoIWzZpKiz7oMIOStq54ZWdA05zi5QEu9bONNkumaPy
 JmLVgvHhvg8+GHmnbZNOThc4HkGmeq5L5sXFsHpxOmNi465VQG7CN8Ds5dj1s3B3lijD
 0HPdDWjKzXSECU+XH+RYSKH972AQ/ZzER4Wo4BG8DOaAASieEDyaKLk3GV4+WYWM/rp5
 hcmr+bcBBan2uzSPEY4VKC/WnUIHJ9c81gfBJajz6JfFeIKtS6QGaE+RlR5tzAG/k/ns
 Gkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XcIFrR8q9TBnn9EQbn2c9eGHujiMtazLJVMVukr6j5g=;
 b=eeIQ+rp1xAClTrw/rCFVQi6jubs4OCCaqJILsT6Zg4mzuATTf8xRowLfH2nuczs3Vo
 OKRdluGG1CLA66FFJL+5+hmLQqJUNyVBdNK7DzMlvMfZa0cbHWexxc2Xe/Q0R1AOCFt0
 S9vBtwd5LAfcamiY+E93jOkPZg5eoeN0QoKAZo3kuTujI/IRDov+1lbxlSVg8nOjsjX6
 3etUs2s3Z+3pDJPUpEFCiVvUA15JJaNnRtnxoiK8/giTYOm8X61FGHdO2Q1WYpDgxlIY
 PWmVgb9ydgBWboxeDRAbhawZZoYmp/CDLTGMS6v4eCj0rXWx2esZ3VurwYfrQu/ybGHm
 YIYQ==
X-Gm-Message-State: APjAAAVfatV2BKnEPEDDl0gABlr4V5/S4t4T3uuHc5LBsK/sBXAwO+RI
 toZ6K9ETmD9fthQ91jTK5Lv2Km0wQN7NwIZnlHU=
X-Google-Smtp-Source: APXvYqwtFuhtvRO/3QmMcKhKUFDDkjQQGcK3HKyd21kUkmREpo2aha8qbevTL1206KghuTgqxs3fPZ7+ebL8OxLzn74=
X-Received: by 2002:a9d:7d11:: with SMTP id v17mr1515417otn.306.1567602988197; 
 Wed, 04 Sep 2019 06:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1567601968-26946-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 4 Sep 2019 15:16:16 +0200
Message-ID: <CAL1e-=j6S=-6WtgGyuxSMSY2+qqPX98C6mfgFpnd1rpcYNLfEw@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 1/8] linux-user: Add support for
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 4, 2019 at 3:11 PM Aleksandar Markovic <
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

Hi, Laurent.

Please note that Aleksandar R. proposed also a code segment mentioned
in this message:

https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg07080.html

... but wasn't sure if he got all bits and peaces right. Please provide your
judgement - and I will modify the patch accordingly.

Thanks,
aleksandar


>  linux-user/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb1..b5bc6e4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6649,7 +6649,43 @@ static inline abi_long host_to_target_statx(struct
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
> +#ifdef __NR_semtimedop
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
> +#else
> +    ret = -TARGET_ENOSYS;
> +#endif
> +    g_free(sops);
> +
> +    return ret;
> +}
> +#endif
>
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
> @@ -9193,6 +9229,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
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
