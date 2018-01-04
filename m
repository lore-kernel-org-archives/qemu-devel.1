Received: from eggs.gnu.org ([2001:4830:134:3::10]:56621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX71k-0007DM-VN
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX71O-0003MD-PP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX71O-0003Kx-K8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:01:30 -0500
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
	<20180104132600.ikr4migzznhantmt@var.youpi.perso.aquilenet.fr>
	<8590ff50-6b1a-c85f-c9fb-a70ebf8132b5@redhat.com>
	<20180104142356.6hoar52jcoxrobgn@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a3431b44-d061-e8f6-a0f4-4f7c8a98a062@redhat.com>
Date: Thu, 4 Jan 2018 16:01:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180104142356.6hoar52jcoxrobgn@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 04.01.2018 15:23, Samuel Thibault wrote:
> Thomas Huth, on jeu. 04 janv. 2018 15:22:25 +0100, wrote:
>> On 04.01.2018 14:26, Samuel Thibault wrote:
>> I think it's more common to not do any magic default setup with
>> "-device", but if you think this should be the case here, it can
>> certainly be added again
> 
> Yes, please: it will almost never be used differently than with just a
> fresh braille chardev.

It's pretty much untested, but would a patch like this help?

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -556,6 +556,19 @@ static const TypeInfo serial_info = {
     .class_init    = usb_serial_class_initfn,
 };
 
+static void usb_braille_realize(USBDevice *dev, Error **errp)
+{
+    USBSerialState *uss = USB_SERIAL_DEV(dev);
+
+    if (!qemu_chr_fe_backend_connected(&uss->cs)) {
+        /* Create a default braille chardev if user did not specify one */
+        Chardev *cdrv = qemu_chr_new("braille", "braille");
+        qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
+    }
+
+    usb_serial_realize(dev, errp);
+}
+
 static Property braille_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
     DEFINE_PROP_END_OF_LIST(),
@@ -568,6 +581,7 @@ static void usb_braille_class_initfn(ObjectClass *klass, void *data)
 
     uc->product_desc   = "QEMU USB Braille";
     uc->usb_desc       = &desc_braille;
+    uc->realize        = usb_braille_realize;
     dc->props = braille_properties;
 }
 

 Thomas
