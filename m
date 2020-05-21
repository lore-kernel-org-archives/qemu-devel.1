Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B157C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A43020748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6mNrtM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A43020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmxF-0007ea-9s
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbmwd-00078Z-0f
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:17:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbmwc-00010A-16
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590074229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5cCSpbXJx9JQ2LEHphZBAwxQ67olcgcZJ23avf9nYQ=;
 b=P6mNrtM0+NquILRK+YdhjiuYe6TIA+Uvntbjx+YFJglpjin7N4RS32/NzoChlDbcESqYXc
 yGfrw+xULqhp/10twWzyIdfUVwfGJM5oo3rAlKyrFEgaAjgEKMmrRDdZCdW3NbkujVTUx9
 f7Mg/g0ApbZQ4LNPFQYkfl5ST/WkkS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Yu17PuHCMpC4uVwUEjlR8A-1; Thu, 21 May 2020 11:17:07 -0400
X-MC-Unique: Yu17PuHCMpC4uVwUEjlR8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D9078005AA;
 Thu, 21 May 2020 15:17:06 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 260B160C05;
 Thu, 21 May 2020 15:17:00 +0000 (UTC)
Date: Thu, 21 May 2020 17:16:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Message-ID: <20200521171657.778f20a4@redhat.com>
In-Reply-To: <20200428012810.10877-3-vishal.l.verma@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
 <20200428012810.10877-3-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
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
Cc: jingqi.liu@intel.com, Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 19:28:09 -0600
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
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  hw/i386/acpi-build.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23c77eeb95..b0da67de0e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -48,6 +48,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
> +#include "qemu/nvdimm-utils.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
>  
> @@ -2429,6 +2430,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                                MEM_AFFINITY_ENABLED);
>          }
>      }
> +
> +    if (machine->nvdimms_state->is_enabled) {
> +        GSList *device_list = nvdimm_get_device_list();
> +
> +        for (; device_list; device_list = device_list->next) {
> +            DeviceState *dev = device_list->data;
> +            int node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                               NULL);
> +            uint64_t addr = object_property_get_uint(OBJECT(dev),
> +                                                     PC_DIMM_ADDR_PROP, NULL);
> +            uint64_t size = object_property_get_uint(OBJECT(dev),
> +                                                     PC_DIMM_SIZE_PROP, NULL);
> +
suggest to use error_abort in getters

> +            numamem = acpi_data_push(table_data, sizeof *numamem);
> +            build_srat_memory(numamem, addr, size, node,
> +                              MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
> +        }
who is in charge of freeing device_list ?

> +    }

There is ARM version of build_srat(),
I suggest to put this NVDIMM specific part in helper function within hw/acpi/nvdimm.c
and use it from both build_srat() functions.

> +
>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);


