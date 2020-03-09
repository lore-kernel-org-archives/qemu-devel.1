Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC27CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A04205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJCklVW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A04205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJpE-0004jM-UL
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJoU-0004AG-KA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJoT-0004dV-84
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:55:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53115
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJoT-0004bP-2U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqwWreUaZoPxzpqPTNxmMqGOdhjQZ5WqwRXhBdLKQEw=;
 b=CJCklVW/bMi0MRagaanAkttUlvAWJ+s6zieP+X1hnYQez0bRjqqRNK7mxt3mnpeyMJQSkR
 8+2jVrcJzCqjmEJk50InyS9/Y2ejOUR0B33Swp+ZwOTt1aHuPrs6i2qRS/oXu8gnasu1LS
 Trzn8ejEv22p34jucE60vUibzMWNOlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-k6C8HNCMOmu3tCh82YMw3g-1; Mon, 09 Mar 2020 10:55:22 -0400
X-MC-Unique: k6C8HNCMOmu3tCh82YMw3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5DF8017DF;
 Mon,  9 Mar 2020 14:55:21 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68FE31001B0B;
 Mon,  9 Mar 2020 14:55:17 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:55:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 11/16] target/i386: Load apicid model specific
 handlers from X86CPUDefinition
Message-ID: <20200309155514.13fd19c9@Igors-MacBook-Pro>
In-Reply-To: <20200309154922.6a523245@Igors-MacBook-Pro>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326548299.40452.4030040738160407065.stgit@naples-babu.amd.com>
 <20200309154922.6a523245@Igors-MacBook-Pro>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 15:49:22 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 03 Mar 2020 13:58:03 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > Load the model specific handlers if available or else default handlers
> > will be loaded. Add the model specific handlers if apicid decoding
> > differs from the standard sequential numbering.
> > 
> 
> this is still the old version of the patch and hadn't addressed feedback from v4
> 
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c |   34 ++++++++++++++++++++++++++++++++++
> >  target/i386/cpu.h |    1 +
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index c75cf744ab..f33d8b77f5 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -51,6 +51,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/tcg.h"
> >  #include "hw/qdev-properties.h"
> > +#include "hw/i386/x86.h"
> this dependency shouldn't be here, see below

btw: it does break build of linux-user target
(one more reason to avoid machine deps)

> 
> >  #include "hw/i386/topology.h"
> >  #ifndef CONFIG_USER_ONLY
> >  #include "exec/address-spaces.h"
> [...]
> > +void cpu_x86_init_apicid_fns(MachineState *machine)
> it should be something like:
>   x86_use_epyc_apic_id_encoding(char *cpu_type)
> try to avoid pulling in unnecessary dependency on Machine into cpu.c
> 
> > +{
> > +    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(machine->cpu_type));
> > +    X86CPUModel *model = xcc->model;
> > +    X86CPUDefinition *def = model->cpudef;
> > +    X86MachineState *x86ms = X86_MACHINE(machine);
> > +
> > +    if (def) {
> > +        if (def->apicid_from_cpu_idx) {
> > +            x86ms->apicid_from_cpu_idx = def->apicid_from_cpu_idx;
> > +        }
> > +        if (def->topo_ids_from_apicid) {
> > +            x86ms->topo_ids_from_apicid = def->topo_ids_from_apicid;
> > +        }
> > +        if (def->apicid_from_topo_ids) {
> > +            x86ms->apicid_from_topo_ids = def->apicid_from_topo_ids;
> > +        }
> > +        if (def->apicid_pkg_offset) {
> > +            x86ms->apicid_pkg_offset = def->apicid_pkg_offset;
> > +        }
> > +    }
> > +}
> 
> It was suggested to move defaults initialization to x86_machine_class_init()
> 
> as was suggested at 
> [PATCH v4 12/16] hw/i386: Use the apicid handlers from X86MachineState
> and acked by Eduardo
> 
> > +
> >  static CPUCaches epyc_cache_info = {
> >      .l1d_cache = &(CPUCacheInfo) {
> >          .type = DATA_CACHE,
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 20abbda647..34f0d994ef 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1895,6 +1895,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
> >  void host_cpuid(uint32_t function, uint32_t count,
> >                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
> >  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> > +void cpu_x86_init_apicid_fns(MachineState *machine);
> >  
> >  /* helper.c */
> >  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > 
> 
> 


