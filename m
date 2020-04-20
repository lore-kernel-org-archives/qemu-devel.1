Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4293BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059252078A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjJK4+9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059252078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQgJ-0000Ra-2I
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 03:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQfR-0008P9-Ce
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:16:33 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQfP-0003zO-DO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:16:33 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32992)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQfO-0003xD-UC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:16:31 -0400
Received: by mail-ej1-x643.google.com with SMTP id nv1so7049001ejb.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dpSORFEpMcnuKtTJjqciclAmpJDMaFvpza3o1AI7AYE=;
 b=sjJK4+9UhTwbaaYtQ2XZw+vQkvAs2W6Nlp1Ymq8Vf3wJvGqvK7w0WfY6eZ1pvsYkd4
 itORaQbJymYACELcply6BtBLH6jIvCJjiqQB30ecXymA0TLoiBLFx3EK+7CZZnenF9tv
 apbCIijxVnZE9hUyyVaer6RT4AuFTMbnc3UH+0tXK2cFGJBe105WUPVJNbRr3gSBrTjJ
 Hav1ZpRv5W+6ARFerCVMsNAz6gubRGBRnfUl8UtE5Hlw/awIEYvbEReuokmZSwW4YCb2
 PQulOJr+pWevksoEd1+oxWuIiGr6YGw8XbYLrvP5mnZc0kXHNomUgFwO78onkprnEYwp
 Q/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dpSORFEpMcnuKtTJjqciclAmpJDMaFvpza3o1AI7AYE=;
 b=kLNw72nvmf+MAnE2MQRC5slDsb7ZtExhPjIJokCFfTXj9xn3U3ypgqtCYH15E1Pc53
 +vAbRf7HZb7m6BDPgtJEopWMPER95YD5swA3IS2nyH0em+IgyWeem8uhg2fYQBw3yKWf
 bRcj910tAhtxfVtk3I230YbW1/db7Pm0n69UEwQktIEl6pCCaLeEEYm68lEbUJ9phEoH
 B/4w9FpVItwLEOEgT9WGNP0ORYEGJaweREC0+ImrdXFE65RLinRlE/HXLv2p3+6nY3uj
 Sa/+UZkvQH8xJ6+aYrFxsqffVrMGY7fx5uBnZCwju+LdaJ0f5WE9AsWbtR4J5oC9CbBp
 Xoig==
X-Gm-Message-State: AGi0PuY/LIfLh2V+5aIdFi+vdU4y3q/IAfPGLz90rWuLTgf5ezh7HgCV
 HiA0iR2SkNCl/VpuSfnh0GQ=
X-Google-Smtp-Source: APiQypLo/LF3Iw34JQ+NOwW3imrVTIoKloociAmtKVmK2krPXm0aa3xGjVe/Ez1YbEr3aSABFHFWXQ==
X-Received: by 2002:a17:906:1502:: with SMTP id
 b2mr14786256ejd.359.1587366988580; 
 Mon, 20 Apr 2020 00:16:28 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h12sm50222ejj.40.2020.04.20.00.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 00:16:28 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <c61f354f-1768-8a53-e4e8-c8af69007e3f@amsat.org>
Date: Mon, 20 Apr 2020 09:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200329001705.15966-5-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

