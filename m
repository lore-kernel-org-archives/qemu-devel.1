Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E3C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D3720838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQayDWfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D3720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75d3-0002kR-Ex
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j75az-00007e-0w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j75ax-0003FI-8r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:56:00 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j75aw-0003DY-UX; Wed, 26 Feb 2020 17:55:59 -0500
Received: by mail-lf1-x143.google.com with SMTP id y17so558362lfe.8;
 Wed, 26 Feb 2020 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9T1PEZ94rXwwPATh7T6h6oYRt0LLjg2suPggv+gHdaY=;
 b=IQayDWfUz+Qc4wIS2Pc3ZnLqwnXbW3Bw31nXvCPrf0xUDtcotr/0MOm6Z6uWzbcUSJ
 Er4ZlHZOnkvlF3Q5FyEw9+S5wCDPQeBcBM0SSTrXdwkksjpqdyb0IClbe86RSlHcWveX
 OPvc6f8OFMmfJMFyNHPDnxCN8EfRiUHyoCaP22Y7I1qn62w38ZvbITaOdGmO859GZuW5
 3PsUFuv2ljPSPtRS+ZsSPil9NM20cBBAwZO0HfPZ2aH3GIIAByriL/L+CBnrrRRa9nZ4
 mfLUaAFFcCJZKD03CCZ1M59ocm/tRYNJAbYLSG3ig8xqt4B78Bh8f+hYXb3c8gnShg7A
 eXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9T1PEZ94rXwwPATh7T6h6oYRt0LLjg2suPggv+gHdaY=;
 b=W9UbyaAc475loLZ0FLwaTMAcxAzESt5hI3PCAdHkbFulA+/M5f3JmsB9wCPCH7CVY7
 hu4cIL/wVS7j7U/cATvM3sWA3ocEjrt9rf2RR4fuEbqorRSnE6vi/UYYgni4oH07EFo9
 A0jp3MttPfWgx9OznblBVAvRxAQLySKZhqsWHSS6u4s1sctkfeNAikCnfUDl5mQFdoTY
 9n7vF786farBD+WGaosiQ8/7NEBrAZPNWpYG6wWW9WRPf/bOmNw6rjRWFwWwc1msbN0Q
 OQxmtETFRw+hHLX+NYBHtaSOc2h1mrMjmRBBLnn65HVbE02m3VcZWXli0YfQm9uAa64f
 m2Tw==
X-Gm-Message-State: ANhLgQ1XXqv2WhyO5oecckD3cGys8YHgKR9WN3VY0MKfECGXTuZDKZ1L
 AMAI4FXzOxVVp+eFmNJSDlZ/OOqeI4OjKvCd9dc=
X-Google-Smtp-Source: ADFU+vuz6NgXMGzZ18oh7BC1ojPnZqspqPjLE/kpxv4Xo/eNoAEbZmAgrGmOkGufyEwW9IiLP1s3+gWoA/w/eOAfP0I=
X-Received: by 2002:a05:6512:3048:: with SMTP id
 b8mr471804lfb.102.1582757757068; 
 Wed, 26 Feb 2020 14:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-7-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-7-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 14:48:19 -0800
Message-ID: <CAKmqyKMfytsugQ0XewgTcohu8Ko6TdH0VkEKrnQktpa2qzD8yA@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] hw/misc/zynq_slcr: add clock generation for uarts
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 5:56 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add some clocks to zynq_slcr
> + the main input clock (ps_clk)
> + the reference clock outputs for each uart (uart0 & 1)
>
> This commit also transitional the slcr to multi-phase reset as it is
> required to initialize the clocks correctly.
>
> The clock frequencies are computed using the internal pll & uart configuration
> registers and the input ps_clk frequency.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

