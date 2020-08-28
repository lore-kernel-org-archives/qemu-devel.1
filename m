Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1726C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9544D208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXV85ERh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9544D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaBk-0000PA-UV
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaAp-0008JF-J6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:55:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaAn-0000lx-DH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598604947;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqsqtjeqZOzxCbtlMYplNuzkCVv8TNpyliGZRjdcEIU=;
 b=MXV85ERhqqVjJrRK/pCaCXBSRUMrydU8+z9l7MroX5uIHww0c1DDwebKSCyFjW3Ry84dcJ
 BhNIvuBTz+15dw6KGIjUPCvrN9fjEfmpBqb3AnFabyc9nzyDR/hgfOR5VT9uk3oYHF364c
 8IDvTf7GIWWkaNZSSr94qv2hrbnZesQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-yC7aQ_8yPZ-jgWjaT6ujJA-1; Fri, 28 Aug 2020 04:55:43 -0400
X-MC-Unique: yC7aQ_8yPZ-jgWjaT6ujJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF87A1084C95;
 Fri, 28 Aug 2020 08:55:42 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CED484FA;
 Fri, 28 Aug 2020 08:55:36 +0000 (UTC)
Date: Fri, 28 Aug 2020 09:55:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200828085533.GC224144@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <20200826133638.GO168515@redhat.com>
 <20200826160258.0e9047f4@redhat.com>
 <20200826150340.GP168515@redhat.com>
 <20200827190314.717ec788@imammedo-mac>
 <20200827190752.GK642093@habkost.net>
 <20200827225526.0b1f6d32@imammedo-mac>
