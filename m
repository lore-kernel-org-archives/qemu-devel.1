Received: from eggs.gnu.org ([2001:4830:134:3::10]:42080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPmKO-00028d-0H
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPmKK-0001HV-12
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:35:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPmKJ-0001GB-QX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:35:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so8708478wrx.9
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 02:35:15 -0800 (PST)
References: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e61b7517-a736-8cb5-ce35-815225f18c52@redhat.com>
Date: Thu, 22 Nov 2018 11:35:13 +0100
MIME-Version: 1.0
In-Reply-To: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Li Qiang <liq3ea@gmail.com>, jan.kiszka@web.de, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, maozhongyi@cmss.chinamobile.com, Markus Armbruster <armbru@redhat.com>

Hi Li,

On 22/11/18 11:00, Li Qiang wrote:
> The third argument of object_property_set_link() is the name of
> property, not related with the QOM type name, using the constant
> string instead.

You are correct.

> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/arm/musicpal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 9648b3af44..726ae29394 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
>      dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>      s = SYS_BUS_DEVICE(dev);
>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
> -                             TYPE_WM8750, NULL);
> +                             "wm8750", NULL);

Since this property is not related to migration, maybe we can resolve
this the other way, using TYPE_WM8750 in mv88w8618_audio_init():

-- >8 --
@@ -255,3 +255,3 @@ static void mv88w8618_audio_init(Object *obj)

-    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
+    object_property_add_link(OBJECT(dev), TYPE_WM8750, TYPE_WM8750,
                              (Object **) &s->wm,
---

So using the same definition would protect someone to accidentaly rename
the property name.

What do you think?

Regards,

Phil.

>      qdev_init_nofail(dev);
>      sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
>      sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
> 
