Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BC920786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsWTI2Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BC920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOPX-00047D-Qw
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBOOo-0003M8-Hh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:21:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBOOl-00087k-2r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598559685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msJX8TLWTxxJfrQujRwKv+bo1akuypgMwLGyrceHxA4=;
 b=ZsWTI2ThMaYKhFFAcmRpjJ3OfPm7CnyMrWTEbeG6Dl5HEyAa42AshVOfZF7MD4jgKZa/Rf
 qkJfGQnjl7zTXtOP5Z46TRzq30yZLCasuHWKD084YAugxayq0Fti5SIJj1NOfuVGIDoshi
 g8UHpiM6Pu2MjXdhsYs+IZUI5U8cLzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-r2TJj0SzPzmNVdJ0Vzno4A-1; Thu, 27 Aug 2020 16:21:19 -0400
X-MC-Unique: r2TJj0SzPzmNVdJ0Vzno4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E6AE75D;
 Thu, 27 Aug 2020 20:21:18 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69EF75D9F1;
 Thu, 27 Aug 2020 20:21:13 +0000 (UTC)
Date: Thu, 27 Aug 2020 22:21:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200827222110.1c2ee236@imammedo-mac>
In-Reply-To: <11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
 <20200826183331.GA3977@work-vm>
 <11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
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
Cc: "Daniel P. =?UTF-8?Q?B?= =?UTF-8?Q?errang=C3=A9?=" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 13:45:51 -0500
Babu Moger <babu.moger@amd.com> wrote:

