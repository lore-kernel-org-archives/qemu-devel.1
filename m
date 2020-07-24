Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BE2206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpwuPWC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BE2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz19L-00032O-1B
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jz18i-0002Vx-AG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:05:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jz18f-0005yV-4K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595610338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lkhnr3mKVST56cWem81kdHjlWCx75hjOb+BCPYZenKE=;
 b=NpwuPWC3GnZY+vOt/OfjcXNzVgRVRU/VkspGTTmTPsyP4r+OzARwO8deHEeZrFbzhWHdMb
 7Pqj0FgBInvUfjbEM28KG9xB+XGCCaLG0G3SUsK8OvE36145oDjXSJ/Lr7u3USIYhkPKrZ
 BZWYKkkswS4/cal0hxOvSujK3B7H1SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-15PEsYFkO4i3D8eIAdLPww-1; Fri, 24 Jul 2020 13:05:23 -0400
X-MC-Unique: 15PEsYFkO4i3D8eIAdLPww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 071EB58;
 Fri, 24 Jul 2020 17:05:22 +0000 (UTC)
Received: from localhost (unknown [10.40.208.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 721E4726A7;
 Fri, 24 Jul 2020 17:05:20 +0000 (UTC)
Date: Fri, 24 Jul 2020 19:05:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
Message-ID: <20200724190518.0f7a2b6b@redhat.com>
In-Reply-To: <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
 <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
 <20200713193221.27674630@redhat.com>
 <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 14:30:29 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Monday, July 13, 2020 12:32 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> > devel@nongnu.org
> > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > CpuInstanceProperties
> >=20
> > On Mon, 13 Jul 2020 11:43:33 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> > > On 7/13/20 11:17 AM, Igor Mammedov wrote: =20
> > > > On Mon, 13 Jul 2020 10:02:22 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > =20
> > > >>> -----Original Message-----
> > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > >>> qemu- devel@nongnu.org
> > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > >>> CpuInstanceProperties =20
> > > > [...] =20
> > > >>>> +
> > > >>>> +/*
> > > >>>> + * Initialize topo_ids from CpuInstanceProperties
> > > >>>> + * node_id in CpuInstanceProperties(or in CPU device) is a sequ=
ential
> > > >>>> + * number, but while building the topology =20
> > > >>> =20
> > > >>>> we need to separate it for
> > > >>>> + * each socket(mod nodes_per_pkg). =20
> > > >>> could you clarify a bit more on why this is necessary? =20
> > > >>
> > > >> If you have two sockets and 4 numa nodes, node_id in
> > > >> CpuInstanceProperties will be number sequentially as 0, 1, 2, 3.
> > > >> But in EPYC topology, it will be  0, 1, 0, 1( Basically mod % numb=
er of nodes =20
> > per socket). =20
> > > >
> > > > I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes per
> > > > socket so APIC id woulbe be composed like:
> > > >
> > > >  1st socket
> > > >    pkg_id(0) | node_id(0)
> > > >    pkg_id(0) | node_id(1)
> > > >
> > > >  2nd socket
> > > >    pkg_id(1) | node_id(0)
> > > >    pkg_id(1) | node_id(1)
> > > >
> > > > if that's the case, then EPYC's node_id here doesn't look like a
> > > > NUMA node in the sense it's usually used (above config would have 4
> > > > different memory controllers =3D> 4 conventional NUMA nodes). =20
> > >
> > > EPIC model uses combination of socket id and node id to identify the
> > > numa nodes. So, it internally uses all the information. =20
> >=20
> > well with above values, EPYC's node_id doesn't look like it's specifyin=
g a
> > machine numa node, but rather a node index within single socket. In whi=
ch case,
> > it doesn't make much sense calling it NUMA node_id, it's rather some in=
dex
> > within a socket. (it starts looking like terminology is all mixed up)
> >=20
> > If you have access to a milti-socket EPYC machine, can you dump and pos=
t here
> > its apic ids, pls? =20
>=20
> Here is the output from my EPYC machine with 2 sockets and totally 8
> nodes(SMT disabled). The cpus 0-31 are in socket 0 and  cpus 32-63 in
> socket 1.
>=20
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              64
> On-line CPU(s) list: 0-63
> Thread(s) per core:  1
> Core(s) per socket:  32
> Socket(s):           2
> NUMA node(s):        8
> Vendor ID:           AuthenticAMD
> CPU family:          23
> Model:               1
> Model name:          AMD Eng Sample: 1S1901A4VIHF5_30/19_N
> Stepping:            2
> CPU MHz:             2379.233
> CPU max MHz:         1900.0000
> CPU min MHz:         1200.0000
> BogoMIPS:            3792.81
> Virtualization:      AMD-V
> L1d cache:           32K
> L1i cache:           64K
> L2 cache:            512K
> L3 cache:            8192K
> NUMA node0 CPU(s):   0-7
> NUMA node1 CPU(s):   8-15
> NUMA node2 CPU(s):   16-23
> NUMA node3 CPU(s):   24-31
> NUMA node4 CPU(s):   32-39
> NUMA node5 CPU(s):   40-47
> NUMA node6 CPU(s):   48-55
> NUMA node7 CPU(s):   56-63
>=20
> Here is the output of #cpuid  -l 0x8000001e  -r


(1)
> You may want to refer
> https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip
> (section 2.1.12.2.1.3 ApicId Enumeration Requirements).
> Note that this is a general guideline. We tried to generalize in qemu as
> much as possible. It is bit complex.


=20
> CPU 0:
>    0x8000001e 0x00: eax=3D0x00000000 ebx=3D0x00000100 ecx=3D0x00000300
> edx=3D0x00000000
[...]
> CPU 63:
>    0x8000001e 0x00: eax=3D0x0000007e ebx=3D0x0000011f ecx=3D0x00000307
> edx=3D0x00000000
>=20
> >  =20
> > > =20
> > > >
> > > > I wonder if linux guest actually uses node_id encoded in apic id fo=
r
> > > > configuring/checking numa structures, or it just uses whatever ACPI
> > > > SRAT table provided.
> > > > =20
> > > >>>> + */
> > > >>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > > >>>> +                                     CpuInstanceProperties prop=
s,
> > > >>>> +                                     X86CPUTopoIDs *topo_ids) {
> > > >>>> +    topo_ids->smt_id =3D props.has_thread_id ? props.thread_id =
: 0;
> > > >>>> +    topo_ids->core_id =3D props.has_core_id ? props.core_id : 0=
;
> > > >>>> +    topo_ids->die_id =3D props.has_die_id ? props.die_id : 0;
> > > >>>> +    topo_ids->node_id =3D props.has_node_id ?
> > > >>>> +                        props.node_id % MAX(topo_info->nodes_pe=
r_pkg, 1) : 0;

It looks like I was wrong pushing system wide NUMA node-id into APIC ID
(choosen naming is confusing a bit), per [1] mentioned above, EPYC's node-i=
d is:

=E2=80=A2 ApicId[6] =3D Socket ID.
* ApicId[5:4]=3D Node ID.
=E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
=E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Logi=
calCoreID[1:0]}

which is can hold only 0-3 values, and defined as:

"A node, is an integrated circuit device that includes one to 8 cores (one =
or two Core Complexes)."

