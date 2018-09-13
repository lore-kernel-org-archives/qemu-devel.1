Received: from eggs.gnu.org ([2001:4830:134:3::10]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TI1-0003bi-JK
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0THx-000210-Fc
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:12:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0THx-000202-7e
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:12:13 -0400
References: <20180912160118.21158-1-liq3ea@163.com>
	<20180912160118.21158-6-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <256edc89-6f54-da5d-10e1-a57ffb4ca613@redhat.com>
Date: Thu, 13 Sep 2018 17:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180912160118.21158-6-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] hw: designware: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

On 12/09/2018 18:01, Li Qiang wrote:
> From: Li Qiang <liq3ea@gmail.com>
>=20
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/pci-host/designware.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 29ea313798..f5641b5c8c 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -57,6 +57,12 @@ designware_pcie_root_to_host(DesignwarePCIERoot *roo=
t)
>      return DESIGNWARE_PCIE_HOST(bus->parent);
>  }
> =20
> +static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr add=
r,
> +                                              unsigned size)
> +{
> +    return 0;
> +}
> +
>  static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>                                             uint64_t val, unsigned len)
>  {
> @@ -71,6 +77,7 @@ static void designware_pcie_root_msi_write(void *opaq=
ue, hwaddr addr,
>  }
> =20
>  static const MemoryRegionOps designware_pci_host_msi_ops =3D {
> +    .read =3D designware_pcie_root_msi_read,
>      .write =3D designware_pcie_root_msi_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
>=20

This probably needs to generate an unassigned access too, because the
datasheet says that the device basically traps memory writes.

Generating an unassigned access is probably a good idea for the memory
core; devices can then override the behavior to return zero.  I'm
queuing patches 1-4, with slightly expanded commit messages.

Paolo
