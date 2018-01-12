Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea0Sy-0007IZ-OA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea0Sx-0001xC-Ia
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:37:56 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-6-eblake@redhat.com>
	<76132a6d-3d2f-92ba-d05d-93c20dbe9025@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec35cf28-6e7c-efed-a5d9-dd5a501d8800@redhat.com>
Date: Fri, 12 Jan 2018 08:37:45 -0600
MIME-Version: 1.0
In-Reply-To: <76132a6d-3d2f-92ba-d05d-93c20dbe9025@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YDRheeTFkgZV9yJyK2MYJ01WcJyLwvdyb"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] nbd/server: Add helper functions
 for parsing option payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YDRheeTFkgZV9yJyK2MYJ01WcJyLwvdyb
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec35cf28-6e7c-efed-a5d9-dd5a501d8800@redhat.com>
Subject: Re: [PATCH v2 5/6] nbd/server: Add helper functions for parsing
 option payload
References: <20180110230825.18321-1-eblake@redhat.com>
 <20180110230825.18321-6-eblake@redhat.com>
 <76132a6d-3d2f-92ba-d05d-93c20dbe9025@virtuozzo.com>
In-Reply-To: <76132a6d-3d2f-92ba-d05d-93c20dbe9025@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 04:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.01.2018 02:08, Eric Blake wrote:
>> Rather than making every callsite perform length sanity checks
>> and error reporting, add the helper functions nbd_opt_read()
>> and nbd_opt_drop() that use the length stored in the client
>> struct; also add an assertion that optlen is reduced to zero
>> after each option is handled.
>>
>> Note that the call in nbd_negotiate_handle_export_name() does
>> not use the new helper (in part because the server cannot
>> reply to NBD_OPT_EXPORT_NAME - it either succeeds or the
>> connection drops).
>>

>>
>> +/* Drop remainder of the current option, after sending a reply with
>=20
> looks a bit weird: actually you drop the remainder _before_ sending a
> reply)

Good catch. I'll fix it with s/after/and/

>=20
>> + * the given error type and message. Return -errno on read or write
>=20
> also, unrelated note, -errno is always forced to -EIO, because of
> nbd_read realization.
> and this note applies to many other places here. It is correct (EIO is
> errno, why not?),
> but it may be not bad to note it somewhere..

Someday nbd_read() might fail with something other than EIO (ESHUTDOWN,
perhaps?), in which case leaving this documented as -errno would be
better than hardcoding that EIO is the only failure for now.

>> @@ -812,14 +819,9 @@ static int nbd_negotiate_options(NBDClient
>> *client, uint16_t myflags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 default:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (nbd_drop(client->ioc, length, errp) < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_rep_err(client,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBD=
_REP_ERR_UNSUP,
>> errp,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Un=
supported option
>> 0x%"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PRI=
x32 " (%s)", option,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> nbd_opt_lookup(option));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_drop(client, NBD_REP_ERR_UNSUP, err=
p,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Unsupported=
 option 0x%" PRIx32 "
>> (%s)",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 option, nbd_=
opt_lookup(option));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> @@ -842,6 +844,7 @@ static int nbd_negotiate_options(NBDClient
>> *client, uint16_t myflags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!client->optlen);
>=20
> isn't it from 2/6?

No, this is a second instance of the assertion, the one that applies
between each option (which I couldn't do in 2/6 because not all options
were manipulating optlen back then).  Maybe I can tweak the commit
messages to make that more obvious.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>=20
> anyway,
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for the careful attention to detail.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--YDRheeTFkgZV9yJyK2MYJ01WcJyLwvdyb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpYyDkACgkQp6FrSiUn
Q2oxWwf/Q6xAfiZwG4/npZnzPMloYbnaS0NW0mj7dPjuPiXh6aTsCnaebg7fJpTP
TnjoQADYvEVOXLXQ4m6BijBJrwXSR33W6T+29ObNqcFnYiY2mHZSlhsxpFamSGCm
wJ+RJ/iI8DnIFkNFf/92dFIO+T6jFrhF65NYPK8W6MshqHzrcL016S/r2bH/cN/0
oD45yWWu5YOjY3LbnKPyxvO7xkn/LgZ+mZpVyE3SnhPPUCv6EpcoiwuWuK3QrAA0
p0dIjGZt+0y2CQVvmMajb8OSALRp89fti4KMvt6IwOD/Cr0OPn/InRpGBPmdakAD
gFg+xwt8BxJYLrlccD/BpNzqUYwXvg==
=g58J
-----END PGP SIGNATURE-----

--YDRheeTFkgZV9yJyK2MYJ01WcJyLwvdyb--
