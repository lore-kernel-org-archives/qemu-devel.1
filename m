Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A93C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B994A2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy6ULmrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B994A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaDu-00020S-2S
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaDH-0001aA-0r
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:58:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBaDD-00014e-CG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598605097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSusMSwNDDvzRXASED8OAF6YpCqghYfqBfjouqnWnNo=;
 b=fy6ULmrMHmd9xMtW+tHBYjVeejdL+Y5fqnebrCmT2aGSJwr+IydNRkKbULjmp0MRYc5Xk5
 P6nmV8gptEA4oNBKc1Z+BqvwWMHjRt4vl91njvtoI67bveBtiQIqLL8WNbG0GFVlJs0T6M
 lynHmMhR2o0il62nKfasr8boNbQqznA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-K9Hh85YYNyiTopEDZGkyAw-1; Fri, 28 Aug 2020 04:58:12 -0400
X-MC-Unique: K9Hh85YYNyiTopEDZGkyAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D446610066FB;
 Fri, 28 Aug 2020 08:58:11 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 677AC7E565;
 Fri, 28 Aug 2020 08:58:06 +0000 (UTC)
Date: Fri, 28 Aug 2020 09:58:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200828085803.GD224144@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
 <20200826183331.GA3977@work-vm>
 <11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com>
 <20200827222110.1c2ee236@imammedo-mac>
MIME-Version: 1.0
In-Reply-To: <20200827222110.1c2ee236@imammedo-mac>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Babu Moger <babu.moger@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 10:21:10PM +0200, Igor Mammedov wrote:
> On Wed, 26 Aug 2020 13:45:51 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > 
> > 
> > > -----Original Message-----
> > > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Sent: Wednesday, August 26, 2020 1:34 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>; Daniel P. Berrangé
> > > <berrange@redhat.com>; ehabkost@redhat.com; mst@redhat.com; Michal
> > > Privoznik <mprivozn@redhat.com>; qemu-devel@nongnu.org;
> > > pbonzini@redhat.com; rth@twiddle.net
> > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
> > > decode
> > > 
> > > * Babu Moger (babu.moger@amd.com) wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > Sent: Wednesday, August 26, 2020 8:31 AM
> > > > > To: Daniel P. BerrangÃ© <berrange@redhat.com>
> > > > > Cc: Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > > > > rth@twiddle.net; ehabkost@redhat.com; qemu-devel@nongnu.org;
> > > > > mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> > > > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> > > > > generic decode
> > > > >
> > > > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > > > Daniel P. BerrangÃ© <berrange@redhat.com> wrote:
> > > > >
> > > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:
> > > > > > > On Fri, 21 Aug 2020 17:12:19 -0500 Babu Moger
> > > > > > > <babu.moger@amd.com> wrote:
> > > > > > >
> > > > > > > > To support some of the complex topology, we introduced EPYC
> > > > > > > > mode
> > > > > apicid decode.
> > > > > > > > But, EPYC mode decode is running into problems. Also it can
> > > > > > > > become quite a maintenance problem in the future. So, it was
> > > > > > > > decided to remove that code and use the generic decode which
> > > > > > > > works for majority of the topology. Most of the SPECed
> > > > > > > > configuration would work just fine. With some non-SPECed user
> > > > > > > > inputs, it will create some sub-
> > > > > optimal configuration.
> > > > > > > > Here is the discussion thread.
> > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2
> > > > > > > > F%2F
> > > > > > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-
> > > > > d5b437c1b25
> > > > > > > >
> > > > >
> > > 4%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C8a5c
> > > > > 52f92
> > > > > > > >
> > > > >
> > > 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > > > > C0
> > > > > > > >
> > > > >
> > > %7C637340454473508873&amp;sdata=VnW28H1v4XwK3GaNGFxu%2BhwiMeA
> > > > > YO%2B
> > > > > > > > 3WAzo3DeY5Ha8%3D&amp;reserved=0
> > > > > > > >
> > > > > > > > This series removes all the EPYC mode specific apicid changes
> > > > > > > > and use the generic apicid decode.
> > > > > > >
> > > > > > > the main difference between EPYC and all other CPUs is that it
> > > > > > > requires numa configuration (it's not optional) so we need an
> > > > > > > extra
> > > > No, That is not true. Because of that assumption we made all these
> > > > apicid changes. And here we are now.
> > > >
> > > > AMD supports varies mixed configurations. In case of EPYC-Rome, we
> > > > have NPS1, NPS2 and NPS4(Numa Nodes per socket). In case of NPS1,
> > > > basically we have all the cores in a socket under one numa node. This
> > > > is non-numa configuration.
> > > > Looking at the various configurations and also discussing internally,
> > > > it is not advisable to have (epyc && !numa) check.
> > > 
> > > Indeed on real hardware, I don't think we always see NUMA; my single socket,
> > > 16 core/32 thread 7302P Dell box, shows the kernel printing 'No NUMA
> > > configuration found...Faking a node.'
> looks like firmware bug or maybe it's feature and there is a knob in fw
> to turn it on/off in case used OS doesn't like it for some reason.
> 
> 
> > > So if real hardware hasn't got a NUMA node, what's the real problem?
> > 
> > I don't see any problem once we revert all these changes(patch 1-7).
> > We don't need if (epyc && !numa) error check or auto_enable_numa=true
> > unconditionally.
> 
> We need revert to unbreak migration from QEMU < 5.0,
> everything else (fixes for CPUID_Fn8000001E) could go on top.
> 
> So what's on top (because old code also wasn't correct when
> CPUID_Fn8000001E is taken in account, tha's why we are at this point),
> 
> When starting QEMU without -numa
> Indeed we can skip "if (epyc && !numa) error check or auto_enable_numa=true",
> in case where there is 1 die (NPS1).
> (1) User however may set core/threads number bigger than possible by spec,
>     in which case CPUID_Fn8000001E_EBX/CPUID_Fn8000001E_ECX will not be
>     valid spec vise and could trigger OPPs in guest kernel.
>     Given we allow go out of spec, perhaps we should add a warning at
>     realize time saying that used -smp config is not supported since it
>     doesn't match AMD EPYC spec and might not work.
> 
> (2) Earlier we agreed that we can reuse existing die_id instead of internal
>     (topo_ids.node_id in current code)
>     (It's is called DIE_ID and NODE ID in spec interchangeably)
>     Same as (1) add a warning when '-smp dies' goes beyond spec limits.
>     
> (3) "-smp dies>1" ''if'' we allow to run it without -numa,
>     then system wide NUMA node id in CPUID_Fn8000001E_ECX probably doesn't matter.
>     could be something like in spec but taking in account die offset, to produce
>     unique id.
> 
>     Same, add a warning that there are more than 1 dies but numa is not enabled,
>     suggest to enable numa.
> 
>     With current code it produces invalid APIC ID for valid '-smp' combination,
>     however if we revert it and switch to die_id than it should produce
>     valid APIC ID once again (as in 4.2).
>     Given it produces invalid APIC id, maybe we should just ditch the case and
>     fold it in (4) (i.e. require -numa if "-smp dies>1")
> 
> (4) -numa is used (RHBZ1728166)
>     we need to ensure that socket*dies == ms->numa_state->num_nodes
>      and make sure that CPUID_Fn8000001E_ECX consistent with
>     cpu mapping provided with "-numa cpu=" option.

Why do we need to socket*dies == ms->numa_state->num_nodes ? That doesn't
seem to be the case in bare metal EPYC nodes I've used which lets you
configure how many NUMA nodes in firmware.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


