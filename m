Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079E320768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpdNI8rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079E320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWGJ-0003ny-8E
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEWEq-00028v-Vl
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEWEo-00034m-Cl
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEWEo-00033m-7e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584528470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IF+D+brU5OR2j+v6zrzlLrnLEMLZ0976ftEu1XgZpkA=;
 b=KpdNI8rDH9eAkWjm2Jy1CHSd+G8HaJXnjzQ8EzOwoQ3kx+DbVOZioe1F5/98rpFOK15RGo
 w2WjGQ7ROk0NuAlb/23fzDSBQ66sw/PuZ3KX4iorZwmYBAKdpJGEKFaemGlNxJa4iXQPHI
 piiLrwZiLdAMYbypqKPLxcXORBqwq3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-DA5qSud6M_Ki7Ue0ZAN3VQ-1; Wed, 18 Mar 2020 06:47:23 -0400
X-MC-Unique: DA5qSud6M_Ki7Ue0ZAN3VQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36AC01084439;
 Wed, 18 Mar 2020 10:47:22 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.195.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDBF35C1D8;
 Wed, 18 Mar 2020 10:47:17 +0000 (UTC)
Date: Wed, 18 Mar 2020 11:47:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH v7 00/13] APIC ID fixes for AMD EPYC CPU model
Message-ID: <20200318114714.12f99637@office.mammed.net>
In-Reply-To: <SN1PR12MB256026FEB14D1738C8A436CE95F70@SN1PR12MB2560.namprd12.prod.outlook.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <5a90d4e6-5f7f-5a8d-6895-3b5f9890b58b@amd.com>
 <20200317232201.GH1817047@habkost.net>
 <20200317234608.GI1817047@habkost.net>
 <SN1PR12MB256026FEB14D1738C8A436CE95F70@SN1PR12MB2560.namprd12.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 02:43:57 +0000
"Moger, Babu" <Babu.Moger@amd.com> wrote:

> [AMD Official Use Only - Internal Distribution Only]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Eduardo Habkost <ehabkost@redhat.com>
> > Sent: Tuesday, March 17, 2020 6:46 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> > mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> > Subject: Re: [PATCH v7 00/13] APIC ID fixes for AMD EPYC CPU model
> >=20
> > On Tue, Mar 17, 2020 at 07:22:06PM -0400, Eduardo Habkost wrote: =20
> > > On Thu, Mar 12, 2020 at 11:28:47AM -0500, Babu Moger wrote: =20
> > > > Eduardo, Can you please queue the series if there are no concerns.
> > > > Thanks =20
> > >
> > > I had queued it for today's pull request, but it looks like it
> > > breaks "make check".  See =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ftra=
vis-
> > ci.org%2Fgithub%2Fehabkost%2Fqemu%2Fjobs%2F663529282&amp;data=3D02%7
> > C01%7Cbabu.moger%40amd.com%7C43bba959c4d34e3be5fd08d7cacd634d%7
> > C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637200855817408351&
> > amp;sdata=3DcfjMVDKMgByvtUIqqGtcjNWGAf3PKFKxDLaS1eVME3U%3D&amp;re
> > served=3D0 =20
> > >
> > >   PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
> > >   Could not access KVM kernel module: No such file or directory
> > >   qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such f=
ile or =20
> > directory =20
> > >   qemu-system-x86_64: falling back to tcg
> > >   qemu-system-x86_64: Invalid CPU [socket: 0, die: 0, core: 1, thread=
: 0] with =20
> > APIC ID 1, valid index range 0:5 =20
> > >   Broken pipe
> > >   /home/travis/build/ehabkost/qemu/tests/qtest/libqtest.c:166: kill_q=
emu() =20
> > tried to terminate QEMU process but encountered exit status 1 (expected=
 0) =20
> > >   Aborted (core dumped)
> > >   ERROR - too few tests run (expected 17, got 4)
> > >   /home/travis/build/ehabkost/qemu/tests/Makefile.include:633: recipe=
 for =20
