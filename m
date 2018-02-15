Received: from eggs.gnu.org ([2001:4830:134:3::10]:39780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emKhv-0007Pp-KF
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emKhr-0003u9-4o
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:40:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emKhq-0003tB-Oe
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:40:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FEbWSN119865
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:40:13 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5atnc140-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:40:12 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 14:40:09 -0000
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518690027-31318-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<3b41b0f0-09cf-9e43-bfa4-617335d76584@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 15:40:03 +0100
MIME-Version: 1.0
In-Reply-To: <3b41b0f0-09cf-9e43-bfa4-617335d76584@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <50053a43-4905-9609-9be3-8418f1978465@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 2/4] qmp: add query-cpus-fast
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

On 15.02.2018 15:19, Eric Blake wrote:
> On 02/15/2018 04:20 AM, Viktor Mihajlovski wrote:
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
>> =C2=A0 o Drop "halted" field as it can not retrieved in a fast
>=20
> s/can not retrieved/cannot be retrieved/
>=20
>> =C2=A0=C2=A0=C2=A0 way on most architectures
>>
>> =C2=A0 o Drop irrelevant fields such as "current", "pc" and "arch"
>>
>> =C2=A0 o Rename some fields for better clarification & proper naming
>> =C2=A0=C2=A0=C2=A0 standard
>>
>> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Acked-by: Eric Blake <eblake@redhat.com>
>> ---
>=20
>> +++ b/hmp-commands-info.hx
>> @@ -160,6 +160,20 @@ Show infos for each CPU.
>=20
> Pre-existing, but while we are here, it wouldn't hurt to do
> s/infos/information/
>=20
>> =C2=A0 ETEXI
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "cpus_fast",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .args_type=C2=A0 =3D "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .params=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "show information for each CPU without
>> interrupting them",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cmd=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D hmp_info_cpus_fast,
>> +=C2=A0=C2=A0=C2=A0 },
>> +
>> +STEXI
>> +@item info cpus_fast
>> +@findex info cpus_fast
>> +Show infos for each CPU without performance penalty.
>=20
> and again here, where you copied and pasted.
>=20
> You know, we have no back-compat guarantees on HMP.=C2=A0 We could make=
 'info
> cpu' just ALWAYS call query-cpus-fast, with no HMP counterpart for the
> slower query-cpus, and without needing a deprecation period.=C2=A0 But =
I'll
> leave that up to David if that makes more sense.
Ditching info cpus_fast would make me happy as well, because it would
cause less headache on the libvirt side of things.
>=20
>> +++ b/hmp.c
>> @@ -410,6 +410,20 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdi=
ct)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_free_CpuInfoList(cpu_list);
>> =C2=A0 }
>> =C2=A0 +void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
>> +{
>> +=C2=A0=C2=A0=C2=A0 CpuInfoFastList *head, *cpu;
>> +
>> +=C2=A0=C2=A0=C2=A0 head =3D qmp_query_cpus_fast(NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (cpu =3D head; cpu; cpu =3D cpu->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "=C2=A0=
 CPU #%" PRId64 ":",
>> cpu->value->cpu_index);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, " thre=
ad-id=3D%" PRId64 "\n",
>> cpu->value->thread_id);
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> This is particularly true since your HMP implementation is not even
> printing all the information returned by query-cpus-fast!
>=20


--=20
Regards,
 Viktor Mihajlovski
