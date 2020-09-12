Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6FC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 09:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7C3206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTbbmpsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7C3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH1dl-0000e7-V4
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 05:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH1cZ-0007qc-I3; Sat, 12 Sep 2020 05:14:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH1cX-00071V-JT; Sat, 12 Sep 2020 05:14:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id q9so6412671wmj.2;
 Sat, 12 Sep 2020 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6WG9GPdcwH5z92fkBwss061DrnYALpyGvcUJSvgscME=;
 b=ZTbbmpsZZ5rCSlyZFk0uBRWfoXQzGrNCsHxhwh75jhCd3+/a/YsZUWFj0SHvlbt6qi
 OwL+uFMm4KMvfFXSJEu+pmlZJtikHkdb22hIvq4qTlc1Xf8SnhY5UNpdY7W78C47em2c
 0SuVUpYv6abnipqISqtZ2/875R5LMp275udxswU8jPMbD/B4Y1pOkujY8meTo0RrN05d
 ulVH6tzlT6zFg8ZTPVnBpEiti7noXVt+KmscMYzGtUNF6oZH0PgmnRQSw4EZMot2HutL
 joqo2sQPvVKxF/vZ9GJ22lbdX8r7AQ4Bf/i9H+kV9YjV3izMEuVz0PRX7+6kVebNy6br
 wZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6WG9GPdcwH5z92fkBwss061DrnYALpyGvcUJSvgscME=;
 b=CuZ7lpW4L1cIxdJQ7Q5FUDUx5BqUtKQXvlhFFPnE6FvE2S1EA+JftgOlL8Pth50zk1
 jCFiW2UnAMRwW4NtOvcwfAbiQjdDnCHQdcUP075NLIkbJw9RdcoPWjJh4UNKnNFovR+j
 MtKLko9mBCE3TSrZjYrlWH+qwsoXuMyYv16zZkFd+sFrPw7D8DSCIrPzbr0kzfl+qECx
 PAY+LBEAzU62MttsbYHgQP8Yb5wSxNqwxDLfPb6cveqBFRMWntNNsPj1Bua7uxjGtyA0
 zRRNXbUUXRAyT54cbHZzhsUTcxPAya27DALBhFpEh0/MvKdzWczs+B9iXcznq48OAScf
 yy0g==
X-Gm-Message-State: AOAM533gwBygPolbr6bVHONKYYW+aPMle8jEXzBtx8jNABA/qlO09r2B
 oezwB6bl9BpHp9+zQ0h6EJU=
