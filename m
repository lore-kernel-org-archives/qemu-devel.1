Received: from eggs.gnu.org ([2001:4830:134:3::10]:41926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8Suc-00082m-Qn
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8Suc-0005Lm-1k
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:25:10 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1g8Sub-0005Fh-NK
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:25:09 -0400
Received: by mail-lj1-x242.google.com with SMTP id u21-v6so12119674lja.8
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <1538744508-17108-1-git-send-email-thuth@redhat.com>
	<1538744508-17108-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1538744508-17108-3-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Oct 2018 09:24:39 -0700
Message-ID: <CAKmqyKOyQ0i50GNf2RnXm9n8NVMRRpU=975qXxC07RYYjO1NwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Oct 5, 2018 at 6:05 AM Thomas Huth <thuth@redhat.com> wrote:
>
> The generic-loader is currently compiled target specific due to one
> single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We have already a
> function called target_words_bigendian() for this instead, so we can
> put the generic-loader into common-obj to save some compilation time.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 1.8.3.1
>
>
