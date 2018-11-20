Received: from eggs.gnu.org ([2001:4830:134:3::10]:56022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP1LT-0008RS-4o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP1LP-0001Je-6K
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:25:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gP1LP-0001JQ-1F
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:25:15 -0500
Date: Tue, 20 Nov 2018 09:25:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181120082513.t3cvd3vuh7lbp3ha@sirius.home.kraxel.org>
References: <20181120011815.10580-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120011815.10580-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] usb-host: set ifs.detached as true if
 kernel driver is not active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, jianjay.zhou@huawei.com, wangxinxin.wang@huawei.com

On Tue, Nov 20, 2018 at 09:18:15AM +0800, linzhecheng wrote:
> If no kernel driver is active, we can already claim and perform I/O on
> it without detaching it.
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index f31e9cbbb8..db4ae1e6e8 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -1119,6 +1119,10 @@ static void usb_host_detach_kernel(USBHostDevice *s)
>      for (i = 0; i < USB_MAX_INTERFACES; i++) {
>          rc = libusb_kernel_driver_active(s->dh, i);
>          usb_host_libusb_error("libusb_kernel_driver_active", rc);
> +        if (rc == 0) {
> +            s->ifs[i].detached = true;
> +            continue;
> +        }
>          if (rc != 1) {

Can't we just add detached = true here?

>              continue;
>          }

cheers,
  Gerd
