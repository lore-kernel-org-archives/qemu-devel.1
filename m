Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4918C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803C324677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMhiWbAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803C324677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaKF-0004uP-IT
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBaIc-0003m8-83
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBaIa-0001jB-S3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:31:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBaIa-0001gw-NX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+4d7xxJdDYKbYDkhtkDSdHopSsdQae6QDFkShJ/vIw=;
 b=UMhiWbAeLsKgLPYt4XUVLva6MZdFvv5GV/jk2wO6OTG/BL55DMCDPpR+mgVrYJnbGuPkR6
 fJIYDyQttrT6bhvbbQM5hVPIjctpKa0YX+syxoWLr3Ghge+ErlJCXJjDftInbwD4SdTYA8
 t+Jx8BBWCa168MstViZkReNmZR4rVeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-1xKo_y9BMfG-4jYElynbUw-1; Tue, 10 Mar 2020 04:31:34 -0400
X-MC-Unique: 1xKo_y9BMfG-4jYElynbUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5B2477;
 Tue, 10 Mar 2020 08:31:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF705D9E2;
 Tue, 10 Mar 2020 08:31:24 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:31:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
Message-ID: <20200310093122.1ecb89ab@redhat.com>
In-Reply-To: <a7c44aaa-cc0f-68be-6183-5f6bfb6a3ec3@amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326548999.40452.9247570542382737462.stgit@naples-babu.amd.com>
 <20200309160157.0509fa8d@Igors-MacBook-Pro>
 <a7c44aaa-cc0f-68be-6183-5f6bfb6a3ec3@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Mon, 9 Mar 2020 14:08:53 -0500
Babu Moger <babu.moger@amd.com> wrote:

> On 3/9/20 10:01 AM, Igor Mammedov wrote:
> > On Tue, 03 Mar 2020 13:58:10 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Check and Load the apicid handlers from X86CPUDefinition if available.
> >> Update the calling convention for the apicid handlers.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>  
> > 
> >   
> >> ---
> >>  hw/i386/pc.c  |    6 +++---
> >>  hw/i386/x86.c |   11 +++++++----
> >>  2 files changed, 10 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 17cce3f074..c600ba0432 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1581,14 +1581,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >>          topo_ids.die_id = cpu->die_id;
> >>          topo_ids.core_id = cpu->core_id;
> >>          topo_ids.smt_id = cpu->thread_id;
> >> -        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> >> +        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> >>      }
> >>  
> >>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> >>      if (!cpu_slot) {
> >>          MachineState *ms = MACHINE(pcms);
> >>  
> >> -        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> >> +        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);  
> > this (including other similar) change(s) to callbacks should go to 11/16  
> 
> So, you mean patch #11 and #12 should be squashed together. Is that right?
yes, modulo cpu_x86_init_apicid_fns() which sets defaults (it should be machine's
class_init)


> 
> >   
> >>          error_setg(errp,
> >>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> >>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> >> @@ -1609,7 +1609,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
> >>       * once -smp refactoring is complete and there will be CPU private
> >>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> >> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> >> +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> >>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
> >>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> >>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index 15b7815bb0..d46dd4ad9e 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -86,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >>  
> >>      init_topo_info(&topo_info, x86ms);
> >>  
> >> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
> >> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
> >>      if (x86mc->compat_apic_id_mode) {
> >>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
> >>              error_report("APIC IDs set in compatibility mode, "
> >> @@ -158,8 +158,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
> >>     init_topo_info(&topo_info, x86ms);
> >>  
> >>     assert(idx < ms->possible_cpus->len);
> >> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> >> -                            &topo_info, &topo_ids);
> >> +   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> >> +                               &topo_info, &topo_ids);
> >>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
> >>  }
> >>  
> >> @@ -179,6 +179,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
> >>          return ms->possible_cpus;
> >>      }
> >>  
> >> +    /* Initialize apicid handlers */
> >> +    cpu_x86_init_apicid_fns(ms);
> >> +
> >>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> >>                                    sizeof(CPUArchId) * max_cpus);
> >>      ms->possible_cpus->len = max_cpus;
> >> @@ -192,7 +195,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
> >>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> >>          ms->possible_cpus->cpus[i].arch_id =
> >>              x86_cpu_apic_id_from_index(x86ms, i);
> >> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> >> +        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> >>                                   &topo_info, &topo_ids);  
> > 
> > not aligned properly
> >   
> >>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
> >>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
> >>  
> >   
> 