MIME-Version: 1.0
In-Reply-To: <20200827225526.0b1f6d32@imammedo-mac>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 00:28:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 10:55:26PM +0200, Igor Mammedov wrote:
> On Thu, 27 Aug 2020 15:07:52 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, Aug 27, 2020 at 07:03:14PM +0200, Igor Mammedov wrote:
> > > On Wed, 26 Aug 2020 16:03:40 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > > On Wed, Aug 26, 2020 at 04:02:58PM +0200, Igor Mammedov wrote:
> > > > > On Wed, 26 Aug 2020 14:36:38 +0100
> > > > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > 
> > > > > > On Wed, Aug 26, 2020 at 03:30:34PM +0200, Igor Mammedov wrote:
> > > > > > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > > > > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > > >   
> > > > > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:  
> > > > > > > > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > > > > > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > > > > > >     
> > > > > > > > > > To support some of the complex topology, we introduced EPYC mode apicid decode.
> > > > > > > > > > But, EPYC mode decode is running into problems. Also it can become quite a
> > > > > > > > > > maintenance problem in the future. So, it was decided to remove that code and
> > > > > > > > > > use the generic decode which works for majority of the topology. Most of the
> > > > > > > > > > SPECed configuration would work just fine. With some non-SPECed user inputs,
> > > > > > > > > > it will create some sub-optimal configuration.
> > > > > > > > > > Here is the discussion thread.
> > > > > > > > > > https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> > > > > > > > > > 
> > > > > > > > > > This series removes all the EPYC mode specific apicid changes and use the generic
> > > > > > > > > > apicid decode.    
> > > > > > > > > 
> > > > > > > > > the main difference between EPYC and all other CPUs is that
> > > > > > > > > it requires numa configuration (it's not optional)
> > > > > > > > > so we need an extra patch on top of this series to enfoce that, i.e:
> > > > > > > > > 
> > > > > > > > >  if (epyc && !numa) 
> > > > > > > > >     error("EPYC cpu requires numa to be configured")    
> > > > > > > > 
> > > > > > > > Please no. This will break 90% of current usage of the EPYC CPU in
> > > > > > > > real world QEMU deployments. That is way too user hostile to introduce
> > > > > > > > as a requirement.
> > > > > > > > 
> > > > > > > > Why do we need to force this ?  People have been successfuly using
> > > > > > > > EPYC CPUs without NUMA in QEMU for years now.
> > > > > > > > 
> > > > > > > > It might not match behaviour of bare metal silicon, but that hasn't
> > > > > > > > obviously caused the world to come crashing down.  
> > > > > > > So far it produces warning in linux kernel (RHBZ1728166),
> > > > > > > (resulting performance might be suboptimal), but I haven't seen
> > > > > > > anyone reporting crashes yet.
> > > > > > > 
> > > > > > > 
> > > > > > > What other options do we have?
> > > > > > > Perhaps we can turn on strict check for new machine types only,
> > > > > > > so old configs can keep broken topology (CPUID),
> > > > > > > while new ones would require -numa and produce correct topology.  
> > > > > > 
> > > > > > No, tieing this to machine types is not viable either. That is still
> > > > > > going to break essentially every single management application that
> > > > > > exists today using QEMU.
> > > > > for that we have deprecation process, so users could switch to new CLI
> > > > > that would be required.
> > > > 
> > > > We could, but I don't find the cost/benefit tradeoff is compelling.
> > > > 
> > > > There are so many places where we diverge from what bare metal would
> > > > do, that I don't see a good reason to introduce this breakage, even
> > > > if we notify users via a deprecation message. 
> > > I find (3) and (4) good enough reasons to use deprecation.
> > > 
> > > > If QEMU wants to require NUMA for EPYC, then QEMU could internally
> > > > create a single NUMA node if none was specified for new machine
> > > > types, such that there is no visible change or breakage to any
> > > > mgmt apps.  
> > > 
> > > (1) for configs that started without -numa &&|| without -smp dies>1,
> > >       QEMU can do just that (enable auto_enable_numa).
> > 
> > Why exactly do we need auto_enable_numa with dies=1?
> > 
> > If I understand correctly, Babu said earlier in this thread[1]
> > that we don't need auto_enable_numa.
> > 
> > [1] https://lore.kernel.org/qemu-devel/11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com/
> 
> in case of 1 die, -numa is not must have as it's one numa node only.
> Though having auto_enable_numa, will allow to reuse the CPU.node-id property
> to compose CPUID_Fn8000001E_ECX. i.e only code one path vs numa|non-numa variant.
> 
>  
> > > (2) As for configs that are out of spec, I do not care much (junk in - junk out)
> > > (though not having to spend time on bug reports and debug issues, just to say
> > > it's not supported in the end, makes deprecation sound like a reasonable
> > > choice)
> > > 
> > > (3) However if config matches bare metal i.e. CPU has more than 1 die and within
> > > dies limits (spec wise), QEMU has to produce valid CPUs.
> > > In this case QEMU can't make up multiple numa nodes and mappings of RAM/CPUs
> > > on user's behalf. That's where we have to error out and ask for explicit
> > > numa configuration.
> > > 
> > > For such configs, current code (since 5.0), will produce in the best case
> > > performance issues  due to mismatching data in APICID, CPUID and ACPI tables,
> > > in the worst case issues might be related to invalid APIC ID if running on EPYC host
> > > and HW takes in account subfields of APIC ID (according to Babu real CPU uses
> > > die_id(aka node_id) internally).
> > > I'd rather error out on nonsense configs earlier than debug such issues
> > > and than error out anyways later (upsetting more users).
> > > 
> > 
> > The requirements are not clear to me.  Is this just about making
> > CPU die_id match the NUMA node ID, or are there additional
> > constraints?
> die_id is per socket numa node index, so it's not numa node id in
> a sense we use it in qemu
> (that's where all the confusion started that led to current code)
> 
> I understood that each die in EPYC chip is a numa node, which encodes
> NUMA node ID (system wide) in CPUID_Fn8000001E_ECX, that's why I
> wrote earlier that EPYC makes -numa non optional.

AFAIK, that isnt a hard requirement.  In bare metal EPYC machine I
have used, the BIOS lets you choose whether the dies are exposed as
1, 2 or 4 NUMA nodes. So there's no fixed  die == numa node mapping
that I see.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


