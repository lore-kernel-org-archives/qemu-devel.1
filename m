Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0sq-0003fa-GT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0sl-00059a-HH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:46:32 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0sl-00058n-Cu
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:46:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id q8so246206qtb.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:46:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170907082918.7299-1-famz@redhat.com>
	<20170907082918.7299-8-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58759972-657f-ae54-d3bb-ff84963e4f7e@amsat.org>
Date: Thu, 7 Sep 2017 14:46:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170907082918.7299-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] buildsys: Move libcacard cflags/libs
 to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 09/07/2017 05:29 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   configure            | 4 ++--
>   hw/usb/Makefile.objs | 6 ++++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index b1320b1994..85fef3d16f 100755
> --- a/configure
> +++ b/configure
> @@ -4237,8 +4237,6 @@ if test "$smartcard" != "no"; then
>       if $pkg_config libcacard; then
>           libcacard_cflags=$($pkg_config --cflags libcacard)
>           libcacard_libs=$($pkg_config --libs libcacard)
> -        QEMU_CFLAGS="$QEMU_CFLAGS $libcacard_cflags"
> -        libs_softmmu="$libs_softmmu $libcacard_libs"
>           smartcard="yes"
>       else
>           if test "$smartcard" = "yes"; then
> @@ -5831,6 +5829,8 @@ fi
>   
>   if test "$smartcard" = "yes" ; then
>     echo "CONFIG_SMARTCARD=y" >> $config_host_mak
> +  echo "SMARTCARD_CFLAGS=$libcacard_cflags" >> $config_host_mak
> +  echo "SMARTCARD_LIBS=$libcacard_libs" >> $config_host_mak
>   fi
>   
>   if test "$libusb" = "yes" ; then
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 97f1c4561a..795ff25a5e 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -26,8 +26,10 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    += dev-bluetooth.o
>   
>   ifeq ($(CONFIG_USB_SMARTCARD),y)
>   common-obj-y                          += dev-smartcard-reader.o
> -common-obj-$(CONFIG_SMARTCARD)        += ccid-card-passthru.o
> -common-obj-$(CONFIG_SMARTCARD)        += ccid-card-emulated.o
> +common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
> +smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
> +smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
> +smartcard.mo-libs := $(SMARTCARD_LIBS)

this line here looks more natural to me:

common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo

>   endif
>   
>   ifeq ($(CONFIG_POSIX),y)
> 
