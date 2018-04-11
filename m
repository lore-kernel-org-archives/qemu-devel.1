Received: from eggs.gnu.org ([2001:4830:134:3::10]:34645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6FP7-0006ye-5A
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6FP1-0006yl-QB
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6FP1-0006y4-Di
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:03:07 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
	<20180411073638.GA10940@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e51f584-b850-9881-a8e1-3dafa85a11df@redhat.com>
Date: Wed, 11 Apr 2018 08:02:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180411073638.GA10940@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fvfFSstSY5oKicD7deRErzsPGiF8CdA9n"
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fvfFSstSY5oKicD7deRErzsPGiF8CdA9n
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org
Message-ID: <6e51f584-b850-9881-a8e1-3dafa85a11df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
 <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
 <20180411073638.GA10940@ruderich.org>
In-Reply-To: <20180411073638.GA10940@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 02:36 AM, Simon Ruderich wrote:
> On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
>>> +void qmp_pmemload(int64_t addr, int64_t size, const char *filename,
>>> +                  Error **errp)
>>> +{
>>> +    FILE *f;
>>> +    size_t l;
>>> +    uint8_t buf[1024];
>>> +
>>> +    f =3D fopen(filename, "rb");
>>
>> Use qemu_fopen() here, so that you can automagically support /dev/fdse=
t/
>> magic filenames that work on file descriptors passed via SCM_RIGHTS.
>=20
> Hello,
>=20
> I can't find qemu_fopen() in the source. Did you mean
> qemu_open()?

Looks like you're right; we don't have an automatic FILE wrapper.

> From reading qemu_close() I guess that I can't use
> fdopen() (as there's no qemu_fclose()) but must work with the raw
> fd. Or is there an easy way to fdopen? (I prefer the FILE *
> interface which is easier to work with.)

You could always add qemu_fopen/qemu_fclose to match the existing
qemu_open/qemu_close.  But you do have a point that you can't call
qemu_close/fclose (because fclose would be left with a stale fd that
might spuriously close something that has been opened in another thread
during the race window), nor fclose/qemu_close.

The FILE interface may sometimes be easier to work with, but it also
comes with buffering issues that you don't have to worry about when
using the fd interface.

>=20
> But I just copied the code from qmp_pmemsave. Should I change it
> as well to use qemu_open()?

Good point - but yes, ideally it should always be possible to pass in an
fd instead of having qemu itself open a file, because there are
execution environments where qemu is intentionally prohibited from
directly calling open() for security reasons (where the management app,
such as libvirt, opens and then passes fds to qemu instead).


>>> +##
>>> +# @pmemload:
>>> +#
>>> +# Load a portion of guest physical memory from a file.
>>> +#
>>> +# @val: the physical address of the guest to start from
>>
>> Is 'val' really the best name for this, or would 'phys-addr' or simila=
r
>> be a more descriptive name?
>=20
> I copied it from pmemsave to keep the argument names consistent.
> Should I change it only for pmemload? Changing it for pmemsave is
> problematic as it will break the existing API.

You are correct that we can't really change the existing interface; so
documenting in the commit message that your choice of names is for
consistency reasons may be sufficient.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fvfFSstSY5oKicD7deRErzsPGiF8CdA9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOB4IACgkQp6FrSiUn
Q2p22AgAnjg+dSaHlmmUGIdIXjV5xJSZm4ekIRe6YPR2FVYOUEqo8WL4Kq9bgDET
vq0mBKXTVfkEbTjIBpXTAemDNrOmm9wDdN8RW4s/lo4oGChHmmGuibEyNPDZo3ui
v3FfYb5jSwPucjbeDyEyYSJd0Dt/A4+NShChdpUj0GfZNtJS705kr3gpbXnGm8mc
ndr6hc9GcW2VQfqCK6E57BJ7rNzOfQgp3GFXde2me5BJ7N3QS++8RZ0KQjVUnlcb
XUSyEBZ+CSgpikuFno5BoH2kQy2F7qSJMOj6L3kg7gVIb6aRivogflOpYvWikO9q
wdBjC2SPAlqSHLpNdoJ5xEnYPRVbOw==
=boJj
-----END PGP SIGNATURE-----

--fvfFSstSY5oKicD7deRErzsPGiF8CdA9n--
