Received: from eggs.gnu.org ([2001:4830:134:3::10]:45947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNP0c-0006N6-4s
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNP0X-0005ce-Gc
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNP0X-0005cK-7j
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:12:29 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
	<20171208153010.GD8998@stefanha-x1.localdomain>
	<43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e53494e0-a4ef-8523-3ad1-45a2148302e7@redhat.com>
Date: Fri, 8 Dec 2017 14:12:18 -0600
MIME-Version: 1.0
In-Reply-To: <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gIS2xQmf7SqJvOH0TrAmxH4D72nSuNu5B"
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gIS2xQmf7SqJvOH0TrAmxH4D72nSuNu5B
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <e53494e0-a4ef-8523-3ad1-45a2148302e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <20171208105553.12249-3-pbonzini@redhat.com>
 <20171208153010.GD8998@stefanha-x1.localdomain>
 <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
In-Reply-To: <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 11:56 AM, Paolo Bonzini wrote:

>>> +typedef void QemuLockGuardFunc(void *);
>>> +typedef struct QemuLockGuard {
>>> +    QemuLockGuardFunc *p_lock_fn, *p_unlock_fn;
>>> +    void *lock;
>>> +    int locked;
>>
>> bool?
>=20
> Yes.
>=20
>>> +#define QEMU_WITH_LOCK(type, name, lock)                            =
       \
>>> +    for (QEMU_LOCK_GUARD(type, name, lock);                         =
       \
>>> +         qemu_lock_guard_is_taken(&name);                           =
       \
>>> +         qemu_lock_guard_unlock(&name))
>>
>> I don't understand the need for the qemu_lock_guard_is_taken(&name)
>> condition, why not do the following?
>>
>>   for (QEMU_LOCK_GUARD(type, name, lock);
>>        ;
>>        qemu_lock_guard_unlock(&name))
>=20
> Because that would be an infinite loop. :)

Do we really need 'locked' to belong to the lockguard, just for our use
in for loops?  Or can we just declare it in the for loop proper, as in

#define QEMU_WITH_LOCK(type, name, lock) \
    for (bool name##_done =3D false, QEMU_LOCK_GUARD(type, name, lock); \=

         !name##_done; \
         name##_done =3D true)

and let the automatic scope exit at the conclusion of the one-shot loop
thus unlock things on our behalf, and now we don't have to futz around
with guard->locked everywhere else?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gIS2xQmf7SqJvOH0TrAmxH4D72nSuNu5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq8iIACgkQp6FrSiUn
Q2oDEwf/U/IIBAUUfKV14R1ADRJJ63WiPONMTk9qWFWoeUy5+xFGAlejb/Sy0E6T
9WS7G3dVf/OWR7A2rZGxNxNk83sX2s9qO3DPPpofO/Vp269jU/FdQvjevbakV1WP
pEA0yRhqaOyjdIJPjo1WuGZaQzj4y/CbFw5DjI91NR6JaU7A1p0LwLlXdJWpY4Pp
Lwy6EP104pKoZFMs+Cjfl6fU4ChZEq+OB71LXT674znmvb6vxTvYUnGNNzjiLNsx
Cu6cezXoBjxJVbEepiL52r5qxLCMkFyfyhbciYlTUXtA0jElfLtR2d8/dRGed7b7
rAgpUGI28+Vbhq8f6RiuZjyp/d6xfg==
=CW7k
-----END PGP SIGNATURE-----

--gIS2xQmf7SqJvOH0TrAmxH4D72nSuNu5B--
