Received: from eggs.gnu.org ([2001:4830:134:3::10]:51403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOqLD-00027L-9T
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOqLC-0005uw-6X
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:08:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180427102033.20232-1-kraxel@redhat.com>
	<20180427102033.20232-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f3e852e7-7439-d230-f2bb-3f044e93a64d@amsat.org>
Date: Fri, 1 Jun 2018 17:07:50 -0300
MIME-Version: 1.0
In-Reply-To: <20180427102033.20232-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/3] Fix libusb-1.0.22 deprecated
 libusb_set_debug with libusb_set_option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Thomson <git@johnthomson.fastmail.com.au>, qemu-stable <qemu-stable@nongnu.org>

Cc'ing qemu-stable since I can not build it without this patch
cherry-picked.

On 04/27/2018 07:20 AM, Gerd Hoffmann wrote:
> From: John Thomson <git@johnthomson.fastmail.com.au>
> 
> libusb-1.0.22 marked libusb_set_debug deprecated
> it is replaced with
> libusb_set_option(libusb_context, LIBUSB_OPTION_LOG_LEVEL, libusb_log_level);
> 
> details here: https://github.com/libusb/libusb/commit/539f22e2fd916558d11ab9a66f10f461c5593168
> 
> Warning here:
> 
>   CC      hw/usb/host-libusb.o
> /builds/xen/src/qemu-xen/hw/usb/host-libusb.c: In function 'usb_host_init':
> /builds/xen/src/qemu-xen/hw/usb/host-libusb.c:250:5: error: 'libusb_set_debug' is deprecated: Use libusb_set_option instead [-Werror=deprecated-declarations]
>      libusb_set_debug(ctx, loglevel);
>      ^~~~~~~~~~~~~~~~
> In file included from /builds/xen/src/qemu-xen/hw/usb/host-libusb.c:40:0:
> /usr/include/libusb-1.0/libusb.h:1300:18: note: declared here
>  void LIBUSB_CALL libusb_set_debug(libusb_context *ctx, int level);
>                   ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/builds/xen/src/qemu-xen/rules.mak:66: hw/usb/host-libusb.o] Error 1
> make: Leaving directory '/builds/xen/src/xen/tools/qemu-xen-build'
> 
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> Message-id: 20180405132046.4968-1-git@johnthomson.fastmail.com.au
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/host-libusb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 1b0be071cc..dc0a8fe295 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -247,7 +247,11 @@ static int usb_host_init(void)
>      if (rc != 0) {
>          return -1;
>      }
> +#if LIBUSB_API_VERSION >= 0x01000106
> +    libusb_set_option(ctx, LIBUSB_OPTION_LOG_LEVEL, loglevel);
> +#else
>      libusb_set_debug(ctx, loglevel);
> +#endif
>  #ifdef CONFIG_WIN32
>      /* FIXME: add support for Windows. */
>  #else
> 
