Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dSMYC-0004bl-Am
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dSMY9-0002O9-8v
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:03:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dSMY8-0002Nk-Va
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:03:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64C10Fw079715
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 08:03:23 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j6awup-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 08:03:22 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 13:03:19 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
References: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<650c9114-67bf-1f5b-7155-7bb1c7813b21@redhat.com>
	<9df99982-111b-01f4-e1e5-ec375a4cf4e0@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 14:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <9df99982-111b-01f4-e1e5-ec375a4cf4e0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <caf8745b-b86b-d65c-f5ec-86a3a9799bbe@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com

On 04.07.2017 13:22, Viktor Mihajlovski wrote:
> On 04.07.2017 11:35, David Hildenbrand wrote:
>>> +
>>>  static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>>>  {
>>> -    CpuDefinitionInfoList **cpu_list =3D opaque;
>>> +    struct CpuDefinitionInfoListData *cpu_list_data =3D opaque;
>>> +    CpuDefinitionInfoList **cpu_list =3D &cpu_list_data->list;
>>>      CpuDefinitionInfoList *entry;
>>>      CpuDefinitionInfo *info;
>>>      char *name =3D g_strdup(object_class_get_name(klass));
>>> @@ -300,7 +331,19 @@ static void create_cpu_model_list(ObjectClass *k=
lass, void *opaque)
>>>      info->migration_safe =3D scc->is_migration_safe;
>>>      info->q_static =3D scc->is_static;
>>>      info->q_typename =3D g_strdup(object_class_get_name(klass));
>>> -
>>
>> Wonder if we should add the following:
>>
>> /* the host model can never be used under TCG */
>> if (scc->kvm_required && !kvm_enabled())) {
>>     info->has_unavailable_features =3D true;
>>     list_add_feat("type", &info->unavailable_features);
>> } else if (cpu_list_data->model ...
>>
>>> +    /* check for unavailable features */
>>> +    if (cpu_list_data->model) {
>>> +        Object *obj;
>>> +        S390CPU *sc;
>>> +        obj =3D object_new(object_class_get_name(klass));
>>> +        sc =3D S390_CPU(obj);
>>
>> So we can drop the check here (if we have a host/max_model definition
>> under KVM, then all models have sc->model set). But the current code
>> should also work (it simply will not indicate runability information f=
or
>> the "host" model under TCG, as sc->model will be NULL).
> Hmm ... that made me think that we could remove the check here and make
> check_unavailable_features interpret a NULL model as not
> usable/incompatible (a bit more robust in the unlikely event of a memor=
y
> allocation failure). Thoughts?
In fact, all of this may be moot anyway: libvirt blacklists the host
model as I found out, after wondering why there was no "host" CPU with
unknown usability in the virsh domcapabilities output.
I'll take your r-b then, and abstain from posting my v4 :-).
>>>> +        if (sc->model) {
>>> +            info->has_unavailable_features =3D true;
>>> +            check_unavailable_features(cpu_list_data->model, sc->mod=
el,
>>> +                                       &info->unavailable_features);
>>> +        }
>>> +        object_unref(obj);
>>> +    }
>>> =20
>> Looks good to me and produced the expected result under TCG.
>>
>> Feel free to add my
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>> with or without the modification.
>>
>=20
>=20


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
