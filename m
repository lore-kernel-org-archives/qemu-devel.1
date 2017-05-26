Received: from eggs.gnu.org ([2001:4830:134:3::10]:57110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dELcm-0000YM-Hz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dELcj-0002de-Cg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dELcj-0002dJ-3U
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:14:13 -0400
References: <1495704132-5675-1-git-send-email-thuth@redhat.com>
	<b8b5569d-db2a-2c6c-f4c2-6647bb1444e5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <091318e1-6572-9c69-c294-2dab340e03ed@redhat.com>
Date: Fri, 26 May 2017 22:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <b8b5569d-db2a-2c6c-f4c2-6647bb1444e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 26.05.2017 14:14, David Hildenbrand wrote:
> On 25.05.2017 11:22, Thomas Huth wrote:
>> Currently we only present the plain z900 feature bits to the guest,
>> but QEMU already emulates some additional features (but not all of
>> the next CPU generation, so we can not use the next CPU level as
>> default yet). Since newer Linux kernels are checking the feature bits
>> and refuse to work if a required feature is missing, it would be nice
>> to have a way to present more of the supported features when we are
>> running with the "qemu" CPU.
>> This patch now adds the supported features to the "full_feat" bitmap,
>> so that additional features can be enabled on the command line now,
>> for example with:
>>
>>  qemu-system-s390x -cpu qemu,stfle=3Dtrue,ldisp=3Dtrue,eimm=3Dtrue,stc=
kf=3Dtrue>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Mark feats array with "static const"
>>
>>  target/s390x/cpu_models.c | 34 +++++++++++++++++++++++++++++++---
>>  1 file changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 8d27363..e5e005a 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -658,6 +658,30 @@ static void check_compatibility(const S390CPUMode=
l *max_model,
>>                    "available in the configuration: ");
>>  }
>> =20
>> +/**
>> + * The base TCG CPU model "qemu" is based on the z900. However, we al=
ready
>> + * can also emulate some additional features of later CPU generations=
, so
>> + * we add these additional feature bits here.
>> + */
>> +static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>> +{
>> +    static const int feats[] =3D {
>> +        S390_FEAT_STFLE,
>> +        S390_FEAT_EXTENDED_IMMEDIATE,
>> +        S390_FEAT_LONG_DISPLACEMENT,
>> +        S390_FEAT_LONG_DISPLACEMENT_FAST,
>> +        S390_FEAT_STORE_CLOCK_FAST,
>> +        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
>> +        S390_FEAT_EXECUTE_EXT,
>> +        S390_FEAT_STFLE_45,
>> +    };
>> +    int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(feats); i++) {
>> +        set_bit(feats[i], fbm);
>> +    }
>> +}
>> +
>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>  {
>>      static S390CPUModel max_model;
>> @@ -670,10 +694,11 @@ static S390CPUModel *get_max_cpu_model(Error **e=
rrp)
>>      if (kvm_enabled()) {
>>          kvm_s390_get_host_cpu_model(&max_model, errp);
>>      } else {
>> -        /* TCG emulates a z900 */
>> +        /* TCG emulates a z900 (with some optional additional feature=
s) */
>>          max_model.def =3D &s390_cpu_defs[0];
>>          bitmap_copy(max_model.features, max_model.def->default_feat,
>>                      S390_FEAT_MAX);
>> +        add_qemu_cpu_model_features(max_model.features);
>>      }
>>      if (!*errp) {
>>          cached =3D true;
>> @@ -925,11 +950,14 @@ static void s390_host_cpu_model_initfn(Object *o=
bj)
>> =20
>>  static void s390_qemu_cpu_model_initfn(Object *obj)
>>  {
>> +    static S390CPUDef s390_qemu_cpu_defs;
>>      S390CPU *cpu =3D S390_CPU(obj);
>> =20
>>      cpu->model =3D g_malloc0(sizeof(*cpu->model));
>> -    /* TCG emulates a z900 */
>> -    cpu->model->def =3D &s390_cpu_defs[0];
>> +    /* TCG emulates a z900 (with some optional additional features) *=
/
>> +    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_c=
pu_defs));
>> +    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
>> +    cpu->model->def =3D &s390_qemu_cpu_defs;
>>      bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
>>                  S390_FEAT_MAX);
>=20
> That should work for the general case, at least for now.
>=20
> arch_query_cpu_model_baseline() will still drop the additional featues.

It's only for experimenting with the additional feature right now, not
for serious usage yet (since some features are still missing to run
Linux kernels that are compiled for something > z900) - so I don't think
we need this for QMP already, i.e. IMHO we do not need care too much
about arch_query_cpu_model_baseline() yet.

> Another option would be to directly bump up the CPU model to a z9, with
> missing base features (for now). Which looks cleaner in my eyes:

But couldn't this cause issues, too? What if a kernel just assumes that
certain features are available with a z9 machine, without having a
closer look at the feature bits? Also, what about the features that we
already provide, but that were not available in the z9 yet, like
S390_FEAT_GENERAL_INSTRUCTIONS_EXT (which was introduced with the z10 as
far as I can see)? Don't you have the same issue with
arch_query_cpu_model_baseline() there?

 Thomas
