Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1174C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D07A20651
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DioEtRvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D07A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkthv-0000yG-Jg
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hktUI-0000j3-LE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hktUG-0002ca-52
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:01:06 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hktUF-0002aW-QI; Tue, 09 Jul 2019 13:01:04 -0400
Received: by mail-lf1-x144.google.com with SMTP id x3so7987143lfc.0;
 Tue, 09 Jul 2019 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xcCeVgnp40aRjw7zb105YFx2HqnVA7iLMrIEIJ2JEHI=;
 b=DioEtRvF68F3LcUzxiRXTJyjjC6lA9olZuEP43D7wP4y0nuS5AiX7+RyrmTg28SqTe
 vcBpPEurE4+WePXriitk3kQ+wFApXnsIA0h+HIqt+F/K7o4icyGMLkQa+9QEiVUCGslL
 315WNDbxuV32YTvMnd3iNJLTS0lkIpACox6G8cbbq/e2kSycCj08O9qS5yXz0h3jgmip
 iQFo58z0T4uFWQfz2aHAToOETvgjLwTD6w0iEXOA5O0kfOTtI6CXkgJ9V3W9kJlNht61
 hzSrp3bMHZhxRsU7swNeYep5QqN1d6X112chIdpxWdU5O09EKurbuTOOWhHkNxlu+KSQ
 VdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xcCeVgnp40aRjw7zb105YFx2HqnVA7iLMrIEIJ2JEHI=;
 b=MGpi/v3bn7geEbUy3FtSbCyn/aTLriNrSHaCjFpODwDr8EDXnYhZeXzxd6Xplv29TU
 yBgBfgawGSpOKDtSEkMc7DvP2/eNUKCbGsWuKJmmg5jkAIavGaGIyVPSMa67wJSeF1mo
 W1awsZqxy4Jx1w8H4t0KrzXUKQ+7vP6GY6ubfp98CGI21fQp/GaMB9JPeLBLaBw+9aBw
 6dx/EdQr9IyEO2sKa1aHsVCMollAq73eJ1ORqxAqVWPaXiI/r3E1GA73qTe5U1hbIUxJ
 77zDcc6cmtuKNAA3KzodVPJBg1Vw/Y01ijv4jOJ6jYdcU1kr/kApzCm36caYFwDjF46D
 XUXg==
X-Gm-Message-State: APjAAAXivavKK+/wjdtvtO2D0hISX+e8VmEJr8KhCqd/rjITyaY38XuZ
 VSD7/NX8jJmY5uUnOrrYoRzKLvm+WsX8FXEarzI=
X-Google-Smtp-Source: APXvYqx+uRUrQDDzTGTGx5+6EFY95LQQCBOcvg8rzlgzsYbSHSNXQiR1o3SxSmWi35tja004IUh6qz3rD4e5xqy0qws=
X-Received: by 2002:a19:6904:: with SMTP id e4mr1158017lfc.156.1562691661839; 
 Tue, 09 Jul 2019 10:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190709113715.7761-1-philmd@redhat.com>
 <20190709113715.7761-4-philmd@redhat.com>