> > target 'check-qtest-x86_64' failed =20
> > >   make: *** [check-qtest-x86_64] Error 1 =20
> >=20
> > Failure is at the /x86_64/acpi/piix4/cpuhp test case:
> >=20
> >   $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> > QTEST_QEMU_IMG=3Dqemu-img tests/qtest/bios-tables-test -m=3Dquick --ver=
bose -
> > -debug-log
> >   [...]
> >   {*LOG(start):{/x86_64/acpi/piix4/cpuhp}:LOG*}
> >   # starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest
> > unix:/tmp/qtest-2052313.sock -qtest-log /dev/null -chardev
> > socket,path=3D/tmp/qtest-2052313.qmp,id=3Dchar0 -mon
> > chardev=3Dchar0,mode=3Dcontrol -display none -machine pc,kernel-irqchip=
=3Doff -
> > accel kvm -accel tcg -net none -display none -smp
> > 2,cores=3D3,sockets=3D2,maxcpus=3D6 -object memory-backend-
> > ram,id=3Dram0,size=3D64M -object memory-backend-ram,id=3Dram1,size=3D64=
M -numa
> > node,memdev=3Dram0 -numa node,memdev=3Dram1 -numa dist,src=3D0,dst=3D1,=
val=3D21
> > -drive id=3Dhd0,if=3Dnone,file=3Dtests/acpi-test-disk-PVjFru,format=3Dr=
aw -device ide-
> > hd,drive=3Dhd0  -accel qtest
> >   {*LOG(message):{starting QEMU: exec x86_64-softmmu/qemu-system-x86_64
> > -qtest unix:/tmp/qtest-2052313.sock -qtest-log /dev/null -chardev
> > socket,path=3D/tmp/qtest-2052313.qmp,id=3Dchar0 -mon
> > chardev=3Dchar0,mode=3Dcontrol -display none -machine pc,kernel-irqchip=
=3Doff -
> > accel kvm -accel tcg -net none -display none -smp
> > 2,cores=3D3,sockets=3D2,maxcpus=3D6 -object memory-backend-
> > ram,id=3Dram0,size=3D64M -object memory-backend-ram,id=3Dram1,size=3D64=
M -numa
> > node,memdev=3Dram0 -numa node,memdev=3Dram1 -numa dist,src=3D0,dst=3D1,=
val=3D21
> > -drive id=3Dhd0,if=3Dnone,file=3Dtests/acpi-test-disk-PVjFru,format=3Dr=
aw -device ide-
> > hd,drive=3Dhd0  -accel qtest}:LOG*}
> >   qemu-system-x86_64: Invalid CPU [socket: 0, die: 0, core: 1, thread: =
0] with
> > APIC ID 1, valid index range 0:5
> >   Broken pipe =20
>=20
> The ms->smp.cpus Is not initialized to max cpus in this case. Looks like =
smp_parse did not run in this path.
> For that reason the apicid is not initialized for all the cpus. Following=
 patch fixes the problem.
> I will test all the combinations and send the patch tomorrow. Let me know=
 which tree I should use the to
> generate the patch. It appears some patches are already pulled. I can sen=
d top of
>  git://github.com/ehabkost/qemu.git (x86-next).
>=20
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 023dce1dbd..1eeb7b9732 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -156,7 +156,7 @@ void x86_cpus_init(X86MachineState *x86ms, int defaul=
t_cpu_version)
>                                                        ms->smp.max_cpus -=
 1) + 1;
