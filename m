Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC2C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEC220674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="fIcbZZK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEC220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUBH-00041S-8u
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icU8G-0003BR-F2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icU8F-0006l1-8P
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:51:52 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icU8B-0006ih-Rz; Wed, 04 Dec 2019 07:51:48 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0800496EF0;
 Wed,  4 Dec 2019 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575463905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBFgRgY4wIEhLoMAYwc94hmZaFaQBM/mMjjINIFJ5ZI=;
 b=fIcbZZK/GP3axF2KOd6gSzFzLkmwVdlQPTY13wtdOQUQ1tdvRqstqQGdCW7x5On5l2PPwb
 ZJu1Onc9esznT+CnUPhLaalnkUlwcCW7QxHhRq1CLBihRfz0zRaIeoSrUapbI5SalatM+H
 v3aAJoi4nGSIwKR38ilekoGMg7KjqU8=
Subject: Re: [PATCH v6 7/9] hw/misc/zynq_slcr: add clock generation for uarts
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-8-damien.hedde@greensocs.com>
 <CAFEAcA_mmBeVnx5TsdeEaEU=jNnkFR9aa-nziaTQD7par7GpoA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <7e255f65-bbfa-897a-4dd0-cb366886f32c@greensocs.com>
Date: Wed, 4 Dec 2019 13:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mmBeVnx5TsdeEaEU=jNnkFR9aa-nziaTQD7par7GpoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575463905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBFgRgY4wIEhLoMAYwc94hmZaFaQBM/mMjjINIFJ5ZI=;
 b=3N5xzz1AsIzwskbc4d4tQ8te3WGoJ42BR7F2ZfcXncEENAfIok9ANzMCuKZUHDh/6nx8GN
 UwWO9QL7kBr16K48vzIjPWmFAdDExAO2MXWiy6G+xAYdCEFsTVho5X3zT2EIC4rYhnS2f3
 HQrkGZs2VSsIXDrPE6YVJL7Iteg14SQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575463905; a=rsa-sha256; cv=none;
 b=7jh+YjDZfbgf5tQMfwe6bqIXCKyuv8k1OZdQL8g8W6rFUvmQZNSeTJxSyGIKhE03Xgn3wt
 M0McP9y3PXyBF66cv9Ac9a2KrrmSYFDwCMeIYucA5YqB6N7Ktm2A5Jcsl83MSo1rKMLYJm
 Jwk30WQ2Aj8FXnOg6oAxazaXZNjifaY=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 4:20 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Switch the slcr to multi-phase reset and add some clocks:
>> + the main input clock (ps_clk)
>> + the reference clock outputs for each uart (uart0 & 1)
>>
>> The clock frequencies are computed using the internal pll & uart configuration
>> registers and the ps_clk frequency.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
> Review of this and the following two patches by some Xilinx
> person would be nice. I've just looked them over for general
> issues, and haven't checked against the hardware specs.
> 
>> ---
> 
> 
>> +/*
>> + * return the output frequency of a clock given:
>> + * + the frequencies in an array corresponding to mux's indexes
>> + * + the register xxx_CLK_CTRL value
>> + * + enable bit index in ctrl register
>> + *
>> + * This function make the assumption that ctrl_reg value is organized as follow:
> 
> "makes"; "that the"; "follows"
> 
>> + * + bits[13:8] clock divisor
>> + * + bits[5:4]  clock mux selector (index in array)
>> + * + bits[index] clock enable
>> + */
>> +static uint64_t zynq_slcr_compute_clock(const uint64_t mux[],
>> +                                        uint32_t ctrl_reg,
>> +                                        unsigned index)
>> +{
>> +    uint32_t srcsel = extract32(ctrl_reg, 4, 2); /* bits [5:4] */
>> +    uint32_t divisor = extract32(ctrl_reg, 8, 6); /* bits [13:8] */
>> +
>> +    /* first, check if clock is enabled */
>> +    if (((ctrl_reg >> index) & 1u) == 0) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * according to the Zynq technical ref. manual UG585 v1.12.2 in
>> +     * "Clocks" chapter, section 25.10.1 page 705" the range of the divisor
>> +     * is [1;63].
> 
> Is this the range notation the spec doc uses?

The exact terms is:
"The 6-bit divider provides a divide range of 1 to 63"
At the time, I checked also the kernel sources, and this is the behavior
implemented in the driver as well (1 based timer and allowing 0 special
value for bypass). The bypass is undocumented as far as I can tell.

> 
>> +     * So divide the source while avoiding division-by-zero.
>> +     */
>> +    return mux[srcsel] / (divisor ? divisor : 1u);
>> +}
>> +
> 
>> +static const ClockPortInitArray zynq_slcr_clocks = {
>> +    QDEV_CLOCK_IN(ZynqSLCRState, ps_clk, zynq_slcr_ps_clk_callback),
>> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
>> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
>> +    QDEV_CLOCK_END
>> +};
>> +
>>  static void zynq_slcr_init(Object *obj)
>>  {
>>      ZynqSLCRState *s = ZYNQ_SLCR(obj);
>> @@ -425,6 +559,8 @@ static void zynq_slcr_init(Object *obj)
>>      memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
>>                            ZYNQ_SLCR_MMIO_SIZE);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>> +
>> +    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
>>  }
>>
>>  static const VMStateDescription vmstate_zynq_slcr = {
>> @@ -440,9 +576,12 @@ static const VMStateDescription vmstate_zynq_slcr = {
>>  static void zynq_slcr_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>>
>>      dc->vmsd = &vmstate_zynq_slcr;
>> -    dc->reset = zynq_slcr_reset;
>> +    rc->phases.init = zynq_slcr_reset_init;
>> +    rc->phases.hold = zynq_slcr_reset_hold;
>> +    rc->phases.exit = zynq_slcr_reset_exit;
>>  }
> 
> We're adding an input clock, so doesn't the migration
> state struct need to be updated to migrate it ?
Yes, we can. Although this input clock is really not expected to change.

> 
> thanks
> -- PMM
> 

