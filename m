Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485BC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7776620663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQKZ3OJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7776620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6RW-0002Yp-B3
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6QQ-0001Oh-JN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6QP-0003VK-It
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:15:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6QN-0003Ud-86; Mon, 13 Apr 2020 17:15:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id i10so11767483wrv.10;
 Mon, 13 Apr 2020 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LtGItvIFB2RBwRBpxEtgWnaT3qY0AEYaQ/tHxmaePAo=;
 b=nQKZ3OJGjWCtOYTcPriiNkpAkAuiL2cTcRPvNu+0M+mN/XJomqJX3P2M/kImnMRGl4
 oFE2k5ahJuW4pKhP7jztpA7LT4WhB2QayBO7I4vvUNUR44jf03Np7yDJIw6MyYJNaBE6
 gfdMFajbLItDTttxQVf2WDz0BFtbt/zL09iFxZLsHR4nMTTBujrYLoU+x/LGLUDx9kRE
 TUJrYvWtssh7i2MZJRSrtHPv9JHwBR5fM8EJ2MTQ0k1FguOkv/zEqBDGzuq6BGyGlpHD
 od6Ot+rMlJC7olK083mc6NImEOsQP5eZBv7qX7rmoHbzG71jjngplPjU0mF3KqmMr6yw
 cUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LtGItvIFB2RBwRBpxEtgWnaT3qY0AEYaQ/tHxmaePAo=;
 b=SHIsLc0zjIMc4eiUpbXQPOnMZgRSkJhA1HERV6xjcQeeHlACqmWA5CPUvffpaSC+eL
 s/Zgj4q4fYZs/8P2P1UASGYolFEzxVMFgRlaD42fthR6tbLBZT6QTV0NQm1ZMFL7CKZS
 lWGqhY7/Wu+OsG9VYfmE5VfclmTly3Sk6Vqw1eigDX8Og8NyOQZoCaqOT2zUBOjCXp02
 9tO1v40DWtm9gqoQys4L4BaKi1IOgJ1mCvq+cvpiwACWYU79ndqv3ZsYSxh3cOxpXcod
 38lR/fuM+L3Wh4S3tVVl8YGXQWVKLnurk9Dp5DVsTbwCG0+30ITkkAsUwsJrytbkzJuS
 t5iw==
X-Gm-Message-State: AGi0PuYxtW3sjKTSSL0UuisxFqOUJG1JkJ1u04u5kPbWZTrVWfNX+ufx
 yRyfeRfzPQGkPSyqvlAej0g=
X-Google-Smtp-Source: APiQypIT3YWNCcL9WZS61vzXgytPCaKfkoM90bsGeU7wCIzcW1bbW0gXNJqO6PLeZEfB5hQnWzzvGQ==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr20861024wrb.54.1586812521862; 
 Mon, 13 Apr 2020 14:15:21 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k3sm16103040wmf.16.2020.04.13.14.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 14:15:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.0? 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather
 than qemu_allocate_irqs()
To: Stafford Horne <shorne@gmail.com>
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-4-f4bug@amsat.org>
 <20200412233308.GS7926@lianli.shorne-pla.net>
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
Message-ID: <d2e08a54-a020-1d46-fb88-65f5bb78156f@amsat.org>
Date: Mon, 13 Apr 2020 23:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200412233308.GS7926@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stafford,

On 4/13/20 1:33 AM, Stafford Horne wrote:
> On Sun, Apr 12, 2020 at 11:29:43PM +0200, Philippe Mathieu-Daudé wrote:
>> Switch to using the qdev gpio API which is preferred over
>> qemu_allocate_irqs(). Doing so we also stop leaking the
>> allocated memory. One step to eventually deprecate and
>> remove qemu_allocate_irqs() one day.
>>
>> Patch created mechanically using spatch with this script
>> inspired from commit d6ef883d9d7:
>>
>>   @@
>>   typedef qemu_irq;
>>   identifier irqs, handler;
>>   expression opaque, count, i;
>>   @@
>>   -   qemu_irq *irqs;
>>       ...
>>   -   irqs = qemu_allocate_irqs(handler, opaque, count);
>>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
>>       <+...
>>   -   irqs[i]
>>   +   qdev_get_gpio_in(DEVICE(opaque), i)
>>       ...+>
>>   ?-  g_free(irqs);
>>
>> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/openrisc/pic_cpu.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
>> index 36f9350830..4b0c92f842 100644
>> --- a/hw/openrisc/pic_cpu.c
>> +++ b/hw/openrisc/pic_cpu.c
>> @@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int irq, int level)
>>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
>>  {
>>      int i;
>> -    qemu_irq *qi;
>> -    qi = qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
>> +    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
>>  
>>      for (i = 0; i < NR_IRQS; i++) {
>> -        cpu->env.irq[i] = qi[i];
>> +        cpu->env.irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
>>      }
>>  }
> 
> This looks fine to me.
> 
> Why do you have the '5.0?' in the subject?

Simply because similar commit d6ef883d9d7 was merged in 5.0-rc1 (and it
fixes a bug reported by Coverity, I'm not sure why Coverity didn't
reported this too).

> 
> -Stafford
> 

