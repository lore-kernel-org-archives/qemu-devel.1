Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D59C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609BA20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmAM+Vkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609BA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrm8-0008NQ-W2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDqMb-0007W7-JK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDqMa-0000rS-5g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:05:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDqMZ-0000gL-VW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:05:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id w13so17905436oih.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iMcdHlw77oZY/VVh3hFvxe/fzUHqyDJ83dwS3dXDDvU=;
 b=qmAM+VklC6LjMVZPBYpagU6/U24JUoMqNRyvzvxx7s7ZG4fFrLfYqvoqWjzRfK1sLW
 cH2anYxf7aBEZ8utEKTMu2Bq4/N+k1w0QzPm8/+0nJyFIYs6XIopZkx2tKAfYVRmgg0G
 P5oUdjNcXIrTsYW/nV0f3G3Ruta+k9+YqSLfDgKMf1vX54cXDbyINQco1gIHOjI++GkK
 VADPKUN0UUivtJlcgwZjlz6mtMVAU/qmdzoTnEjOaAxVvuNMuX4U1C7J8y50WFQTD83F
 vH6WkxNUGouBvt+LX7iup3Uu66Z2bPZ3bzagrCfEju0JPp1AnW7MwlGO2TGen97U9cSG
 ewlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iMcdHlw77oZY/VVh3hFvxe/fzUHqyDJ83dwS3dXDDvU=;
 b=q72WhGrEJ+FySz+wlRFEaQlYJ26/fekVnqYYj7+jbxzOpO04SYrxIonrDec42qxmHT
 I6uzsOe6ejILMLE4HakDaVNpKnNoIYfhUoWoPbuZs1eUPuzx/Nb9oTc0zQGUBI2kOO6/
 v/d/FXmeWXxDzKM8An5cVwGdk4ug4tes0flGhoXZeLUcb1N//4GZUUN+L7GcS3NxKaWH
 C7U9oRzIQDsdHoxTZCi5pB9CCYgTM4u4PI4KdtabM9ZgLRIDYi4nN+WBGgFf7qi0boWm
 732OotBFNKJFAJZrJTvxXIsol9nwKtl+KvBceA97VmiLAQ6PnYffLV47t3rt1VqoRnFc
 M/8A==
X-Gm-Message-State: ANhLgQ3kYK3mYOlmbkFQX0MjDyK64ksHcMAcGa8OYtkZX3IJR1q6LKVs
 g6CnnLA3qvWePEE8XNSiIhIxTEID1nav5JZIscBmow==
X-Google-Smtp-Source: ADFU+vttT/HthjxNAEcWmfjuNJBti9sU+5n19AmJa9ltu/JNWkzsyQqKV9yhd/SiL4LSlQ5S8tbRAv/z04VwFCCxZuc=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr16740881oib.146.1584367502952; 
 Mon, 16 Mar 2020 07:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200316114050.3167-1-jiangyifei@huawei.com>
 <20200316114050.3167-2-jiangyifei@huawei.com>
In-Reply-To: <20200316114050.3167-2-jiangyifei@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 14:04:51 +0000
Message-ID: <CAFEAcA8c8sYvrridu_c=Nxs8k0CwDUcbavMdQuHvHfF-ZaUWwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: avoid integer overflow
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, limingwang@huawei.com,
 victor.zhangxiaofeng@huawei.com, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dengkai1@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 13:15, Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> This fixes coverity issues 75234842, etc.,:

Where does this issue number come from, by the way?
It's not from the online Coverity Scan we use which
is the issue ID we usually cite for coverity stuff.

>     2221    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
> CID 75234842: (OVERFLOW_BEFORE_WIDEN)
>     2222. overflow_before_widen: Potentially overflowing expression "1 << nbit" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "int64_t" (64 bits, signed).
>     2222    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);

Again, you need to apply a more critical eye to the Coverity
suggestions. For instance:

> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 327d9588e0..3aeb049a46 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -2219,7 +2219,7 @@ static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
>      /* Create -1 for each negative element.  */
>      tcg_gen_shri_i64(t, b, nbit - 1);
>      tcg_gen_andi_i64(t, t, dup_const(vece, 1));
> -    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
> +    tcg_gen_muli_i64(t, t, ((int64_t)1 << nbit) - 1);

In this function nbit can only be 8 or 16, so this shift
can never overflow.

I haven't checked whether any of the others are valid.

thanks
-- PMM

