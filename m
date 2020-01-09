Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF5C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AA92075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnmB0vmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AA92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWYm-0005HH-HT
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWWV-0002gT-Ou
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWWT-0002Cs-UD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWWT-00029D-OA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578571362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UioHiDxo931qLxqJwxrZXWGpD5NAJmYbzncT05fq5wM=;
 b=GnmB0vmHW+39/Un4qCkX/v2YUy4xuz8ep54zHC+gLNaKbjAynJiWUJQJEJlJIzVhdP/JCo
 MlkDxRfVyLaOS3EMzahcopOpNi6fr+r09fSkDctX7ylTv2TlCeIgFmwzCvDz68dZMtX0Ue
 JmLGcn70IoRzianNK/iF1wyj9fsCCt8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-l0Uge83GM_COQ3t0mbEr4g-1; Thu, 09 Jan 2020 07:02:11 -0500
Received: by mail-qk1-f198.google.com with SMTP id g28so3974987qkl.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dm1Fx8oGwOYdwTadI8Cr5xXOlp+v3Rhd4ezGGdDTNQM=;
 b=OGDtIc+mgl4uHvd0lf7Nt7Yo7aXd7xAdzjliFPqor618K/hK/zMq9MJ1KhHbywzpZJ
 E+/lfMosjzk0fYAlaMBWcEiKXFHLrd5YpmEB6nV1lQtkgapIPh3yAQHC+ctJBqjgGbjD
 0hHNh+B9Wa/Gpbd1dIga8x1OzRBnqimLehYAII6C7FR1Sp8y3kAZMy/9VurtL1rhEZ8f
 ZkD1I7ieVSjpE1LoQbx3w6p5nV5ULalP8sGYlpiQ/yO/rPU6ABzAhlvRVcgYBayThZOr
 zDdY1QQXFeUUlIlrU3CDZUvjeVcLklViUttEsLvD1UvXL2Z6Tm628bOH2qeFnh8+4RLr
 pvTQ==
X-Gm-Message-State: APjAAAWBn5/AZeb5jQCLjztvGsw6Wk7Hc4aH7cOxTPzd/nNyryQe96L5
 I3XPRJ5JSMo94I0MHrlpP+1E0dcvC1gdOUJa1qCj012AQtGaF0UzLbdf5vrh9hHgZnQkYIhE+79
 aTqOr/mReyP9v8B0=
X-Received: by 2002:a05:6214:13a8:: with SMTP id
 h8mr8167638qvz.41.1578571330822; 
 Thu, 09 Jan 2020 04:02:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqy01AxOfsgaSLIHrZXufNPH7Ah9sD0S/wcOt6BrG5JqN1tWCV+qEbAabtSAV/OI8Ue1n9uZOw==
X-Received: by 2002:a05:6214:13a8:: with SMTP id
 h8mr8167610qvz.41.1578571330499; 
 Thu, 09 Jan 2020 04:02:10 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 21sm2859398qky.41.2020.01.09.04.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:02:09 -0800 (PST)
Date: Thu, 9 Jan 2020 07:02:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 19/20] pc: Add support for virtio-iommu-pci
Message-ID: <20200109065832-mutt-send-email-mst@kernel.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-20-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-20-eric.auger@redhat.com>
X-MC-Unique: l0Uge83GM_COQ3t0mbEr4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, quintela@redhat.com, jean-philippe.brucker@arm.com,
 qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:42PM +0100, Eric Auger wrote:
> The virtio-iommu-pci is instantiated through the -device QEMU
> option. However if instantiated it also requires an IORT ACPI table
> to describe the ID mappings between the root complex and the iommu.
>=20
> This patch adds the generation of the IORT table if the
> virtio-iommu-pci device is instantiated.
>=20
> We also declare the [0xfee00000 - 0xfeefffff] MSI reserved region
> so that it gets bypassed by the IOMMU.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

So I'd like us to use virtio config space in preference to ACPI.

Guest bits for that are not ready yet, but I think it's
better to wait than maintaining both ACPI and config space forever
later.

Could you send a smaller patchset without pci/acpi bits for now?

