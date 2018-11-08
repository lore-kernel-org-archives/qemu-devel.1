Received: from eggs.gnu.org ([2001:4830:134:3::10]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKi9g-0003uX-T9
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKi9g-00014b-5x
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:07:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKi9d-000105-Tr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:07:19 -0500
Received: by mail-oi1-x241.google.com with SMTP id p144-v6so16532409oic.12
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 03:07:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 11:06:56 +0000
Message-ID: <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com

On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> x86/x86_64 has alredy supported 4G initrd.
>
> linux/arch/x86/boot/header.S:
>  # (Header version 0x0203 or later) the highest safe address for the contents
>  # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
>  # avoid possible bootloader bugs.
>
> CC: Philip Li <philip.li@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index cd5029c..e1b910f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -913,6 +913,12 @@ static void load_linux(PCMachineState *pcms,
>      /* highest address for loading the initrd */
>      if (protocol >= 0x203) {
>          initrd_max = ldl_p(header+0x22c);
> +        if (initrd_max == 0x7fffffff) {
> +            /* for some reasons, initrd_max is hard code with 0x7fffffff
> +             * hard code to 4G - 1 to allow 4G initrd
> +             */
> +            initrd_max = UINT32_MAX - 1;
> +        }

I don't understand this. If the header of the file we're using
says "this is the maximum", then we should trust the header to
in fact not be lying to us, shouldn't we ?

If the kernel initrd creation process creates an initrd which
is larger than 2GB and also claims that it can't be placed
with any part of it above 2GB, then that sounds like a bug
in the initrd creation process...

>      } else {
>          initrd_max = 0x37ffffff;
>      }

This patch should come last in the series: only after we have fixed all
of QEMU's internal plumbing to handle larger initrd sizes should we
enable it.

thanks
-- PMM
