Received: from eggs.gnu.org ([209.51.188.92]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goh4L-0007wp-Dr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 23:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goh4K-0007Zk-GB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 23:01:45 -0500
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
Date: Tue, 29 Jan 2019 22:01:39 -0600
MIME-Version: 1.0
In-Reply-To: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N1DIPdnvCRYN3tlXs33lzF5P8i2qeNHDn"
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
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1DIPdnvCRYN3tlXs33lzF5P8i2qeNHDn
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>
Message-ID: <00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
Subject: Re: [PATCH v8 0/2] qemu-img info lists bitmap directory entries
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 12:40 PM, Andrey Shinkevich wrote:
> Here is the update for the bitmap extension of the qcow2 specific
> information as the output of the 'qemu-img info' command.
> The version #7 was in email with the message ID:
> <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>=20
> v8:
> The output benchmark files for the qemu-iotests, namely 060, 065 082, 1=
98
> and 206, were modified to show the bitmap extension for the qemu specif=
ic
> information. A new test file 239 was added to the test set that checks =
the
> output for the fields of the bitmap section.
> The backward compatibility of the output for images of the version 2
> of qcow2 was added.

So, I'm trying to test this, and I've discovered something rather
annoying about persistent snapshots: they DON'T get written to disk
until the qemu process exits.  In other words, even after creating a
persistent bitmap via QMP (I'm trying to debug my libvirt API for
incremental snapshots, so I did this via 'virsh snapshot-create-as $dom
name', but it boils down to a QMP transaction with
'block-dirty-bitmap-add' as one of the commands), running:

$ qemu-img info -U Active1.qcow2

shows
    bitmaps:
    refcount bits: 16

for as long as the qemu process is running. What does it take to force a
qcow2 image to write out its current set of known bitmaps to disk, even
if they are known to be potentially dirty? Should it happen any time we
flush L1/L2/refcount tables?  On a periodic but slow timer (say once
every 5 minutes)? Other ideas?  I know we don't want to be flushing the
full bitmap contents on every change to the in-memory internal bitmap,
but meta-changes (such as adding a bitmap) seem like the sort of thing
where it's worth flushing the qcow2 file; particularly when adding the
bitmap via QMP 'transaction' which goes to the bother of flushing all
pending I/O in order to properly roll back on failure (which means on
success, it would be nice for the new bitmap name to show up in the
qcow2 header, even if the contents of the bitmap are not up-to-date).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--N1DIPdnvCRYN3tlXs33lzF5P8i2qeNHDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxRIaMACgkQp6FrSiUn
Q2rYXgf/UAfTG4otK7mkrfxGOsk66VloiCqVVbavRBaKV2bNKzBHtlEOqKJButID
HqSIoOFYUixpaM7Ll330D/uKXyHBtFiFk/KKKhYc7OALK2ZIsVhBLSf2h9Ra3PhP
c2BJ1syRTVCBILMsIjat+CEdrFqRMjYdq8MDKtOfNJHUEKJUl/7b1zkj8ZY9J/wn
oK8GTjh5CYLaScAvHZpA+q0TfsA5fCtG7cX3RYn7ZDEmH9Nbu3VXHn9kzuo+SjMf
m67GkLlc/LgJFXfwrsfVY9aE77nxCoAErsvxfbmc4f5aadGTAx9rLoVRfmlvK+kV
y726IKE7J17kkgoWbDBywDCX5pIL9A==
=sbQI
-----END PGP SIGNATURE-----

--N1DIPdnvCRYN3tlXs33lzF5P8i2qeNHDn--
