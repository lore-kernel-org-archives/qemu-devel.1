Received: from eggs.gnu.org ([209.51.188.92]:49162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhn3-00043J-RI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhmw-00063d-F5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:47:15 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-14-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a7abd300-9898-45cd-5e3d-9a8c79374ac7@redhat.com>
Date: Wed, 16 Jan 2019 10:46:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-14-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/37] hw/riscv/Makefile.objs:
 Create CONFIG_* for riscv boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On 2019-01-15 15:10, Yang Zhong wrote:
> Add the new configs to default-configs/riscv*-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/riscv32-softmmu.mak |  6 ++++++
>  default-configs/riscv64-softmmu.mak |  6 ++++++
>  hw/riscv/Makefile.objs              | 22 +++++++++++-----------
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index dbc9398284..af841839d1 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -11,3 +11,9 @@ CONFIG_PCI_GENERIC=y
>  
>  CONFIG_VGA=y
>  CONFIG_VGA_PCI=y
> +
> +CONFIG_HTIF=y
> +CONFIG_HART=y
> +CONFIG_SIFIVE=y
> +CONFIG_SPIKE=y
> +CONFIG_RISCV_VIRTIO=y
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index dbc9398284..af841839d1 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -11,3 +11,9 @@ CONFIG_PCI_GENERIC=y
>  
>  CONFIG_VGA=y
>  CONFIG_VGA_PCI=y
> +
> +CONFIG_HTIF=y
> +CONFIG_HART=y
> +CONFIG_SIFIVE=y
> +CONFIG_SPIKE=y
> +CONFIG_RISCV_VIRTIO=y
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index 1dde01d39d..dde1b01f90 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -1,11 +1,11 @@
> -obj-y += riscv_htif.o
> -obj-y += riscv_hart.o
> -obj-y += sifive_e.o
> -obj-y += sifive_clint.o
> -obj-y += sifive_prci.o
> -obj-y += sifive_plic.o
> -obj-y += sifive_test.o
> -obj-y += sifive_u.o
> -obj-y += sifive_uart.o
> -obj-y += spike.o
> -obj-y += virt.o
> +obj-$(CONFIG_HTIF) += riscv_htif.o

riscv_htif.o seems to belong to the spike machine, so I think you don't
need a separate config switch for that and could simply use CONFIG_SPIKE
here.

> +obj-$(CONFIG_HART) += riscv_hart.o
> +obj-$(CONFIG_SIFIVE) += sifive_e.o
> +obj-$(CONFIG_SIFIVE) += sifive_clint.o
> +obj-$(CONFIG_SIFIVE) += sifive_prci.o
> +obj-$(CONFIG_SIFIVE) += sifive_plic.o
> +obj-$(CONFIG_SIFIVE) += sifive_test.o
> +obj-$(CONFIG_SIFIVE) += sifive_u.o

Looking at the output of "qemu-system-riscv64 -M help", sifive_e and
sifive_u are two separate machines. So should we use two different
config switches here?

> +obj-$(CONFIG_SIFIVE) += sifive_uart.o
> +obj-$(CONFIG_SPIKE) += spike.o
> +obj-$(CONFIG_RISCV_VIRTIO) += virt.o

The machine is only called "virt", so I'd suggest to call the config
switch CONFIG_RISCV_VIRT only.

 Thomas