>      possible_cpus =3D mc->possible_cpu_arch_ids(ms);
>=20
> -    for (i =3D 0; i < ms->smp.cpus; i++) {
> +    for (i =3D 0; i < ms->possible_cpus->len; i++) {
>          ms->possible_cpus->cpus[i].arch_id =3D
>              x86_cpu_apic_id_from_index(x86ms, i);
>      }

indeed, it should use possible_cpus->len instead of initial cpus number

> >=20
> >  =20
> > >
> > > =20
> > > >
> > > > On 3/11/20 5:52 PM, Babu Moger wrote: =20
> > > > > This series fixes APIC ID encoding problem reported on AMD EPYC c=
pu =20
> > models. =20
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
zilla.
> > redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.
> > moger%40amd.com%7C43bba959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4
> > 884e608e11a82d994e183d%7C0%7C0%7C637200855817408351&amp;sdata=3Dm
> > E%2FiWq9sB2Jp9GtQesFZtU2lGT4MU6IVgm7HxhyfO9w%3D&amp;reserved=3D0 =20
> > > > >
> > > > > Currently, the APIC ID is decoded based on the sequence
> > > > > sockets->dies->cores->threads. This works for most standard AMD a=
nd =20
> > other =20
> > > > > vendors' configurations, but this decoding sequence does not foll=
ow that =20
> > of =20
> > > > > AMD's APIC ID enumeration strictly. In some cases this can cause =
CPU =20
> > topology =20
> > > > > inconsistency.  When booting a guest VM, the kernel tries to vali=
date the
> > > > > topology, and finds it inconsistent with the enumeration of EPYC =
cpu =20
> > models. =20
> > > > >
> > > > > To fix the problem we need to build the topology as per the Proce=
ssor
> > > > > Programming Reference (PPR) for AMD Family 17h Model 01h, Revisio=
n B1
> > > > > Processors. The documentation is available from the bugzilla Link=
 below.
> > > > >
> > > > > Link: =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
zilla.
> > kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D02%7C01%7Cbabu.m
> > oger%40amd.com%7C43bba959c4d34e3be5fd08d7cacd634d%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637200855817408351&amp;sdata=3DBH1
> > L3fcVzZdjo2zU3TclzJzZKJq%2BxpT3P%2FJwZXvs6Pc%3D&amp;reserved=3D0 =20
> > > > >
> > > > > Here is the text from the PPR.
> > > > > Operating systems are expected to use =20
> > Core::X86::Cpuid::SizeId[ApicIdSize], the =20
> > > > > number of least significant bits in the Initial APIC ID that indi=
cate core ID
> > > > > within a processor, in constructing per-core CPUID masks.
> > > > > Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum numbe=
r of =20
> > cores =20
> > > > > (MNC) that the processor could theoretically support, not the act=
ual =20
> > number of =20
> > > > > cores that are actually implemented or enabled on the processor, =
as =20
> > indicated =20
> > > > > by Core::X86::Cpuid::SizeId[NC].
> > > > > Each Core::X86::Apic::ApicId[ApicId] register is preset as follow=
s:
> > > > > =E2=80=A2 ApicId[6] =3D Socket ID.
> > > > > =E2=80=A2 ApicId[5:4] =3D Node ID.
> > > > > =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> > > > > =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : =
=20
> > {1'b0,LogicalCoreID[1:0]} =20
> > > > >
> > > > > v7:
> > > > >  Generated the patches on top of git://github.com/ehabkost/qemu.g=
it =20
> > (x86-next). =20
> > > > >  Changes from v6.
> > > > >  1. Added new function x86_set_epyc_topo_handlers to override the=
 apic =20
> > id =20
> > > > >     encoding handlers.
> > > > >  2. Separated the code to set use_epyc_apic_id_encoding and added=
 as a =20
> > new patch =20
> > > > >     as it looked more logical.
> > > > >  3. Fixed minor typos.
> > > > >
> > > > > v6:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-
> > devel%2F158389385028.22020.7608244627303132902.stgit%40naples-
> > babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C43bb
> > a959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d994e183d%7
> > C0%7C0%7C637200855817408351&amp;sdata=3D7BZjkRROVX9M5nW1RmQYnITY
> > fndrgR1jcHSWQGLSYco%3D&amp;reserved=3D0 =20
> > > > >  Generated the patches on top of git://github.com/ehabkost/qemu.g=
it =20
> > (x86-next). =20
> > > > >  Changes from v5.
> > > > >  1. Eduardo has already queued couple of patches, submitting the =
rest =20
> > here. =20
> > > > >  2. Major change is how the EPYC mode apic id encoding handlers a=
re =20
> > loaded. =20
> > > > >     Added a boolean variable use_epyc_apic_id_encoding in =20
> > X86CPUDefinition. =20
> > > > >     The variable is will be used to tell if we need to use EPYC m=
ode encoding.
> > > > >  3. Eduardo reported bysectability problem with x86 unit test cod=
e.
> > > > >     Quashed the patches in 1 and 2 to resolve it. Problem was cha=
nge in =20
> > calling =20
> > > > >     conventions of topology related functions.
> > > > >  4. Also set the use_epyc_apic_id_encoding for EPYC-Rome. This mo=
del is
> > > > >     added recently to the cpu table.
> > > > >
> > > > > v5:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-
> > devel%2F158326531474.40452.11433722850425537745.stgit%40naples-
> > babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C43bb
> > a959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d994e183d%7
> > C0%7C0%7C637200855817413332&amp;sdata=3DrVqY3p6vUGeEu%2FbHTfE%2FfI
> > gTtp0vuxzrE1egl5%2FYsGQ%3D&amp;reserved=3D0 =20
> > > > >  Generated the patches on top of git://github.com/ehabkost/qemu.g=
it =20
> > (x86-next). =20
> > > > >  Changes from v4.
> > > > >  1. Re-arranged the patches 2 and 4 as suggested by Igor.
> > > > >  2. Kept the apicid handler functions inside X86MachineState as d=
iscussed.
> > > > >     These handlers are loaded from X86CPUDefinitions.
> > > > >  3. Removed unnecessary X86CPUstate initialization from x86_cpu_n=
ew. =20
> > Suggested =20
> > > > >     by Igor.
> > > > >  4. And other minor changes related to patch format.
> > > > >
> > > > > v4:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-
> > devel%2F158161767653.48948.10578064482878399556.stgit%40naples-
> > babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C43bb
> > a959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d994e183d%7
> > C0%7C0%7C637200855817413332&amp;sdata=3Dpyd8T6rE%2BbR3FZf2c4cdtLr%2
> > Fbxz%2FgW%2FWrap14mMt7To%3D&amp;reserved=3D0 =20
> > > > >  Changes from v3.
> > > > >  1. Moved the arch_id calculation inside the function x86_cpus_in=
it. With =20
> > this change, =20
> > > > >     we dont need to change common numa code.(suggested by Igor)
> > > > >  2. Introduced the model specific handlers inside X86CPUDefinitio=
ns.
> > > > >     These handlers are loaded into X86MachineState during the ini=
t.
> > > > >  3. Removed llc_id from x86CPU.
> > > > >  4. Removed init_apicid_fn hanlder from MachineClass. Kept all th=
e code =20
> > changes =20
> > > > >     inside the x86.
> > > > >  5. Added new handler function apicid_pkg_offset for pkg_offset =
=20
> > calculation. =20
> > > > >  6. And some Other minor changes.
> > > > >
> > > > > v3:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-
> > devel%2F157541968844.46157.17994918142533791313.stgit%40naples-
> > babu.amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C43bb
> > a959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d994e183d%7
> > C0%7C0%7C637200855817413332&amp;sdata=3DOM5sjNorayyzETuwa4FBPSLMb
> > XtpbeXEG0AxRotIcXA%3D&amp;reserved=3D0 =20
> > > > >   1. Consolidated the topology information in structure X86CPUTop=
oInfo.
> > > > >   2. Changed the ccx_id to llc_id as commented by upstream.
> > > > >   3. Generalized the apic id decoding. It is mostly similar to cu=
rrent apic id
> > > > >      except that it adds new field llc_id when numa configured. R=
emoves all =20
> > the =20
> > > > >      hardcoded values.
> > > > >   4. Removed the earlier parse_numa split. And moved the numa nod=
e =20
> > initialization =20
> > > > >      inside the numa_complete_configuration. This is bit cleaner =
as =20
> > commented by =20
> > > > >      Eduardo.
> > > > >   5. Added new function init_apicid_fn inside machine_class struc=
ture. This
> > > > >      will be used to update the apic id handler specific to cpu m=
odel.
> > > > >   6. Updated the cpuid unit tests.
> > > > >   7. TODO : Need to figure out how to dynamically update the hand=
lers =20
> > using cpu models. =20
> > > > >      I might some guidance on that.
> > > > >
> > > > > v2:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-
> > devel%2F156779689013.21957.1631551572950676212.stgit%40localhost.locald
> > omain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C43bba959c4d
> > 34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> > %7C637200855817413332&amp;sdata=3DHhZyaoTcB93BX2wFBQ46QXkLZywhIeq
> > Rt9FkiqUmwaI%3D&amp;reserved=3D0 =20
> > > > >   1. Introduced the new property epyc to enable new epyc mode.
> > > > >   2. Separated the epyc mode and non epyc mode function.
> > > > >   3. Introduced function pointers in PCMachineState to handle the
> > > > >      differences.
> > > > >   4. Mildly tested different combinations to make things are work=
ing as =20
> > expected. =20
> > > > >   5. TODO : Setting the epyc feature bit needs to be worked out. =
This =20
> > feature is =20
> > > > >      supported only on AMD EPYC models. I may need some guidance =
on =20
> > that. =20
> > > > >
> > > > > v1:
> > > > > =20
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.ker
> > nel.org%2Fqemu-devel%2F20190731232032.51786-1-
> > babu.moger%40amd.com%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.co
> > m%7C43bba959c4d34e3be5fd08d7cacd634d%7C3dd8961fe4884e608e11a82d9
> > 94e183d%7C0%7C0%7C637200855817413332&amp;sdata=3DBbMBhRE5C5lfdtc%
> > 2FepDHzz2aOwhVbX7uDfUu737LNjA%3D&amp;reserved=3D0 =20
> > > > > ---
> > > > >
> > > > > Babu Moger (13):
> > > > >       hw/i386: Introduce X86CPUTopoInfo to contain topology info
> > > > >       hw/i386: Consolidate topology functions
> > > > >       machine: Add SMP Sockets in CpuTopology
> > > > >       hw/i386: Remove unnecessary initialization in x86_cpu_new
> > > > >       hw/i386: Update structures to save the number of nodes per =
package
> > > > >       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_top=
o_ids
> > > > >       hw/386: Add EPYC mode topology decoding functions
> > > > >       target/i386: Cleanup and use the EPYC mode topology functio=
ns
> > > > >       hw/i386: Introduce apicid functions inside X86MachineState
> > > > >       i386: Introduce use_epyc_apic_id_encoding in X86CPUDefiniti=
on
> > > > >       hw/i386: Move arch_id decode inside x86_cpus_init
> > > > >       target/i386: Enable new apic id encoding for EPYC based cpu=
s models
> > > > >       i386: Fix pkg_id offset for EPYC cpu models
> > > > >
> > > > >
> > > > >  hw/core/machine.c          |    1
> > > > >  hw/i386/pc.c               |   15 ++-
> > > > >  hw/i386/x86.c              |   73 ++++++++++++----
> > > > >  include/hw/boards.h        |    2
> > > > >  include/hw/i386/topology.h |  195 ++++++++++++++++++++++++++++++=
--- =20
> > --------- =20
> > > > >  include/hw/i386/x86.h      |   12 +++
> > > > >  softmmu/vl.c               |    1
> > > > >  target/i386/cpu.c          |  203 ++++++++++++++----------------=
--------------
> > > > >  target/i386/cpu.h          |    3 +
> > > > >  tests/test-x86-cpuid.c     |  116 +++++++++++++++----------
> > > > >  10 files changed, 358 insertions(+), 263 deletions(-)
> > > > >
> > > > > --
> > > > > Signature
> > > > > =20
> > > > =20
> > >
> > > --
> > > Eduardo =20
> >=20
> > --
> > Eduardo =20


