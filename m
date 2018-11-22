Received: from eggs.gnu.org ([2001:4830:134:3::10]:43096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmNa-00058r-Of
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmNY-0005br-Bv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:38:37 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPmNY-0005ax-6h
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:38:36 -0500
Received: by mail-oi1-x241.google.com with SMTP id h25so7118339oig.1
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 02:38:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e61b7517-a736-8cb5-ce35-815225f18c52@redhat.com>
References: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
	<e61b7517-a736-8cb5-ce35-815225f18c52@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 10:38:14 +0000
Message-ID: <CAFEAcA8XgZRXyHkjWnOZ4d_yrqzWdxCDJjo6DtR+PTzx4t1cxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: arm: musicpal: drop TYPE_WM8750 in
 object_property_set_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Markus Armbruster <armbru@redhat.com>

On 22 November 2018 at 10:35, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Hi Li,
>
> On 22/11/18 11:00, Li Qiang wrote:
>> The third argument of object_property_set_link() is the name of
>> property, not related with the QOM type name, using the constant
>> string instead.
>
> You are correct.
>
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
>>  hw/arm/musicpal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>> index 9648b3af44..726ae29394 100644
>> --- a/hw/arm/musicpal.c
>> +++ b/hw/arm/musicpal.c
>> @@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
>>      dev =3D qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>>      s =3D SYS_BUS_DEVICE(dev);
>>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>> -                             TYPE_WM8750, NULL);
>> +                             "wm8750", NULL);
>
> Since this property is not related to migration, maybe we can resolve
> this the other way, using TYPE_WM8750 in mv88w8618_audio_init():
>
> -- >8 --
> @@ -255,3 +255,3 @@ static void mv88w8618_audio_init(Object *obj)
>
> -    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
> +    object_property_add_link(OBJECT(dev), TYPE_WM8750, TYPE_WM8750,
>                               (Object **) &s->wm,
> ---
>
> So using the same definition would protect someone to accidentaly rename
> the property name.

I think I prefer Li's patch -- the property name is just
an arbitrary name not related to the type name necessarily.

thanks
-- PMM
