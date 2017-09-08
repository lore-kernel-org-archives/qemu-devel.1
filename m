Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqHgo-0000GH-ME
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqHgl-0005F1-FK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqHgl-0005E8-8V
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A91934CD
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:43:10 +0000 (UTC)
References: <20170908111217.21985-1-kraxel@redhat.com>
	<20170908111217.21985-2-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0efdb75d-5f13-8797-a5c4-66c06f244cf8@redhat.com>
Date: Fri, 8 Sep 2017 13:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170908111217.21985-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] usb: drop HOST_USB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 13:12, Gerd Hoffmann wrote:
> Nowdays we use libusb for usb-host, so we don't have different code
> for linux vs. bsd any more.  So there is little reason to have the
> HOST_USB variable, we can just write things directly into the Makefile
> and avoid a pointless indirection.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure            | 7 -------
>  hw/usb/Makefile.objs | 6 +++++-
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index a541aadebc..ec93234f47 100755
> --- a/configure
> +++ b/configure
> @@ -5978,13 +5978,6 @@ if test "$live_block_migration" = "yes" ; then
>    echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
>  fi
>  
> -# USB host support
> -if test "$libusb" = "yes"; then
> -  echo "HOST_USB=libusb legacy" >> $config_host_mak
> -else
> -  echo "HOST_USB=stub" >> $config_host_mak
> -fi
> -
>  # TPM passthrough support?
>  if test "$tpm" = "yes"; then
>    echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 97f1c4561a..a43ebbc17f 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -38,7 +38,11 @@ endif
>  common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
>  
>  # usb pass-through
> -common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
> +ifeq ($(CONFIG_LIBUSB),y)
> +common-obj-y += host-libusb.o host-legacy.o
> +else
> +common-obj-y += host-stub.o
> +endif
>  
>  ifeq ($(CONFIG_USB_LIBUSB),y)
>  common-obj-$(CONFIG_XEN) += xen-usb.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
