Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7521D214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXKcKWEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7521D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT9z-0003hD-N1
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUT92-00030t-T2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUT91-00066S-Jr
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:11:32 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUT91-00065y-Df
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:11:31 -0500
Received: by mail-ot1-x344.google.com with SMTP id r24so13786067otk.12
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 02:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mcex5tKYR5kzchIuDH/dGD55kEemk/iIXwnLCDeRETo=;
 b=GXKcKWENluTlcfZ3RY48ui1MgE00FdZut7YQOYO7G/rUFPjqh4ruNImrR23OBV/Soy
 vmQbFsmiqm63ROWqBFMSUycz6o8L1O6mMGa1mj37++iuTYDmJxq9D9Oz+WX/7hQEvsUw
 u6MhdtzbKxcPObRbAfPp8hDBpGFF4QuAj695e79UvkAxQGg/zPA5QPJdvtLNZBoUCgn8
 eO+uXLmdN1J9+j2ekjtzSRnntKLAA4kbI8WglbhMMqyRChqp/unImcMiXAEdOUclxw7S
 TSykqSJw2uP16rWI8ANxL78TKQArB6uLiRw1B+WNbF31ROCKE8L9BIJzg6D+5wajZFrU
 jCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mcex5tKYR5kzchIuDH/dGD55kEemk/iIXwnLCDeRETo=;
 b=Vxip9KslgJqKK8nHbnVpu80YwhI96hwr6c5iQWCYIZfNCL5K7tqKNKqFSNaSTgaStn
 ZB550Rj7zRNgajpxUCLQuqFjU0N2k6szLP/QwS3lULPPe5vIeBS//+NTSsMN7q84l6lr
 D3JR0AztT+oZYGA53mTMwW5hqHakKY7FZdKeQ5KdQLJ71lsg3/YLFfy+7MYpL6neIebl
 03Z2w71Xuy5TJd0AKdjbgtFODENzpGJMC9Wmlml+kSdG1YnrJV0lYBTbH7Uv2DuBqe6w
 vj3/DWNoCTFJzVXjv1NHEqNqTs5xbwmeQMOYMzkAIwBoNraFUldmiWZlm/mIrDW8sYWE
 YjOg==
X-Gm-Message-State: APjAAAVWiwsDvrZZdUR2mjbxNByXLtKjj6kuWXe7pFvilgx81LV/b4cq
 4bz7XdC3+3UEwLEGIPnoG+HL7ZhOILCAbPw1qTwCug==
X-Google-Smtp-Source: APXvYqwRebUTxYY5thVFoDR1BmPwG2vJ7lg1ITZueVio8cgV6+ut4gsC/nbjdPYzw0u1NU8ksz5gAhHK0IJJ5IeZZpU=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr14930216otn.135.1573553490290; 
 Tue, 12 Nov 2019 02:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20191106130456.6176-1-laurent@vivier.eu>
 <20191106130456.6176-2-laurent@vivier.eu>
In-Reply-To: <20191106130456.6176-2-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 10:11:19 +0000
Message-ID: <CAFEAcA-fTQzYjDtHRzghwA6EAREN=m=JixWJzOMkBc7ZPDmp_g@mail.gmail.com>
Subject: Re: [PULL v2 01/13] linux-user: Support for NETLINK socket options
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Josh Kunz <jkz@google.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 13:07, Laurent Vivier <laurent@vivier.eu> wrote:
>
> From: Josh Kunz <jkz@google.com>
>
> This change includes support for all AF_NETLINK socket options up to about
> kernel version 5.4 (5.4 is not formally released at the time of writing).
> Socket options that were introduced in kernel versions before the oldest
> currently stable kernel version are guarded by kernel version macros.
>
> This change has been built under gcc 8.3, and clang 9.0, and it passes
> `make check`. The netlink options have been tested by emulating some
> non-trival software that uses NETLINK socket options, but they have
> not been exaustively verified.

Hi; Coverity reports a missing-break-in-switch error for
this commit (CID 1407221):

> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f6751eecb78c..247883292ce5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2248,6 +2248,39 @@ set_timeout:
>              return -TARGET_EFAULT;
>         ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
>          break;
> +#ifdef SOL_NETLINK
> +    case SOL_NETLINK:
> +        switch (optname) {
> +        case NETLINK_PKTINFO:
> +        case NETLINK_ADD_MEMBERSHIP:
> +        case NETLINK_DROP_MEMBERSHIP:
> +        case NETLINK_BROADCAST_ERROR:
> +        case NETLINK_NO_ENOBUFS:
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
> +        case NETLINK_LISTEN_ALL_NSID:
> +        case NETLINK_CAP_ACK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
> +        case NETLINK_EXT_ACK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
> +        case NETLINK_GET_STRICT_CHK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
> +            break;
> +        default:
> +            goto unimplemented;
> +        }
> +        val = 0;
> +        if (optlen < sizeof(uint32_t)) {
> +            return -TARGET_EINVAL;
> +        }
> +        if (get_user_u32(val, optval_addr)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(setsockopt(sockfd, SOL_NETLINK, optname, &val,
> +                                   sizeof(val)));
> +        break;
> +#endif /* SOL_NETLINK */
>      default:
>      unimplemented:
>          gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
> @@ -2532,6 +2565,74 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>              break;
>          }
>          break;
> +#ifdef SOL_NETLINK
> +    case SOL_NETLINK:
> +        switch (optname) {
> +        case NETLINK_PKTINFO:
> +        case NETLINK_BROADCAST_ERROR:
> +        case NETLINK_NO_ENOBUFS:
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
> +        case NETLINK_LISTEN_ALL_NSID:
> +        case NETLINK_CAP_ACK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
> +        case NETLINK_EXT_ACK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
> +        case NETLINK_GET_STRICT_CHK:
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len != sizeof(val)) {
> +                return -TARGET_EINVAL;
> +            }
> +            lv = len;
> +            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            if (put_user_u32(lv, optlen)
> +                || put_user_u32(val, optval_addr)) {
> +                return -TARGET_EFAULT;
> +            }
> +            break;
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
> +        case NETLINK_LIST_MEMBERSHIPS:
> +        {
> +            uint32_t *results;
> +            int i;
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            results = lock_user(VERIFY_WRITE, optval_addr, len, 1);
> +            if (!results) {
> +                return -TARGET_EFAULT;
> +            }
> +            lv = len;
> +            ret = get_errno(getsockopt(sockfd, level, optname, results, &lv));
> +            if (ret < 0) {
> +                unlock_user(results, optval_addr, 0);
> +                return ret;
> +            }
> +            /* swap host endianess to target endianess. */
> +            for (i = 0; i < (len / sizeof(uint32_t)); i++) {
> +                results[i] = tswap32(results[i]);
> +            }
> +            if (put_user_u32(lv, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            unlock_user(results, optval_addr, 0);
> +            break;
> +        }
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> +        default:
> +            goto unimplemented;
> +        }
> +#endif /* SOL_NETLINK */

Here at the end of the 'case SOL_NETLINK' we will just
fall straight through into 'default:'. Missing 'break' ?

>      default:
>      unimplemented:
>          gemu_log("getsockopt level=%d optname=%d not yet supported\n",
> --
> 2.21.0

thanks
-- PMM

