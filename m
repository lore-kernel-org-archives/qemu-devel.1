Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49423C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303723426
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT+Yz4no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303723426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqGv-0007UI-AL
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqGG-0006vb-F3; Mon, 29 Jun 2020 05:39:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqGD-0000rN-6z; Mon, 29 Jun 2020 05:39:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so15450569wmh.2;
 Mon, 29 Jun 2020 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L8zI7YPGNZeY9/AUI6Vz6l0QsHvF2ayZSlMrp7XHAkA=;
 b=eT+Yz4noEe5Rek31bqw9kmhx6RjcID2Fm8SBr2W2Y6vWl7TQQit7xDfsZJNzgvdWlS
 LyBzDhp2SelcDnjyE+R//8bPqPTTGCVyln6AnYPYRbHpPvnikdoVk3EaQL9YBcPtjaDJ
 2jYx87d9SjImqBR9jxPw8UoXy4gVBF0JiOL3v/E2HcKB/Tl7emeigLAjZRw/x1++D9cw
 BVzddj7VPCzUMtguo8nO1DqQXnfvS4QyTT4YVo1IYQf+YK2ZGabhNgx3FU/G3nAn3HAW
 2a/DIOl2GcQOt5Ytd+B1AHHs9F6+44T6PE9FcVYbLYZUETuf7x0FNggBTZOO+0hGkACD
 wsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L8zI7YPGNZeY9/AUI6Vz6l0QsHvF2ayZSlMrp7XHAkA=;
 b=LaADqugOh/eKzxJLACXWxvPRvptGKOdbe1tOjp1mJea2WBHIAQwRh/my2X9vDihvrq
 YVI1lrw5KCP1HkKMef5ueX010iUfgyiBSIj+mIOOT0ss5ZeEaH4gdJO1UwHn+8fdGJPt
 yfCak9hH58wq7/NNdNjIq2J196yKoqc4CxZGbymgu7bmahW01z//QiRoUpqX2oDryVDQ
 9sm5qsXq1YMm2BygQhkxYp4cuOue0xQ9U1J4SrLDyGGKcYWkS2uGmPAbIk8pZGABndTH
 1OFRpp3B6fV8oD3SyecmE/+iyo+U4DE2HMuYWLLX5TqVUz2FZVXdFRVqT3R1v2KFbGUp
 GUsg==
X-Gm-Message-State: AOAM53188EFGacehhi0GUG66o/rTL+/oZ7mUf0qS2bAJ+gknBFcPez3b
 X1WzFKrsqKEQp8szd77APok=
X-Google-Smtp-Source: ABdhPJyPv6CNkSpcDnlPfUSssVQGITrK/0XcGaSr3wRFBaVBwqJHVS9YeHaONK9/hwZ/TOxUpQ0v3Q==
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr15360192wme.159.1593423571237; 
 Mon, 29 Jun 2020 02:39:31 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y7sm42493493wrt.11.2020.06.29.02.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:39:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/tosa: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628203748.14250-1-peter.maydell@linaro.org>
 <20200628203748.14250-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <bdc37753-de8e-eba4-75e0-32eada401b24@amsat.org>
Date: Mon, 29 Jun 2020 11:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628203748.14250-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Hi Peter,

On 6/28/20 10:37 PM, Peter Maydell wrote:
> Currently we have a free-floating set of IRQs and a function
> tosa_out_switch() which handle the GPIO lines on the tosa board which
> connect to LEDs, and another free-floating IRQ and tosa_reset()
> function to handle the GPIO line that resets the system.  Encapsulate
> this behaviour in a simple QOM device.
> 
> This commit fixes Coverity issue CID 1421929 (which pointed out that
> the 'outsignals' in tosa_gpio_setup() were leaked), because it
> removes the use of the qemu_allocate_irqs() API from this code
> entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is simpler than the spitz changes because the new device
> doesn't need to refer to any of the other devices on the board.
> ---
>  hw/arm/tosa.c | 88 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 06ecf1e7824..383b3b22e24 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -65,24 +65,39 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
>      pxa2xx_pcmcia_attach(cpu->pcmcia[0], md);
>  }
>  
> -static void tosa_out_switch(void *opaque, int line, int level)
> +/*
> + * Encapsulation of some GPIO line behaviour for the Tosa board
> + *
> + * QEMU interface:
> + *  + named GPIO inputs "leds[0..3]": assert to light LEDs
> + *  + named GPIO input "reset": when asserted, resets the system
> + */
> +
> +#define TYPE_TOSA_MISC_GPIO "tosa-misc-gpio"
> +#define TOSA_MISC_GPIO(obj) \
> +    OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
> +
> +typedef struct TosaMiscGPIOState {
> +    SysBusDevice parent_obj;
> +} TosaMiscGPIOState;

