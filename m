Received: from eggs.gnu.org ([209.51.188.92]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0xQO-0004kF-5d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0xQN-0005nm-Cx
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:55:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0xQN-0005lZ-4l
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:55:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id a188so815474wmf.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 15:55:10 -0800 (PST)
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<1551723614-1823-41-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fcdcc732-74de-c334-ae6b-dd13ba2a75c5@redhat.com>
Date: Tue, 5 Mar 2019 00:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <1551723614-1823-41-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/54] lm32-softmmu.mak: express
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 3/4/19 7:20 PM, Paolo Bonzini wrote:
> %-softmmu.mak only keep boards and optional device
> definitions in Kconfig mode.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/lm32-softmmu.mak | 10 ++++++----
>  hw/display/Kconfig               |  3 +--
>  hw/lm32/Kconfig                  |  6 ++++++
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
> index f489838..6d25966 100644
> --- a/default-configs/lm32-softmmu.mak
> +++ b/default-configs/lm32-softmmu.mak
> @@ -1,8 +1,10 @@
>  # Default configuration for lm32-softmmu
>  
> +# Uncomment the following lines to disable these optional devices:
> +#
> +#CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
> +
> +# Boards:
> +#
>  CONFIG_LM32=y
>  CONFIG_MILKYMIST=y
> -CONFIG_FRAMEBUFFER=y
> -CONFIG_PFLASH_CFI01=y
> -CONFIG_PFLASH_CFI02=y
> -CONFIG_SD=y
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index e126cbb..a96ea76 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -70,8 +70,7 @@ config FRAMEBUFFER
>  
>  config MILKYMIST_TMU2
>      bool
> -    default y
> -    depends on OPENGL && X11 && MILKYMIST
> +    depends on OPENGL && X11
>  
>  config SM501
>      bool
> diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
> index 4f45840..3d09c2d 100644
> --- a/hw/lm32/Kconfig
> +++ b/hw/lm32/Kconfig
> @@ -1,7 +1,13 @@
>  config LM32
>      bool
>      select PTIMER
> +    select PFLASH_CFI02
>  
>  config MILKYMIST
>      bool
> +    # FIXME: disabling it results in compile-time errors
> +    select MILKYMIST_TMU2 if OPENGL && X11

This should be fixed by 57d434407a... which got merged recently, maybe
you didn't tried again after rebasing?

>      select PTIMER
> +    select PFLASH_CFI01
> +    select FRAMEBUFFER
> +    select SD
> 
