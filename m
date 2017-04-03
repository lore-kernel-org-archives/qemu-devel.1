Received: from eggs.gnu.org ([2001:4830:134:3::10]:50646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1HE-0006AQ-06
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1H8-0005tX-E9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1H8-0005s1-8T
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:40:02 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so7583716qke.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:40:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403105238.23262-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3797efbb-bd41-c051-f781-f709ea9cb6e5@amsat.org>
Date: Mon, 3 Apr 2017 09:39:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170403105238.23262-1-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb-host: switch to LIBUSB_API_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 04/03/2017 07:52 AM, Gerd Hoffmann wrote:
> libusbx doesn't exist any more, the fork got merged back to libusb.  So
> stop using LIBUSBX_API_VERSION and use LIBUSB_API_VERSION instead.  For
> backward compatibility alias LIBUSB_API_VERSION to LIBUSBX_API_VERSION
> in case we figure LIBUSB_API_VERSION isn't defined.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/usb/host-libusb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index c9876a5..f9c8eaf 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -159,7 +159,10 @@ static void usb_host_attach_kernel(USBHostDevice *s);
>  #define BULK_TIMEOUT         0        /* unlimited */
>  #define INTR_TIMEOUT         0        /* unlimited */
>
> -#if LIBUSBX_API_VERSION >= 0x01000103
> +#ifndef LIBUSB_API_VERSION
> +# define LIBUSB_API_VERSION LIBUSBX_API_VERSION
> +#endif
> +#if LIBUSB_API_VERSION >= 0x01000103
>  # define HAVE_STREAMS 1
>  #endif
>
> @@ -269,7 +272,7 @@ static int usb_host_get_port(libusb_device *dev, char *port, size_t len)
>      size_t off;
>      int rc, i;
>
> -#if LIBUSBX_API_VERSION >= 0x01000102
> +#if LIBUSB_API_VERSION >= 0x01000102
>      rc = libusb_get_port_numbers(dev, path, 7);
>  #else
>      rc = libusb_get_port_path(ctx, dev, path, 7);
>
