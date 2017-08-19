Received: from eggs.gnu.org ([2001:4830:134:3::10]:59572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dixuY-0001Ce-9Q
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dixuU-0000my-S5
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:11:10 -0400
Date: Sat, 19 Aug 2017 10:08:59 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170818151621.o367sr74hi3e2kpm@postretch>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-5-el13635@mail.ntua.gr>
	<w51r2w958mc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gaal4ddkogczlmjm"
Content-Disposition: inline
In-Reply-To: <w51r2w958mc.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--gaal4ddkogczlmjm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 03:05:31PM +0200, Alberto Garcia wrote:
>On Fri 18 Aug 2017 05:10:17 AM CEST, Manos Pitsidianakis wrote:
>
>>   * If no ThrottleGroup is found with the given name a new one is
>>   * created.
>>   *
>> - * @name: the name of the ThrottleGroup
>> + * This function edits throttle_groups and must be called under the glo=
bal
>> + * mutex.
>> + *
>> + * @name: the name of the ThrottleGroup, NULL means a new anonymous gro=
up will
>> + *        be created.
>>   * @ret:  the ThrottleState member of the ThrottleGroup
>>   */
>>  ThrottleState *throttle_group_incref(const char *name)
>
>If we're not going to have anonymous groups in the end this patch needs
>changes (name =3D=3D NULL is no longer allowed).
>
>> +/* This function edits throttle_groups and must be called under the glo=
bal
>> + * mutex */
>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **err=
p)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj), *iter;
>> +    ThrottleConfig *cfg =3D &tg->ts.cfg;
>> +
>> +    /* set group name to object id if it exists */
>> +    if (!tg->name && tg->parent_obj.parent) {
>> +        tg->name =3D object_get_canonical_path_component(OBJECT(obj));
>> +    }
>> +
>> +    if (tg->name) {
>> +        /* error if name is duplicate */
>> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
>> +            if (!g_strcmp0(tg->name, iter->name) && tg !=3D iter) {
>
>I'm just nitpicking here :) but if you change this and put 'tg !=3D iter'
>first you'll save one unnecessary string comparison.

Only in the case where tg =3D=3D iter, otherwise you have one unnecessary=
=20
pointer comparison for every other group.
>
>> +                error_setg(errp, "A group with this name already exists=
");
>> +                return;
>> +            }
>> +        }
>> +    }
>> +
>> +    /* unfix buckets to check validity */
>> +    throttle_get_config(&tg->ts, cfg);
>> +    if (!throttle_is_valid(cfg, errp)) {
>> +        return;
>> +    }
>> +    /* fix buckets again */
>> +    throttle_config(&tg->ts, tg->clock_type, cfg);
>
>throttle_get_config(ts, cfg) makes a copy of the existing configuration,
>but the cfg pointer that you are passing already points to the existing
>configuration, so in practice you are doing
>
>    *(ts->cfg) =3D *(ts->cfg);
>    throttle_unfix_bucket(...);
>
>and since you "unfixed" the configuration, then you need undo the whole
>thing by setting the config again:
>
>    *(ts->cfg) =3D *(ts->cfg);
>    throttle_fix_bucket(...);
>
>You should declare a local ThrottleConfig variable, copy the config
>there, and run throttle_is_valid() on that copy. The final
>throttle_config() call is unnecessary.

I figured I didn't have to make an extra copy but this looks bad in=20
retrospect

>
>Once the patches I sent yesterday are merged we'll be able to skip the
>throttle_get_config() call and do throttle_is_valid(&tg->ts.cfg, errp)
>directly.
>
>> +static void throttle_group_set(Object *obj, Visitor *v, const char * na=
me,
>> +                               void *opaque, Error **errp)
>> +
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleParamInfo *info =3D opaque;
>> +    Error *local_err =3D NULL;
>> +    int64_t value;
>> +
>> +    /* If we have finished initialization, don't accept individual prop=
erty
>> +     * changes through QOM. Throttle configuration limits must be set i=
n one
>> +     * transaction, as certain combinations are invalid.
>> +     */
>> +    if (tg->is_initialized) {
>> +        error_setg(&local_err, "Property cannot be set after initializa=
tion");
>> +        goto ret;
>> +    }
>> +
>> +    visit_type_int64(v, name, &value, &local_err);
>> +    if (local_err) {
>> +        goto ret;
>> +    }
>> +    if (value < 0) {
>> +        error_setg(&local_err, "Property values cannot be negative");
>> +        goto ret;
>> +    }
>> +
>> +    cfg =3D tg->ts.cfg;
>> +    switch (info->data_type) {
>> +    case UINT64:
>> +        {
>> +            uint64_t *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            *field =3D value;
>> +        }
>> +        break;
>> +    case DOUBLE:
>> +        {
>> +            double *field =3D (void *)&cfg.buckets[info->type] + info->=
offset;
>> +            *field =3D value;
>> +        }
>> +        break;
>> +    case UNSIGNED:
>> +        {
>> +            if (value > UINT_MAX) {
>> +                error_setg(&local_err, "%s value must be in the"
>> +                                       "range [0, %u]", info->name, UIN=
T_MAX);
>> +                goto ret;
>> +            }
>> +            unsigned *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            *field =3D value;
>> +        }
>> +    }
>> +
>> +    tg->ts.cfg =3D cfg;
>
>There's a bit of black magic here :)

This offset business is indeed black magic! And university makes you=20
think the world runs on ML and Haskell...

>you have a user-defined enumeration
>(UNSIGNED, DOUBLE, UINT64) to identify C types and I'm worried about
>what happens if the data types of LeakyBucket change, will we be able to
>detect the problem?
>
>Out of the blue I can think of the following alternative:
>
>   - There's 6 different buckets (we have BucketType listing them)
>
>   - There's 3 values we can set in each bucket (max, avg,
>     burst_length). For those we can have an internal enumeration
>     (probably with one additional value for iops-size).
>
>   - In the 'properties' array, for each property we know its category
>     (and I mean: avg, max, burst-lenght, iops-size) and the bucket
>     where they belong.
>
>   - In throttle_group_set() the switch could be something like this:
>
>     switch (info->category) {
>        case THROTTLE_VALUE_AVG:
>           cfg->buckets[info->bkt_type].avg =3D value;
>           break;
>        case THROTTLE_VALUE_MAX:
>           cfg->buckets[info->bkt_type].max =3D value;
>           break;
>        case THROTTLE_VALUE_BURST_LENGTH:
>           /* Code here to check that value <=3D UINT_MAX */
>           cfg->buckets[info->bkt_type].iops_length =3D value;
>           break;
>        case THROTTLE_VALUE_IOPS_SIZE:
>           cfg->op_size =3D value;
>     }

