Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7510C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3386206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDXJv0bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3386206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igN7w-0008BC-Pe
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 01:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igN7J-0007mm-Q7
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igN7F-00037u-SF
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:10:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igN7D-00037N-N0
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576390250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmIC6RKykY+2P+HPtiKifriCa+aFJXa/9+EmH+kupkU=;
 b=FDXJv0bIrpXiouHIU5xDHJEPf9dKmarxXxOe1F77lk1919z09jL9AJR/fhDB5G7QgcXu2V
 BK1lHb7RKDFp8I0dz/+cVPGsyKpKXyAPV37K+Dtd0zGsuFimmrVU2p61Q620TtuQOgV/W/
 GdvaJbs3Spj/aowYdi0ER6IKMhR0/NQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-GUSrveDMOc6Ul6-n6QJPVg-1; Sun, 15 Dec 2019 01:10:49 -0500
Received: by mail-wr1-f71.google.com with SMTP id 90so1834089wrq.6
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 22:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RjeJiOiU0+xrm533LwV2A17On70otHbmTNIe0oStHJc=;
 b=dC+bsMhug/Os+jOysUQsYD50Zm4LNJwDoFuz/5jXJgSxYU5rF0CB9RJtV8HeAlJqep
 mwZJs0byq2hGkDmVapdXoZ5KaxAVfC5ul6LM2NdxeG/xf9lidCqhFDDfDkS1NiaMiW1j
 PaUHzlashceHhZUHLeALifGRC1EmylKamNei0rBaXc9QP+SA90xrLmn8Q/UayuGhscqr
 HvFcUmi+hFwTyHtjOJFFBuTr7OO43bAHwGAjc+9/frgOwxG78PL01wsFYvJ1R6mRt4CE
 ecKcOHr1VH4kO+1EmgkCrC9eay2v8pf8wHAoInqtolIk/0vRT5pkB4U6yFt2Dz9tJ0Rm
 9X9A==
X-Gm-Message-State: APjAAAXrStVYWPZ6wcguT9FuBvGDXhF6KaN+vr2pfa4EmjhIxXu04lH7
 +8wIZovrGeEc9XP267jQXFMWpR7Y2vk+F+T17CvZrwD1Cz/BaNODB+WR6mRPGqvdR2Dw3WlYgh2
 B9Ljb1w24H6Yhzok=
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr23525269wmb.34.1576390248390; 
 Sat, 14 Dec 2019 22:10:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxF/UirP3Fv8yllox4iDRN5cG2F8R++bivp0+zUEitGrBrJLQaa6vmLGUPtD1DGIbEmUtg8WQ==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr23525254wmb.34.1576390248207; 
 Sat, 14 Dec 2019 22:10:48 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id d10sm16554286wrw.64.2019.12.14.22.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 22:10:47 -0800 (PST)
Subject: Re: [PATCH v4 27/37] leon3: use qdev gpio facilities for the PIL
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-28-marcandre.lureau@redhat.com>
 <CAFEAcA-k5tHOzAoUERk2MGx8BPjHUvWELgvgONfLS_UQMmJRuA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2b7f742-917a-fb20-4f0a-2b4bef7a1a62@redhat.com>
Date: Sun, 15 Dec 2019 07:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-k5tHOzAoUERk2MGx8BPjHUvWELgvgONfLS_UQMmJRuA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: GUSrveDMOc6Ul6-n6QJPVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 2:51 PM, Peter Maydell wrote:
> On Wed, 20 Nov 2019 at 15:30, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/sparc/leon3.c   | 6 ++++--
>>   target/sparc/cpu.h | 1 -
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
>> index cac987373e..1a89d44e57 100644
>> --- a/hw/sparc/leon3.c
>> +++ b/hw/sparc/leon3.c
>> @@ -230,8 +230,10 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>>
>>       /* Allocate IRQ manager */
>>       dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
>> -    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
>> -    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
>> +    qdev_init_gpio_in_named_with_opaque(DEVICE(env), leon3_set_pil_in,
>> +                                        env, "pil", 1);
>> +    qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
>> +                                qdev_get_gpio_in_named(DEVICE(env), "pi=
l", 0));
>>       qdev_init_nofail(dev);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
>>       env->irq_manager =3D dev;
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Creating a gpio pin on some object that isn't yourself
> looks a bit odd, but all this leon3 code is modifying
> the CPU object from the outside anyway. Someday we might
> tidy it up, but not today.

Watch out, while SPARCCPU inherits DeviceState from CPUState,
env does not: it is not QDEV but a CPUSPARCState object.

If you replace both DEVICE(env) uses by DEVICE(cpu), your patch looks safe.

If you agree with the change:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


