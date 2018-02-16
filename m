Received: from eggs.gnu.org ([2001:4830:134:3::10]:46562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emhKN-0004Bd-KW
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emhKK-0005xZ-F3
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:49:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32994
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emhKK-0005vX-8S
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:49:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GEnNRC108051
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:49:25 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5yuc4anh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:49:23 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 14:49:12 -0000
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<ceb7028a-6878-9a63-004e-bdf774bb2509@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 15:49:07 +0100
MIME-Version: 1.0
In-Reply-To: <ceb7028a-6878-9a63-004e-bdf774bb2509@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <fb0e5ac4-4339-ea4c-2aea-3439a5e01bf4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv4 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 16.02.2018 15:03, Eric Blake wrote:
> On 02/16/2018 06:04 AM, Viktor Mihajlovski wrote:
>> From: Luiz Capitulino <lcapitulino@redhat.com>
>>
>> The query-cpus command has an extremely serious side effect:
>> it always interrupts all running vCPUs so that they can run
>> ioctl calls. This can cause a huge performance degradation for
>> some workloads. And most of the information retrieved by the
>> ioctl calls are not even used by query-cpus.
>>
>> This commit introduces a replacement for query-cpus called
>> query-cpus-fast, which has the following features:
>>
>> =C2=A0 o Never interrupt vCPUs threads. query-cpus-fast only returns
>> =C2=A0=C2=A0=C2=A0 vCPU information maintained by QEMU itself, which s=
hould be
>> =C2=A0=C2=A0=C2=A0 sufficient for most management software needs
>>
>> =C2=A0 o Drop "halted" field as it can not be retrieved in a fast
>> =C2=A0=C2=A0=C2=A0 way on most architectures
>>
>> =C2=A0 o Drop irrelevant fields such as "current", "pc" and "arch"
>>
>> =C2=A0 o Rename some fields for better clarification & proper naming
>> =C2=A0=C2=A0=C2=A0 standard
>>
>> Further, the HMP "info cpus" implementation is changed to
>> use the new QMP interface to avoid the side effects caused
>> by query-cpus. This means that only a reduced subset of cpu
>> information will be reported, which is acceptable as
>> the content of "info cpus" is not documented or guaranteed
>> to be stable.
>>
>> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Eric Blake <eblake@redhat.com>
>=20
> The HMP changes are non-trivial compared to v3, so I might have dropped
> all R-b and Acked-by to ensure they are looked at again.
>=20
> In fact,...
>=20
>> ---
>> =C2=A0 cpus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 38 ++++++++++++++++++++++++++++++
>> =C2=A0 hmp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 46 +++++--------------------------------
>> =C2=A0 qapi-schema.json | 70
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 3 files changed, 114 insertions(+), 40 deletions(-)
>>
>=20
>> +++ b/hmp.c
>> @@ -360,50 +360,16 @@ void hmp_info_migrate_cache_size(Monitor *mon,
>> const QDict *qdict)
>> =C2=A0 =C2=A0 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 CpuInfoList *cpu_list, *cpu;
>> +=C2=A0=C2=A0=C2=A0 CpuInfoFastList *head, *cpu;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 cpu_list =3D qmp_query_cpus(NULL);
>> +=C2=A0=C2=A0=C2=A0 head =3D qmp_query_cpus_fast(NULL);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 for (cpu =3D cpu_list; cpu; cpu =3D cpu->ne=
xt) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int active =3D ' ';
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->value->CPU =3D=3D=
 monitor_get_cpu_index()) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ac=
tive =3D '*';
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> The old code was doing multiple things - it was telling you the current
> HMP cpu (HMP has 'cpu' with no QMP counterpart, but if you are using
> HMP, knowing which cpu is the active target for future HMP commands tha=
t
> depend on the active target, this bit of information is important), as
> well as...
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "%c CP=
U #%" PRId64 ":", active,
>> cpu->value->CPU);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (cpu->value->arch) =
{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CPU_INFO_ARCH_X86:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mo=
nitor_printf(mon, " pc=3D0x%016" PRIx64,
>> cpu->value->u.x86.pc);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>=20
> ...inundating you with the arch-specific slow stuff.=C2=A0 I'm in agree=
ment
> that dropping the slow stuff is okay, but...
>=20
>> +=C2=A0=C2=A0=C2=A0 for (cpu =3D head; cpu; cpu =3D cpu->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "=C2=A0=
 CPU #%" PRId64 ":",
>> cpu->value->cpu_index);
>=20
> ...unilaterally dropping the '*' active indicator, which has no bearing
> on the QMP changes, and thus is not an appropriate change for this patc=
h>
> I've now gone through the entire patch (and not just the UI), so on the
> next revision, I'll be prepared to give a full R-b, rather than just
> Acked-by.=C2=A0 But I do think this means we need a v5.
>=20
Thanks for the patience. I'll respin with the r/a-b's on patch 2/4
removed, but want to verify first that I can get the active cpu without
triggering cpu_synchronize_state via monitor_get_cpu_index...

--=20
Regards,
 Viktor Mihajlovski
