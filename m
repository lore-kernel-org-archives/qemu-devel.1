Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DFC004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A228C2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvsdgXnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A228C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hko3I-0005tO-R6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hko27-0005A5-2j
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hko26-0001XI-1X
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:11:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hko25-0001We-Nw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:11:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id g7so15046999oia.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iCpMKQP1wSq6LChmAKTvqIOjwZP+ADPkJjmV0vxF1GI=;
 b=XvsdgXnzuag4ixkO+Z66nuQ8Mbo12ilPskojQ7xmDkk8bf1aknAlo8VGr6/PT8GIRQ
 woAUCbT29/BpZ3VjNdALMLdINhisEHkJfLIDJ4vbZbZrDDEZX9LIQmySeGq+Gz8QXgJy
 CIL9aX2yyjPy6hF5SfWOld7lMQ6RPxy+nzLvcDoVEiC/vzXrY3D7EetOXsSReQNossJP
 wT26adhSJ3nfAB5Lev86+E9VPdF/HrjBkOnh0SonW6NfqKjNeSpoC44YU9IeQ0zHvxgZ
 gd/aw3Pi/mCBRzr5SNNmM/lGSABlGC3uEaVWzDVsNw0YRetDQR431FKDzoAdYNMND3YG
 pPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iCpMKQP1wSq6LChmAKTvqIOjwZP+ADPkJjmV0vxF1GI=;
 b=QIq9QUgaPBn+Lj8zi5FOgOXgCcNpKqj6WaN12RQySI3EJGAOi38G7063XWW5odQEpw
 wPsWv4AaG92jXrUHlhonTPVY2cUyVpsByGAEQfFNtNEWGTI9D+AQyRt7TaiQ33s5zoPD
 UENlJI6fQ3MI8cByYAXV9VQyZa5I61IKfbG+6D4eicbWQ3E3HcTYozmAGxkvi2WdVj0m
 uHNyXJLzhGc5ZtMsKcXmF9prt0cRkQTFcd3pv39kghhjPD1/Uv+WpET/zUJ0nBcs2+b7
 c0cJCysOvOMqi2tybWwotFg9tSEpJS4GJIVupmt2Dy3qT07Yu0oBC3VRF7gTk8O6gnn5
 OAUQ==
X-Gm-Message-State: APjAAAUhabr4xdKOoyfMLmliFytj4pHkmp0xQxCikyI9XLtHRAFhbT+9
 2IgDDTzx5T9ZBsXZVhSBXN5bChB2wq6PxIrPUMR8XA==
X-Google-Smtp-Source: APXvYqyBvPNcgi9Qaf7nvdN2z1YP+/V7xG71DfPSOpxymj7JygOzFO0xkoKY/zWjJlWic52mYar/+mpmaBJYmJtZgY0=
X-Received: by 2002:aca:6185:: with SMTP id v127mr1404994oib.163.1562670696769; 
 Tue, 09 Jul 2019 04:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-2-philmd@redhat.com>
In-Reply-To: <20190708104750.1071-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 12:11:26 +0100
Message-ID: <CAFEAcA_NnBYWKs89B5apxmXFBUcA5oh3QShRM-1CkWu4Rp6aug@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 1/3] hw/ssi/xilinx_spips:
 Convert lqspi_read() to read_with_attrs
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
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 at 11:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> In the next commit we will implement the write_with_attrs()
> handler. To avoid using different APIs, convert the read()
> handler first.
>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v4: Do not ignore lqspi_read() return value (Francisco)
> ---
>  hw/ssi/xilinx_spips.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8115bb6d46..b7c7275dbe 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1202,27 +1202,26 @@ static void lqspi_load_cache(void *opaque, hwaddr=
 addr)
>      }
>  }
>
> -static uint64_t
> -lqspi_read(void *opaque, hwaddr addr, unsigned int size)
> +static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value=
,
> +                              unsigned size, MemTxAttrs attrs)
>  {
> -    XilinxQSPIPS *q =3D opaque;
> -    uint32_t ret;
> +    XilinxQSPIPS *q =3D XILINX_QSPIPS(opaque);
>
>      if (addr >=3D q->lqspi_cached_addr &&
>              addr <=3D q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
>          uint8_t *retp =3D &q->lqspi_buf[addr - q->lqspi_cached_addr];
> -        ret =3D cpu_to_le32(*(uint32_t *)retp);
> -        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
> -                   (unsigned)ret);
> -        return ret;
> -    } else {
> -        lqspi_load_cache(opaque, addr);
> -        return lqspi_read(opaque, addr, size);
> +        *value =3D cpu_to_le32(*(uint32_t *)retp);

If you find yourself casting a uint8_t* to uint32_t* in
order to pass it to cpu_to_le32(), it's a sign that you
should instead be using one of the "load/store value in
appropriate endianness" operations. In this case I think
you want
    *value =3D ldl_le_p(retp);

That looks like it was an issue already present in this code,
though, (we do it several times in various places in the source file)
so we can fix it later.

thanks
-- PMM

