Received: from eggs.gnu.org ([209.51.188.92]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goBEu-0003Zq-Id
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goB0i-0001Pz-36
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goB0h-0001Ls-T1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so14866977wmd.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:47:40 -0800 (PST)
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
Date: Mon, 28 Jan 2019 18:47:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

Cc'ing Thomas/Paolo for Makefile rules...

On 1/24/19 12:43 PM, Gerd Hoffmann wrote:
> On Thu, Jan 24, 2019 at 02:15:54AM +0100, Philippe Mathieu-Daudé wrote:
>> Move the complexity of milkymist_tmu2_create() into the
>> source file. Doing so we avoid to include the X11/OpenGL
>> headers in all LM32 devices, and we also avoid the duplicate
>> declaration of glx_fbconfig_attr[] (it is already declared
>> in hw/display/milkymist-tmu2.c).
>> Since TYPE_MILKYMIST_TMU2 is now accessible, use it.
> 
> Oops, fails the build:
> 
>   LINK    lm32-softmmu/qemu-system-lm32
> hw/lm32/milkymist.o: In function `milkymist_init':
> milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_create'

The problem comes from patch #2:

> diff --git a/default-configs/lm32-softmmu.mak
b/default-configs/lm32-softmmu.mak
> index 4889348a10..4049b23562 100644
> --- a/default-configs/lm32-softmmu.mak
> +++ b/default-configs/lm32-softmmu.mak
> @@ -2,7 +2,7 @@
>
>  CONFIG_LM32=y
>  CONFIG_MILKYMIST=y
> -CONFIG_MILKYMIST_TMU2=$(CONFIG_OPENGL)
> +CONFIG_MILKYMIST_TMU2=$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
>  CONFIG_FRAMEBUFFER=y
>  CONFIG_PTIMER=y
>  CONFIG_PFLASH_CFI01=y
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 97acd5b6cb..079e702f25 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -29,8 +29,8 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
>  common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
>
>  common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
> -milkymist-tmu2.o-cflags := $(X11_CFLAGS)
> -milkymist-tmu2.o-libs := $(X11_LIBS)
> +milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
> +milkymist-tmu2.o-libs := $(X11_LIBS) $(OPENGL_LIBS)
>
>  obj-$(CONFIG_OMAP) += omap_dss.o
>  obj-$(CONFIG_OMAP) += omap_lcdc.o

Using $(call land) seems to break CONFIG_MILKYMIST_TMU2 availability in
$(common-obj), while it works correctly in the per-target $(obj).
I'm not sure what is the cause, but moving milkymist-tmu2.o to $(obj)
makes more sense and fix this, so I'll go this way.

Regards,

Phil.
