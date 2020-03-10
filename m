Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730CCC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4003624677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp8I0Lem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4003624677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaDm-0000Kg-CP
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBaCW-0007Dl-CQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBaCU-0004rs-Uk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBaCU-0004ql-Qw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAGcKh9LRGcr/ndbtvpTzt2HyuYAw8Fr81qZdxnbvXQ=;
 b=Cp8I0LemxTjzXFCwlxtuvMiCWQDd6MY+amz896gJ5Efw7KjkXX10dX8oYoizswBYle21cv
 8o3Kn+QymVJd2w9jnfUGI+otjjW2a6oxQZEKkIJ6jSw5OcJBfRsX84yLO51v3luSs/Tn8Q
 Cr0oLPSzVEdgThmEjLZ6T4rj+VD7Cw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-GxcqTfdPMye_JgAhTzPgBA-1; Tue, 10 Mar 2020 04:25:15 -0400
X-MC-Unique: GxcqTfdPMye_JgAhTzPgBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4172D18C8C03;
 Tue, 10 Mar 2020 08:25:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE695C545;
 Tue, 10 Mar 2020 08:25:05 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:25:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 13/16] target/i386: Add EPYC model specific handlers
Message-ID: <20200310092503.10e7dac2@redhat.com>
In-Reply-To: <df9e6525-f9a7-2f98-d5b4-985efc634335@amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326549681.40452.14219781294371149597.stgit@naples-babu.amd.com>
 <20200309160301.00243403@Igors-MacBook-Pro>
 <df9e6525-f9a7-2f98-d5b4-985efc634335@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, 9 Mar 2020 14:12:10 -0500
Babu Moger <babu.moger@amd.com> wrote:

> On 3/9/20 10:03 AM, Igor Mammedov wrote:
> > On Tue, 03 Mar 2020 13:58:16 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> Add the new EPYC model specific handlers to fix the apicid decoding.
> >>
> >> The APIC ID is decoded based on the sequence sockets->dies->cores->thr=
eads.
> >> This works fine for most standard AMD and other vendors' configuration=
s,
> >> but this decoding sequence does not follow that of AMD's APIC ID enume=
ration
> >> strictly. In some cases this can cause CPU topology inconsistency.
> >>
> >> When booting a guest VM, the kernel tries to validate the topology, an=
d finds
> >> it inconsistent with the enumeration of EPYC cpu models. The more deta=
ils are
> >> in the bug https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C=
01%7Cbabu.moger%40amd.com%7C3ddda6803d584aac171b08d7c43b0530%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637193630113242242&amp;sdata=3D3TkNY2O8HWBqa=
OrmO8QQoxlzvIv2oEdTO1P9k6VglmU%3D&amp;reserved=3D0.
> >>
> >> To fix the problem we need to build the topology as per the Processor
> >> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> >> Processors.
> >> It is available at https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55570-B1_PUB.zip=
&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C3ddda6803d584aac171b08d7c43b05=
30%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637193630113242242&amp;sdat=
a=3DcPYmcthdgilh9lOiGDrwKwOt7cn%2BvBcT%2F8PhRs92x8I%3D&amp;reserved=3D0
> >>
> >> Here is the text from the PPR.
> >> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdS=
ize], the
> >> number of least significant bits in the Initial APIC ID that indicate =
core ID
> >> within a processor, in constructing per-core CPUID masks.
> >> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of =
cores
> >> (MNC) that the processor could theoretically support, not the actual n=
umber of
> >> cores that are actually implemented or enabled on the processor, as in=
dicated
> >> by Core::X86::Cpuid::SizeId[NC].
> >> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> >> =E2=80=A2 ApicId[6] =3D Socket ID.
> >> =E2=80=A2 ApicId[5:4] =3D Node ID.
> >> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> >> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0=
,LogicalCoreID[1:0]}
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com> =20
> >=20
> > Acked-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
> If use a boolean variable, then I dont need all these handlers in
> X86CPUDefinition. I just need to set a boolean variable here.

agreed, that would be better

> >  =20
> >> ---
> >>  target/i386/cpu.c |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index f33d8b77f5..f870f7c55b 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -3884,6 +3884,10 @@ static X86CPUDefinition builtin_x86_defs[] =3D =
{
> >>          .xlevel =3D 0x8000001E,
> >>          .model_id =3D "AMD EPYC Processor",
> >>          .cache_info =3D &epyc_cache_info,
> >> +        .apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc,
> >> +        .topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc,
> >> +        .apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc,
> >> +        .apicid_pkg_offset =3D apicid_pkg_offset_epyc,
> >>          .versions =3D (X86CPUVersionDefinition[]) {
> >>              { .version =3D 1 },
> >>              {
> >>
> >> =20
> >  =20
>=20


