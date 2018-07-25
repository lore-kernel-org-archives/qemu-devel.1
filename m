Received: from eggs.gnu.org ([2001:4830:134:3::10]:32864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiNvf-0005Pj-U2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiNvc-0004e4-Sw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:50:27 -0400
References: <20180725091233.3300-1-david@redhat.com>
	<20180725170925.GE12380@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a33a67eb-2fb6-31fd-f4ca-1d883a5a7b75@redhat.com>
Date: Wed, 25 Jul 2018 19:50:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180725170925.GE12380@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 25.07.2018 19:09, Eduardo Habkost wrote:
> On Wed, Jul 25, 2018 at 11:12:33AM +0200, David Hildenbrand wrote:
>> The "max" CPU model behaves like "-cpu host" when KVM is enabled, and =
like
>> a CPU with the maximum possible feature set when TCG is enabled.
>>
>> While the "host" model can not be used under TCG ("kvm_required"), the
>> "max" model can and "Enables all features supported by the accelerator=
 in
>> the current host".
>>
>> So we can treat "host" just as a special case of "max" (like x86 does)=
.
>> It differs to the "qemu" CPU model under TCG such that compatibility
>> handling will not be performed and that some experimental CPU features
>> not yet part of the "qemu" model might be indicated.
>>
>> These are right now under TCG (see "qemu_MAX"):
>> - stfle53
>> - msa5-base
>> - zpci
>>
>> This will result right now in the following warning when starting QEMU=
 TCG
>> with the "max" model:
>>     "qemu-system-s390x: warning: 'msa5-base' requires 'kimd-sha-512'."
>>
>> The "qemu" model (used as default in QEMU under TCG) will continue to
>> work without such warnings. The "max" mdel in the current form
>> might be interesting for kvm-unit-tests (where we would e.g. now also
>> test "msa5-base").
>>
>> The "max" model is neither static nor migration safe (like the "host"
>> model). It is independent of the machine but dependends on the acceler=
ator.
>> It can be used to detect the maximum CPU model also under TCG from upp=
er
>> layers without having to care about CPU model names for CPU model
>> expansion.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu_models.c | 81 +++++++++++++++++++++++++++-----------=
-
>>  1 file changed, 56 insertions(+), 25 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 604898a882..708bf0e3ba 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -307,7 +307,10 @@ static gint s390_cpu_list_compare(gconstpointer a=
, gconstpointer b)
>>      const char *name_a =3D object_class_get_name((ObjectClass *)a);
>>      const char *name_b =3D object_class_get_name((ObjectClass *)b);
>> =20
>> -    /* move qemu and host to the top of the list, qemu first, host se=
cond */
>> +    /*
>> +     * Move qemu, host and max to the top of the list, qemu first, ho=
st second,
>> +     * max third.
>> +     */
>>      if (name_a[0] =3D=3D 'q') {
>>          return -1;
>>      } else if (name_b[0] =3D=3D 'q') {
>> @@ -316,6 +319,10 @@ static gint s390_cpu_list_compare(gconstpointer a=
, gconstpointer b)
>>          return -1;
>>      } else if (name_b[0] =3D=3D 'h') {
>>          return 1;
>> +    } else if (name_a[0] =3D=3D 'm') {
>> +        return -1;
>> +    } else if (name_b[0] =3D=3D 'm') {
>> +        return 1;
>>      }
>=20
> Isn't it simpler to add a S390CPUClass::ordering field?  See
> x86_cpu_list_compare() for an example.

Not sure if it is simpler, this way the whole sorting logic is located at=
 a
single place.

But I agree that if this list grows bigger, we might want to use a
ordering field at least for the special cases (qemu/host/max/...)

>=20
>=20
>> =20
>>      /* keep the same order we have in our table (sorted by release da=
te) */
>> @@ -1077,27 +1084,6 @@ static void s390_cpu_model_initfn(Object *obj)
>>      }
>>  }
>> =20
>> -#ifdef CONFIG_KVM
>> -static void s390_host_cpu_model_initfn(Object *obj)
>> -{
>> -    S390CPU *cpu =3D S390_CPU(obj);
>> -    Error *err =3D NULL;
>> -
>> -    if (!kvm_enabled() || !kvm_s390_cpu_models_supported()) {
>> -        return;
>> -    }
>> -
>> -    cpu->model =3D g_malloc0(sizeof(*cpu->model));
>> -    kvm_s390_get_host_cpu_model(cpu->model, &err);
>> -    if (err) {
>> -        error_report_err(err);
>> -        g_free(cpu->model);
>> -        /* fallback to unsupported cpu models */
>> -        cpu->model =3D NULL;
>> -    }
>> -}
>> -#endif
>> -
>>  static S390CPUDef s390_qemu_cpu_def;
>>  static S390CPUModel s390_qemu_cpu_model;
>> =20
>> @@ -1136,6 +1122,30 @@ static void s390_qemu_cpu_model_initfn(Object *=
obj)
>>      memcpy(cpu->model, &s390_qemu_cpu_model, sizeof(*cpu->model));
>>  }
>> =20
>> +static void s390_max_cpu_model_initfn(Object *obj)
>> +{
>> +    const S390CPUModel *max_model;
>> +    S390CPU *cpu =3D S390_CPU(obj);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
>> +        /* "max" and "host" always work, even without CPU model suppo=
rt */
>> +        return;
>> +    }
>=20
> What's the use case that requires this check to be here?
>=20
> What do you expect 'query-cpu-model-expansion model=3Dmax' to
> return if !kvm_s390_cpu_models_supported()?

The same as for "host". We have been handling the host model like this fo=
rever.
(If we have no KVM interface, we have have basically no real idea on whic=
h CPU
 we are running, so we can't expand/baseline)

cpu_model_from_info():

if (!cpu->model) {
    error_setg(errp, "Details about the host CPU model are not available,=
 "
               "it cannot be used.");
    object_unref(obj);
    return;
}

We might want to tweak this error message later maybe (use the
model name instead of "host", but as "max" maps to "host" under KVM,
this is not of high priority)

>=20
>=20
>> +
>> +    max_model =3D get_max_cpu_model(&local_err);
>=20
> I've just confirmed that get_max_cpu_model() is already ready to
> work with TCG.

Yes, it was used for detecting "runability" already also for TCG.

>=20
>> +    if (local_err) {
>> +        g_assert(kvm_enabled());
>> +        error_report_err(local_err);
>> +        /* fallback to unsupported CPU models */
>> +        return;
>=20
> What about moving this outside instance_init?

To which place for example? We at least have to copy the CPU model
for each and every CPU instance (so we can modify it without side
effects using properties).

And if you look closely, 99% of this function will be exactly that
(as the max model is cached internally, it will only be looked up once).

>=20
> On x86 we have a x86_cpu_expand_features() function to allow us
> to handle CPU model expansion errors more gracefully.
>=20
> None of my comments are about new code, but existing code from
> "host", so:
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!

--=20

Thanks,

David / dhildenb
