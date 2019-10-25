Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D1ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241C02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcV10b9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241C02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6Sg-0003Zh-Gy
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iO6Fh-0003bD-32
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iO6Fd-0006Cc-3P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:32:02 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iO6Fc-00067c-J3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:32:01 -0400
Received: by mail-lf1-x144.google.com with SMTP id u16so2846707lfq.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=liPsnNhb6zm0Y030WC/f4qnofzc2vYL2mJjUoU6rTgs=;
 b=KcV10b9uch+uI/2gHfYDwXRaHh7oT2NdoVv3BBCkW9joz7rJT8JL990Uq+az3zrMXr
 +Yu3DEEtpSE0vkZcnnM0wAKQJA7a3Z8wt11llNZ14pOk40CYRxo/IBy+70AD3DycX5ja
 AWeHad/dV3qAnlcnkdhghVens5+B68c80J3bxSEs/CN1w0jMxMR3bRcc/Pu3b5upeY7U
 TPBrMQto2l5bSWZtly87VX2TZdoHQRKaFAUjDvM9Pm0YgvijXB6tb4FrDbzRu74cm72O
 7n06xQ4Chh33uocm9fUjNWWnvVyJJvjYBdOtRMNkXOtsVvqpnXl28TnYpi52zUrt396K
 uuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=liPsnNhb6zm0Y030WC/f4qnofzc2vYL2mJjUoU6rTgs=;
 b=O0cyOXFYDpdyi9kyjlS43xlC9o3JvQR71GItcWE0gUdLg1T3W4vyzycgIEUYa30Cgk
 CwHOsMA9gnz7GUq4C/fmrutwnDgdPeI+UOcpOPPrEcvdQJU9o0Hb+5sMNCJnMUTUb61e
 COC27H4OL18sCrWJzLPKxkCAIlyrqD5BBgqmeP5R9kd7YFtDXQa/aa1iQw2PHGXf+K7i
 iHjK9IB/q5Ox8+CuEeQLE0oGcuQKvuDhWMDpXBbfaHim8fBilfkCc6/jm0PLP+6lVPAs
 g40Por/0imUbGAP+pmHKSPL24rs6AwtTeoCDvgRwIebywnM/wTlZcts1SGJ3kspWZKSd
 jJZQ==
X-Gm-Message-State: APjAAAX5BmyO9P7uX3lWQg0OeachxyHiX05v9tjkQtQgA71bouk6QZio
 O0QA+3S8FmA3/MCAB9/fxhhLc8iFVJwK/YM2nkc=
X-Google-Smtp-Source: APXvYqxGy2ptC/0vJCqxfG1c8HfnYylfvoKzPcmQ1pzIw4hGwZc/qxFpHsDETLF+QUUAhYTRYixVbHB4gh8dbvZpqII=
X-Received: by 2002:ac2:5dd5:: with SMTP id x21mr3999364lfq.156.1572035519014; 
 Fri, 25 Oct 2019 13:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Oct 2019 13:31:32 -0700
Message-ID: <CAKmqyKMdO1k1YaYvpbA4hGai6a5mPMG2_Du3u7XdyEGcYz8J=Q@mail.gmail.com>
Subject: Re: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
 Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 10:31 PM Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> A few configuration register writes need not update the spi bus state, so just
> return after register write.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes for V2:
>         Just skip update of spips cs and fifos
>         Update commit message accordingly
> Changes for V4:
>         Avoid checking for zynqmp qspi
>         Skip spi bus update for few of the registers Changes for V4:
>         Move the register list to existing switch case above.
> Change for V5:
>         Fixed Commit message.
>
>  hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..0d6c2e1 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -109,6 +109,7 @@
>  #define R_GPIO              (0x30 / 4)
>  #define R_LPBK_DLY_ADJ      (0x38 / 4)
>  #define R_LPBK_DLY_ADJ_RESET (0x33)
> +#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
>  #define R_TXD1              (0x80 / 4)
>  #define R_TXD2              (0x84 / 4)
>  #define R_TXD3              (0x88 / 4)
> @@ -139,6 +140,8 @@
>  #define R_LQSPI_STS         (0xA4 / 4)
>  #define LQSPI_STS_WR_RECVD      (1 << 1)
>
> +#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
> +#define R_ECO               (0xF8 / 4)
>  #define R_MOD_ID            (0xFC / 4)
>
>  #define R_GQSPI_SELECT          (0x144 / 4)
> @@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>  {
>      int mask = ~0;
>      XilinxSPIPS *s = opaque;
> +    bool try_flush = true;
>
>      DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
>      addr >>= 2;
> @@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>          tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
>                        s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
>          goto no_reg_update;
> +    /* Skip SPI bus update for below registers writes */
> +    case R_GPIO:
> +    case R_LPBK_DLY_ADJ:
> +    case R_IOU_TAPDLY_BYPASS:
> +    case R_DUMMY_CYCLE_EN:
> +    case R_ECO:
> +        try_flush = false;
> +        break;
>      }
>      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
>  no_reg_update:
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_check_flush(s);
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_update_ixr(s);
> +    if (try_flush) {
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_check_flush(s);
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_update_ixr(s);
> +    }
>  }
>
>  static const MemoryRegionOps spips_ops = {
> --
> 2.7.4
>
>

