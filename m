Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A50B2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdxjfM2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A50B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABt8-0004i5-Me
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jABsT-0004AX-2n
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jABsR-0003sI-RX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:14:52 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jABsR-0003rk-MH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:14:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id a20so2218882otl.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nkitIgEckwOZafZDzIMfghTRqr3EDV68pTvYUeUHkG4=;
 b=xdxjfM2CZN8Xt6qvN4jQqCpLHtNJTAAs3Zxm/JMP12bZogfOEZfWO5eb9H3DqXyZcq
 V1xybT4klYvpb4dnPQOT1FROl9JcQTX0x9U6CxvXFb5FaRbJmNYgBgy9rKnYC9TQpTwa
 yQkM5xu8uxvzru4JK/WOX0LzBLqexyWx8QdBDpEyW/F1XJeT7g/ZqnXcn8wZV6HAjDJS
 ZXhZSZCRZ7/GJJZG47jg7/neNLvITLjMfcQDiSaDNaUqvC+CP1DYYA81kxUdNJMuEDah
 axasQtMyMqJ0HJYaSj1zE5+hPhIp1XNyD4Wws/jhAjpXA96Q+ZIvz5N7EN9VKaOt0wxI
 3Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nkitIgEckwOZafZDzIMfghTRqr3EDV68pTvYUeUHkG4=;
 b=OH2aKURE8AywPyxipM5QQoM+bmkTTJsomKVt1HdkUgbjhD8fTjnvAXaOMrsBAajCal
 H/OKXDvQ/N1mYDg1L+OW9NYILAIONT3S0iSg9hFTh/h4sJwRsqPdjN8kIUnChwsJysQw
 JCrOwMrnswgUyNYv0rBDxnXAEqIIhutjIu6rJNOajmqdxLHme0FvYc14jR6bpcurCRSn
 2rwIH6ZVDYD4eQgcfnK62OE+/y73Al+0qxtZbWbr7dOXO5nKvM+88Z7rB2NXyGKWb/bG
 R9kZzTvbXlML0bwqjOusPXYWX8VITIvXL029cF5tpU8Ul39DwXhEm67GmwbB2ML5yhkB
 nqKg==
X-Gm-Message-State: ANhLgQ12lPKq+8qA+6pX2E7ekEyFvMM5+qg232D/ejjvz0jcWZOOkvDU
 TjigB7B3XkGMh22CVwhMahvESNSNcxn1TpdAIJkm+Q==
X-Google-Smtp-Source: ADFU+vvmavXyZW8jt2WBOZ3Pe6d80k7TGsOw2lFf71+3eWhmQy5Cab7DyshR4tO8bCMPmRA9A+fXJLV4hXho9GzpCE4=
X-Received: by 2002:a05:6830:30ac:: with SMTP id
 g12mr2114288ots.221.1583496890553; 
 Fri, 06 Mar 2020 04:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20200306120735.24457-1-jingqi.liu@intel.com>
In-Reply-To: <20200306120735.24457-1-jingqi.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 12:14:39 +0000
Message-ID: <CAFEAcA8jWa8y=uY1M3e9DjXhPE4MMMbdk2fgJbs8jzZvq=iGiw@mail.gmail.com>
Subject: Re: [PATCH] util: fix to check if target OS is linux in
 util/mmap-alloc.c
To: Jingqi Liu <jingqi.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 12:12, Jingqi Liu <jingqi.liu@intel.com> wrote:
>
> The CONFIG_LINUX symbol is always undefined before including "qemu/osdep.h".
> Use __linux__ to check if target OS is linux instead of CONFIG_LINUX.
>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  util/mmap-alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..8340540292 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -10,12 +10,12 @@
>   * later.  See the COPYING file in the top-level directory.
>   */
>
> -#ifdef CONFIG_LINUX
> +#ifdef __linux__
>  #include <linux/mman.h>
> -#else  /* !CONFIG_LINUX */
> +#else
>  #define MAP_SYNC              0x0
>  #define MAP_SHARED_VALIDATE   0x0
> -#endif /* CONFIG_LINUX */
> +#endif

This is not the right way to fix this. osdep.h must go
first, no exceptions.

thanks
-- PMM

