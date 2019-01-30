Received: from eggs.gnu.org ([209.51.188.92]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gopDf-0005VX-PK
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gopDe-0006n4-T6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:43:55 -0500
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
	<8e49d7d5-9608-9e40-a997-1d423f86fab1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <982d9998-e9d5-9c41-9ab6-74f893254b33@redhat.com>
Date: Wed, 30 Jan 2019 06:43:28 -0600
MIME-Version: 1.0
In-Reply-To: <8e49d7d5-9608-9e40-a997-1d423f86fab1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DMwJgzWZVIvEXLwvWAES21BpgxJwKyRG5"
Subject: Re: [Qemu-devel] [PATCH v8 0/2] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DMwJgzWZVIvEXLwvWAES21BpgxJwKyRG5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <982d9998-e9d5-9c41-9ab6-74f893254b33@redhat.com>
Subject: Re: [PATCH v8 0/2] qemu-img info lists bitmap directory entries
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
 <8e49d7d5-9608-9e40-a997-1d423f86fab1@virtuozzo.com>
In-Reply-To: <8e49d7d5-9608-9e40-a997-1d423f86fab1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 2:00 AM, Vladimir Sementsov-Ogievskiy wrote:

>> So, I'm trying to test this, and I've discovered something rather
>> annoying about persistent snapshots: they DON'T get written to disk
>> until the qemu process exits.  In other words, even after creating a
>> persistent bitmap via QMP (I'm trying to debug my libvirt API for
>> incremental snapshots, so I did this via 'virsh snapshot-create-as $do=
m
>> name', but it boils down to a QMP transaction with
>> 'block-dirty-bitmap-add' as one of the commands), running:
>>
>> $ qemu-img info -U Active1.qcow2
>>
>> shows
>>      bitmaps:
>>      refcount bits: 16
>>
>> for as long as the qemu process is running.

>=20
> But what is the benefit of it, except qemu-img info with --force-share =
option,
> which of course is not guaranteed to show valid metadata?
>=20
> While qemu is running valid way to obtain info is qmp. Do libvirt call =
qemu-img
> --fore-share?

You're right that libvirt will be using QMP and not qemu-img. But that
does not prevent other clients from using qemu-img on a file, regardless
of whether the file is in use by a guest. There's also the argument that
if qemu dies suddenly (most likely due to a bug or to a host being
fenced), knowing what bitmaps were present in the image is better than
having nothing at all (but conversely, if qemu dies suddenly, you are
likely missing the bitmap data for the most recent changes, so even if
disabled bitmaps are flushed and no longer marked in-use, they still
won't be sufficient to allow an incremental backup, and a full backup
will be necessary regardless of how much or little bitmap information
got persisted).

While you're right that --force-share is not required to show up-to-date
metadata, it also is not required to show nothing at all.  And at least
knowing that a persistent bitmap is associated with a qcow2 file may
make other things obvious - such as the fact that the image can't be
resized (until we implement the functionality to support resize and
bitmaps in the same image).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--DMwJgzWZVIvEXLwvWAES21BpgxJwKyRG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxRm/AACgkQp6FrSiUn
Q2rM2Af+M2xqPQSBQNEW707/kpOUWHwWSxkgjgI4mWKao5FWcVPLAWdDf2mcarcG
qkwqgg64LH35znoqdiIMt7P20/trU9Js4S6pHCyzOmujvL5bdSUpfXB0DaggN8Gi
osn6D+Y95kvMSoBNUH1Grp/C1Lo30fN14hc6DQ/vKPy4DcsQz3A4x6sIXJcIL3P3
iKWcUThTNPldbY49V+SlWfviZpuFR2daO1ETFo/xrzOQum1aM0sGmI9ZZh8PeUlf
OWawCJClaUxDXhNsxiIgt9dUUDOyYPn9vnUdc5ia5h4hsTC0H6amc0MWI9aV3Iq/
g5r7zJfeXu0BSLXEb3jrnoP86ZM70Q==
=zKHB
-----END PGP SIGNATURE-----

--DMwJgzWZVIvEXLwvWAES21BpgxJwKyRG5--