X-Google-Smtp-Source: ABdhPJz4gxYSzUQitcnMcBx7zkrDrmoINiPP7QdqzUGxs/oZ7P2hQflMfbybvCkHK7BBlTqni+kK4w==
X-Received: by 2002:a1c:40a:: with SMTP id 10mr6309282wme.61.1599902095727;
 Sat, 12 Sep 2020 02:14:55 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v17sm9906275wrc.23.2020.09.12.02.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 02:14:55 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <448947fa-805a-69d6-258f-6e337c4c5076@greensocs.com>
 <03c25384-6913-8cd6-f17c-0baff8fffed3@amsat.org>
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
Message-ID: <a035a13b-d4da-1d28-79ea-626e8f9bb403@amsat.org>
Date: Sat, 12 Sep 2020 11:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <03c25384-6913-8cd6-f17c-0baff8fffed3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 11:02 AM, Philippe Mathieu-Daudé wrote:
> On 9/11/20 9:42 PM, Luc Michel wrote:
>> Hi Phil,
>>
>> On 9/10/20 10:54 PM, Philippe Mathieu-Daudé wrote:
>>> Some devices expose GPIO lines.
>>>
>>> Add a GPIO qdev input to our LED device, so we can
>>> connect a GPIO output using qdev_connect_gpio_out().
>>>
>>> When used with GPIOs, the intensity can only be either
>>> minium or maximum. This depends of the polarity of the
>>> GPIO (which can be inverted).
>>> Declare the GpioPolarity type to model the polarity.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   include/hw/misc/led.h  |  8 ++++++++
>>>   include/hw/qdev-core.h |  8 ++++++++
>>>   hw/misc/led.c          | 17 ++++++++++++++++-
>>>   3 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>>> index f5afaa34bfb..71c9b8c59bf 100644
>>> --- a/include/hw/misc/led.h
>>> +++ b/include/hw/misc/led.h
>>> @@ -38,10 +38,16 @@ typedef struct LEDState {
>>>       /* Public */
>>>         uint8_t intensity_percent;
>>> +    qemu_irq irq;
>>>         /* Properties */
>>>       char *description;
>>>       char *color;
>>> +    /*
>>> +     * When used with GPIO, the intensity at reset is related
>>> +     * to the GPIO polarity.
>>> +     */
>>> +    bool inverted_polarity;
>>>   } LEDState;
>>>     /**
>>> @@ -71,6 +77,7 @@ void led_set_state(LEDState *s, bool is_emitting);
>>>   /**
>>>    * led_create_simple: Create and realize a LED device
>>>    * @parentobj: the parent object
>>> + * @gpio_polarity: GPIO polarity
>>>    * @color: color of the LED
>>>    * @description: description of the LED (optional)
>>>    *
>>> @@ -78,6 +85,7 @@ void led_set_state(LEDState *s, bool is_emitting);
>>>    * drop the reference to it (the device is realized).
>>>    */
>>>   LEDState *led_create_simple(Object *parentobj,
>>> +                            GpioPolarity gpio_polarity,
>>>                               LEDColor color,
>>>                               const char *description);
>>>   diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>>> index ea3f73a282d..846354736a5 100644
>>> --- a/include/hw/qdev-core.h
>>> +++ b/include/hw/qdev-core.h
>>> @@ -424,6 +424,14 @@ void qdev_simple_device_unplug_cb(HotplugHandler
>>> *hotplug_dev,
>>>   void qdev_machine_creation_done(void);
>>>   bool qdev_machine_modified(void);
>>>   +/**
>>> + * GpioPolarity: Polarity of a GPIO line
>>> + */
>>> +typedef enum {
>>> +    GPIO_POLARITY_ACTIVE_LOW,
>>> +    GPIO_POLARITY_ACTIVE_HIGH
>>> +} GpioPolarity;
>>> +
>>>   /**
>>>    * qdev_get_gpio_in: Get one of a device's anonymous input GPIO lines
>>>    * @dev: Device whose GPIO we want
>>> diff --git a/hw/misc/led.c b/hw/misc/led.c
>>> index 89acd9acbb7..3ef4f5e0469 100644
>>> --- a/hw/misc/led.c
>>> +++ b/hw/misc/led.c
>>> @@ -10,6 +10,7 @@
>>>   #include "migration/vmstate.h"
>>>   #include "hw/qdev-properties.h"
>>>   #include "hw/misc/led.h"
>>> +#include "hw/irq.h"
>>>   #include "trace.h"
>>>     #define LED_INTENSITY_PERCENT_MAX   100
>>> @@ -53,11 +54,19 @@ void led_set_state(LEDState *s, bool is_emitting)
>>>       led_set_intensity(s, is_emitting ? LED_INTENSITY_PERCENT_MAX : 0);
>>>   }
>>>   +static void led_set_state_gpio_handler(void *opaque, int line, int
>>> new_state)
>>> +{
>>> +    LEDState *s = LED(opaque);
>>> +
>>> +    assert(line == 0);
>>> +    led_set_state(s, !!new_state != s->inverted_polarity);
>>> +}
>>> +
>>>   static void led_reset(DeviceState *dev)
>>>   {
>>>       LEDState *s = LED(dev);
>>>   -    led_set_state(s, false);
>>> +    led_set_state(s, s->inverted_polarity);
>>>   }
>>>     static const VMStateDescription vmstate_led = {
>>> @@ -84,11 +93,14 @@ static void led_realize(DeviceState *dev, Error
>>> **errp)
>>>       if (s->description == NULL) {
>>>           s->description = g_strdup("n/a");
>>>       }
>>> +
>>> +    qdev_init_gpio_in(DEVICE(s), led_set_state_gpio_handler, 1);
>>>   }
>>>     static Property led_properties[] = {
>>>       DEFINE_PROP_STRING("color", LEDState, color),
>>>       DEFINE_PROP_STRING("description", LEDState, description),
>>> +    DEFINE_PROP_BOOL("polarity-inverted", LEDState,
>>> inverted_polarity, false),
>> I was wondering, since the GpioPolarity type you introduce is not used
>> in the GPIO API, and since you use a boolean property here.
> 
> "GpioPolarity not used in GPIO API": For now, but I expect it to be
> used there too. Maybe not soon, but some places could use it and
> become clearer.
> 
>> Wouldn't it
>> be clearer is you name this property "active-low"? Because
>> "polarity-inverted" doesn't tell what the polarity is in the first
>> place. Moreover since this property only affects the LED GPIO, and not
>> the LED API (led_set_state), I think you can even name it
>> "gpio-active-low" to make this clear.
> 
> Very good point, thanks for your suggestion!
> 
>>
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>   @@ -119,6 +131,7 @@ static void led_register_types(void)
>>>   type_init(led_register_types)
>>>     LEDState *led_create_simple(Object *parentobj,
>>> +                            GpioPolarity gpio_polarity,
>> You could go with a boolean here also and name the parameter
>> gpio_active_low, but I don't have a strong opinion on this.
> 
> I'll try, as this might postpone the need for the GpioPolarity enum
> (including its migration and the qapi enum visitors...).

After testing using a simple boolean, I think I'll keep the enum
as it makes the caller code easier to review:

    s->led = led_create_simple(OBJECT(dev),
                               GPIO_POLARITY_ACTIVE_HIGH,
                               LED_COLOR_GREEN, name);

vs

    s->led = led_create_simple(OBJECT(dev), true,
                               LED_COLOR_GREEN, name);

> 
>>
>> So with or without those modifications:
>> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
>>
>>>                               LEDColor color,
>>>                               const char *description)
>>>   {
>>> @@ -126,6 +139,8 @@ LEDState *led_create_simple(Object *parentobj,
>>>       DeviceState *dev;
>>>         dev = qdev_new(TYPE_LED);
>>> +    qdev_prop_set_bit(dev, "polarity-inverted",
>>> +                      gpio_polarity == GPIO_POLARITY_ACTIVE_LOW);
>>>       qdev_prop_set_string(dev, "color", led_color_name[color]);
>>>       if (!description) {
>>>           static unsigned undescribed_led_id;
>>>
>>
> 

