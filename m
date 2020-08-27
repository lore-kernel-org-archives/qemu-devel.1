Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D88C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8145B2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z78H9Mnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8145B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLKQ-0005qf-Je
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBLJB-0003Mg-A0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:03:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBLJ9-0005pq-0K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598547806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FT4Rh1amtZ1zt7K+NdwtQNMPi4Zn+Gp1ZG8tzw2ffs=;
 b=Z78H9MnmCxgYC2/7Xd93Qpd+Kz57M9KGFxAH2fUkBUcEILKA+jc0d2kVLAS+OvvozkiS2r
 bKs0XhZXi+HJ6tC5hfqNvTB9tRz1iLrcMQcBaq8jqJ06Y+txeuGCAncqOCTEwT3tgGLokW
 QOn0NRvalZJM/eLsWMQE5vB1mTmzNHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-mNvbjqZmMO20PWTn_x67cw-1; Thu, 27 Aug 2020 13:03:23 -0400
X-MC-Unique: mNvbjqZmMO20PWTn_x67cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9876C80EDA4;
 Thu, 27 Aug 2020 17:03:22 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18AF59F77;
 Thu, 27 Aug 2020 17:03:17 +0000 (UTC)
Date: Thu, 27 Aug 2020 19:03:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200827190314.717ec788@imammedo-mac>
In-Reply-To: <20200826150340.GP168515@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com>
 <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <20200826133638.GO168515@redhat.com>
 <20200826160258.0e9047f4@redhat.com>
 <20200826150340.GP168515@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
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
Cc: ehabkost@redhat.com, mst@redhat.com, Michal Privoznik <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 16:03:40 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 04:02:58PM +0200, Igor Mammedov wrote:
> > On Wed, 26 Aug 2020 14:36:38 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Wed, Aug 26, 2020 at 03:30:34PM +0200, Igor Mammedov wrote:
> > > > On Wed, 26 Aug 2020 13:50:59 +0100
> > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > >  =20
> > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote: =
=20
> > > > > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > > >    =20
> > > > > > > To support some of the complex topology, we introduced EPYC m=
ode apicid decode.
> > > > > > > But, EPYC mode decode is running into problems. Also it can b=
ecome quite a
> > > > > > > maintenance problem in the future. So, it was decided to remo=
ve that code and
> > > > > > > use the generic decode which works for majority of the topolo=
gy. Most of the
> > > > > > > SPECed configuration would work just fine. With some non-SPEC=
ed user inputs,
> > > > > > > it will create some sub-optimal configuration.
> > > > > > > Here is the discussion thread.
> > > > > > > https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5=
b437c1b254@amd.com/
> > > > > > >=20
> > > > > > > This series removes all the EPYC mode specific apicid changes=
 and use the generic
> > > > > > > apicid decode.   =20
> > > > > >=20
> > > > > > the main difference between EPYC and all other CPUs is that
> > > > > > it requires numa configuration (it's not optional)
> > > > > > so we need an extra patch on top of this series to enfoce that,=
 i.e:
> > > > > >=20
> > > > > >  if (epyc && !numa)=20
> > > > > >     error("EPYC cpu requires numa to be configured")   =20
> > > > >=20
> > > > > Please no. This will break 90% of current usage of the EPYC CPU i=
n
> > > > > real world QEMU deployments. That is way too user hostile to intr=
oduce
> > > > > as a requirement.
> > > > >=20
> > > > > Why do we need to force this ?  People have been successfuly usin=
g
> > > > > EPYC CPUs without NUMA in QEMU for years now.
> > > > >=20
> > > > > It might not match behaviour of bare metal silicon, but that hasn=
't
> > > > > obviously caused the world to come crashing down. =20
> > > > So far it produces warning in linux kernel (RHBZ1728166),
> > > > (resulting performance might be suboptimal), but I haven't seen
> > > > anyone reporting crashes yet.
> > > >=20
> > > >=20
> > > > What other options do we have?
> > > > Perhaps we can turn on strict check for new machine types only,
> > > > so old configs can keep broken topology (CPUID),
> > > > while new ones would require -numa and produce correct topology. =
=20
> > >=20
> > > No, tieing this to machine types is not viable either. That is still
> > > going to break essentially every single management application that
> > > exists today using QEMU.
> > for that we have deprecation process, so users could switch to new CLI
> > that would be required.
>=20
> We could, but I don't find the cost/benefit tradeoff is compelling.
>=20
> There are so many places where we diverge from what bare metal would
> do, that I don't see a good reason to introduce this breakage, even
> if we notify users via a deprecation message.=20
I find (3) and (4) good enough reasons to use deprecation.

> If QEMU wants to require NUMA for EPYC, then QEMU could internally
> create a single NUMA node if none was specified for new machine
> types, such that there is no visible change or breakage to any
> mgmt apps. =20

(1) for configs that started without -numa &&|| without -smp dies>1,
      QEMU can do just that (enable auto_enable_numa).

(2) As for configs that are out of spec, I do not care much (junk in - junk=
 out)
(though not having to spend time on bug reports and debug issues, just to s=
ay
it's not supported in the end, makes deprecation sound like a reasonable
choice)

(3) However if config matches bare metal i.e. CPU has more than 1 die and w=
ithin
dies limits (spec wise), QEMU has to produce valid CPUs.
In this case QEMU can't make up multiple numa nodes and mappings of RAM/CPU=
s
on user's behalf. That's where we have to error out and ask for explicit
numa configuration.

For such configs, current code (since 5.0), will produce in the best case
performance issues  due to mismatching data in APICID, CPUID and ACPI table=
s,
in the worst case issues might be related to invalid APIC ID if running on =
EPYC host
and HW takes in account subfields of APIC ID (according to Babu real CPU us=
es
die_id(aka node_id) internally).
I'd rather error out on nonsense configs earlier than debug such issues
and than error out anyways later (upsetting more users).

(4)
If I were non hobby user, I'd hate if QEMU allowed me to start invalid conf=
ig,
that I'd have to spend time on debugging issues (including performance ones=
),
instead of clearly telling me what's wrong and how config should be correct=
ed.
I'd probably jump to another hypervisor that does the job right,
instead of digging into QEMU codebase and CPU specs to figure out how
to hack and configure it.


>=20
>=20
> Regards,
> Daniel


