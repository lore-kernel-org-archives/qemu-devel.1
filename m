Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbS97-0000cK-Em
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbS96-0005Uv-6i
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:18:53 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-15-famz@redhat.com>
	<f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
	<20170208060033.GC13286@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e4b256b-caed-82d5-6ab6-5ee7396c788d@redhat.com>
Date: Wed, 8 Feb 2017 14:18:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170208060033.GC13286@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9IkCMhj1LGkJAkwVHm1VJNv4D4srT31Ah"
Subject: Re: [Qemu-devel] [PATCH v12 14/16] file-posix: Implement image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9IkCMhj1LGkJAkwVHm1VJNv4D4srT31Ah
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 rjones@redhat.com
Message-ID: <3e4b256b-caed-82d5-6ab6-5ee7396c788d@redhat.com>
Subject: Re: [PATCH v12 14/16] file-posix: Implement image locking
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-15-famz@redhat.com>
 <f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
 <20170208060033.GC13286@lemon.lan>
In-Reply-To: <20170208060033.GC13286@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 07:00, Fam Zheng wrote:
> On Wed, 02/08 04:05, Max Reitz wrote:
>>> +static int raw_lt_write_to_write_share(RawLockTransOp op,
>>> +                                       int old_lock_fd, int new_lock=
_fd,
>>> +                                       BDRVRawLockMode old_lock,
>>> +                                       BDRVRawLockMode new_lock,
>>> +                                       Error **errp)
>>> +{
>>> +    int ret =3D 0;
>>> +
>>> +    assert(old_lock =3D=3D RAW_L_WRITE);
>>> +    assert(new_lock =3D=3D RAW_L_WRITE_SHARE_RW);
>>> +    /*
>>> +     *        lock byte "no other writer"      lock byte "write"
>>> +     * old                X                           X
>>> +     * new                0                           S
>>> +     *
>>> +     * (0 =3D unlocked; S =3D shared; X =3D exclusive.)
>>> +     */
>>> +    switch (op) {
>>> +    case RAW_LT_PREPARE:
>>> +        break;
>>> +    case RAW_LT_COMMIT:
>>> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, fa=
lse);
>>> +        if (ret) {
>>> +            error_report("Failed to downgrade old fd (share byte)");=

>>> +            break;
>>> +        }
>>> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, fa=
lse);
>>> +        if (ret) {
>>> +            error_report("Failed to unlock new fd (share byte)");
>>> +            break;
>>> +        }
>>
>> The second one is not an "unlock", but a new shared lock.
>=20
> You are right.
>=20
>> Which brings
>> me to the point that both of these commands can fail and thus should b=
e
>> in the prepare path.
>=20
> We cannot. If we lose the exclusive lock already in prepare, and some o=
ther
> things fail later in the transaction, abort() may not be able to restor=
e that
> lock (another process took a shared lock in between).
>=20
> The reason for my code is, the lock semantics implies both of these com=
mands can
> succeed, so it doesn't hurt if we ignore ret codes here. I'm just tryin=
g to
> catch the very unlikely abnormalities.

Indeed. Well, then raw_lt_write_to_read() should do the same, though.

Max

>> (This function should be a mirror of raw_lt_write_to_read, if I'm not
>> mistaken.)
>>
>>> +        break;
>>> +    case RAW_LT_ABORT:
>>> +        break;
>>> +    }
>>> +    return ret;
>>> +}
>=20
> Fam
>=20



--9IkCMhj1LGkJAkwVHm1VJNv4D4srT31Ah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibGrESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMG0H/RApldQGoK1zG0sVhzyvdcdBCgCKuLer
i3vR1tuJfXyA7smXGUhdaewqKrhRzKm9q6fex30wEUytDc9nJSDHZJjDCiTkeGM2
K0NJOTyISMLQfajmehe1HkFXSJBJe3adKQNvDtXu/XSIrF6m+jLiONJJkwef4dOd
LZFbmuLPvQGQ1uvQ+aYr36WfOkxOtrYAOegzfSrJsjZw/RTSsB2tbv6y8x54K8hg
8dUQTS+TRBM8KjTA/sVwAusZBVIJm/VD2xuIMpKTCIG0LfiGQrkT9tvqDhv+HydV
ev19el59t0iOfTuCuKBjO/OYv3nHmHRgPnoMlyKgSeUmCaS7URU+DlY=
=sXxa
-----END PGP SIGNATURE-----

--9IkCMhj1LGkJAkwVHm1VJNv4D4srT31Ah--
