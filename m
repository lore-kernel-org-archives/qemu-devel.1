Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF7C3A59D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0121F2077C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EjfiQa4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0121F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyn9l-00050N-Rl
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 21:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1hylmE-0003wt-KS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1hylmB-0000AV-6d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:36:57 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1hylm8-00008s-6z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:36:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id y1so3039932plp.9
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e4Lx6wWXbd6ffhNIOQFJiBVPGZ/9pQupzsoFMeU6VT4=;
 b=EjfiQa4yrDbtgGU+NX/IUydjWOys+8gonnpq9ObOSc7j/+5iRR9pXeBjQT3cC3cG4b
 b4mzgpnZxQrAkEU9e63Yc41AIXtlQvNjZ06PGWqdwiX0AiPRXcf/ELG6oB9/yd6Pepm6
 jO5I4n22K9TzP4aqaTOWtAFUhky5F3mzfZVNjSchXvshcfhZVwp6WOZBFR6gVAypykAO
 yy2BciFN+l3ci3YB3XNbLUpkuq4ynDkEV7jnaWg7FX+YfKkfYcfuru4GIDRqYT3QV3fK
 apqEWelkOYdgec2K+JdzoRLcqz33je7VaQNIrVWTNdFYrHpF6gGFGPruEaoCZ1wdoSIz
 dQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e4Lx6wWXbd6ffhNIOQFJiBVPGZ/9pQupzsoFMeU6VT4=;
 b=T5p6G4TMFCiy46Y2A+qgz2VS8Q2DEbe7GbVAo8Khn8asbETw6HOOEIj0d8VpOSMoU2
 oyosttBCNzvQ27QjO8vVa96w99/uc8/N02KO9A5bVfwna8BevkrpYIRybUAe/NA0iKu+
 h/f0Z+IjbLeDSSRD3vachz6RqLjJn6L0t/RoU7MQwaM3P1ytSGdnb04SqEukdJjJBmQH
 ponj3TsQLWcJHumnA+7l7wlfrXX/e14lpclf0EYfvAWqGoePHO8UppiPMKcBHeM2pq1V
 8qYWErOwLGbo54zsjSP5wWXkg3Jak6hp/NumcgrT7kCU5s7SjRp8893MY8LhiiNCM1uD
 YALQ==
X-Gm-Message-State: APjAAAWArOrEOIIhMKhPW8/iQfNe3avowMVeBBbfTnl4roammthsuxVT
 LrxEY4hHr0QPQsAFP1fnKwzZH+lnE40aixJhQdrjKlTpo4ZDNA==
X-Google-Smtp-Source: APXvYqw7f9rI8XUzdi8hN/PN6hjIyFAggNcti8AzfPjl0z/tm5nEXaRcLG9BNEXsBf/CYVUjxGQKPC1M2AsFudgvguM=
X-Received: by 2002:a17:902:e38b:: with SMTP id
 ch11mr10778799plb.275.1565998607549; 
 Fri, 16 Aug 2019 16:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190816233422.16715-1-jkz@google.com>
In-Reply-To: <20190816233422.16715-1-jkz@google.com>
Date: Fri, 16 Aug 2019 16:36:36 -0700
Message-ID: <CADgy-2s7t-zoycYZ5yBygN2cJ4-cj1wjdnAA=D0QDUTGnTjLRw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
X-Mailman-Approved-At: Fri, 16 Aug 2019 21:04:12 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support gdb 'qOffsets' query
 for ELF
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: qemu-trivial@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+cc: riku.voipio@iki.fi, I typoed the email on the first go.

On Fri, Aug 16, 2019 at 4:34 PM Josh Kunz <jkz@google.com> wrote:

> This is needed to support debugging PIE ELF binaries running under QEMU
> user mode. Currently, `code_offset` and `data_offset` remain unset for
> all ELF binaries, so GDB is unable to correctly locate the position of
> the binary's text and data.
>
> The fields `code_offset`, and `data_offset` were originally added way
> back in 2006 to support debugging of bFMT executables (978efd6aac6),
> and support was just never added for ELF. Since non-PIE binaries are
> loaded at exactly the address specified in the binary, GDB does not need
> to relocate any symbols, so the buggy behavior is not normally observed.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1528239
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 3365e192eb..ceac035208 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2380,6 +2380,8 @@ static void load_elf_image(const char *image_name,
> int image_fd,
>      }
>
>      info->load_bias = load_bias;
> +    info->code_offset = load_bias;
> +    info->data_offset = load_bias;
>      info->load_addr = load_addr;
>      info->entry = ehdr->e_entry + load_bias;
>      info->start_code = -1;
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
>
