Received: from eggs.gnu.org ([209.51.188.92]:40615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbZj-0007Mx-OZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbZh-0006tY-SY
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:44:51 -0500
References: <20190110071330.28136-1-eblake@redhat.com>
	<20190110071330.28136-3-eblake@redhat.com>
	<7bead05e-672a-fdc2-6291-e72090defb66@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4482d97-637f-edcd-a37d-af708c25f567@redhat.com>
Date: Thu, 10 Jan 2019 08:44:38 -0600
MIME-Version: 1.0
In-Reply-To: <7bead05e-672a-fdc2-6291-e72090defb66@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bZdAlJ9mMGSsq9xDJsMB99e07PmD5ezpU"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd: Merge nbd_export_set_name into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bZdAlJ9mMGSsq9xDJsMB99e07PmD5ezpU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d4482d97-637f-edcd-a37d-af708c25f567@redhat.com>
Subject: Re: [PATCH v2 2/6] nbd: Merge nbd_export_set_name into nbd_export_new
References: <20190110071330.28136-1-eblake@redhat.com>
 <20190110071330.28136-3-eblake@redhat.com>
 <7bead05e-672a-fdc2-6291-e72090defb66@virtuozzo.com>
In-Reply-To: <7bead05e-672a-fdc2-6291-e72090defb66@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 4:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.01.2019 10:13, Eric Blake wrote:
>> The existing NBD code had a weird split where nbd_export_new()
>> created an export but did not add it to the list of exported
>> names until a later nbd_export_set_name() came along and grabbed
>> a second reference on the object; later, nbd_export_close()
>> drops the second reference.  But since we never change the
>> name of an NBD export while it is exposed, it is easier to just
>> inline the process of setting the name as part of creating the
>> export.
>>
>> Inline the contents of nbd_export_set_name() and
>> nbd_export_set_description() into the two points in an export
>> lifecycle where they matter, then adjust both callers to pass
>> the name up front.  Note that all callers pass a non-NULL name,
>> (passing NULL at creation was for old style servers, but we
>> removed support for that in commit 7f7dfe2a).

I need to fix that sentence:


>> -void nbd_export_set_name(NBDExport *exp, const char *name)
>> -{
>> -    if (exp->name =3D=3D name) {
>> -        return;
>> -    }
>> -
>> -    nbd_export_get(exp);
>> -    if (exp->name !=3D NULL) {
>> -        g_free(exp->name);
>> -        exp->name =3D NULL;
>> -        QTAILQ_REMOVE(&exports, exp, next);
>> -        nbd_export_put(exp);
>> -    }

In the old code, exp->name =3D=3D NULL was possible during a second
nbd_export_close(), so this conditional needs to be preserved if
nbd_export_close() can be called more than once on the same exp.

>> -    if (name !=3D NULL) {
>> -        nbd_export_get(exp);
>> -        exp->name =3D g_strdup(name);
>> -        QTAILQ_INSERT_TAIL(&exports, exp, next);
>> -    }

Whereas this conditional was only possible right after nbd_export_new(),
and was always non-NULL, hence I converted it to an assert() for a
non-NULL name and unconditional code.

>> -    nbd_export_put(exp);
>> -}
>> -
>> -void nbd_export_set_description(NBDExport *exp, const char *descripti=
on)
>> -{
>> -    g_free(exp->description);
>> -    exp->description =3D g_strdup(description);
>> -}
>> -
>>   void nbd_export_close(NBDExport *exp)
>>   {
>>       NBDClient *client, *next;
>> @@ -1568,8 +1549,14 @@ void nbd_export_close(NBDExport *exp)
>>       QTAILQ_FOREACH_SAFE(client, &exp->clients, next, next) {
>>           client_close(client, true);
>>       }
>> -    nbd_export_set_name(exp, NULL);
>> -    nbd_export_set_description(exp, NULL);
>> +    if (exp->name) {
>> +        nbd_export_put(exp);
>> +        g_free(exp->name);
>> +        exp->name =3D NULL;
>> +        QTAILQ_REMOVE(&exports, exp, next);
>=20
> exp->name is always non-zero, and _get and _INSERT_TAIL were done indep=
endently from name,
> so with these four lines done unconditionally:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Now, on to the analysis of whether the code in nbd_export_close() needs
a conditional - yes, it does. Making it unconditional breaks the fact
that we have nested referencing semantics: You can create an export,
then call nbd_export_get(exp) to hold a second reference to it for as
long as the export remains alive. The first time nbd_export_close() is
called, you are telling the NBD server to no longer advertise the export
(no new clients can connect, because exp->name is now NULL), but all
existing clients continue to access the export just fine. The second
time nbd_export_close() is called, exp->name is already NULL, and we are
closing out all existing clients (if any are left) - it's how we
implemented the nbd-server-remove safe vs. hard mode, and how we could
add the hide/soft modes in the future (see block.json:NbdServerRemoveMode=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--bZdAlJ9mMGSsq9xDJsMB99e07PmD5ezpU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw3WlYACgkQ3g5py3or
ov2t9gf/QAroPGJO5WzTS9OZhdYsWdSCDByEsPGJ7Ku2UuYYlkv3vLauBvslI+EP
72S+0wQSgofz9Sj9eXV8guK/SbRMkxIZR5HH0EzZ1Xzwa3KbuKgyC5Tou+UEa/Eh
b7jvgQzEh+O08Rcv5zBMTLPakipS8K9zKJEiOGcIEz+gbv/bX77R2A3aPZZGAevd
Kh4DTOzwQB9ZaCMDRIvotNymA96HTCmI9ZGvIJJnbPd2Z2xUEf1DG+sBiZbFv8Bv
bUO/D4B/CBlJjzlIy+Y3nRnoSi4/R6eRMBSXGmqb6DiIvDUhs9Ma3bIucBpGWvX7
MO3EMRuGoyGWfqKZ3jpk1Yic/nQNlQ==
=zlLK
-----END PGP SIGNATURE-----

--bZdAlJ9mMGSsq9xDJsMB99e07PmD5ezpU--