I don't think that solves the type problem, since C uses coercion.  For=20
example if hypothetically a double changes to uint in the future,=20
`value` will not be checked for overflow and the compiler would just=20
convert it to uint implicitly.  An academic solution would be to use a=20
strongly typed language!
>
>> +static void throttle_group_get(Object *obj, Visitor *v, const char *nam=
e,
>> +                               void *opaque, Error **errp)
>
>And the same approach here, of course.
>
>> +static void throttle_group_set_limits(Object *obj, Visitor *v,
>> +                                      const char *name, void *opaque,
>> +                                      Error **errp)
>> +
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleLimits *arg =3D NULL;
>> +    Error *local_err =3D NULL;
>> +
>> +    arg =3D g_new0(ThrottleLimits, 1);
>
>Do you need to allocate ThrottleLimits in the heap?

I thought you actually do because visit_type_ThrottleLimits() frees arg=20
on error:
=20
    if (err && visit_is_input(v)) {
        qapi_free_ThrottleLimits(*obj);
        *obj =3D NULL;
    }

but I see now it doesn't actually call g_free and only sets the pointer=20
to NULL.  Is that supposed to prevent use of a stack pointer in the=20
caller after error? I am a bit confused as to why. (This is the=20
generated qapi-visit.c code but similar to other visitor functions)

I will change this back to

    ThrottleLimits arg =3D { 0 };
    ThrottleLimits *argp =3D &arg;
    visit_type_ThrottleLimits(v, name, &argp, &local_err);

>
>> +static void throttle_group_get_limits(Object *obj, Visitor *v,
>> +                                      const char *name, void *opaque,
>> +                                      Error **errp)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleLimits *arg =3D NULL;
>> +
>> +    qemu_mutex_lock(&tg->lock);
>> +    throttle_get_config(&tg->ts, &cfg);
>> +    qemu_mutex_unlock(&tg->lock);
>> +
>> +    arg =3D g_new0(ThrottleLimits, 1);
>> +    throttle_config_to_limits(&cfg, arg);
>> +
>> +    visit_type_ThrottleLimits(v, name, &arg, errp);
>> +    g_free(arg);
>
>Same question here.
>
>Berto
>

--gaal4ddkogczlmjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmX5AsACgkQc2J8L2kN
9xD0Kg/+OJOaqJGn3k5WW1S+4mOx3wbsl1W7pm3Ey6CzYf9Ayg350Dnw16iMMgll
ZpFdZl4m2d2RQp1Yj2zLr4kd4lfKU82htIYgUJxt8eAJBE9hwyj7K8TZcaZGnnbb
+CzX9DK7L9XKIt1EdCEOzOUO55+UZkZXfDyEwLz3NdJpssORfAk1DdUfFKA1G45X
0V+IhCeXtXj6UHZka7p9+JJvXrzYmDNAjEF/RVj+DsVkqJ4LmIq//E8JAy+4QSy+
Gg63Z1TTIu5KaWKBzWATWo4azTzf/WK3A3OHWhKKSgDonsEdWh+JjcplVmq9lVP1
01e/DPLXJqXMeA5SgJyi0oEjIf9I+zQdELGOlWdem5soiC0X//oWOwILPXCpzvpE
+vHaspEkzhA3lkL2wlDkUWYcWVsXjRcGHrAr942eVsqxUhVefajM4aGFK4QJitjx
hOEP7Riw+B9Z/JvHr21nWkRj0l8n+1BrNlqYK6wWFX9E846PjrP5VgQi55/U4B8X
PCxPu6xZGKXVExsyM9PnotpOFElbvKp8aWF7txcd4N+FiteKDoqTpivRUcu5//R2
Q3/P26l4v8QkeYKfYEFAIIq8iDqa31M2PnNeXW2dPKQQ48+TMBpuBO96bIWCVtIt
KtDwFX7/ODHWWTHYhE/iMv/XC7a0T7k600UJhJt1UwPwkfBUy8I=
=rusd
-----END PGP SIGNATURE-----

--gaal4ddkogczlmjm--