In-Reply-To: <20190709113715.7761-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jul 2019 09:57:52 -0700
Message-ID: <CAKmqyKO+7kQvWP+SrtrOnjsR+xbKUu+YYmrsr6CemRDtORzthg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH-for-4.1 3/3] hw/display/xlnx_dp: Avoid
 crash when reading empty RX FIFO
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 4:38 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> In the previous commit we fixed a crash when the guest read a
> register that pop from an empty FIFO.
> By auditing the repository, we found another similar use with
> an easy way to reproduce:
>
>   $ qemu-system-aarch64 -M xlnx-zcu102 -monitor stdio -S
>   QEMU 4.0.50 monitor - type 'help' for more information
>   (qemu) xp/b 0xfd4a0134
>   Aborted (core dumped)
>
>   (gdb) bt
>   #0  0x00007f6936dea57f in raise () at /lib64/libc.so.6
>   #1  0x00007f6936dd4895 in abort () at /lib64/libc.so.6
>   #2  0x0000561ad32975ec in xlnx_dp_aux_pop_rx_fifo (s=3D0x7f692babee70) =
at hw/display/xlnx_dp.c:431
>   #3  0x0000561ad3297dc0 in xlnx_dp_read (opaque=3D0x7f692babee70, offset=
=3D77, size=3D4) at hw/display/xlnx_dp.c:667
>   #4  0x0000561ad321b896 in memory_region_read_accessor (mr=3D0x7f692babf=
620, addr=3D308, value=3D0x7ffe05c1db88, size=3D4, shift=3D0, mask=3D429496=
7295, attrs=3D...) at memory.c:439
>   #5  0x0000561ad321bd70 in access_with_adjusted_size (addr=3D308, value=
=3D0x7ffe05c1db88, size=3D1, access_size_min=3D4, access_size_max=3D4, acce=
ss_fn=3D0x561ad321b858 <memory_region_read_accessor>, mr=3D0x7f692babf620, =
attrs=3D...) at memory.c:569
>   #6  0x0000561ad321e9d5 in memory_region_dispatch_read1 (mr=3D0x7f692bab=
f620, addr=3D308, pval=3D0x7ffe05c1db88, size=3D1, attrs=3D...) at memory.c=
:1420
>   #7  0x0000561ad321ea9d in memory_region_dispatch_read (mr=3D0x7f692babf=
620, addr=3D308, pval=3D0x7ffe05c1db88, size=3D1, attrs=3D...) at memory.c:=
1447
>   #8  0x0000561ad31bd742 in flatview_read_continue (fv=3D0x561ad69c04f0, =
addr=3D4249485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\376\=
177", len=3D1, addr1=3D308, l=3D1, mr=3D0x7f692babf620) at exec.c:3385
>   #9  0x0000561ad31bd895 in flatview_read (fv=3D0x561ad69c04f0, addr=3D42=
49485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\376\177", len=
=3D1) at exec.c:3423
>   #10 0x0000561ad31bd90b in address_space_read_full (as=3D0x561ad5bb3020,=
 addr=3D4249485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\376=
\177", len=3D1) at exec.c:3436
>   #11 0x0000561ad33b1c42 in address_space_read (len=3D1, buf=3D0x7ffe05c1=
dcf0 "\020\335\301\005\376\177", attrs=3D..., addr=3D4249485620, as=3D0x561=
ad5bb3020) at include/exec/memory.h:2131
>   #12 0x0000561ad33b1c42 in memory_dump (mon=3D0x561ad59c4530, count=3D1,=
 format=3D120, wsize=3D1, addr=3D4249485620, is_physical=3D1) at monitor/mi=
sc.c:723
>   #13 0x0000561ad33b1fc1 in hmp_physical_memory_dump (mon=3D0x561ad59c453=
0, qdict=3D0x561ad6c6fd00) at monitor/misc.c:795
>   #14 0x0000561ad37b4a9f in handle_hmp_command (mon=3D0x561ad59c4530, cmd=
line=3D0x561ad59d0f22 "/b 0x00000000fd4a0134") at monitor/hmp.c:1082
>
> Fix by checking the FIFO is not empty before popping from it.
>
> The datasheet is not clear about the reset value of this register,
> we choose to return '0'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index cfd4c700b7..cc5b650df0 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -427,11 +427,18 @@ static uint8_t xlnx_dp_aux_pop_rx_fifo(XlnxDPState =
*s)
>      uint8_t ret;
>
>      if (fifo8_is_empty(&s->rx_fifo)) {
> -        DPRINTF("rx_fifo underflow..\n");
> -        abort();
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Reading empty RX_FIFO\n",
> +                      __func__);
> +        /*
> +         * The datasheet is not clear about the reset value, it seems
> +         * to be unspecified. We choose to return '0'.
> +         */
> +        ret =3D 0;
> +    } else {
> +        ret =3D fifo8_pop(&s->rx_fifo);
> +        DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
>      }
> -    ret =3D fifo8_pop(&s->rx_fifo);
> -    DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
>      return ret;
>  }
>
> --
> 2.20.1
>
>