spec also mentions it indirectly as die-id if one looks at
CPUID_Fn8000001E_EBX [Core Identifiers] (Core::X86::Cpuid::CoreId)
...
  CoreId =3D ({2'b0, DieId[1:0], LogicalComplexId[0], LogicalThreadId[2:0]}=
 >> SMT

and in
(2)
CPUID_Fn8000001E_ECX [Node Identifiers] (Core::X86::Cpuid::NodeId)
...
  {5'b00000,1'b[SOCKET_ID],2'b[DIE_ID]}

Question is why we did not reuse topo_ids->die_id instead of adding
confusing topo_ids->node_id in the first place?

Also looking APIC ID and SRAT table provided here,
CPUID_Fn8000001E_ECX corresponds to NUMA node id (i.e. what -numa in QEMU u=
sed for)
and Node ID embeded into ApicId[5:4] is basically die-id.

Difference between die-id implemented in QEMU and EPYC's die id (topo_ids->=
node_id)
is that the former doesn't require numa config (maybe it should, but ship's=
already sailed)
and gets number of dies from '-smp dies=3DX' CLI option, while for EPYC we =
calculate
topo_ids->node_id implicitly from number of numa nodes and sockets, which i=
mplicitly
requires that machine 'must' be configured with -numa options.

Maybe we should drop this implicit calculation along with topo_ids->node_id
and reuse '-smp dies=3DX' plus extra checks for EPYC to ask for -numa if th=
ere
is more than 1 die and if we need to be really strict, add checks for limit=
 of
dies/cores within socket/die according to spec[2] so encoded APIC ID and CP=
UID_8000001E
match the spec.



> > > >>>> +    topo_ids->pkg_id =3D props.has_socket_id ? props.socket_id =
:
> > > >>>> +0; }
> > > >>>>  /*
> > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > >>>>   *
> > > >>>> =20
> > > >> =20
> > > > =20
> > > =20
>=20
>=20


