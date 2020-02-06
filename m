Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7033420661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ5qrm/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7033420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh7E-0007JI-KU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1izgto-0004P8-Os
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1izgtm-0002YR-Qo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1izgtm-0002Y4-MN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580994530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwtKBXobbHOJUY+qczJQH4BHdUqYlzLqXY6tKN4pN5k=;
 b=bQ5qrm/7DKlZAXM52BheAIDzTyfwhYNBfDRRRrG5lLXhN+6xLMv71pGcAWoeu4dQqaOZjE
 OiW5yWE1zbV+wlWSHHXQU6lHS0zVrhc01NtVqAYA8nkUQ64qH0UZnDa+RVh9ZdRkKwFR7f
 FrmheJv2X/Bbn+7QmuWW73imJtc3g5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-2QG99HKvN0KVdW-BmpnrYg-1; Thu, 06 Feb 2020 08:08:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ABA5800EB2;
 Thu,  6 Feb 2020 13:08:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF6EF60BEC;
 Thu,  6 Feb 2020 13:08:41 +0000 (UTC)
Date: Thu, 6 Feb 2020 14:08:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
Message-ID: <20200206140839.378ea544@redhat.com>
In-Reply-To: <8b97f174-dd7e-cec0-daf7-29104d663aa6@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
 <20200204090230.28f31a87@redhat.com>
 <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
 <20200205103838.424b40a9@redhat.com>
 <3b7e02cb-4da0-d5f0-6cd0-c9b8045bbe17@amd.com>
 <20200205175619.51be0cc8@redhat.com>
 <8b97f174-dd7e-cec0-daf7-29104d663aa6@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2QG99HKvN0KVdW-BmpnrYg-1
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 13:07:31 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/5/20 10:56 AM, Igor Mammedov wrote:
> > On Wed, 5 Feb 2020 10:10:06 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> On 2/5/20 3:38 AM, Igor Mammedov wrote: =20
> >>> On Tue, 4 Feb 2020 13:08:58 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>    =20
> >>>> On 2/4/20 2:02 AM, Igor Mammedov wrote:   =20
> >>>>> On Mon, 3 Feb 2020 13:31:29 -0600
> >>>>> Babu Moger <babu.moger@amd.com> wrote:
> >>>>>      =20
> >>>>>> On 2/3/20 8:59 AM, Igor Mammedov wrote:     =20
> >>>>>>> On Tue, 03 Dec 2019 18:36:54 -0600
> >>>>>>> Babu Moger <babu.moger@amd.com> wrote:
> >>>>>>>        =20
> >>>>>>>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
> >>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7C=
babu.moger%40amd.com%7C6b6d6af79fee45cc904808d7aa5c5f37%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637165186049856500&amp;sdata=3DvDAkIxR3U6LX%2FmnY=
jZPRC55smMqLend%2FHQjbfYWydBk%3D&amp;reserved=3D0
> >>>>>>>>
> >>>>>>>> Currently, the APIC ID is decoded based on the sequence
> >>>>>>>> sockets->dies->cores->threads. This works for most standard AMD =
and other
> >>>>>>>> vendors' configurations, but this decoding sequence does not fol=
low that of
> >>>>>>>> AMD's APIC ID enumeration strictly. In some cases this can cause=
 CPU topology
> >>>>>>>> inconsistency.  When booting a guest VM, the kernel tries to val=
idate the
> >>>>>>>> topology, and finds it inconsistent with the enumeration of EPYC=
 cpu models.
> >>>>>>>>
> >>>>>>>> To fix the problem we need to build the topology as per the Proc=
essor
> >>>>>>>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revisi=
on B1
> >>>>>>>> Processors. It is available at https://nam11.safelinks.protectio=
n.outlook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%=
2F55570-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C6b6d6af79fee=
45cc904808d7aa5c5f37%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637165186=
049856500&amp;sdata=3DrVMRN%2BbUeGWEksKO5uQ3Wxc71eeHCXMrkLVRbo4JHHI%3D&amp;=
reserved=3D0
> >>>>>>>>
> >>>>>>>> Here is the text from the PPR.
> >>>>>>>> Operating systems are expected to use Core::X86::Cpuid::SizeId[A=
picIdSize], the
> >>>>>>>> number of least significant bits in the Initial APIC ID that ind=
icate core ID
> >>>>>>>> within a processor, in constructing per-core CPUID masks.
> >>>>>>>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum numb=
er of cores
> >>>>>>>> (MNC) that the processor could theoretically support, not the ac=
tual number of
> >>>>>>>> cores that are actually implemented or enabled on the processor,=
 as indicated