> ---
>  hw/i386/acpi-build.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c         | 15 ++++++++-
>  include/hw/i386/pc.h |  2 ++
>  3 files changed, 88 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 12ff55fcfb..f09cabdcae 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2744,6 +2744,72 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      return true;
>  }
> =20
> +static inline void
> +fill_iort_idmap(AcpiIortIdMapping *idmap, int i,
> +                uint32_t input_base, uint32_t id_count,
> +                uint32_t output_base, uint32_t output_reference)
> +{
> +    idmap[i].input_base =3D cpu_to_le32(input_base);
> +    idmap[i].id_count =3D cpu_to_le32(id_count);
> +    idmap[i].output_base =3D cpu_to_le32(output_base);
> +    idmap[i].output_reference =3D cpu_to_le32(output_reference);
> +}
> +
> +static void
> +build_iort(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
> +{
> +    size_t iommu_node_size, rc_node_size, iommu_node_offset;
> +    int iort_start =3D table_data->len;
> +    AcpiIortPVIommuPCI *iommu;
> +    AcpiIortIdMapping *idmap;
> +    AcpiIortTable *iort;
> +    size_t iort_length;
> +    AcpiIortRC *rc;
> +
> +    iort =3D acpi_data_push(table_data, sizeof(*iort));
> +    iort_length =3D sizeof(*iort);
> +    iort->node_count =3D cpu_to_le32(2);
> +
> +    /* virtio-iommu node */
> +
> +    iommu_node_offset =3D sizeof(*iort);
> +    iort->node_offset =3D cpu_to_le32(iommu_node_offset);
> +    iommu_node_size =3D sizeof(*iommu);
> +    iort_length +=3D iommu_node_offset;
> +    iommu =3D acpi_data_push(table_data, iommu_node_size);
> +    iommu->type =3D ACPI_IORT_NODE_PARAVIRT;
> +    iommu->length =3D cpu_to_le16(iommu_node_size);
> +    iommu->mapping_count =3D 0;
> +    iommu->devid =3D cpu_to_le32(pcms->virtio_iommu_bdf);
> +    iommu->model =3D cpu_to_le32(ACPI_IORT_NODE_PV_VIRTIO_IOMMU_PCI);
> +
> +    /* Root Complex Node */
> +    rc_node_size =3D sizeof(*rc) + 2 * sizeof(*idmap);
> +    iort_length +=3D rc_node_size;
> +    rc =3D acpi_data_push(table_data, rc_node_size);
> +
> +    rc->type =3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
> +    rc->length =3D cpu_to_le16(rc_node_size);
> +    rc->mapping_count =3D cpu_to_le32(2);
> +    rc->mapping_offset =3D cpu_to_le32(sizeof(*rc));
> +
> +    /* fully coherent device */
> +    rc->memory_properties.cache_coherency =3D cpu_to_le32(1);
> +    rc->memory_properties.memory_flags =3D 0x3; /* CCA =3D CPM =3D DCAS =
=3D 1 */
> +    rc->pci_segment_number =3D 0; /* MCFG pci_segment */
> +    fill_iort_idmap(rc->id_mapping_array, 0, 0, pcms->virtio_iommu_bdf, =
0,
> +                    iommu_node_offset);
> +    fill_iort_idmap(rc->id_mapping_array, 1, pcms->virtio_iommu_bdf + 1,
> +                    0xFFFF - pcms->virtio_iommu_bdf,
> +                    pcms->virtio_iommu_bdf + 1, iommu_node_offset);
> +
> +    iort =3D (AcpiIortTable *)(table_data->data + iort_start);
> +    iort->length =3D cpu_to_le32(iort_length);
> +
> +    build_header(linker, table_data, (void *)(table_data->data + iort_st=
art),
> +                 "IORT", table_data->len - iort_start, 0, NULL, NULL);
> +}
> +
>  static
>  void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>  {
> @@ -2835,6 +2901,12 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>              build_slit(tables_blob, tables->linker, machine);
>          }
>      }
> +
> +    if (pcms->virtio_iommu) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_iort(tables_blob, tables->linker, pcms);
> +    }
> +
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_mcfg(tables_blob, tables->linker, &mcfg);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e63604..af984ee041 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -84,6 +84,7 @@
>  #include "hw/net/ne2000-isa.h"
>  #include "standard-headers/asm-x86/bootparam.h"
>  #include "hw/virtio/virtio-pmem-pci.h"
> +#include "hw/virtio/virtio-iommu.h"
>  #include "hw/mem/memory-device.h"
>  #include "sysemu/replay.h"
>  #include "qapi/qmp/qerror.h"
> @@ -1940,6 +1941,11 @@ static void pc_machine_device_pre_plug_cb(HotplugH=
andler *hotplug_dev,
>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
>          pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) =
{
> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
> +        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +        qdev_prop_set_string(dev, "reserved-regions[0]",
> +                             "0xfee00000, 0xfeefffff, 1");
>      }
>  }
> =20
> @@ -1952,6 +1958,12 @@ static void pc_machine_device_plug_cb(HotplugHandl=
er *hotplug_dev,
>          pc_cpu_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
>          pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), "virtio-iommu-pci")) {
> +        PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +        PCIDevice *pdev =3D PCI_DEVICE(dev);
> +
> +        pcms->virtio_iommu =3D true;
> +        pcms->virtio_iommu_bdf =3D pci_get_bdf(pdev);
>      }
>  }
> =20
> @@ -1990,7 +2002,8 @@ static HotplugHandler *pc_get_hotplug_handler(Machi=
neState *machine,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), "virtio-iommu-pci")) {
>          return HOTPLUG_HANDLER(machine);
>      }
> =20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1f86eba3f9..221b4c6ef9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -49,6 +49,8 @@ struct PCMachineState {
>      bool smbus_enabled;
>      bool sata_enabled;
>      bool pit_enabled;
> +    bool virtio_iommu;
> +    uint16_t virtio_iommu_bdf;
> =20
>      /* NUMA information: */
>      uint64_t numa_nodes;
> --=20
> 2.20.1


