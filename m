Received: from eggs.gnu.org ([2001:4830:134:3::10]:44442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJoo-0001Nv-A7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAJol-0003YL-52
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:06:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAJok-0003XU-GB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:06:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so6931796wrt.10
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:06:46 -0700 (PDT)
References: <cover.1539023064.git.alistair.francis@wdc.com>
	<17e897f16e0972da80a22d50b50293dc893731b0.1539023064.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60c2a871-7d31-309a-5b3b-2f4d41ce591e@redhat.com>
Date: Wed, 10 Oct 2018 21:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <17e897f16e0972da80a22d50b50293dc893731b0.1539023064.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] RISC-V: Don't add NULL bootargs to
 device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 08/10/2018 20:25, Alistair Francis wrote:
> From: Michael Clark <mjc@sifive.com>
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/riscv/sifive_u.c | 4 +++-
>  hw/riscv/spike.c    | 6 ++++--
>  hw/riscv/virt.c     | 4 +++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 862f8ff5f7..ef07df2442 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -230,7 +230,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  }
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index be5ef85e81..8a712ed490 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -156,8 +156,10 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>  
> -    qemu_fdt_add_subnode(fdt, "/chosen");
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_add_subnode(fdt, "/chosen");
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>   }
>  
>  static void spike_v1_10_0_board_init(MachineState *machine)
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 6bd723dc3a..4a137a503c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -254,7 +254,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  
>      return fdt;
> 
