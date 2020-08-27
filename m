Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CB5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D0120737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUIvrghe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D0120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOwZ-0003QF-TQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBOvu-0002zv-5m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBOvr-0003nq-Ij
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598561738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIQfc/ICmkIcvXaBVLsSwMjGA1OZ8SgIJ6PkQxNsCFQ=;
 b=hUIvrgheBh/JcWAVDMc6A4nTSnvmE2rgHH+nPHylls+/NkpbllBzvqEyVwDjEKU9Rfvoum
 gxcQvWCyEzT5w/5gThGIW6Nj/nKiLOmE30/N5EJ7rnG+x3q8kzo68L/ASx4J9SMU5Sq7qw
 SkNJNCXMgnPqnAgWLIfkmIi/DsJrKos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-QPLEqi4tMIalrePicSJuWQ-1; Thu, 27 Aug 2020 16:55:36 -0400
X-MC-Unique: QPLEqi4tMIalrePicSJuWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 370C01029D22;
 Thu, 27 Aug 2020 20:55:35 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7269774E23;
 Thu, 27 Aug 2020 20:55:29 +0000 (UTC)
Date: Thu, 27 Aug 2020 22:55:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200827225526.0b1f6d32@imammedo-mac>
In-Reply-To: <20200827190752.GK642093@habkost.net>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <20200826133638.GO168515@redhat.com>
 <20200826160258.0e9047f4@redhat.com>
 <20200826150340.GP168515@redhat.com>
 <20200827190314.717ec788@imammedo-mac>
 <20200827190752.GK642093@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, mst@redhat.com,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 15:07:52 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Aug 27, 2020 at 07:03:14PM +0200, Igor Mammedov wrote:
