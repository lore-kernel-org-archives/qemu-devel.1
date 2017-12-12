Received: from eggs.gnu.org ([2001:4830:134:3::10]:52948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOoGH-0008C9-HS
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOoGG-0002Wd-Gw
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:22:33 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOoGG-0002WG-BX
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:22:32 -0500
Received: by mail-ot0-x22a.google.com with SMTP id d27so18426635ote.11
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:22:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b8fdafd1-d8d8-056f-681e-d5469dc79edd@amsat.org>
References: <1512154296-5652-1-git-send-email-peter.maydell@linaro.org>
	<1512154296-5652-3-git-send-email-peter.maydell@linaro.org>
	<b8fdafd1-d8d8-056f-681e-d5469dc79edd@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 17:22:11 +0000
Message-ID: <CAFEAcA-ON_8zKaMeUMf84gtFTYeCMFQzJahnA=kXXTkh-yHEmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] nvic: Make systick banked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 5 December 2017 at 04:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks; I will squash this diff in when I apply to target-arm.next:

--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2068,9 +2068,14 @@ static void armv7m_nvic_realize(DeviceState
*dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), 0,
-                       qdev_get_gpio_in_named(dev, "systick-trigger", 0));
+                       qdev_get_gpio_in_named(dev, "systick-trigger",
+                                              M_REG_NS));

     if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
-        object_initialize(&s->systick[M_REG_S], sizeof(s->systick[M_REG_NS=
]),
+        /* We couldn't init the secure systick device in instance_init
+         * as we didn't know then if the CPU had the security extensions;
+         * so we have to do it here.
+         */
+        object_initialize(&s->systick[M_REG_S], sizeof(s->systick[M_REG_S]=
),
                           TYPE_SYSTICK);
         qdev_set_parent_bus(DEVICE(&s->systick[M_REG_S]),
sysbus_get_default());
@@ -2082,7 +2087,8 @@ static void armv7m_nvic_realize(DeviceState
*dev, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_S]), 0,
-                           qdev_get_gpio_in_named(dev, "systick-trigger", =
1));
+                           qdev_get_gpio_in_named(dev, "systick-trigger",
+                                                  M_REG_S));
     }

     /* The NVIC and System Control Space (SCS) starts at 0xe000e000
@@ -2161,7 +2167,8 @@ static void armv7m_nvic_instance_init(Object *obj)

     sysbus_init_irq(sbd, &nvic->excpout);
     qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
-    qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger", =
2);
+    qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger",
+                            M_REG_NUM_BANKS);
 }

 static void armv7m_nvic_class_init(ObjectClass *klass, void *data)


thanks
-- PMM
