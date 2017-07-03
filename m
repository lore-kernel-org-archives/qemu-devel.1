Received: from eggs.gnu.org ([2001:4830:134:3::10]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dRyvN-0004Us-MU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dRyvJ-0000HH-H9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:49:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dRyvJ-0000Gd-6c
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:49:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63AmvRD117007
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 06:49:43 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bfh29gf6m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 06:49:42 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 11:49:40 +0100
References: <1499068251-6164-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<83e957bb-6064-e769-6ada-3846cbd77059@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 12:49:37 +0200
MIME-Version: 1.0
In-Reply-To: <83e957bb-6064-e769-6ada-3846cbd77059@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <0e91b7e7-5301-8b55-261c-bc4b822f82f7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390: return unavailable features via
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

On 03.07.2017 11:25, David Hildenbrand wrote:
>=20
>> =20
>> +static S390CPUModel *get_max_cpu_model(Error **errp);
>> +
>>  #ifndef CONFIG_USER_ONLY
>> +static void list_add_feat(const char *name, void *opaque);
>=20
> Wonder if we should declare all these prototypes at the beginning of th=
e
> file.
>=20
Don't know either. Looking around in QEMU, forward declarations for
static functions seem to be used sparsely (only when needed). I could
have reordered the functions to get around without forward decls but
this would have obscured the change. Maybe defer and clean up in a
general cleanup/refactoring?
>> +
>> +static void check_unavailable_features(const S390CPUModel *max_model,
>> +                                       const S390CPUModel *model,
>> +                                       strList **unavailable)
>> +{
>> +    S390FeatBitmap missing;
>> +
>> +    /* check general model compatibility */
>> +    if (max_model->def->gen < model->def->gen ||
>> +        (max_model->def->gen =3D=3D model->def->gen &&
>> +         max_model->def->ec_ga < model->def->ec_ga)) {
>> +        list_add_feat("type", unavailable);
>> +    }
>> +
>> +    /* detect missing features if any to properly report them */
>> +    bitmap_andnot(missing, model->features, max_model->features,
>> +                  S390_FEAT_MAX);
>> +    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
>> +        s390_feat_bitmap_to_ascii(missing,
>> +                                  unavailable,
>> +                                  list_add_feat);
>=20
> This certainly fits into one line.
True, will change.
>=20
>> +    }
>> +}
>> +
>> +struct CpuDefinitionInfoListData {
>> +    CpuDefinitionInfoList *list;
>> +    Error **errp;
>> +};
>> +
>>  static void create_cpu_model_list(ObjectClass *klass, void *opaque)
>>  {
>> -    CpuDefinitionInfoList **cpu_list =3D opaque;
>> +    struct CpuDefinitionInfoListData *cpu_list_data =3D opaque;
>> +    CpuDefinitionInfoList **cpu_list =3D &cpu_list_data->list;
>>      CpuDefinitionInfoList *entry;
>>      CpuDefinitionInfo *info;
>>      char *name =3D g_strdup(object_class_get_name(klass));
>>      S390CPUClass *scc =3D S390_CPU_CLASS(klass);
>> +    Object *obj;
>> +    S390CPU *sc;
>> +    S390CPUModel *scm;
>> =20
>>      /* strip off the -s390-cpu */
>>      g_strrstr(name, "-" TYPE_S390_CPU)[0] =3D 0;
>> @@ -300,21 +336,33 @@ static void create_cpu_model_list(ObjectClass *k=
lass, void *opaque)
>>      info->migration_safe =3D scc->is_migration_safe;
>>      info->q_static =3D scc->is_static;
>>      info->q_typename =3D g_strdup(object_class_get_name(klass));
>> -
>> +    /* check for unavailable features */
>> +    obj =3D object_new(object_class_get_name(klass));
>> +    sc =3D S390_CPU(obj);
>> +    scm =3D get_max_cpu_model(cpu_list_data->errp);
>=20
> Hmmmm, if this function fails, we will create the same error multiple
> times (as there is no way to stop this function from iterating). And we
> will fail to create a cpu model list in case there is no host cpu model=
,
> which is a change in behavior (as we will report an error).
>=20
> Would it be better to simply get the max model in
> arch_query_cpu_definitions() and pass it via CpuDefinitionInfoListData,
> instead of the errp variable?Simplifies things, I like it.
>=20
> Then you could simply skip the checks and set
> info->has_unavailable_features =3D false in case there is no max model
> (get_max_cpu_model() returned NULL / an error). (same behavior as for n=
ow)
>=20
> Errors from get_max_cpu_model() then should be ignored and not reported.
>=20
Just to be sure: you suggest that I should call error_free() after
calling get_max_cpu_model, in order to prevent that the QMP command
query-cpu-definitions fails, right?
>=20
>=20
>> +    if (scm && sc->model) {
>> +        info->has_unavailable_features =3D true;
>> +        check_unavailable_features(scm, sc->model, &info->unavailable=
_features);
>> +    }
>> =20
>>      entry =3D g_malloc0(sizeof(*entry));
>>      entry->value =3D info;
>>      entry->next =3D *cpu_list;
>>      *cpu_list =3D entry;
>> +    object_unref(obj);
>>  }
>> =20
>>  CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
>>  {
>> -    CpuDefinitionInfoList *list =3D NULL;
>> +    struct CpuDefinitionInfoListData list_data =3D {
>> +        .list =3D NULL,
>> +        .errp =3D errp,
>> +    };
>> =20
>> -    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,=
 &list);
>> +    object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,
>> +                         &list_data);
>> =20
>> -    return list;
>> +    return list_data.list;
>>  }
>> =20
>>  static void cpu_model_from_info(S390CPUModel *model, const CpuModelIn=
fo *info,
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
