Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AC1206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSM0ua9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AC1206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGaY-0002Qz-PQ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeGZz-0001wn-So
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:20:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeGZy-0003ww-Dk
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590664805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMRO/HwcxcZPCUWpxJpahNSpNOHRa6o617UVKbeFqMk=;
 b=RSM0ua9heWKscZbmy2iO18H+KSWsmAoSGaekgjXnvDiYjUwWyeNuHOHHh3yTgxzT1PWGlb
 W2sQFkvdGlRZNjmYNEItddxWtHS+/GUccytFMpdb+XGT+KCkOeNMCcoc713inXVX/WmJsp
 al7t7u9rh5vWf20bsBhxNVP4g8EPIVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-hUzjcTwRPy6WQBkQPKIjlg-1; Thu, 28 May 2020 07:19:59 -0400
X-MC-Unique: hUzjcTwRPy6WQBkQPKIjlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AA67107ACCD;
 Thu, 28 May 2020 11:19:58 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9E51101E673;
 Thu, 28 May 2020 11:19:49 +0000 (UTC)
Date: Thu, 28 May 2020 13:19:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 2/3] hw/acpi-build: account for NVDIMM numa nodes in
 SRAT
Message-ID: <20200528131946.3a09cd20@redhat.com>
In-Reply-To: <20200528054807.21278-3-vishal.l.verma@intel.com>
References: <20200528054807.21278-1-vishal.l.verma@intel.com>
 <20200528054807.21278-3-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jingqi.liu@intel.com,
 Dave Hansen <dave.hansen@linux.intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 23:48:06 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> NVDIMMs can belong to their own proximity domains, as described by the
> NFIT. In such cases, the SRAT needs to have Memory Affinity structures
> in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
> data structures properly during NUMA initialization. See the following
> for an example failure case.
> 
> https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/
> 
> Fix this by adding device address range and node information from
> NVDIMMs to the SRAT in build_srat().
> 
> The relevant command line options to exercise this are below. Nodes 0-1
> contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
> space.
> 
>   -numa node,nodeid=0,mem=2048M,
>   -numa node,nodeid=1,mem=2048M,
>   -numa node,nodeid=2,mem=0,
>   -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=128M
>   -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
>   -numa node,nodeid=3,mem=0,
>   -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=128M
>   -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3
> 
> Cc: Jingqi Liu <jingqi.liu@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  hw/acpi/nvdimm.c        | 26 ++++++++++++++++++++++++++
>  hw/i386/acpi-build.c    | 10 ++++++++++
>  include/hw/mem/nvdimm.h |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9316d12b70..d322c6a7a7 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -28,6 +28,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/uuid.h"
> +#include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/bios-linker-loader.h"
> @@ -1334,6 +1335,31 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>      free_aml_allocator();
>  }
>  
> +void *nvdimm_build_srat(GArray *table_data)
> +{
> +    AcpiSratMemoryAffinity *numamem = NULL;
> +    GSList *device_list = nvdimm_get_device_list();
> +
> +    for (; device_list; device_list = device_list->next) {
> +        DeviceState *dev = device_list->data;
I'd use Object here with OBJECT() cast and drop casts beolw in property getters

> +        uint64_t addr, size;
> +        int node;
> +
> +        node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                       &error_abort);
> +        addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
> +                                        &error_abort);
> +        size = object_property_get_uint(OBJECT(dev), PC_DIMM_SIZE_PROP,
> +                                        &error_abort);
> +
> +        numamem = acpi_data_push(table_data, sizeof *numamem);
> +        build_srat_memory(numamem, addr, size, node,
> +                          MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
> +    }
> +    g_slist_free(device_list);
> +    return numamem;
> +}
> +
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         BIOSLinker *linker, NVDIMMState *state,
>                         uint32_t ram_slots)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e15f6848e..1461d8a718 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2428,6 +2428,16 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                                MEM_AFFINITY_ENABLED);
>          }
>      }
> +
> +    if (machine->nvdimms_state->is_enabled) {
> +        void *ret;
> +
> +        ret = nvdimm_build_srat(table_data);
> +        if (ret != NULL) {
> +            numamem = ret;
> +        }

why do we need return value here and a test condition and assign 'ret' to numamem?

> +    }
> +
>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index a3c08955e8..fbe56509b8 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -155,6 +155,7 @@ typedef struct NVDIMMState NVDIMMState;
>  void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
>                              struct AcpiGenericAddress dsm_io,
>                              FWCfgState *fw_cfg, Object *owner);
> +void *nvdimm_build_srat(GArray *table_data);
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         BIOSLinker *linker, NVDIMMState *state,
>                         uint32_t ram_slots);


