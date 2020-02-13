Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5055AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB40206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3X7DBSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB40206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LvU-0001fL-BS
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury.norov@gmail.com>) id 1j2LO9-00041C-Eq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury.norov@gmail.com>) id 1j2LO8-00020b-2l
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:09 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yury.norov@gmail.com>)
 id 1j2LO7-0001xU-Qf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:08 -0500
Received: by mail-pf1-x442.google.com with SMTP id s1so3653418pfh.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=mC+IGwdPVaxHWNj8mNYZ18hdPPLG4fUBhPiGoWxhKxE=;
 b=j3X7DBSj5zX5OgW3FjuIP5XlFWRSCWBxH//ZxteGT1FVRQw3F8sb2Gl4Rjyax/bZD1
 9egkvtO6Qlt6ccniFbuWMFLOzKQ0dR2Lbeye5gd7C80+hMILADn/0bSI+kFAl2p5Fcxt
 nYxnN5D2rcw0r8l96CLp5005UPmDwRTA65RlFtvPrZchdmdb581wLJrS5CfAbVs1oHXW
 tTFY9HG2w8c7dPWRq7zT+TSd1IOtxetwIfM4JIz1vRdHINhhiwoGLStDTMiuag18KOgh
 G8ocsJT1plVZh9F8gtzcusgw6svbLgw7ZWkSNcbHPxKB58EP6c/CAJoiGl3d26yOFlbV
 3U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mC+IGwdPVaxHWNj8mNYZ18hdPPLG4fUBhPiGoWxhKxE=;
 b=ZiOso5piEGidZ8D31lOEy2UpWq71iRWwtuYN9jQKR+pfZN/wddU7EtdfMF1Szo41Ys
 SnR3ixfxXvwWJV6FRDkOcvVizy9D9bimACgimbKjw5QsxY7ZEj/+RwMVKzb6Isn54KXE
 k3r8kQdiWm1xPot3k0PRw5jTJZN51S+U4l3Z1u3HhHVmTkz06MathexjXqjMbEPwXugY
 FJlA7uigdEN+zi54M97GJ6Ah5sCtstQT9khBxrY2UXmyplrp6tiIcOVBgM8jgETGuWsP
 vprHWhw7znQ612PJ02ylMvF0E3YxK2y/b3Qm20zLZ0F+5NjZbxMmHaUJwPGLjx/UScW3
 +eHA==
X-Gm-Message-State: APjAAAVJ0ZlJQ52KYd4rXAJWo92d/HHDONT6m13euW/hrWt1yxhUq9zj
 0Gr0N64U8Qo2kHlHh1/FBFc=
X-Google-Smtp-Source: APXvYqyd9pyCtc5N8+2APg5W0dnO2VBKRiLd30iN0yDW/F2HDyNPfQO2v/jLo2mGZPtCkwII3lpKiQ==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr15286361pff.98.1581626826350; 
 Thu, 13 Feb 2020 12:47:06 -0800 (PST)
Received: from localhost ([73.93.152.205])
 by smtp.gmail.com with ESMTPSA id r9sm4219555pfl.136.2020.02.13.12.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 12:47:05 -0800 (PST)
Date: Thu, 13 Feb 2020 12:47:04 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] uapi: fix userspace breakage, use __BITS_PER_LONG for swap
Message-ID: <20200213204704.GA22037@yury-thinkpad>
References: <20200213142147.17604-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213142147.17604-1-borntraeger@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
X-Mailman-Approved-At: Thu, 13 Feb 2020 16:19:59 -0500
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
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 03:21:47PM +0100, Christian Borntraeger wrote:
> QEMU has a funny new build error message when I use the upstream kernel headers:
> 
>   CC      block/file-posix.o
> In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
>                  from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
>                  from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
>                  from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
>                  from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
> /usr/include/linux/swab.h: In function ‘__swab’:
> /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
>    20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>       |                                  ^~~~~~
> /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
>    20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>       |                                         ^
> cc1: all warnings being treated as errors
> make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
> rm tests/qemu-iotests/socket_scm_helper.o
> 
> This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
> This patch is doing
> +#include <asm/bitsperlong.h>
> but it uses BITS_PER_LONG.
> 
> The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.
> 
> Let us use the __ variant in swap.h
> Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Joe Perches <joe@perches.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/uapi/linux/swab.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
> index fa7f97da5b76..7272f85d6d6a 100644
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -135,9 +135,9 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  
>  static __always_inline unsigned long __swab(const unsigned long y)
>  {
> -#if BITS_PER_LONG == 64
> +#if __BITS_PER_LONG == 64
>  	return __swab64(y);
> -#else /* BITS_PER_LONG == 32 */
> +#else /* __BITS_PER_LONG == 32 */
>  	return __swab32(y);
>  #endif
>  }

There is a patch from Torsten Hilbrich fixing this:
https://lkml.org/lkml/2020/2/12/93

