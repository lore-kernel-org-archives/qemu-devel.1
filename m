Received: from eggs.gnu.org ([2001:4830:134:3::10]:40749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dRvPK-0004qA-In
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dRvPH-0003hm-By
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:04:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dRvPH-0003gP-2p
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:04:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v6373wpN059828
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 03:04:25 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bf63028pm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:04:24 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 08:04:22 +0100
References: <1498829133-20598-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<5566d3c2-f791-eab2-cafa-795c96739d8c@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 09:04:19 +0200
MIME-Version: 1.0
In-Reply-To: <5566d3c2-f791-eab2-cafa-795c96739d8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <e2c34fc2-97e0-0a16-c04d-9a039e2d402d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390: return unavailable features via
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
Cc: borntraeger@de.ibm.com, Eduardo Habkost <ehabkost@redhat.com>, jjherne@linux.vnet.ibm.com

On 30.06.2017 18:47, David Hildenbrand wrote:
> On 30.06.2017 15:25, Viktor Mihajlovski wrote:
>> The response for query-cpu-definitions didn't include the
>> unavailable-features field, which is used by libvirt to figure
>> out whether a certain cpu model is usable on the host.
>>
>> The unavailable features are now computed by obtaining the host CPU
>> model and comparing its feature bitmap with the feature bitmaps of
>> the known CPU models.
>>
>> I.e. the output of virsh domcapabilities would change from
>>  ...
>>      <mode name=3D'custom' supported=3D'yes'>
>>       <model usable=3D'unknown'>z10EC-base</model>
>>       <model usable=3D'unknown'>z9EC-base</model>
>>       <model usable=3D'unknown'>z196.2-base</model>
>>       <model usable=3D'unknown'>z900-base</model>
>>       <model usable=3D'unknown'>z990</model>
>>  ...
>> to
>>  ...
>>      <mode name=3D'custom' supported=3D'yes'>
>>       <model usable=3D'yes'>z10EC-base</model>
>>       <model usable=3D'yes'>z9EC-base</model>
>>       <model usable=3D'no'>z196.2-base</model>
>>       <model usable=3D'yes'>z900-base</model>
>>       <model usable=3D'yes'>z990</model>
>>  ...
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> ---
>>  target/s390x/cpu_models.c | 51 ++++++++++++++++++++++++++++++++++++++=
++++-----
>>  1 file changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 63903c2..dc3371f 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -283,14 +283,43 @@ void s390_cpu_list(FILE *f, fprintf_function pri=
nt)
>>      }
>>  }
>> =20
>> +static S390CPUModel *get_max_cpu_model(Error **errp);
>> +
>>  #ifndef CONFIG_USER_ONLY
>> +static void list_add_feat(const char *name, void *opaque);
>> +
>> +static void check_unavailable_features(const S390CPUModel *max_model,
>> +                                       const S390CPUModel *model,
>> +                                       strList **unavailable)
>> +{
>> +    S390FeatBitmap missing;
>> +
>> +    /* detect missing features if any to properly report them */
>> +    bitmap_andnot(missing, model->features, max_model->features,
>> +                  S390_FEAT_MAX);
>> +    if (!bitmap_empty(missing, S390_FEAT_MAX)) {
>> +        s390_feat_bitmap_to_ascii(missing,
>> +                                  unavailable,
>> +                                  list_add_feat);
>=20
> I remember discussing this with Eduardo when he introduced this.
>=20
> There is one additional case to handle here that might turn a CPU model
> not runnable. This can happen when trying to run a new CPU model on an
> old host, where the features are not the problem, but the model itself.
> E.g. running a GA2 version on a GA1 is not allowed. But this can happen
> more generally also between hardware generations.
>=20
> Therefore, whenever the model is never than the host model, we have to
> add here the special property "type" as missing feature. The
> documentation partly coveres what we had in mind.>
> qapi-schema.json:
> # @unavailable-features is a list of QOM property names that
>=20
> # represent CPU model attributes that prevent the CPU from running.
>=20
> # If the QOM property is read-only, that means there's no known
>=20
> # way to make the CPU model run in the current host. Implementations
>=20
> # that choose not to provide specific information return the
>=20
> # property name "type".
>=20
> We discussed that "type" should always be added if there is no way to
> make the model runnable (by simply removing features).
Thanks for the clarification.
I guess I was reading that too narrow-minded (no specific information vs
type), although I had the suspicion that features alone wouldn't
suffice. I will follow the query_cpu_model_comparison pattern and return
both "type" and the real features.
> > See check_compatibility() for details. For these cases, add "type" to
> the list. (you might be able to extend check_compatibility(), making
> e.g. the *errp and *unavailable parameters optional).
>=20

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
