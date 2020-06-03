Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3578C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76308205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT9ird5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76308205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVNv-0002HO-LT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jgVMh-0001Li-CG
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:31:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jgVMf-0002Yj-D3
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591198296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfiNBSpUJlZQfnMummOc2xPZYKViN+UhzinslY3zpvA=;
 b=JT9ird5t3OpC4Nv/DOiJzm9dqNOMHCUoBe5VC2UeRCK9Gic6zjxjs4qJdrhqrSBzhiUhU3
 ej5XmdZzgTabkNLKmATjVDlHB9BOicBzUN8dpwwwzQcInj+c1eSuo3KaJq0De8jz9iIler
 rpOWfTBTE3iDCT9UhVXvhJhMICpMw7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-PCaKFEvZMoidrQlLmZzD0A-1; Wed, 03 Jun 2020 11:31:25 -0400
X-MC-Unique: PCaKFEvZMoidrQlLmZzD0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A5618FE860;
 Wed,  3 Jun 2020 15:31:24 +0000 (UTC)
Received: from localhost (ovpn-113-102.phx2.redhat.com [10.3.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08B3A60C47;
 Wed,  3 Jun 2020 15:31:20 +0000 (UTC)
Date: Wed, 3 Jun 2020 11:31:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
Message-ID: <20200603153119.GA2366737@habkost.net>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
 <e68f8536-40fe-3c35-7d66-04f20fcabb8e@amd.com>
 <20200602230105.GI577771@habkost.net>
 <cc7e970a-0f03-7778-d7f9-76d528c3e260@amd.com>
MIME-Version: 1.0
In-Reply-To: <cc7e970a-0f03-7778-d7f9-76d528c3e260@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 03, 2020 at 10:22:10AM -0500, Babu Moger wrote:
> 
> 
> > -----Original Message-----
> > From: Eduardo Habkost <ehabkost@redhat.com>
> > Sent: Tuesday, June 2, 2020 6:01 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> > mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> > Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
> > functions
> > 
> > On Tue, Jun 02, 2020 at 04:59:19PM -0500, Babu Moger wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > Sent: Tuesday, June 2, 2020 12:19 PM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> > > > mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> > > > Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
> > > > functions
> > > >
> > > > Hi,
> > > >
> > > > It looks like this series breaks -device and CPU hotplug:
> > > >
> > > > On Wed, Mar 11, 2020 at 05:53:34PM -0500, Babu Moger wrote:
> > > > > These functions add support for building EPYC mode topology given the
> > smp
> > > > > details like numa nodes, cores, threads and sockets.
> > > > >
> > > > > The new apic id decoding is mostly similar to current apic id decoding
> > > > > except that it adds a new field node_id when numa configured. Removes
> > all
> > > > > the hardcoded values. Subsequent patches will use these functions to build
> > > > > the topology.
> > > > >
> > > > > Following functions are added.
> > > > > apicid_llc_width_epyc
> > > > > apicid_llc_offset_epyc
> > > > > apicid_pkg_offset_epyc
> > > > > apicid_from_topo_ids_epyc
> > > > > x86_topo_ids_from_idx_epyc
> > > > > x86_topo_ids_from_apicid_epyc
> > > > > x86_apicid_from_cpu_idx_epyc
> > > > >
> > > > > The topology details are available in Processor Programming Reference
> > (PPR)
> > > > > for AMD Family 17h Model 01h, Revision B1 Processors. The revision
> > guides
> > > > are
> > > > > available from the bugzilla Link below.
> > > > > Link:
> > > >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
> > > >
> > kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.m
> > > >
> > oger%40amd.com%7C3487f40d37df4d59097d08d807190248%7C3dd8961fe488
> > > >
> > 4e608e11a82d994e183d%7C0%7C0%7C637267151289763739&amp;sdata=wE0
> > > > ukXIVh0l5eNQWsv6VDE9UZEVJmisofaW192gcZAI%3D&amp;reserved=0
> > > > >
> > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > [...]
> > > > >  typedef struct X86CPUTopoIDs {
> > > > >      unsigned pkg_id;
> > > > > +    unsigned node_id;
> > > >
> > > > You have added a new field here.
> > > >
> > > > >      unsigned die_id;
> > > > >      unsigned core_id;
> > > > >      unsigned smt_id;
> > > > [...]
> > > > > +static inline apic_id_t
> > > > > +x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
> > > > > +                              const X86CPUTopoIDs *topo_ids)
> > > > > +{
> > > > > +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
> > > > > +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
> > > >
> > > > You are using the new field here.
> > > >
> > > > > +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> > > > > +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
> > > > > +           topo_ids->smt_id;
> > > > > +}
> > > >
> > > > But you are not initializing node_id in one caller of apicid_from_topo_ids():
> > > >
> > > > static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > > >                             DeviceState *dev, Error **errp)
> > > > {
> > > >     [...]
> > > >     X86CPUTopoIDs topo_ids;
> > > >     [...]
> > > >     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> > > >         [...]
> > > >         topo_ids.pkg_id = cpu->socket_id;
> > > >         topo_ids.die_id = cpu->die_id;
> > > >         topo_ids.core_id = cpu->core_id;
> > > >         topo_ids.smt_id = cpu->thread_id;
> > > >         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
> > > >     }
> > > >     [...]
> > > > }
> > > >
> > > > Result: -device is broken when using -cpu EPYC:
> > > >
> > > >   $ qemu-system-x86_64 -machine q35,accel=kvm -smp
> > > > 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > > cpu,core-id=0,socket-id=1,thread-id=0
> > 
> > [1]
> > 
> > > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-
> > id=1,thread-
> > > > id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0] with APIC ID
> > 21855,
> > > > valid index range 0:1
> > > >
> > > > This happens because APIC ID is calculated using uninitialized
> > > > memory.
> > > This patch should initialize the node_id. But I am not sure how to
> > > reproduce the bug. Can you please send me the full command line to
> > > reproduce the problem. Also test different options.
> > 
> > The full command line is above[1].
> 
> I just picked up the latest tree from
> git clone https://git.qemu.org/git/qemu.git qemu
> Not seeing the problem.
> 
> ./x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=kvm -smp
> 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device
> EPYC-x86_64-cpu,core-id=0,socket-id=1,thread-id=0
> VNC server running on ::1:5900
> 
> It appears to run ok.
> 
> > 
> > 
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 2128f3d6fe..047b4b9391 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -1539,6 +1539,9 @@ static void pc_cpu_pre_plug(HotplugHandler
> > *hotplug_dev,
> > >      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> > >          int max_socket = (ms->smp.max_cpus - 1) /
> > >                                  smp_threads / smp_cores / x86ms->smp_dies;
> > 
> > So, here's the input you are using to calculate topo_ids.node_id:
> > 
> > > +        unsigned nr_nodes = MAX(topo_info.nodes_per_pkg, 1);
> > 
> > When is topo_info.nodes_per_pkg allowed to be 0?
> 
> It will be zero if numa is not configured. Node_id will be zero for all
> the cores.
> 
> > 
> > > +        unsigned cores_per_node = DIV_ROUND_UP((x86ms->smp_dies *
> > smp_cores *
> > > +                                                smp_threads), nr_nodes);
> > 
> > x86ms->smp_dies should be available at topo_info.dies_per_pkg,
> > smp_cores should available at topo_info.cores_per_die,
> > smp_threads should be available at topo_info.threads_per_core,
> > nr_nodes should be available at topo_info.nodes_per_pkg.
> > 
> > >
> > >          /*
> > >           * die-id was optional in QEMU 4.0 and older, so keep it optional
> > > @@ -1585,6 +1588,7 @@ static void pc_cpu_pre_plug(HotplugHandler
> > *hotplug_dev,
> > >          topo_ids.die_id = cpu->die_id;
> > >          topo_ids.core_id = cpu->core_id;
> > >          topo_ids.smt_id = cpu->thread_id;
> > > +        topo_ids.node_id = (cpu->core_id / cores_per_node) % nr_nodes;
> > 
> > apicid_from_topo_ids() have access to topo_info and topo_ids, If
> > all the information you need to calculate node_id is already
> > available inside topo_info + topo_ids, we could be calculating it
> > inside apicid_from_topo_ids().  Why don't we do it?
> > 
> > Also, is topo_ids.core_id really allowed to be larger than
> > cores_per_node when calling apicid_from_topo_ids()?
> 
> Yes. It is. If we have two numa nodes and 8 cores. Then cores_per_node is
> 4. Nr_nodes =2. Yes. Core_id can be larger than cores_per_node.

I assumed core_id identified the core inside a die, and the range
would be [0, cores_per_die).  This seems to be what
apicid_from_topo_ids_epyc() expects.

We need clearer documentation on the semantics of each *_id
field, to avoid confusion.

> 
> > 
> > >          cpu->apic_id =
> > >          x86ms->apicid_from_topo_ids(&topo_info,
> > >          &topo_ids); }
> > >
> > 
> > -- Eduardo
> 

-- 
Eduardo