Since we don't really use this type, can we avoid declaring it?

Like:

  #define TOSA_MISC_GPIO(obj) \
      OBJECT_CHECK(SysBusDevice, (obj), TYPE_TOSA_MISC_GPIO)

And in tosa_misc_gpio_info:

    .instance_size = sizeof(SysBusDevice)

> +
> +static void tosa_gpio_leds(void *opaque, int line, int level)
>  {
>      switch (line) {
> -        case 0:
> -            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 1:
> -            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 2:
> -            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 3:
> -            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
> -            break;
> -        default:
> -            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
> -            break;
> +    case 0:
> +        fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> +        break;
> +    case 1:
> +        fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
> +        break;
> +    case 2:
> +        fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
> +        break;
> +    case 3:
> +        fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
> +        break;

Nitpicking, the indentation change might go in the previous patch.

> +    default:
> +        g_assert_not_reached();
>      }
>  }
>  
> @@ -93,13 +108,22 @@ static void tosa_reset(void *opaque, int line, int level)
>      }
>  }
>  
> +static void tosa_misc_gpio_init(Object *obj)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +

Ah, MachineClass does not inherit from DeviceClass, so we can use
it to create GPIOs.

Something is bugging me here, similar with the LEDs series I sent
recently.

GPIOs are not specific to a bus. I see ResettableClass takes Object
arguments.

We should be able to wire GPIO lines to generic Objects like LEDs.
Parents don't have to be qdev.

Actually looking at qdev_init_gpio_in_named_with_opaque(), the
function only accesses the QOM API, not the QDEV one. The only
field stored in the state is the gpio list:

struct DeviceState {
    ...
    QLIST_HEAD(, NamedGPIOList) gpios;

Having to create a container to wire GPIOs or hold a reference
to a MemoryRegion sounds wrong.

If the MachineState can not do that, can we create a generic
BoardState (like PCB to route signals) so all machines can use it?

> +    qdev_init_gpio_in_named(dev, tosa_gpio_leds, "leds", 4);
> +    qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
> +}
> +
>  static void tosa_gpio_setup(PXA2xxState *cpu,
>                  DeviceState *scp0,
>                  DeviceState *scp1,
>                  TC6393xbState *tmio)
>  {
> -    qemu_irq *outsignals = qemu_allocate_irqs(tosa_out_switch, cpu, 4);
> -    qemu_irq reset;
> +    DeviceState *misc_gpio;
> +
> +    misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
>  
>      /* MMC/SD host */
>      pxa2xx_mmci_handlers(cpu->mmc,
> @@ -107,8 +131,8 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                      qemu_irq_invert(qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_nSD_DETECT)));
>  
>      /* Handle reset */
> -    reset = qemu_allocate_irq(tosa_reset, cpu, 0);
> -    qdev_connect_gpio_out(cpu->gpio, TOSA_GPIO_ON_RESET, reset);
> +    qdev_connect_gpio_out(cpu->gpio, TOSA_GPIO_ON_RESET,
> +                          qdev_get_gpio_in_named(misc_gpio, "reset", 0));
>  
>      /* PCMCIA signals: card's IRQ and Card-Detect */
>      pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[0],
> @@ -119,10 +143,14 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                          qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
>                          NULL);
>  
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
> +    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED,
> +                          qdev_get_gpio_in_named(misc_gpio, "leds", 0));
> +    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED,
> +                          qdev_get_gpio_in_named(misc_gpio, "leds", 1));
> +    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED,
> +                          qdev_get_gpio_in_named(misc_gpio, "leds", 2));
> +    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED,
> +                          qdev_get_gpio_in_named(misc_gpio, "leds", 3));
>  
>      qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
>  
> @@ -287,10 +315,22 @@ static const TypeInfo tosa_ssp_info = {
>      .class_init    = tosa_ssp_class_init,
>  };
>  
> +static const TypeInfo tosa_misc_gpio_info = {
> +    .name          = "tosa-misc-gpio",
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TosaMiscGPIOState),
> +    .instance_init = tosa_misc_gpio_init,
> +    /*
> +     * No class init required: device has no internal state so does not
> +     * need to set up reset or vmstate, and has no realize method.
> +     */
> +};
> +
>  static void tosa_register_types(void)
>  {
>      type_register_static(&tosa_dac_info);
>      type_register_static(&tosa_ssp_info);
> +    type_register_static(&tosa_misc_gpio_info);
>  }
>  
>  type_init(tosa_register_types)
> 