> >>>>>>>> by Core::X86::Cpuid::SizeId[NC].
> >>>>>>>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follo=
ws:
> >>>>>>>> =E2=80=A2 ApicId[6] =3D Socket ID.
> >>>>>>>> =E2=80=A2 ApicId[5:4] =3D Node ID.
> >>>>>>>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> >>>>>>>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} :=
 {1'b0,LogicalCoreID[1:0]}       =20
> >>>>>>>
> >>>>>>>
> >>>>>>> After checking out all patches and some pondering, used here appr=
oach
> >>>>>>> looks to me too intrusive for the task at hand especially where i=
t
> >>>>>>> comes to generic code.
> >>>>>>>
> >>>>>>> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify witho=
ut reading
> >>>>>>> reasoning behind it first)
> >>>>>>>
> >>>>>>> Lets look for a way to simplify it a little bit.
> >>>>>>>
> >>>>>>> So problem we are trying to solve,
> >>>>>>>  1: calculate APIC IDs based on cpu type (to e more specific: for=
 EPYC based CPUs)
> >>>>>>>  2: it depends on knowing total number of numa nodes.
> >>>>>>>
> >>>>>>> Externally workflow looks like following:
> >>>>>>>   1. user provides -smp x,sockets,cores,...,maxcpus
> >>>>>>>       that's used by possible_cpu_arch_ids() singleton to build l=
ist of
> >>>>>>>       possible CPUs (which is available to user via command 'hotp=
luggable-cpus')
> >>>>>>>
> >>>>>>>       Hook could be called very early and possible_cpus data migh=
t be
> >>>>>>>       not complete. It builds a list of possible CPUs which user =
could
> >>>>>>>       modify later.
> >>>>>>>
> >>>>>>>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node=
,node_id=3Dx,cpus=3D"
> >>>>>>>       options to assign cpus to nodes, which is one way or anothe=
r calling
> >>>>>>>       machine_set_cpu_numa_node(). The later updates 'possible_cp=
us' list
> >>>>>>>       with node information. It happens early when total number o=
f nodes
> >>>>>>>       is not available.
> >>>>>>>
> >>>>>>>   2.2 user does not provide explicit node mappings for CPUs.
> >>>>>>>       QEMU steps in and assigns possible cpus to nodes in machine=
_numa_finish_cpu_init()
> >>>>>>>       (using the same machine_set_cpu_numa_node()) right before c=
alling boards
> >>>>>>>       specific machine init(). At that time total number of nodes=
 is known.
> >>>>>>>
> >>>>>>> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have=
 to be defined before
> >>>>>>> boards init() is run.     =20
> >>>>
> >>>> In case of 2.1, we need to have the arch_id already generated. This =
is
> >>>> done inside possible_cpu_arch_ids. The arch_id is used by
> >>>> machine_set_cpu_numa_node to assign the cpus to correct numa node.  =
 =20
> >>>
> >>> I might have missed something but I don't see arch_id itself being us=
ed in
> >>> machine_set_cpu_numa_node(). It only uses props part of possible_cpus=
   =20
> >>
> >> Before calling machine_set_cpu_numa_node, we call
> >> cpu_index_to_instance_props -> x86_cpu_index_to_props->
> >> possible_cpu_arch_ids->x86_possible_cpu_arch_ids.
> >>
> >> This sequence sets up the arch_id(in x86_cpu_apic_id_from_index) for a=
ll
> >> the available cpus. Based on the arch_id, it also sets up the props. =
=20
> >=20
> >=20
> > x86_possible_cpu_arch_ids()
> >    arch_id =3D x86_cpu_apic_id_from_index(x86ms, i)
> >    x86_topo_ids_from_apicid(arch_id, x86ms->smp_dies, ms->smp.cores,  m=
s->smp.threads, &topo);
> >    // assign socket/die/core/thread from topo
> >=20
> > so currently it uses indirect way to convert index in possible_cpus->cp=
us[]
> > to socket/die/core/thread ids.
> > But essentially it take '-smp' options and [0..max_cpus) number as orig=
inal data
> > converts it into intermediate apic_id and then reverse engineer it back=
 to
> > topo info.
> >=20
> > Why not use x86_topo_ids_from_idx() directly to get rid of 'props' depe=
ndency on apic_id? =20
>=20
> It might work. But this feels like a work-around and delaying the problem
> for later. Just re-arranging the numa code little bit we can address this=
.

The idea behind possible_cpus is to allow users query topo information
board generates (based on -smp) at configuration time (or late) so users
could know what -numa cpu,topo_options [and -device foo-cpu,topo_options]
to use, initializing apic_id on the first access is secondary and I did
it only because I could do it without additional data.

But main purpose of possible_cpus is to keep topology information.
That includes numa node mapping, which should be stored in possible_cpus
along with the rest of cpu topology.

Looking [12/18] numa patch, it makes -numa node,cpus legacy option
to reintroduce data duplication, by storing mapping elsewhere and
then putting that mapping into possible_cpus at numa complete time
(that's what I dislike and don't see a valid reason to do so).

That also won't work if user queries hotpluggable-cpus before that time
and it also doesn't work if user uses preferable -numa cpu,topo_options
as both would initialize possible_cpus on the first access.

So if you need do some board specific post-processing done on topo
information when it's complete and recalculate apic_id do it at board
init time like was suggested before (x86_cpu_new() looks like a good
place to do it).

[...]


