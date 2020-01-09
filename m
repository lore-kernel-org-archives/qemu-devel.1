Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152FC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471332067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkBNJ+gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471332067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipM3c-0006NX-8Z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0b-0002iT-W9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0V-00080i-H0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:08 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipM0V-0007y4-9Q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:03 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so1820036plt.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=oxaYPFpeBulaqXEI8e0zvCoQvUmXj9BsGZbI3S9AAPs=;
 b=nkBNJ+gTd8TFhEZGeXvAhmb3pYpL/KVs8I7Ll0TdBovsXPpv8syPKMpVdE/iLvJ4uX
 WhAQlZGJUWMX4NHeo+/1Tjbzo3G/nbanH2qbJEj/mEq+TsjtbapakzX3ogb4gKy0dKRe
 QJ9NmNtft7veyc95li3xo8mpeqRYxBFfVWHnKmxcgEx4yiZv0Ak45yiwjXHOsO5kNQfE
 JHoef3ZolmCHbGOJDpEgzZSKl/S3dt5Rw2sH95Z+KW76KaLwvHJNKNL61yDZaqjfH+sY
 qj7YV+eM7DHHNaPvi2pGhdkOapeCTr6ma63o7WEOjDT2qIc6noE7zXiyT6Y10PSXDZHg
 s1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=oxaYPFpeBulaqXEI8e0zvCoQvUmXj9BsGZbI3S9AAPs=;
 b=jzMMnXdzC3aQ5ew8X1GILtWvdNfa201tcDqYhZNVtCknUD9KJ7j+iLWMQ/udmwRBnK
 n8SpO+3Df/rhJ3g2IYnlGpHuHM10NVvOsm4GMYUMlfMz8bkChrG9wv4rhfsTveXhaURx
 zoTYUxGo8qAHwg9sJpSimpRWGcdVaXPcIQPFFJd6jCRYSar+H9hUYhuYnbTDKkSuPGlA
 8kU3SM9ayJdPBvKeyYQq9nRaw9ADciv7leJMz1/XOYcOmmg3T1D0AHancRtH+tzc0A0h
 kHYDWBn6QcQbV8UZ8Io7/0x9g7s+B5uP9tgoPesKRqe39lNNNz7hdercrFX9Y92FiwaD
 UBow==
X-Gm-Message-State: APjAAAUTWcD86igPM2V5YIpskqc107AFhQfZ+u09xWob2k1QeOPaVA+S
 Pm36+iGhv0HsRsctBpkWhQqr6yNR1IQ=
X-Google-Smtp-Source: APXvYqxtbOAz2lj1ecTrwijbnMiRA6uUhDyK2H/O8kDV8Edf+yj07PhtKh5x2enJPb5STdwsU55V+g==
X-Received: by 2002:a17:902:34d:: with SMTP id
 71mr8391407pld.140.1578530941637; 
 Wed, 08 Jan 2020 16:49:01 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id w7sm451134pjb.31.2020.01.08.16.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:49:00 -0800 (PST)
Date: Wed, 08 Jan 2020 16:49:00 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 14:40:34 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 19/36] target/riscv: Extend the SIP CSR to support
 virtulisation
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <eecc3f2848d9afa8e640f608bd13112868ca2e5f.1575914822.git.alistair.francis@wdc.com>
References: <eecc3f2848d9afa8e640f608bd13112868ca2e5f.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-d8e48454-f32d-4bff-8601-38ad43e83134@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On Mon, 09 Dec 2019 10:11:30 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 54edfb280e..d028dfb60b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -744,8 +744,19 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
>  static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
>                     target_ulong new_value, target_ulong write_mask)
>  {
> -    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> +    int ret;
> +
> +    if (riscv_cpu_virt_enabled(env)) {
> +        /* Shift the new values to line up with the VS bits */
> +        ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value << 1,
> +                      (write_mask & sip_writable_mask) << 1 & env->mideleg);
> +        ret &= vsip_writable_mask;
> +        ret >>= 1;
> +    } else {
> +        ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
>                        write_mask & env->mideleg & sip_writable_mask);
> +    }
> +
>      *ret_value &= env->mideleg;
>      return ret;
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

