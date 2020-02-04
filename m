Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32405C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29FF20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhYrwgvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29FF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iysnZ-0001df-7N
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 02:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iysmz-0001Ce-7x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iysmw-0006iL-QO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:38:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iysmw-0006Tb-C0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580801905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGIqdXFImRMrqDMJLplxYzJPprTBQAgRYecwVKGwE9U=;
 b=QhYrwgvJ6QiFmKmI+S37C/61JTVayeJx63DurShyTTyIa4zauQU4lyX0rrBR8fYjSO3JQ6
 9vNttkIdMxoDG1ck7cnoqSkVE4YMR/FpmTliIMk4oW35TJlAoTjK+5RqIHuDKHJPE/2mG7
 NiuTBopIxAsyk9yLYxeVsV/WY7TyKXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-X7g2u2MNPkOi7kW44EMUGw-1; Tue, 04 Feb 2020 02:38:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208E81137865;
 Tue,  4 Feb 2020 07:38:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFABA2101;
 Tue,  4 Feb 2020 07:38:12 +0000 (UTC)
Date: Tue, 4 Feb 2020 08:38:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
Message-ID: <20200204083811.1f681427@redhat.com>
In-Reply-To: <192836b5-bd1c-0ad5-b650-e33c6e3bc84d@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
 <b75928ec-c062-7edf-bc24-8dc0ccd7439b@amd.com>
 <20200203161758.3eb85046@redhat.com>
 <192836b5-bd1c-0ad5-b650-e33c6e3bc84d@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X7g2u2MNPkOi7kW44EMUGw-1
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 15:49:31 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/3/20 9:17 AM, Igor Mammedov wrote:
> > On Wed, 29 Jan 2020 10:17:11 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> On 1/29/20 3:14 AM, Igor Mammedov wrote:  
> >>> On Tue, 28 Jan 2020 13:45:31 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>     
> >>>> On 1/28/20 10:29 AM, Igor Mammedov wrote:    
> >>>>> On Tue, 03 Dec 2019 18:37:42 -0600
> >>>>> Babu Moger <babu.moger@amd.com> wrote:
> >>>>>       
> >>>>>> Add a new function init_apicid_fn in MachineClass to initialize the mode
> >>>>>> specific handlers to decode the apic ids.
> >>>>>>
> >>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>>>>> ---
> >>>>>>  include/hw/boards.h |    1 +
> >>>>>>  vl.c                |    3 +++
> >>>>>>  2 files changed, 4 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >>>>>> index d4fab218e6..ce5aa365cb 100644
> >>>>>> --- a/include/hw/boards.h
> >>>>>> +++ b/include/hw/boards.h
> >>>>>> @@ -238,6 +238,7 @@ struct MachineClass {
> >>>>>>                                                           unsigned cpu_index);
> >>>>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> >>>>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> >>>>>> +    void (*init_apicid_fn)(MachineState *ms);      
> >>>>> it's x86 specific, so why it wasn put into PCMachineClass?      
> >>>>
> >>>> Yes. It is x86 specific for now. I tried to make it generic function so
> >>>> other OSes can use it if required(like we have done in
> >>>> possible_cpu_arch_ids). It initializes functions required to build the
> >>>> apicid for each CPUs. We need these functions much early in the
> >>>> initialization. It should be initialized before parse_numa_opts or
> >>>> machine_run_board_init(in v1.c) which are called from generic context. We
> >>>> cannot use PCMachineClass at this time.    
> >>>
> >>> could you point to specific patches in this series that require
> >>> apic ids being initialized before parse_numa_opts and elaborate why?
> >>>
> >>> we already have possible_cpu_arch_ids() which could be called very
> >>> early and calculates APIC IDs in x86 case, so why not reuse it?    
> >>
> >>
> >> The current code(before this series) parses the numa information and then
> >> sequentially builds the apicid. Both are done together.
> >>
> >> But this series separates the numa parsing and apicid generation. Numa
> >> parsing is done first and after that the apicid is generated. Reason is we
> >> need to know the number of numa nodes in advance to decode the apicid.
> >>
> >> Look at this patch.
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2F157541988471.46157.6587693720990965800.stgit%40naples-babu.amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C0a643dd978f149acf9d108d7a8bc487a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163398941923379&amp;sdata=sP2TnNaqNXRGEeQNhJMna3wyeBqN0XbNKqgsCTVDaOQ%3D&amp;reserved=0
> >>
> >> static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> >> +                                                  const X86CPUTopoIDs
> >> *topo_ids)
> >> +{
> >> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> >> +           (topo_ids->llc_id << apicid_llc_offset_epyc(topo_info)) |
> >> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> >> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> >> +           topo_ids->smt_id;
> >> +}
> >>
> >>
> >> The function apicid_from_topo_ids_epyc builds the apicid. New decode adds
> >> llc_id(which is numa id here) to the current decoding. Other fields are
> >> mostly remains same.  
> > 
> > If llc_id is the same as numa id, why not reuse CpuInstanceProperties::node-id
> > instead of llc_id you are adding in previous patch 6/18?
> >   
> I tried to use that earlier. But dropped the idea as it required some
> changes. Don't remember exactly now. I am going to investigate again if we
> can use the node_id for our purpose here. Will let you know if I have any
> issues.
The reason I'm asking to not add new properties here is that it
expands interface visible/used by management tools and it's maintenance
burden not only on QEMU but on engagement side as well. So if yo can reuse
node-id, it will work out of box with existing users.

It should also be less confusing for us since we don't have to keep in mind
(or figure out) that llc_id is the same as node id and wonder why the later
wasn't used in the first place.