On 3/29/20 1:17 AM, Paul Zimmerman wrote:
> Add the dwc-hsotg (dwc2) USB host controller emulation code.
> Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.
> 
> Note that to use this with the dwc-otg driver in the Raspbian
> kernel, you must pass the option "dwc_otg.fiq_fsm_enable=0" on
> the kernel command line.
> 
> Emulation of slave mode and of descriptor-DMA mode has not been
> implemented yet. These modes are seldom used.
> 
> I have used some on-line sources of information while developing
> this emulation, including:
> 
> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> has a pretty complete description of the controller starting on
> page 370.
> 
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
> has a description of the controller registers starting on page
> 130.
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  hw/usb/hcd-dwc2.c   | 1301 +++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/trace-events |   47 ++
>  2 files changed, 1348 insertions(+)
>  create mode 100644 hw/usb/hcd-dwc2.c
> 
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
[...]
> +static void dwc2_init(DWC2State *s, DeviceState *dev)
> +{
> +    s->usb_frame_time = NANOSECONDS_PER_SECOND / 1000;          /* 1000000 */
> +    if (NANOSECONDS_PER_SECOND >= USB_HZ_FS) {
> +        s->usb_bit_time = NANOSECONDS_PER_SECOND / USB_HZ_FS;   /* 83.3 */
> +    } else {
> +        s->usb_bit_time = 1;
> +    }
> +
> +    s->fi = 11999;

What is this magic number?

> +
> +    memory_region_init(&s->mem, OBJECT(dev), "dwc2", DWC2_MMIO_SIZE);
> +    memory_region_init_io(&s->mem_glbreg, OBJECT(dev), &dwc2_mmio_glbreg_ops, s,
> +                          "global", 0x70);
> +    memory_region_init_io(&s->mem_fszreg, OBJECT(dev), &dwc2_mmio_fszreg_ops, s,
> +                          "hptxfsiz", 0x4);
> +    memory_region_init_io(&s->mem_hreg0, OBJECT(dev), &dwc2_mmio_hreg0_ops, s,
> +                          "host", 0x44);
> +    memory_region_init_io(&s->mem_hreg1, OBJECT(dev), &dwc2_mmio_hreg1_ops, s,
> +                          "host channels", 0x20 * NB_CHAN);
> +    memory_region_init_io(&s->mem_pcgreg, OBJECT(dev), &dwc2_mmio_pcgreg_ops, s,
> +                          "power/clock", 0x8);
> +    memory_region_init_io(&s->mem_hreg2, OBJECT(dev), &dwc2_mmio_hreg2_ops, s,
> +                          "host fifos", NB_CHAN * 0x1000);
> +
> +    memory_region_add_subregion(&s->mem, s->glbregbase, &s->mem_glbreg);
> +    memory_region_add_subregion(&s->mem, s->fszregbase, &s->mem_fszreg);
> +    memory_region_add_subregion(&s->mem, s->hreg0base, &s->mem_hreg0);
> +    memory_region_add_subregion(&s->mem, s->hreg1base, &s->mem_hreg1);
> +    memory_region_add_subregion(&s->mem, s->pcgregbase, &s->mem_pcgreg);
> +    memory_region_add_subregion(&s->mem, s->hreg2base, &s->mem_hreg2);
> +
> +    s->eof_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                dwc2_frame_boundary, s);
> +}
> +
> +static void dwc2_sysbus_reset(DeviceState *dev)
> +{
> +    SysBusDevice *d = SYS_BUS_DEVICE(dev);
> +    DWC2State *s = DWC2_USB(d);
> +
> +    dwc2_reset(s);
> +}
> +
> +static void dwc2_sysbus_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *d = SYS_BUS_DEVICE(dev);
> +    DWC2State *s = DWC2_USB(dev);
> +
> +    s->glbregbase = 0;
> +    s->fszregbase = 0x0100;
> +    s->hreg0base = 0x0400;
> +    s->hreg1base = 0x0500;
> +    s->pcgregbase = 0x0e00;
> +    s->hreg2base = 0x1000;

No need to use variable for the constant base addresses, use them
directly in as argument to memory_region_add_subregion().

Since you don't reuse each block, and blocks cover very few registers,
have you considered using a pair of MRs instead? One of 4KB and the
other 64KB. hreg2 is the only one particularly different.

> +    s->portnr = NB_PORTS;
> +    s->as = &address_space_memory;
> +
> +    dwc2_realize(s, dev, errp);
> +    dwc2_init(s, dev);
> +    sysbus_init_irq(d, &s->irq);
> +    sysbus_init_mmio(d, &s->mem);
> +}
[...]

