Received: from eggs.gnu.org ([2001:4830:134:3::10]:55358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBd09-0008HX-Id
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBd06-0006MZ-4e
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBd05-0006MV-RS
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E50E380F8E
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:11:04 +0000 (UTC)
References: <1495175716-12735-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de08e712-ab78-71cb-2dc5-7c0fb6bdb071@redhat.com>
Date: Fri, 19 May 2017 10:11:01 +0200
MIME-Version: 1.0
In-Reply-To: <1495175716-12735-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: Deprecate the legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>



On 19/05/2017 08:35, Thomas Huth wrote:
> The '-usbdevice' option is considered as deprecated nowadays and
> we might want to remove these options in a future version of QEMU.
> So mark this options as deprecated in the documenation and print out
> a warning if it is used to tell the user what to use instead.
> While we're at it, improve also some other minor USB-related spots
> in qemu-options.hx that were not up to date anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 9 +++++----
>  vl.c            | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fd31428..f688123 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -983,12 +983,12 @@ STEXI
>  ETEXI
>  
>  DEF("usb", 0, QEMU_OPTION_usb,
> -    "-usb            enable the USB driver (will be the default soon)\n",
> +    "-usb            enable the USB driver (if it is not used by default yet)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -usb
>  @findex -usb
> -Enable the USB driver (will be the default soon)
> +Enable the USB driver (if it is not used by default yet).
>  ETEXI
>  
>  DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
> @@ -998,7 +998,8 @@ STEXI
>  
>  @item -usbdevice @var{devname}
>  @findex -usbdevice
> -Add the USB device @var{devname}. @xref{usb_devices}.
> +Add the USB device @var{devname}. Note that this option is deprecated,
> +please use @code{-device usb-...} instead. @xref{usb_devices}.
>  
>  @table @option
>  
> @@ -1376,7 +1377,7 @@ output such as guest graphics, guest console, and the QEMU monitor in a
>  window. With this option, you can have QEMU listen on VNC display
>  @var{display} and redirect the VGA display over the VNC session. It is
>  very useful to enable the usb tablet device when using this option
> -(option @option{-usbdevice tablet}). When using the VNC display, you
> +(option @option{-device usb-tablet}). When using the VNC display, you
>  must use the @option{-k} parameter to set the keyboard layout if you are
>  not using en-us. Valid syntax for the @var{display} is
>  
> diff --git a/vl.c b/vl.c
> index abecaf8..3ca6bd3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3748,6 +3748,8 @@ int main(int argc, char **argv, char **envp)
>                  qemu_opts_parse_noisily(olist, "usb=on", false);
>                  break;
>              case QEMU_OPTION_usbdevice:
> +                error_report("'-usbdevice' is deprecated, please use "
> +                             "'-device usb-...' instead");
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "usb=on", false);
>                  add_device_config(DEV_USB, optarg);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
