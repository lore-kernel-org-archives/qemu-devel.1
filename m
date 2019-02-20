Received: from eggs.gnu.org ([209.51.188.92]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gwX4E-0008Nr-8r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gwX4D-0007ew-AM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:58:02 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gwX4C-0007do-US
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:58:01 -0500
Received: by mail-pl1-x644.google.com with SMTP id q3so5302663pll.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:57:55 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190218183314.20157-1-svens@stackframe.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b1fa8a79-c7dc-0e30-b8e3-a11657667143@twiddle.net>
Date: Wed, 20 Feb 2019 10:57:50 -0800
MIME-Version: 1.0
In-Reply-To: <20190218183314.20157-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/hppa/dino: mask out lower 2 bits of
 PCI config addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de

On 2/18/19 10:33 AM, Sven Schnelle wrote:
> some versions of HP-UX 10.20 seems to rely on the fact that DINO
> strips out the lower 2 bits of the PCI configuration address.
> Also update the binary SeaBIOS distributed to the latest version
> from Helge's repository, which is required with that change.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/hppa/dino.c            |  25 ++++++++++++++++++++++---
>  pc-bios/hppa-firmware.img | Bin 215936 -> 760040 bytes
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 360716de57..63441783c4 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -178,7 +178,7 @@ static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
>      case DINO_PCI_IO_DATA ... DINO_PCI_IO_DATA + 3:
>          /* Read from PCI IO space. */
>          io = &address_space_io;
> -        ioaddr = s->parent_obj.config_reg;
> +        ioaddr = s->parent_obj.config_reg + (addr & 3);
>          switch (size) {
>          case 1:
>              val = address_space_ldub(io, ioaddr, attrs, &ret);
> @@ -250,7 +250,7 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
>      case DINO_IO_DATA ... DINO_PCI_IO_DATA + 3:
>          /* Write into PCI IO space.  */
>          io = &address_space_io;
> -        ioaddr = s->parent_obj.config_reg;
> +        ioaddr = s->parent_obj.config_reg + (addr & 3);
>          switch (size) {
>          case 1:
>              address_space_stb(io, ioaddr, val, attrs, &ret);
> @@ -360,6 +360,25 @@ static const MemoryRegionOps dino_config_data_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
> +{
> +    PCIHostState *s = opaque;
> +    return s->config_reg & ~3U;
> +}
> +
> +static void dino_config_addr_write(void *opaque, hwaddr addr,
> +                                   uint64_t val, unsigned len)
> +{
> +    PCIHostState *s = opaque;
> +    s->config_reg = val & ~3U;
> +}
> +
> +static const MemoryRegionOps dino_config_addr_ops = {
> +    .read = dino_config_addr_read,
> +    .write = dino_config_addr_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +

Can you re-test with the following?

If the stores are all aligned, then the reads to not need to re-align.
Also, partial writes to the config register don't make much sense.
Over in hw/pci/pci_host.c, we check addr == 0 && len == 4, which is a
very old fashioned way to do the .valid thing.


r~



diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 63441783c4..40f9e1a963 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -363,7 +363,7 @@ static const MemoryRegionOps dino_config_data_ops = {
 static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
 {
     PCIHostState *s = opaque;
-    return s->config_reg & ~3U;
+    return s->config_reg;
 }

 static void dino_config_addr_write(void *opaque, hwaddr addr,
@@ -376,6 +376,8 @@ static void dino_config_addr_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dino_config_addr_ops = {
     .read = dino_config_addr_read,
     .write = dino_config_addr_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_BIG_ENDIAN,
 };
