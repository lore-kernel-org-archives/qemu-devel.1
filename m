Received: from eggs.gnu.org ([2001:4830:134:3::10]:45605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fI6Sa-0000tE-5l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fI6SW-0000c6-Ow
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:55:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:48699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fI6SW-0000Zf-CW
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:55:44 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Mon, 14 May 2018 05:55:39 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35269E165@SHSMSX103.ccr.corp.intel.com>
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
	<20180511144059.GN25013@localhost.localdomain>
In-Reply-To: <20180511144059.GN25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Friday, May 11, 2018 10:41 PM
> To: Liu, Jingqi <jingqi.liu@intel.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; mst@redhat.com;
> imammedo@redhat.com; marcel.apfelbaum@gmail.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v1 1/7] hmat acpi: Build Memory Subsystem Address Ran=
ge
> Structre(s) in ACPI HMAT
>=20
> On Wed, May 09, 2018 at 04:34:29PM +0800, Liu Jingqi wrote:
> > HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Tabl=
e
> (HMAT).
> > The specification references below link:
> > http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> >
> > It describes the memory attributes, such as memory side cache
> > attributes and bandwidth and latency details, related to the System
> > Physical Address (SPA) Memory Ranges. The software is expected to use
> > this information as hint for optimization.
> >
> > This structure describes the System Physical Address(SPA) range
> > occupied by memory subsystem and its associativity with processor
> > proximity domain as well as hint for memory usage.
> >
> [...]
> > +/*
> > + * The Proximity Domain of System Physical Address ranges defined
> > + * in the HMAT, NFIT and SRAT tables shall match each other.
> > + */
> > +static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
> > +{
> > +    GSList *device_list =3D NULL;
> > +    AcpiHmatSpaRange *hmat_spa;
> > +    uint64_t mem_base, next_base, mem_len;
> > +    int node;
> > +
> > +    next_base =3D 0;
> > +    for (node =3D 0; node < nb_numa_nodes; node++) {
> > +        mem_len =3D numa_info[node].node_mem;
> > +        if (!mem_len) {
> > +            continue;
> > +        }
> > +
> > +        mem_base =3D next_base;
> > +        next_base =3D mem_base + mem_len;
> > +
> > +        /* Cut out the 640K hole */
> > +        if (mem_base <=3D HOLE_640K_START &&
> > +            next_base > HOLE_640K_START) {
> > +            mem_len -=3D next_base - HOLE_640K_START;
> > +            if (mem_len > 0) {
> > +                hmat_spa =3D acpi_data_push(table_data, sizeof(*hmat_s=
pa));
> > +                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node)=
;
> > +            }
> > +
> > +            /* Check for the rare case: 640K < RAM < 1M */
> > +            if (next_base <=3D HOLE_640K_END) {
> > +                next_base =3D HOLE_640K_END;
> > +                continue;
> > +            }
> > +            mem_base =3D HOLE_640K_END;
> > +            mem_len =3D next_base - HOLE_640K_END;
> > +        }
> > +
> > +        /* Cut out the ACPI_PCI hole */
> > +        if (mem_base <=3D pcms->below_4g_mem_size &&
> > +            next_base > pcms->below_4g_mem_size) {
> > +            mem_len -=3D next_base - pcms->below_4g_mem_size;
> > +            if (mem_len > 0) {
> > +                hmat_spa =3D acpi_data_push(table_data, sizeof(*hmat_s=
pa));
> > +                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node)=
;
> > +            }
> > +            mem_base =3D 1ULL << 32;
> > +            mem_len =3D next_base - pcms->below_4g_mem_size;
> > +            next_base =3D mem_base + mem_len;
> > +        }
>=20
> This duplicates very complex logic that already exists in build_srat().  =
We need to
> make the existing logic reusable.
>=20
Thanks Eduardo.
Agree. We need to make them reusable.
HMAT connects memory address ranges to proximity domains,=20
which must be consistent with the affinity attributes defined in other tabl=
es, such as SRAT and NFIT.

Jingqi
>=20
> > +        hmat_spa =3D acpi_data_push(table_data, sizeof(*hmat_spa));
> > +        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> > +    }
> > +
> > +    /* Build HMAT SPA structures for PC-DIMM devices. */
> > +    object_child_foreach(qdev_get_machine(), pc_dimm_device_list,
> > + &device_list);
> > +
> > +    for (; device_list; device_list =3D device_list->next) {
> > +        PCDIMMDevice *dimm =3D device_list->data;
> > +        mem_base =3D object_property_get_uint(OBJECT(dimm),
> PC_DIMM_ADDR_PROP,
> > +                                            NULL);
> > +        mem_len =3D object_property_get_uint(OBJECT(dimm),
> PC_DIMM_SIZE_PROP,
> > +                                           NULL);
> > +        node =3D object_property_get_uint(OBJECT(dimm),
> > + PC_DIMM_NODE_PROP, NULL);
> > +
> > +        hmat_spa =3D acpi_data_push(table_data, sizeof(*hmat_spa));
> > +        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> > +    }
> > +}
>=20
> --
> Eduardo