> > On Wed, 26 Aug 2020 16:03:40 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Wed, Aug 26, 2020 at 04:02:58PM +0200, Igor Mammedov wrote:
> > > > On Wed, 26 Aug 2020 14:36:38 +0100
> > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > >=20
> > > > > On Wed, Aug 26, 2020 at 03:30:34PM +0200, Igor Mammedov wrote:
> > > > > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > > > >  =20
> > > > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote=
: =20
> > > > > > > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > > > > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > > > > >    =20
> > > > > > > > > To support some of the complex topology, we introduced EP=
YC mode apicid decode.
> > > > > > > > > But, EPYC mode decode is running into problems. Also it c=
an become quite a
> > > > > > > > > maintenance problem in the future. So, it was decided to =
remove that code and
> > > > > > > > > use the generic decode which works for majority of the to=
pology. Most of the
> > > > > > > > > SPECed configuration would work just fine. With some non-=
SPECed user inputs,
> > > > > > > > > it will create some sub-optimal configuration.
> > > > > > > > > Here is the discussion thread.
> > > > > > > > > https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e46=
8-d5b437c1b254@amd.com/
> > > > > > > > >=20
> > > > > > > > > This series removes all the EPYC mode specific apicid cha=
nges and use the generic
> > > > > > > > > apicid decode.   =20
> > > > > > > >=20
> > > > > > > > the main difference between EPYC and all other CPUs is that
> > > > > > > > it requires numa configuration (it's not optional)
> > > > > > > > so we need an extra patch on top of this series to enfoce t=
hat, i.e:
> > > > > > > >=20
> > > > > > > >  if (epyc && !numa)=20
> > > > > > > >     error("EPYC cpu requires numa to be configured")   =20
> > > > > > >=20
> > > > > > > Please no. This will break 90% of current usage of the EPYC C=
PU in
> > > > > > > real world QEMU deployments. That is way too user hostile to =
introduce
> > > > > > > as a requirement.
> > > > > > >=20
> > > > > > > Why do we need to force this ?  People have been successfuly =
using
> > > > > > > EPYC CPUs without NUMA in QEMU for years now.
> > > > > > >=20
> > > > > > > It might not match behaviour of bare metal silicon, but that =
hasn't
> > > > > > > obviously caused the world to come crashing down. =20
> > > > > > So far it produces warning in linux kernel (RHBZ1728166),
> > > > > > (resulting performance might be suboptimal), but I haven't seen
> > > > > > anyone reporting crashes yet.
> > > > > >=20
> > > > > >=20
> > > > > > What other options do we have?
> > > > > > Perhaps we can turn on strict check for new machine types only,
> > > > > > so old configs can keep broken topology (CPUID),
> > > > > > while new ones would require -numa and produce correct topology=
. =20
> > > > >=20
> > > > > No, tieing this to machine types is not viable either. That is st=
ill
> > > > > going to break essentially every single management application th=
at
> > > > > exists today using QEMU.
> > > > for that we have deprecation process, so users could switch to new =
CLI
> > > > that would be required.
> > >=20
> > > We could, but I don't find the cost/benefit tradeoff is compelling.
> > >=20
> > > There are so many places where we diverge from what bare metal would
> > > do, that I don't see a good reason to introduce this breakage, even
> > > if we notify users via a deprecation message.=20
> > I find (3) and (4) good enough reasons to use deprecation.
> >=20
> > > If QEMU wants to require NUMA for EPYC, then QEMU could internally
> > > create a single NUMA node if none was specified for new machine
> > > types, such that there is no visible change or breakage to any
> > > mgmt apps. =20
> >=20
> > (1) for configs that started without -numa &&|| without -smp dies>1,
> >       QEMU can do just that (enable auto_enable_numa).
>=20
> Why exactly do we need auto_enable_numa with dies=3D1?
>=20
> If I understand correctly, Babu said earlier in this thread[1]
> that we don't need auto_enable_numa.
>=20
> [1] https://lore.kernel.org/qemu-devel/11489e5f-2285-ddb4-9c35-c9f522d603=
a0@amd.com/

in case of 1 die, -numa is not must have as it's one numa node only.
Though having auto_enable_numa, will allow to reuse the CPU.node-id propert=
y
to compose CPUID_Fn8000001E_ECX. i.e only code one path vs numa|non-numa va=
riant.

=20
> > (2) As for configs that are out of spec, I do not care much (junk in - =
junk out)
> > (though not having to spend time on bug reports and debug issues, just =
to say
> > it's not supported in the end, makes deprecation sound like a reasonabl=
e
> > choice)
> >=20
> > (3) However if config matches bare metal i.e. CPU has more than 1 die a=
nd within
> > dies limits (spec wise), QEMU has to produce valid CPUs.
> > In this case QEMU can't make up multiple numa nodes and mappings of RAM=
/CPUs
> > on user's behalf. That's where we have to error out and ask for explici=
t
> > numa configuration.
> >=20
> > For such configs, current code (since 5.0), will produce in the best ca=
se
> > performance issues  due to mismatching data in APICID, CPUID and ACPI t=
ables,
> > in the worst case issues might be related to invalid APIC ID if running=
 on EPYC host
> > and HW takes in account subfields of APIC ID (according to Babu real CP=
U uses
> > die_id(aka node_id) internally).
> > I'd rather error out on nonsense configs earlier than debug such issues
> > and than error out anyways later (upsetting more users).
> >=20
>=20
> The requirements are not clear to me.  Is this just about making
> CPU die_id match the NUMA node ID, or are there additional
> constraints?
die_id is per socket numa node index, so it's not numa node id in
a sense we use it in qemu
(that's where all the confusion started that led to current code)

I understood that each die in EPYC chip is a numa node, which encodes
NUMA node ID (system wide) in CPUID_Fn8000001E_ECX, that's why I
wrote earlier that EPYC makes -numa non optional.

In case of only one die we can either use auto_enable_numa to ensure
that we have consistent code or special case it and just hardcode=20
CPUID_Fn8000001E_ECX value which is hackish but will let us avoid
enabling numa (explicitly or implictly).

in case of multiple dies, CPUID_Fn8000001E_ECX (encodes number of nodes +
systemwide numa node id looking at CPUID of real EPYC machine)
shall match -numa mapping (otherwise it's a bug where CPUID and
ACPI mismatch).
Here we can go to ways:
  1) ask user to provide sane config with -numa (I'd prefer that)
     and use that info to fill in CPUID_Fn8000001E_ECX
  2) pretend that it's non numa machine, skip ACPI SRAT table
     but make up CPUID_Fn8000001E (i.e. another special case)
     (requires another code path and addition to -numa one)



>=20
>=20
> > (4)
> > If I were non hobby user, I'd hate if QEMU allowed me to start invalid =
config,
> > that I'd have to spend time on debugging issues (including performance =
ones),
> > instead of clearly telling me what's wrong and how config should be cor=
rected.
> > I'd probably jump to another hypervisor that does the job right,
> > instead of digging into QEMU codebase and CPU specs to figure out how
> > to hack and configure it.
> >=20
>=20


