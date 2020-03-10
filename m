Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20ADC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29F024677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM+986dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29F024677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaFh-00023W-0Y
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBaEo-0001dd-Oh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBaEj-0000wZ-QZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:27:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBaEj-0000ui-8R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLTLhA8yyzQ8vxgZeb/tvifa04erkWVJdabAMzMNkR4=;
 b=FM+986dK/lNQ75Kterlpdh/ZSIClzhYR9zkvIIVMTQrZaVSYSV2U0ucS7Q1uVlBSPxXN6p
 L3xNRIhpGQl2MsGC5GZvqiRfEM4uJ1xV5pgUmXOuEquWAY5ISgzplG7JpZEMVz07LfnFP/
 NXr0mWOeVl3egpwMCce1Zm4etj5Utxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-94dR-TuYNjOZuqQ2Ktz4yQ-1; Tue, 10 Mar 2020 04:27:35 -0400
X-MC-Unique: 94dR-TuYNjOZuqQ2Ktz4yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B29318C8C01;
 Tue, 10 Mar 2020 08:27:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16FE48AC42;
 Tue, 10 Mar 2020 08:27:29 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:27:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 11/16] target/i386: Load apicid model specific
 handlers from X86CPUDefinition
Message-ID: <20200310092728.192c57c6@redhat.com>
In-Reply-To: <f6fa5e13-3680-930f-2e0e-7651125ea309@amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326548299.40452.4030040738160407065.stgit@naples-babu.amd.com>
 <20200309154922.6a523245@Igors-MacBook-Pro>
 <f6fa5e13-3680-930f-2e0e-7651125ea309@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 14:04:39 -0500
Babu Moger <babu.moger@amd.com> wrote:

> On 3/9/20 9:49 AM, Igor Mammedov wrote:
> > On Tue, 03 Mar 2020 13:58:03 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Load the model specific handlers if available or else default handlers
> >> will be loaded. Add the model specific handlers if apicid decoding
> >> differs from the standard sequential numbering.
> >>  
> > 
> > this is still the old version of the patch and hadn't addressed feedback from v4  
> 
> Yes. I was confused little bit about it. Will fix it.
> 
> >   
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  target/i386/cpu.c |   34 ++++++++++++++++++++++++++++++++++
> >>  target/i386/cpu.h |    1 +
> >>  2 files changed, 35 insertions(+)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index c75cf744ab..f33d8b77f5 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -51,6 +51,7 @@
> >>  #include "sysemu/sysemu.h"
> >>  #include "sysemu/tcg.h"
> >>  #include "hw/qdev-properties.h"
> >> +#include "hw/i386/x86.h"  
> > this dependency shouldn't be here, see below  
> 
> ok.
> 
> >   
> >>  #include "hw/i386/topology.h"
> >>  #ifndef CONFIG_USER_ONLY
> >>  #include "exec/address-spaces.h"  
> > [...]  
> >> +void cpu_x86_init_apicid_fns(MachineState *machine)  
> > it should be something like:
> >   x86_use_epyc_apic_id_encoding(char *cpu_type)
> > try to avoid pulling in unnecessary dependency on Machine into cpu.c  
> 
> Ok.
> 
> >   
> >> +{
> >> +    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(machine->cpu_type));
> >> +    X86CPUModel *model = xcc->model;
> >> +    X86CPUDefinition *def = model->cpudef;
> >> +    X86MachineState *x86ms = X86_MACHINE(machine);
> >> +
> >> +    if (def) {
> >> +        if (def->apicid_from_cpu_idx) {
> >> +            x86ms->apicid_from_cpu_idx = def->apicid_from_cpu_idx;
> >> +        }
> >> +        if (def->topo_ids_from_apicid) {
> >> +            x86ms->topo_ids_from_apicid = def->topo_ids_from_apicid;
> >> +        }
> >> +        if (def->apicid_from_topo_ids) {
> >> +            x86ms->apicid_from_topo_ids = def->apicid_from_topo_ids;
> >> +        }
> >> +        if (def->apicid_pkg_offset) {
> >> +            x86ms->apicid_pkg_offset = def->apicid_pkg_offset;
> >> +        }
> >> +    }
> >> +}  
> > 
> > It was suggested to move defaults initialization to x86_machine_class_init()  
> 
> ok.  We don't need the above changes. I will use the boolean as you
> suggested and call this function in x86_cpus_init() to initialize the EPYC
> specific handler. Something similar like this below..
> 
> x86_use_epyc_apic_id_encoding(char *cpu_type)
> {
>       X86CPUClass *xcc = ... cpu_type ...
>       return xcc->model->cpudef->use_epyc_apic_id_encoding
> }
> 
> x86_cpus_init()
> {
>  if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>             x86ms->apicid_from_cpu_idx = ...epyc...
>             x86ms->topo_ids_from_apicid = ...epyc...
>             x86ms->apicid_from_topo_ids = ...epyc...
>             x86ms->apicid_pkg_offset = ...epyc...
>     }
> }
> 
> Sounds right?

yes, something like this

> 
> > 
> > as was suggested at 
> > [PATCH v4 12/16] hw/i386: Use the apicid handlers from X86MachineState
> > and acked by Eduardo
> >   
> >> +
> >>  static CPUCaches epyc_cache_info = {
> >>      .l1d_cache = &(CPUCacheInfo) {
> >>          .type = DATA_CACHE,
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index 20abbda647..34f0d994ef 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -1895,6 +1895,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
> >>  void host_cpuid(uint32_t function, uint32_t count,
> >>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
> >>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> >> +void cpu_x86_init_apicid_fns(MachineState *machine);
> >>  
> >>  /* helper.c */
> >>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >>  
> >   
> 


