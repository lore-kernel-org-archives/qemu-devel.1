Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EF820874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpOqizBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EF820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPhlg-0002WW-0n
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 02:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iPhkN-0001zL-TT
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iPhkL-0004Vz-Rr
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:46:22 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iPhkI-0004He-7J; Wed, 30 Oct 2019 02:46:18 -0400
Received: by mail-lj1-x242.google.com with SMTP id v24so1361043ljj.3;
 Tue, 29 Oct 2019 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gfE+NEO7YS8mVjvOVK9/8HpohP3p3byTjfw7KM/WHOI=;
 b=QpOqizBZ4A60YMVDyaD8LtHl3At8+OnZ1WC7kj+kWnyH+ZO85N7FD78vDABsd17MfG
 1DPWu6j5DsIIEPK49URlpEJ8ct7TKTlq9fg7czfYykiLBN1AAClNwMHd3UJmYvApSEBA
 DEEtH7HHwPd9Zk+tmpKa/MYdf71UyInfyDHB0hYbJOXi7HhfxOE1x9BYcUeguahHk7cu
 Vb9IwwZ/CymKJ5ZsX9bOozsbZpb9udNvRiozuRgu9kKrRe/b3O5gh9h9NpnFuVptIbfs
 03mZl+YF7GtSjIM5n8D7T0Uzx5ky+tZKAmDgX+lEci9lp8oOWrF4j18oyIGEDHNNAH8m
 3Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gfE+NEO7YS8mVjvOVK9/8HpohP3p3byTjfw7KM/WHOI=;
 b=NFlzlszCchaSjDP2yZaR7DOEkBiokob9XBYwDX5LFXpsW9PLtrCzRKVGK1Uy2wJrzR
 AmdxE6+EkAbIyDzNp41NRu4NfMz/Q5mGbNw+06mdYL3HvDMVR9710z9OPBp5LEcKWdE6
 ja/NExsC03nVNDVOosU6bQY6alxZileejn/PXQnqIqO9ROmlSy4E06jTRXGwh4fNbZUv
 j4AtZwyeS1uYSWfkLsHBCx6a/+lY+c3E+Mn0skMLaCu9rbGR9feACot31JhURGz86ODp
 1NzMEcNuWNs6HbT7LKlm5FrW7fVnBUNlJ6VZilskSsMnn4gD0HvEOApohpczSuPj3WPj
 LuNQ==
X-Gm-Message-State: APjAAAUK6uAq2NUHu4IZ1qDpCis86d+D1fXJkqmgsPfPSUKgXOY5bNKR
 RmTzRJgHstokZXjQ+4PpOlrPN0VqFhDgR6YCD5s=
X-Google-Smtp-Source: APXvYqzg62/R7K0Ue2ySzCK9briO1v7CioFMN9dA0MwefGz7UR2nc4zhmGmoZ1i9yZb2wg3hXE5wHIDjMpaKhN6s3Sk=
X-Received: by 2002:a2e:420a:: with SMTP id p10mr5597358lja.16.1572417976697; 
 Tue, 29 Oct 2019 23:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191030044341.29179-1-palmer@dabbelt.com>
In-Reply-To: <20191030044341.29179-1-palmer@dabbelt.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2019 07:45:49 +0100
Message-ID: <CAKmqyKPQqNJq1ZEDOd6kdbays+5he3zdhq0dgUMXagAfrqCyiw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change to my personal email address
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 5:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> I'm leaving SiFive in a bit less than two weeks, which means I'll be
> losing my @sifive email address.  I don't have my new email address yet,
> so I'm switching over to my personal address instead.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 325e67a04eee..20445f353e7a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -259,7 +259,7 @@ F: include/hw/ppc/
>  F: disas/ppc.c
>
>  RISC-V TCG CPUs
> -M: Palmer Dabbelt <palmer@sifive.com>
> +M: Palmer Dabbelt <palmer@dabbelt.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> @@ -2392,7 +2392,7 @@ F: tcg/ppc/
>  F: disas/ppc.c
>
>  RISC-V TCG target
> -M: Palmer Dabbelt <palmer@sifive.com>
> +M: Palmer Dabbelt <palmer@dabbelt.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
> --
> 2.21.0
>
>

