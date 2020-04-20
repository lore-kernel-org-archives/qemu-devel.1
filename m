Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B48C54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B227A20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktylaURl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B227A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQoz-00033V-Pc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 03:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45078 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQoG-0002KB-61
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:25:41 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQoE-0001CA-Oi
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:25:39 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43066)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQoE-0001A1-CV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:25:38 -0400
Received: by mail-ed1-x542.google.com with SMTP id p16so1933578edm.10
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aH/KnVnj+CC50R3TvHIxeVyWVAu1zzzwHnXnwkNRYXc=;
 b=ktylaURlB+O8iXN0nrY5GEKIlXxCmn3CQrxUpG1vsEmNpOms26WNV6BnbxKshbJ75A
 tbJWm4L2f6wZgrisuor8jFWMMx9XCI6OHkeRQma9JoocUcTN+nJA0CC1Fh0FeZk0tBUk
 wTV1mY2wE5BsY9hxEYtAoAGNfpOuoRraGUDPsGKBmIuJ0hGPHNWOoZSqz1IFiwwfNqw4
 w7O985n8lz6Oti4tVXWAa1bc2hAA6z4QruztomEfxRqFn9TT/NGJcd9pHc3w7BLoAdVT
 o0RV/C0VZe1tUd1hi5UwC7ukpKMfC/Lz1wrxUGFAgSfzUNUwAmXjRlfaHDFbqBK47Oh+
 Xz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aH/KnVnj+CC50R3TvHIxeVyWVAu1zzzwHnXnwkNRYXc=;
 b=MV0nemHYFnFzKgtVpVYzZrUTFsWvnzah/XVz46LKQV9elFF7cHjWYQP+oU0JgNjm/P
 HzGr/XDTCxu3ERc1T9JzOpr6TKcbpb9ScbiAVy/0qqLI3L19vnXiM15Kmo/8bK/0POaC
 15S8s7o7KNB8rc8RrPXP0hjkbW6x/wMmfTsXc4aw+ThopC+03wAKlW8rJCzASan3cwzP
 4Q3rhjuKxBW0WGFdJ2zfi+G6wkvEiU5H7paDDcuKyKRxDVcBiPO8fzLKK6Rvo0UgoHA+
 S5x6q7vWE+zIcTDXjAcRd4fO9KuTjI3XDkaqkATZyR274QyvNSyNGgEZGbO6ko2hs+bM
 gQ/A==
X-Gm-Message-State: AGi0PuZ0YiFfsu0QNCTuXlq6jMzsPSCupR4qe0BVXzmC5cA0QvybEG+1
 olXxwdxDrS+Gn39Sh0XkK+U=
X-Google-Smtp-Source: APiQypIDr+ZbTfK992nowlqr/tST/BQwQTY/4LoXoYvggaUL+Xc9dB6SPaNw8Jn140cYm2f+GhClFA==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr13368404edn.204.1587367536742; 
 Mon, 20 Apr 2020 00:25:36 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l7sm53008ejx.82.2020.04.20.00.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 00:25:36 -0700 (PDT)
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
Message-ID: <2a1d3776-0a6b-360e-0c71-9b48fda8dd98@amsat.org>
Date: Mon, 20 Apr 2020 09:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200329001705.15966-5-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::542
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
[...]
> +static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,
> +                             unsigned size)
> +{
> +    uint64_t orig = val;
> +
> +    /* TODO - implement FIFOs to support slave mode */
> +    val &= 0xffffffff;
> +    trace_usb_dwc2_hreg2_write(addr, addr >> 12, orig, 0, val);
> +}
> +
[...]
 +
> +static const MemoryRegionOps dwc2_mmio_hreg2_ops = {
> +    .read = dwc2_hreg2_read,
> +    .write = dwc2_hreg2_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
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
[...]
What is this region used for? 64KB of packet buffer sram? I'm wondering
if this shouldn't be created with a memory_region_init_ram() call actually.


