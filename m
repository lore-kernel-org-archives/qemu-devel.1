Received: from eggs.gnu.org ([209.51.188.92]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizxN-0001wZ-QS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizxK-0003Fh-1Z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:59:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizxH-00037v-JJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:58:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so22376599wrw.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:58:55 -0800 (PST)
References: <d2ae859d3d73ec1897d78131e05a6cf6ba6c94b0.1547255794.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56d71bbd-e86b-db1c-8d45-7dd229b87081@redhat.com>
Date: Mon, 14 Jan 2019 11:58:53 +0100
MIME-Version: 1.0
In-Reply-To: <d2ae859d3d73ec1897d78131e05a6cf6ba6c94b0.1547255794.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] riscv: Ensure the kernel start
 address is correctly cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "agraf@suse.de" <agraf@suse.de>

Hi Alistair,

On 1/12/19 2:17 AM, Alistair Francis wrote:
> Cast the kernel start address to the target bit length.
> 
> This ensures that we calculate the initrd offset to a valid address for
> the architecture.

Can you add an example of the failure symptoms?

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Suggested-by: Alexander Graf <agraf@suse.de>
> Reported-by: Alexander Graf <agraf@suse.de>
> ---
> v2:
>  - Remove old comment
>  hw/riscv/sifive_e.c | 2 +-
>  hw/riscv/sifive_u.c | 2 +-
>  hw/riscv/spike.c    | 2 +-
>  hw/riscv/virt.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 5d9d65ff29..e5d7fc548e 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -74,7 +74,7 @@ static const struct MemmapEntry {
>      [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
>  };
>  
> -static uint64_t load_kernel(const char *kernel_filename)
> +static target_ulong load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;

Shouldn't you update load_elf() and co now to take target_ulong
arguments? This would fix this error generically for all archs.

>  
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 3bd3b67507..3b3acec377 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -65,7 +65,7 @@ static const struct MemmapEntry {
>  
>  #define GEM_REVISION        0x10070109
>  
> -static uint64_t load_kernel(const char *kernel_filename)
> +static target_ulong load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 268df04c3c..79cb4c1282 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -53,7 +53,7 @@ static const struct MemmapEntry {
>      [SPIKE_DRAM] =     { 0x80000000,        0x0 },
>  };
>  
> -static uint64_t load_kernel(const char *kernel_filename)
> +static target_ulong load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e7f0716fb6..648462b18c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -62,7 +62,7 @@ static const struct MemmapEntry {
>      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
>  };
>  
> -static uint64_t load_kernel(const char *kernel_filename)
> +static target_ulong load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> 
