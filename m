Received: from eggs.gnu.org ([2001:4830:134:3::10]:55437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk9Jn-0008Rj-RQ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk9Jk-0007Jm-KI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:07 -0400
Date: Tue, 22 Aug 2017 16:31:57 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170822133157.l7llzbytnoomztv6@postretch>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-5-el13635@mail.ntua.gr>
	<w51ziarg2ei.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvqbxwmst6dpizan"
Content-Disposition: inline
In-Reply-To: <w51ziarg2ei.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/6] block: convert ThrottleGroup to
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


--xvqbxwmst6dpizan
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Tue, Aug 22, 2017 at 03:25:41PM +0200, Alberto Garcia wrote:
>> +/* This function edits throttle_groups and must be called under the global
>> + * mutex */
>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
>> +{
>> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +
>> +    /* set group name to object id if it exists */
>> +    if (!tg->name && tg->parent_obj.parent) {
>> +        tg->name = object_get_canonical_path_component(OBJECT(obj));
>> +    }
>> +    /* We must have a group name at this point */
>> +    assert(tg->name);
>> +
>> +    /* error if name is duplicate */
>> +    if (throttle_group_exists(tg->name)) {
>> +            error_setg(errp, "A group with this name already exists");
>> +            return;
>> +    }
>> +
>> +    /* check validity */
>> +    throttle_get_config(&tg->ts, &cfg);
>> +    if (!throttle_is_valid(&cfg, errp)) {
>> +        return;
>> +    }
>
>My fault here because I suggested its removal, but I actually think we
>still need to call throttle_config() here so bkt->max is initialized in
>throttle_fix_bucket(). I'll take care of updating this call once my
>patches to remove throttle_fix_bucket() are applied, but for now we
>still need it.

Oh yes, that is the reason I originally had done it but forgot why.

--xvqbxwmst6dpizan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmcMk0ACgkQc2J8L2kN
9xBZDRAAzGsA2g+MOGMxMKbcgwWwdSDGqT7yhPwOehEmNJQHmqMlqDMgtojJvVMK
Vj+OM6tVrnXvLT4yrS2OILWe/+CThD/1mc6psIUgt0w3uxfNd33fx/FZhjMHsJvy
FDdzWVB42B9+Pd6nn8U9MQ+jlh8GBmerX4J9wKU1tTDzGDfYY+r5qfeW3BPmI/iY
jK/PgYqOyK0FoAM2AbJJYgDuSnU6xiMDN31RhzZ/DZVlBlv7N9GCEEJxbnDNddS7
N0HoEMwfgtmhslowKvOg3kgC4D0jEWB6lstmkV924IhKaO5oFgYHM9mlrJbWXCBr
EfX/TYCGXYKwUWOKqgapq3MiUYT0AZvC41tJBISH9Hs29B0xdfhUgaTZxcsaIvZ/
/U0lV37MS+i1wJ3y42UBxYUQHfbkPZHnUXCXBz37tyT50DlT+NUl0kcbg0GeSAbJ
rUM426KdKF8rLPIZs0QRtNLeyv+Fo3foinZ24s/qmb421pwAcHJPaEA+XCu0M1VX
u545ve8YaVd2IF0LriNNq0ZgFR6HWjMAWBuk+czat2/eQ5V6G6lzQ9DPqM2+Poz5
W4pXwf7NU1KbabWuxGJ8b1OP8PLTrcod86RHgfo+l1NjR+jQ8yZ5hqEmjEUJE7iU
HaV3IPAHbB6ULP6a934ZlPZof8N1obNNuPxWEBKZgNZ5TYWwyes=
=vFaN
-----END PGP SIGNATURE-----

--xvqbxwmst6dpizan--