>=20
>=20
> > -----Original Message-----
> > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Sent: Wednesday, August 26, 2020 1:34 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>; Daniel P. Berrang=C3=A9
> > <berrange@redhat.com>; ehabkost@redhat.com; mst@redhat.com; Michal
> > Privoznik <mprivozn@redhat.com>; qemu-devel@nongnu.org;
> > pbonzini@redhat.com; rth@twiddle.net
> > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use gene=
ric
> > decode
> >=20
> > * Babu Moger (babu.moger@amd.com) wrote:
> > >
> > > > -----Original Message-----
> > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > Sent: Wednesday, August 26, 2020 8:31 AM
> > > > To: Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com>
> > > > Cc: Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > > > rth@twiddle.net; ehabkost@redhat.com; qemu-devel@nongnu.org;
> > > > mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> > > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> > > > generic decode
> > > >
> > > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > > Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com> wrote:
> > > >
> > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:
> > > > > > On Fri, 21 Aug 2020 17:12:19 -0500 Babu Moger
> > > > > > <babu.moger@amd.com> wrote:
> > > > > >
> > > > > > > To support some of the complex topology, we introduced EPYC
> > > > > > > mode
> > > > apicid decode.
> > > > > > > But, EPYC mode decode is running into problems. Also it can
> > > > > > > become quite a maintenance problem in the future. So, it was
> > > > > > > decided to remove that code and use the generic decode which
> > > > > > > works for majority of the topology. Most of the SPECed
> > > > > > > configuration would work just fine. With some non-SPECed user
> > > > > > > inputs, it will create some sub-
> > > > optimal configuration.
> > > > > > > Here is the discussion thread.
> > > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2
> > > > > > > F%2F
> > > > > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-
> > > > d5b437c1b25
> > > > > > >
> > > >
> > 4%40amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C8a5c
> > > > 52f92
> > > > > > >
> > > >
> > 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > > > C0
> > > > > > >
> > > >
> > %7C637340454473508873&amp;sdata=3DVnW28H1v4XwK3GaNGFxu%2BhwiMeA
> > > > YO%2B
> > > > > > > 3WAzo3DeY5Ha8%3D&amp;reserved=3D0
> > > > > > >
> > > > > > > This series removes all the EPYC mode specific apicid changes
> > > > > > > and use the generic apicid decode.
> > > > > >
> > > > > > the main difference between EPYC and all other CPUs is that it
> > > > > > requires numa configuration (it's not optional) so we need an
> > > > > > extra
> > > No, That is not true. Because of that assumption we made all these
> > > apicid changes. And here we are now.
> > >
> > > AMD supports varies mixed configurations. In case of EPYC-Rome, we
> > > have NPS1, NPS2 and NPS4(Numa Nodes per socket). In case of NPS1,
> > > basically we have all the cores in a socket under one numa node. This
> > > is non-numa configuration.
> > > Looking at the various configurations and also discussing internally,
> > > it is not advisable to have (epyc && !numa) check.
> >=20
> > Indeed on real hardware, I don't think we always see NUMA; my single so=
cket,
> > 16 core/32 thread 7302P Dell box, shows the kernel printing 'No NUMA
> > configuration found...Faking a node.'
looks like firmware bug or maybe it's feature and there is a knob in fw
to turn it on/off in case used OS doesn't like it for some reason.


> > So if real hardware hasn't got a NUMA node, what's the real problem?
>=20
> I don't see any problem once we revert all these changes(patch 1-7).
> We don't need if (epyc && !numa) error check or auto_enable_numa=3Dtrue
> unconditionally.

We need revert to unbreak migration from QEMU < 5.0,
everything else (fixes for CPUID_Fn8000001E) could go on top.

So what's on top (because old code also wasn't correct when
CPUID_Fn8000001E is taken in account, tha's why we are at this point),

When starting QEMU without -numa
Indeed we can skip "if (epyc && !numa) error check or auto_enable_numa=3Dtr=
ue",
in case where there is 1 die (NPS1).
(1) User however may set core/threads number bigger than possible by spec,
    in which case CPUID_Fn8000001E_EBX/CPUID_Fn8000001E_ECX will not be
    valid spec vise and could trigger OPPs in guest kernel.
    Given we allow go out of spec, perhaps we should add a warning at
    realize time saying that used -smp config is not supported since it
    doesn't match AMD EPYC spec and might not work.

(2) Earlier we agreed that we can reuse existing die_id instead of internal
    (topo_ids.node_id in current code)
    (It's is called DIE_ID and NODE ID in spec interchangeably)
    Same as (1) add a warning when '-smp dies' goes beyond spec limits.
   =20
(3) "-smp dies>1" ''if'' we allow to run it without -numa,
    then system wide NUMA node id in CPUID_Fn8000001E_ECX probably doesn't =
matter.
    could be something like in spec but taking in account die offset, to pr=
oduce
    unique id.

    Same, add a warning that there are more than 1 dies but numa is not ena=
bled,
    suggest to enable numa.

    With current code it produces invalid APIC ID for valid '-smp' combinat=
ion,
    however if we revert it and switch to die_id than it should produce
    valid APIC ID once again (as in 4.2).
    Given it produces invalid APIC id, maybe we should just ditch the case =
and
    fold it in (4) (i.e. require -numa if "-smp dies>1")

(4) -numa is used (RHBZ1728166)
    we need to ensure that socket*dies =3D=3D ms->numa_state->num_nodes
     and make sure that CPUID_Fn8000001E_ECX consistent with
    cpu mapping provided with "-numa cpu=3D" option.

Warnings won't help a lot, but at least they will point out at
possible problem when someone complains.

> >=20
> > Dave
> >=20
> > > > > > patch on top of this series to enfoce that, i.e:
> > > > > >
> > > > > >  if (epyc && !numa)
> > > > > >     error("EPYC cpu requires numa to be configured")
> > > > >
> > > > > Please no. This will break 90% of current usage of the EPYC CPU i=
n
> > > > > real world QEMU deployments. That is way too user hostile to
> > > > > introduce as a requirement.
> > > > >
> > > > > Why do we need to force this ?  People have been successfuly usin=
g
> > > > > EPYC CPUs without NUMA in QEMU for years now.
> > > > >
> > > > > It might not match behaviour of bare metal silicon, but that
> > > > > hasn't obviously caused the world to come crashing down.
> > > > So far it produces warning in linux kernel (RHBZ1728166), (resultin=
g
> > > > performance might be suboptimal), but I haven't seen anyone reporti=
ng
> > crashes yet.
> > > >
> > > >
> > > > What other options do we have?
> > > > Perhaps we can turn on strict check for new machine types only, so
> > > > old configs can keep broken topology (CPUID), while new ones would
> > > > require -numa and produce correct topology.
> > > >
> > > >
> > > > >
> > > > > Regards,
> > > > > Daniel
> > >
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


