Received: from eggs.gnu.org ([2001:4830:134:3::10]:58722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBVX6-0000Xj-RI
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBVX3-0004ny-GK
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:44:56 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:53064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBVX3-0004nc-8Y
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:44:53 -0500
Received: by mail-pg0-x243.google.com with SMTP id a192so6887716pge.9
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 16:44:52 -0800 (PST)
References: <20171103193802.11876-1-laurent@vivier.eu>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20076e3b-883a-b669-8453-f870eda6e31a@ozlabs.ru>
Date: Mon, 6 Nov 2017 11:44:46 +1100
MIME-Version: 1.0
In-Reply-To: <20171103193802.11876-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove nmi.c and
 fw-path-provider.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@linaro.org>

On 04/11/17 06:38, Laurent Vivier wrote:
> linux-user binaries don't need firmware and NMI,
> so don't add them in this case, move QDEV
> firmware functions to qdev-fw.c


When configured with --target-list=ppc64-linux-user , config-host.mak gets
TARGET_DIRS=ppc64-linux-user  and I would expect CONFIG_SOFTMMU to be
disabled in Makefile#27 and qdev.c not to be compiled at all but this is
not happening, I wonder why...


> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/core/Makefile.objs |  5 +--
>  hw/core/qdev-fw.c     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c        | 77 -----------------------------------------
>  3 files changed, 99 insertions(+), 79 deletions(-)
>  create mode 100644 hw/core/qdev-fw.c
> 
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index f8d7a4aaed..1240728c87 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,11 +1,12 @@
>  # core qdev-related obj files, also used by *-user:
>  common-obj-y += qdev.o qdev-properties.o
>  common-obj-y += bus.o reset.o
> -common-obj-y += fw-path-provider.o
> +common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
> +common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y += irq.o
>  common-obj-y += hotplug.o
> -common-obj-y += nmi.o
> +common-obj-$(CONFIG_SOFTMMU) += nmi.o
>  
>  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
>  common-obj-$(CONFIG_XILINX_AXI) += stream.o



-- 
Alexey
