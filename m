Received: from eggs.gnu.org ([2001:4830:134:3::10]:45281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Py9-0004s7-VE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Py5-0005Rb-Hb
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:16:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Py3-0005MZ-MP
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:16:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so9087640wro.7
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:16:29 -0700 (PDT)
References: <1538744508-17108-1-git-send-email-thuth@redhat.com>
	<1538744508-17108-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aed366d1-b2b1-d46e-980a-ef1cd6adf14a@redhat.com>
Date: Fri, 5 Oct 2018 15:16:26 +0200
MIME-Version: 1.0
In-Reply-To: <1538744508-17108-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/core/generic-loader: Compile
 only once, not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On 05/10/2018 15:01, Thomas Huth wrote:
> The generic-loader is currently compiled target specific due to one
> single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We have already a
> function called target_words_bigendian() for this instead, so we can
> put the generic-loader into common-obj to save some compilation time.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/Makefile.objs    | 2 +-
>  hw/core/generic-loader.c | 6 +-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index eb88ca9..b736ce2 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) += register.o
>  common-obj-$(CONFIG_SOFTMMU) += or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
> +common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
>  
> -obj-$(CONFIG_SOFTMMU) += generic-loader.o
>  obj-$(CONFIG_SOFTMMU) += null-machine.o
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index be29ae1..fbae05f 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>          s->cpu = first_cpu;
>      }
>  
> -#ifdef TARGET_WORDS_BIGENDIAN
> -    big_endian = 1;
> -#else
> -    big_endian = 0;
> -#endif
> +    big_endian = target_words_bigendian();
>  
>      if (s->file) {
>          AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
> 
