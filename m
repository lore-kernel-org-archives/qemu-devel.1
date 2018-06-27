Received: from eggs.gnu.org ([2001:4830:134:3::10]:43787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fXyR7-0008Fz-SO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 20:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fXyR2-0003bm-Tl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 20:35:53 -0400
Date: Wed, 27 Jun 2018 03:35:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180627033321-mutt-send-email-mst@kernel.org>
References: <20180626135928.23950-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180626135928.23950-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>

On Tue, Jun 26, 2018 at 03:59:28PM +0200, C=E9dric Le Goater wrote:
> diff --git a/include/hw/pci-host/pnv_phb3_regs.h b/include/hw/pci-host/=
pnv_phb3_regs.h
> new file mode 100644
> index 000000000000..a1672726b908
> --- /dev/null
> +++ b/include/hw/pci-host/pnv_phb3_regs.h
> @@ -0,0 +1,510 @@
> +/* Copyright (c) 2013-2018, IBM Corporation.
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> + * implied.
> + *
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + */
> +
> +#ifndef PCI_HOST_PNV_PHB3_REGS_H
> +#define PCI_HOST_PNV_PHB3_REGS_H
> +
> +/*
> + * Duplicated from target/ppc/cpu.h
> + */
> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT=
(bs))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +#define PPC_BITLSHIFT(be)       (63 - (be))
> +#define PPC_BITLSHIFT32(be)     (31 - (be))



> +
> +/* Extract field fname from val */
> +#define GETFIELD(fname, val)                    \
> +        (((val) & fname##_MASK) >> fname##_LSH)
> +
> +/* Set field fname of oval to fval
> + * NOTE: oval isn't modified, the combined result is returned
> + */
> +#define SETFIELD(fname, oval, fval)                     \
> +        (((oval) & ~fname##_MASK) | \
> +         ((((typeof(oval))(fval)) << fname##_LSH) & fname##_MASK))
> +

Pls don't make up macros like these. We can't have each device do it.


> @@ -1031,6 +1110,7 @@ static Property pnv_chip_properties[] =3D {
>      DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
>      DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
>      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
> +    DEFINE_PROP_UINT32("num-phbs", PnvChip, num_phbs, 1),
>      DEFINE_PROP_END_OF_LIST(),
>  };

How about instanciating each extra phb using -device?
Seems better than teaching everyone about platform-specific
options.

--=20
MST