This looks fine, although I didn't compare it to the datasheet, I'll
leave that for a Xilinx person to do.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> v7:
>   + handle migration of input clock
>   + update ClockIn/ClockOut types
>   + comments correction/precision (Peter)
> ---
>  hw/misc/zynq_slcr.c | 172 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 168 insertions(+), 4 deletions(-)
>
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index b9a38272d9..f7472d1f3c 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -22,6 +22,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/registerfields.h"
> +#include "hw/qdev-clock.h"
>
>  #ifndef ZYNQ_SLCR_ERR_DEBUG
>  #define ZYNQ_SLCR_ERR_DEBUG 0
> @@ -45,6 +46,12 @@ REG32(LOCKSTA, 0x00c)
>  REG32(ARM_PLL_CTRL, 0x100)
>  REG32(DDR_PLL_CTRL, 0x104)
>  REG32(IO_PLL_CTRL, 0x108)
> +/* fields for [ARM|DDR|IO]_PLL_CTRL registers */
> +    FIELD(xxx_PLL_CTRL, PLL_RESET, 0, 1)
> +    FIELD(xxx_PLL_CTRL, PLL_PWRDWN, 1, 1)
> +    FIELD(xxx_PLL_CTRL, PLL_BYPASS_QUAL, 3, 1)
> +    FIELD(xxx_PLL_CTRL, PLL_BYPASS_FORCE, 4, 1)
> +    FIELD(xxx_PLL_CTRL, PLL_FPDIV, 12, 7)
>  REG32(PLL_STATUS, 0x10c)
>  REG32(ARM_PLL_CFG, 0x110)
>  REG32(DDR_PLL_CFG, 0x114)
> @@ -64,6 +71,10 @@ REG32(SMC_CLK_CTRL, 0x148)
>  REG32(LQSPI_CLK_CTRL, 0x14c)
>  REG32(SDIO_CLK_CTRL, 0x150)
>  REG32(UART_CLK_CTRL, 0x154)
> +    FIELD(UART_CLK_CTRL, CLKACT0, 0, 1)
> +    FIELD(UART_CLK_CTRL, CLKACT1, 1, 1)
> +    FIELD(UART_CLK_CTRL, SRCSEL,  4, 2)
> +    FIELD(UART_CLK_CTRL, DIVISOR, 8, 6)
>  REG32(SPI_CLK_CTRL, 0x158)
>  REG32(CAN_CLK_CTRL, 0x15c)
>  REG32(CAN_MIOCLK_CTRL, 0x160)
> @@ -179,11 +190,127 @@ typedef struct ZynqSLCRState {
>      MemoryRegion iomem;
>
>      uint32_t regs[ZYNQ_SLCR_NUM_REGS];
> +
> +    Clock *ps_clk;
> +    Clock *uart0_ref_clk;
> +    Clock *uart1_ref_clk;
>  } ZynqSLCRState;
>
> -static void zynq_slcr_reset(DeviceState *d)
> +/*
> + * return the output frequency of ARM/DDR/IO pll
> + * using input frequency and PLL_CTRL register
> + */
> +static uint64_t zynq_slcr_compute_pll(uint64_t input, uint32_t ctrl_reg)
>  {
> -    ZynqSLCRState *s = ZYNQ_SLCR(d);
> +    uint32_t mult = ((ctrl_reg & R_xxx_PLL_CTRL_PLL_FPDIV_MASK) >>
> +            R_xxx_PLL_CTRL_PLL_FPDIV_SHIFT);
> +
> +    /* first, check if pll is bypassed */
> +    if (ctrl_reg & R_xxx_PLL_CTRL_PLL_BYPASS_FORCE_MASK) {
> +        return input;
> +    }
> +
> +    /* is pll disabled ? */
> +    if (ctrl_reg & (R_xxx_PLL_CTRL_PLL_RESET_MASK |
> +                    R_xxx_PLL_CTRL_PLL_PWRDWN_MASK)) {
> +        return 0;
> +    }
> +
> +    /* frequency multiplier -> period division */
> +    return input / mult;
> +}
> +
> +/*
> + * return the output period of a clock given:
> + * + the periods in an array corresponding to input mux selector
> + * + the register xxx_CLK_CTRL value
> + * + enable bit index in ctrl register
> + *
> + * This function makes the assumption that the ctrl_reg value is organized as
> + * follows:
> + * + bits[13:8]  clock frequency divisor
> + * + bits[5:4]   clock mux selector (index in array)
> + * + bits[index] clock enable
> + */
> +static uint64_t zynq_slcr_compute_clock(const uint64_t periods[],
> +                                        uint32_t ctrl_reg,
> +                                        unsigned index)
> +{
> +    uint32_t srcsel = extract32(ctrl_reg, 4, 2); /* bits [5:4] */
> +    uint32_t divisor = extract32(ctrl_reg, 8, 6); /* bits [13:8] */
> +
> +    /* first, check if clock is disabled */
> +    if (((ctrl_reg >> index) & 1u) == 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * according to the Zynq technical ref. manual UG585 v1.12.2 in
> +     * Clocks chapter, section 25.10.1 page 705:
> +     * "The 6-bit divider provides a divide range of 1 to 63"
> +     * We follow here what is implemented in linux kernel and consider
> +     * the 0 value as a bypass (no division).
> +     */
> +    /* frequency divisor -> period multiplication */
> +    return periods[srcsel] * (divisor ? divisor : 1u);
> +}
> +
> +/*
> + * macro helper around zynq_slcr_compute_clock to avoid repeating
> + * the register name.
> + */
> +#define ZYNQ_COMPUTE_CLK(state, plls, reg, enable_field) \
> +    zynq_slcr_compute_clock((plls), (state)->regs[reg], \
> +                            reg ## _ ## enable_field ## _SHIFT)
> +
> +/**
> + * Compute and set the ouputs clocks periods.
> + * But do not propagate them further. Connected clocks
> + * will not receive any updates (See zynq_slcr_compute_clocks())
> + */
> +static void zynq_slcr_compute_clocks(ZynqSLCRState *s)
> +{
> +    uint64_t ps_clk = clock_get(s->ps_clk);
> +
> +    /* consider outputs clocks are disabled while in reset */
> +    if (device_is_in_reset(DEVICE(s))) {
> +        ps_clk = 0;
> +    }
> +
> +    uint64_t io_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_IO_PLL_CTRL]);
> +    uint64_t arm_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_ARM_PLL_CTRL]);
> +    uint64_t ddr_pll = zynq_slcr_compute_pll(ps_clk, s->regs[R_DDR_PLL_CTRL]);
> +
> +    uint64_t uart_mux[4] = {io_pll, io_pll, arm_pll, ddr_pll};
> +
> +    /* compute uartX reference clocks */
> +    clock_set(s->uart0_ref_clk,
> +              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT0));
> +    clock_set(s->uart1_ref_clk,
> +              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT1));
> +}
> +
> +/**
> + * Propagate the outputs clocks.
> + * zynq_slcr_compute_clocks() should have been called before
> + * to configure them.
> + */
> +static void zynq_slcr_propagate_clocks(ZynqSLCRState *s)
> +{
> +    clock_propagate(s->uart0_ref_clk);
> +    clock_propagate(s->uart1_ref_clk);
> +}
> +
> +static void zynq_slcr_ps_clk_callback(void *opaque)
> +{
> +    ZynqSLCRState *s = (ZynqSLCRState *) opaque;
> +    zynq_slcr_compute_clocks(s);
> +    zynq_slcr_propagate_clocks(s);
> +}
> +
> +static void zynq_slcr_reset_init(Object *obj, ResetType type)
> +{
> +    ZynqSLCRState *s = ZYNQ_SLCR(obj);
>      int i;
>
>      DB_PRINT("RESET\n");
> @@ -277,6 +404,23 @@ static void zynq_slcr_reset(DeviceState *d)
>      s->regs[R_DDRIOB + 12] = 0x00000021;
>  }
>
> +static void zynq_slcr_reset_hold(Object *obj)
> +{
> +    ZynqSLCRState *s = ZYNQ_SLCR(obj);
> +
> +    /* will disable all output clocks */
> +    zynq_slcr_compute_clocks(s);
> +    zynq_slcr_propagate_clocks(s);
> +}
> +
> +static void zynq_slcr_reset_exit(Object *obj)
> +{
> +    ZynqSLCRState *s = ZYNQ_SLCR(obj);
> +
> +    /* will compute output clocks according to ps_clk and registers */
> +    zynq_slcr_compute_clocks(s);
> +    zynq_slcr_propagate_clocks(s);
> +}
>
>  static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
>  {
> @@ -409,6 +553,13 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>          }
>          break;
> +    case R_IO_PLL_CTRL:
> +    case R_ARM_PLL_CTRL:
> +    case R_DDR_PLL_CTRL:
> +    case R_UART_CLK_CTRL:
> +        zynq_slcr_compute_clocks(s);
> +        zynq_slcr_propagate_clocks(s);
> +        break;
>      }
>  }
>
> @@ -418,6 +569,13 @@ static const MemoryRegionOps slcr_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> +static const ClockPortInitArray zynq_slcr_clocks = {
> +    QDEV_CLOCK_IN(ZynqSLCRState, ps_clk, zynq_slcr_ps_clk_callback),
> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
> +    QDEV_CLOCK_END
> +};
> +
>  static void zynq_slcr_init(Object *obj)
>  {
>      ZynqSLCRState *s = ZYNQ_SLCR(obj);
> @@ -425,14 +583,17 @@ static void zynq_slcr_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
>                            ZYNQ_SLCR_MMIO_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +
> +    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
>  }
>
>  static const VMStateDescription vmstate_zynq_slcr = {
>      .name = "zynq_slcr",
> -    .version_id = 2,
> +    .version_id = 3,
>      .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, ZynqSLCRState, ZYNQ_SLCR_NUM_REGS),
> +        VMSTATE_CLOCK_V(ps_clk, ZynqSLCRState, 3),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -440,9 +601,12 @@ static const VMStateDescription vmstate_zynq_slcr = {
>  static void zynq_slcr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>
>      dc->vmsd = &vmstate_zynq_slcr;
> -    dc->reset = zynq_slcr_reset;
> +    rc->phases.enter = zynq_slcr_reset_init;
> +    rc->phases.hold  = zynq_slcr_reset_hold;
> +    rc->phases.exit  = zynq_slcr_reset_exit;
>  }
>
>  static const TypeInfo zynq_slcr_info = {
> --
> 2.25.1
>
>

