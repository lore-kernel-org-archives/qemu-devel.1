Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJ67-0000sr-SE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJ64-0000uI-MU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:59:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSJ62-0000si-MU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:58:59 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a6b51f9-f24b-7cac-8804-a3feeefd40d7@redhat.com>
Date: Thu, 29 Nov 2018 10:58:51 +0100
MIME-Version: 1.0
In-Reply-To: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] esp-pci: Fix status register write
 erase control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 28/11/18 22:56, Guenter Roeck wrote:
> Per AM53C974 datasheet, definition of "SCSI Bus and Control (SBAC)"
> register:
>=20
> Bit 24 =E2=80=93 STATUS =E2=80=93 Write Erase Control
>=20
> This bit controls the Write Erase feature on bits 3:1 and bit 6 of the =
DMA
> Status Register ((B)+54h). When this bit is programmed to =E2=80=981=E2=
=80=99, the state
> of bits 3:1 are preserved when read. Bits 3:1 are only cleared when a =E2=
=80=981=E2=80=99
> is written to the corresponding bit location. For example, to clear bit=
 1,
> the value of =E2=80=980000_0010b=E2=80=99 should be written to the regi=
ster. When the DMA
> Status Preserve bit is =E2=80=980=E2=80=99, bits 3:1 are cleared when r=
ead.
>=20
> The status register is currently defined to bit 12, not bit 24.
> Also, its implementation is reversed: The status is auto-cleared if
> the bit is set to 1, and must be cleared explicitly when the bit is
> set to 0. This results in spurious interrupts reported by the Linux
> kernel, and in some cases even results in stalled SCSI operations.
>=20
> Set SBAC_STATUS to bit 24 and reverse the logic to fix the problem.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/scsi/esp-pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 419fc66..d956909 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -59,7 +59,7 @@
>  #define DMA_STAT_SCSIINT 0x10
>  #define DMA_STAT_BCMBLT  0x20
> =20
> -#define SBAC_STATUS 0x1000
> +#define SBAC_STATUS (1 << 24)
> =20
>  typedef struct PCIESPState {
>      /*< private >*/
> @@ -136,7 +136,7 @@ static void esp_pci_dma_write(PCIESPState *pci, uin=
t32_t saddr, uint32_t val)
>          pci->dma_regs[saddr] =3D val;
>          break;
>      case DMA_STAT:
> -        if (!(pci->sbac & SBAC_STATUS)) {
> +        if (pci->sbac & SBAC_STATUS) {
>              /* clear some bits on write */
>              uint32_t mask =3D DMA_STAT_ERROR | DMA_STAT_ABORT | DMA_ST=
AT_DONE;
>              pci->dma_regs[DMA_STAT] &=3D ~(val & mask);
> @@ -157,7 +157,7 @@ static uint32_t esp_pci_dma_read(PCIESPState *pci, =
uint32_t saddr)
>          if (pci->esp.rregs[ESP_RSTAT] & STAT_INT) {
>              val |=3D DMA_STAT_SCSIINT;
>          }
> -        if (pci->sbac & SBAC_STATUS) {
> +        if (!(pci->sbac & SBAC_STATUS)) {
>              pci->dma_regs[DMA_STAT] &=3D ~(DMA_STAT_ERROR | DMA_STAT_A=
BORT |
>                                           DMA_STAT_DONE);
>          }
>=20

Queued this one only, for now at least.

Paolo
