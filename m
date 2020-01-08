Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93F4C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9354D206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGPYGdB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9354D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0o5-0003Om-Ou
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ip0kg-0006JO-FO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ip0kf-0000CM-GX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:18 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ip0kf-0000Bl-BH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:17 -0500
Received: by mail-pf1-x443.google.com with SMTP id x184so804088pfb.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 18:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=ryMKAswZa6GtlJHI1XGaeDcICda12Y4PVe7eW7k6yRg=;
 b=FGPYGdB2mfSDyk1aZQq8tDKJv+VYmMSVEywvyr2qrBeqA4/GcIops6KdWKo66lCWPA
 LkFsesj3YA1GSTX6Kf3pqQ6dA2VBMww7kCZsfAe8ASAcvVwDAV1dHbHGnABPsm83TW9D
 AYn3eg3RdKxPONZaWpuPGHSSDnZy4OAKd2C6Umj/Su1wHigVN7YnijYd876ncerz9/lp
 HdLzfg7F3Fx61lf+QW/U+7cDY3rRf25ivYNCwkM7wrIZeIXckZ+DwFJ+BunRN7yghamV
 Rr76HkXBs63KiuLoEB0vdEs0JQQqJHvJpR4v9BBzxaKHgXsyY3+e+FKZEIoAl/w76Tko
 hDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=ryMKAswZa6GtlJHI1XGaeDcICda12Y4PVe7eW7k6yRg=;
 b=t3SfHAQ0idWI0WRtpWidm1R/NlhzGbKLgv0DxM7dn1/ReZw8fVgM6sLETE0cs/by2h
 0KNY/6x55QmgZwnvmtH28dClLE0Mkjg+dkqjhscG3IuUkrhQSJg/ZmGv6lsJmYPoOVUY
 Nol6IKjG1oWkQ1C73LL8wrUonvtsImkj9lzwhorHhxPfmjk1En/iovQe////vU6H6Iqv
 X/no228aqIFSv1CLVD+T2IT6XbsNIIv350DyZFMSF1Ic5wXMvtIPeCVOVxOgM//VoTdj
 aIhyOqwPUWteHC+Xh5nyqyUzBYIm/Kml5l8P2ixu7qT46d8Qez7asy8P4vLS8Sxj8h1v
 HgCg==
X-Gm-Message-State: APjAAAVaVoHacKyipAlv5VxN2v4C3k5Zl1H4QJRc0+8xZHmRVdcZDNVj
 nX3siXR/Pip9fZeGIRaiRXPqBMah98o=
X-Google-Smtp-Source: APXvYqxsT8Mi7I1IY6DJ1QH0UEOB+WNQtv8RiIcQpTwarIJvPp7f6Pj2cAlfjK8YphMwuXzlpzFkjg==
X-Received: by 2002:a63:941:: with SMTP id 62mr2850483pgj.203.1578449235963;
 Tue, 07 Jan 2020 18:07:15 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id g18sm896820pfi.80.2020.01.07.18.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 18:07:15 -0800 (PST)
Date: Tue, 07 Jan 2020 18:07:15 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 18:07:06 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 17/36] target/riscv: Set VS bits in mideleg for Hyp
 extension
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <b1313a76928acfe101247e33248f000e1f82f558.1575914822.git.alistair.francis@wdc.com>
References: <b1313a76928acfe101247e33248f000e1f82f558.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-1d91cb12-dd7c-4160-9e39-a1d5a9f5023a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On Mon, 09 Dec 2019 10:11:24 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a4b598d49a..fc38c45a7e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -449,6 +449,9 @@ static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
>  static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      env->mideleg = (env->mideleg & ~delegable_ints) | (val & delegable_ints);
> +    if (riscv_has_ext(env, RVH)) {
> +        env->mideleg |= VS_MODE_INTERRUPTS;
> +    }
>      return 0;
>  }

Do you have any idea why?  The spec is explicit that this is the case, but I'm
surprised.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

