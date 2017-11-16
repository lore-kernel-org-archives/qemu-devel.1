Received: from eggs.gnu.org ([2001:4830:134:3::10]:42109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFNVm-0005Kt-CP
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFNVj-0006YR-3C
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:59:34 -0500
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-2-michael.nawrocki@gtri.gatech.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <41891d99-8cb7-79a6-9aa7-0bfe3d192f41@redhat.com>
Date: Thu, 16 Nov 2017 17:59:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171106203520.7880-2-michael.nawrocki@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Fix eepro100 simple transmission
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, jasowang@redhat.com, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>Jason Wang <jasowang@redhat.com>, qemu-s390x@nongnu.org

On 06.11.2017 21:35, Mike Nawrocki wrote:
> The simple transmission mode was treating the area immediately after th=
e
> transmit command block (TCB) as if it were a transmit buffer descriptor=
,
> when in reality it is simply the packet data. This change simply copies
> the data following the TCB into the packet buffer.
>=20
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/net/eepro100.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 80b8f47c4b..91dd058010 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -774,23 +774,11 @@ static void tx_command(EEPRO100State *s)
>      }
>      assert(tcb_bytes <=3D sizeof(buf));
>      while (size < tcb_bytes) {
> -        uint32_t tx_buffer_address =3D ldl_le_pci_dma(&s->dev, tbd_add=
ress);
> -        uint16_t tx_buffer_size =3D lduw_le_pci_dma(&s->dev, tbd_addre=
ss + 4);
> -#if 0
> -        uint16_t tx_buffer_el =3D lduw_le_pci_dma(&s->dev, tbd_address=
 + 6);
> -#endif
> -        if (tx_buffer_size =3D=3D 0) {
> -            /* Prevent an endless loop. */
> -            logout("loop in %s:%u\n", __FILE__, __LINE__);
> -            break;
> -        }
> -        tbd_address +=3D 8;
>          TRACE(RXTX, logout
>              ("TBD (simplified mode): buffer address 0x%08x, size 0x%04=
x\n",
> -             tx_buffer_address, tx_buffer_size));
> -        tx_buffer_size =3D MIN(tx_buffer_size, sizeof(buf) - size);
> -        pci_dma_read(&s->dev, tx_buffer_address, &buf[size], tx_buffer=
_size);
> -        size +=3D tx_buffer_size;
> +             tbd_address, tcb_bytes));
> +        pci_dma_read(&s->dev, tbd_address, &buf[size], tcb_bytes);
> +        size +=3D tcb_bytes;
>      }
>      if (tbd_array =3D=3D 0xffffffff) {
>          /* Simplified mode. Was already handled by code above. */
>=20

 Hi,

I've got no clue why, but apparently this patch introduced a regression
in rc1: The tests/pxe-test is now failing on a big endian (s390x) host
when testing the i82550 device.
It's working fine with commit 8fa5ad6dfb66b6c695aa6a6b54b7031c (and
2.11-rc0), and it's broken starting with commit
1865e288a823c764cd4344d704e33344 ... do you have any clue what might be
wrong here now?

 Thomas
