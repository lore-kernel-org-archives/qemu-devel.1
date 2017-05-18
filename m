Received: from eggs.gnu.org ([2001:4830:134:3::10]:41711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBK7C-000507-HT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBK76-0000j7-Ls
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBK76-0000iV-6b
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:01:04 -0400
References: <20170512122158.32032-1-kraxel@redhat.com>
	<20170512122158.32032-7-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4f99c9b-1fb4-8a0c-ec3b-0cadc7dfd382@redhat.com>
Date: Thu, 18 May 2017 14:00:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170512122158.32032-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 6/6] hw/usb/dev-serial: Do not try to set
 vendorid or productid properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Thomas Huth <thuth@redhat.com>



On 12/05/2017 14:21, Gerd Hoffmann wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When starting QEMU with the legacy USB serial device like this:
> 
>  qemu-system-x86_64 -usbdevice serial:vendorid=0x1234:stdio
> 
> it currently aborts since the vendorid property does not exist
> anymore (it has been removed by commit f29783f72ea77dfbd7ea0c9):
> 
>  Unexpected error in object_property_find() at qemu/qom/object.c:1008:
>  qemu-system-x86_64: -usbdevice serial:vendorid=0x1234:stdio: Property
>                      '.vendorid' not found
>  Aborted (core dumped)
> 
> Fix this crash by issuing a more friendly error message instead
> (and simplify the code also a little bit this way).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-id: 1493883704-27604-1-git-send-email-thuth@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-serial.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 6d5137383b..83a4f0e6fb 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -513,27 +513,18 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
>  {
>      USBDevice *dev;
>      Chardev *cdrv;
> -    uint32_t vendorid = 0, productid = 0;
>      char label[32];
>      static int index;
>  
>      while (*filename && *filename != ':') {
>          const char *p;
> -        char *e;
> +
>          if (strstart(filename, "vendorid=", &p)) {
> -            vendorid = strtol(p, &e, 16);
> -            if (e == p || (*e && *e != ',' && *e != ':')) {
> -                error_report("bogus vendor ID %s", p);
> -                return NULL;
> -            }
> -            filename = e;
> +            error_report("vendorid is not supported anymore");
> +            return NULL;
>          } else if (strstart(filename, "productid=", &p)) {
> -            productid = strtol(p, &e, 16);
> -            if (e == p || (*e && *e != ',' && *e != ':')) {
> -                error_report("bogus product ID %s", p);
> -                return NULL;
> -            }
> -            filename = e;
> +            error_report("productid is not supported anymore");
> +            return NULL;
>          } else {
>              error_report("unrecognized serial USB option %s", filename);
>              return NULL;

All breanches of the "if" now return NULL, so the "while" loop in turn
can become an

    if (*filename && *filename != ':') {
    }

and the "while (*filename == ',')" subloop can go away, replaced by just
"return NULL".

Even better, the "if (!*filename)" if just below can be moved first.

Paolo
> @@ -554,10 +545,7 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
>  
>      dev = usb_create(bus, "usb-serial");
>      qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
> -    if (vendorid)
> -        qdev_prop_set_uint16(&dev->qdev, "vendorid", vendorid);
> -    if (productid)
> -        qdev_prop_set_uint16(&dev->qdev, "productid", productid);
> +
>      return dev;
>  }
>  
> 
