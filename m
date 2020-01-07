Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A324C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4421D207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx93yBgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4421D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorEX-0002oZ-B2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ior7T-0005Lj-D3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ior7Q-0007WC-Lf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:50:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ior7Q-0007Ur-Gh
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578412207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Odwf/AUtoZmMcMcAIxGxeYOSRVe1Tmv4H0wuhbOlVc=;
 b=Lx93yBgiFCs5haK/th9oQyjxqHOg5l0S06qRvMtub90sfdQQos3L5lw8Ta7zFggvkSnC1M
 81780wX1fAoBW8CFhpnZ0GiQ7gBo8BFSql8lBdx8wrt/QSK6dJ6S2pHPEjWIXjlJjCXnOT
 kJ23j508g53b/boKD2K4nJRFnuSGI48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-3ZZHcbHKMjqJOprrKr5Ilg-1; Tue, 07 Jan 2020 10:50:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FAE98024D3;
 Tue,  7 Jan 2020 15:50:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 154FD858B9;
 Tue,  7 Jan 2020 15:49:59 +0000 (UTC)
Date: Tue, 7 Jan 2020 16:49:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Message-ID: <20200107164958.7811777d@redhat.com>
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340B608D@dggemm526-mbx.china.huawei.com>
References: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107042918-mutt-send-email-mst@kernel.org>
 <678F3D1BB717D949B966B68EAEB446ED340B608D@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3ZZHcbHKMjqJOprrKr5Ilg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter
 Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 10:29:22 +0000
"Zengtao (B)" <prime.zeng@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, January 07, 2020 5:33 PM
> > To: Zengtao (B)
> > Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org; Shannon Zhao;
> > Peter Maydell; Igor Mammedov; qemu-arm@nongnu.org
> > Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
> > node_id ascending order
> > 
> > On Tue, Jan 07, 2020 at 05:18:49PM +0800, Zeng Tao wrote:  
> > > When booting the guest linux with the following numa configuration:
> > > -numa node,node_id=1,cpus=0-3
> > > -numa node,node_id=0,cpus=4-7
> > > We can get the following numa topology in the guest system:
> > > Architecture:          aarch64
> > > Byte Order:            Little Endian
> > > CPU(s):                8
> > > On-line CPU(s) list:   0-7
> > > Thread(s) per core:    1
> > > Core(s) per socket:    8
> > > Socket(s):             1
> > > NUMA node(s):          2
> > > L1d cache:             unknown size
> > > L1i cache:             unknown size
> > > L2 cache:              unknown size
> > > NUMA node0 CPU(s):     0-3
> > > NUMA node1 CPU(s):     4-7
> > > The Cpus 0-3 is assigned with NUMA node 1 in QEMU while it get NUMA  
> > node  
> > > 0 in the guest.
> > >
> > > In fact, In the linux kernel, numa_node_id is allocated per the ACPI
> > > SRAT processors structure order,so the cpu 0 will be the first one to
> > > allocate its NUMA node id, so it gets the NUMA node 0.
> > >
> > > To fix this issue, we pack the SRAT processors structure in numa node id
> > > order but not the default cpu number order.
> > >
> > > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>  
> > 
> > 
> > Does this matter? If yes fixing linux to take node id from proximity
> > field in ACPI seems cleaner ...
> >  
> 
> In fact, I just want to align the node_id concept in QEMU and Linux.
> If we fix the kernel side, we need to align with all platforms.
> i think maybe not a good idea.
if linux makes up node ID's on it's own, it would be hard for it to
map SRAT entries to other tables that use proximity id as well.

So it would need to maintain map of [proximity id] -> [node id] (and reverse)
somewhere to resolve mappings on other tables.
If it doesn't do this then it's broken and works just by accident,
if it does the fix probably should be in that code and not in QEMU.

>  
> > > ---
> > >  hw/arm/virt-acpi-build.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index bd5f771..497192b 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -520,7 +520,8 @@ build_srat(GArray *table_data, BIOSLinker  
> > *linker, VirtMachineState *vms)  
> > >      AcpiSystemResourceAffinityTable *srat;
> > >      AcpiSratProcessorGiccAffinity *core;
> > >      AcpiSratMemoryAffinity *numamem;
> > > -    int i, srat_start;
> > > +    int i, j, srat_start;
> > > +    uint32_t node_id;
> > >      uint64_t mem_base;
> > >      MachineClass *mc = MACHINE_GET_CLASS(vms);
> > >      MachineState *ms = MACHINE(vms);
> > > @@ -530,13 +531,19 @@ build_srat(GArray *table_data, BIOSLinker  
> > *linker, VirtMachineState *vms)  
> > >      srat = acpi_data_push(table_data, sizeof(*srat));
> > >      srat->reserved1 = cpu_to_le32(1);
> > >
> > > -    for (i = 0; i < cpu_list->len; ++i) {
> > > -        core = acpi_data_push(table_data, sizeof(*core));
> > > -        core->type = ACPI_SRAT_PROCESSOR_GICC;
> > > -        core->length = sizeof(*core);
> > > -        core->proximity =  
> > cpu_to_le32(cpu_list->cpus[i].props.node_id);  
> > > -        core->acpi_processor_uid = cpu_to_le32(i);
> > > -        core->flags = cpu_to_le32(1);
> > > +    for (i = 0; i < ms->numa_state->num_nodes; ++i) {
> > > +        for (j = 0; j < cpu_list->len; ++j) {  
> > 
> > Hmm O(n ^2) isn't great ...  
> Good suggestion, 3Q.
> >   
> > > +            node_id = cpu_to_le32(cpu_list->cpus[j].props.node_id);
> > > +            if (node_id != i) {
> > > +                continue;
> > > +            }
> > > +            core = acpi_data_push(table_data, sizeof(*core));
> > > +            core->type = ACPI_SRAT_PROCESSOR_GICC;
> > > +            core->length = sizeof(*core);
> > > +            core->proximity = node_id;
> > > +            core->acpi_processor_uid = cpu_to_le32(j);
> > > +            core->flags = cpu_to_le32(1);
> > > +        }
> > >      }  
> > 
> > is the issue arm specific? wouldn't it affect x86 too?
> >   
> Good question, I think it will affect x86, but I need to confirm.
> 
> > >      mem_base = vms->memmap[VIRT_MEM].base;
> > > --
> > > 2.8.1  
> 


