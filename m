Received: from eggs.gnu.org ([2001:4830:134:3::10]:36410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjqL4-00089d-CB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjqKz-0008Ax-PD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:45:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjqKz-0008A5-FQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:45:49 -0500
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
	<e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a93c2a39-6e10-331c-599a-81a7d8f2f52e@redhat.com>
Date: Fri, 3 Mar 2017 10:45:46 -0600
MIME-Version: 1.0
In-Reply-To: <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="46HWIu5Qrd7U542MwKQieLh7r2iucfADH"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--46HWIu5Qrd7U542MwKQieLh7r2iucfADH
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Greg Kurz <groug@kaod.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Message-ID: <a93c2a39-6e10-331c-599a-81a7d8f2f52e@redhat.com>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
 <8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
 <20170303164426.42472535@bahia.lan>
 <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
 <20170303162128.GD13631@redhat.com>
 <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
In-Reply-To: <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 10:40 AM, Eric Blake wrote:

>> Isn't the use of O_PATH required in order to fix the recent
>> security vulnerability in 9p ?  If so, then defining it to
>> 0 means the QEMU is silently becoming vulnerable once again
>> which I don't think is a good idea.
>=20
> My understanding is that O_PATH is an optimization. It lets openat()
> succeed in some places where it would ordinarily fail (for example, it
> can be used to open a dir with mode 0000) - the resulting fd is
> limited-use (it cannot be used to read() or write(), but CAN be used as=

> the relative fd for a subsequent openat(), for example).  If you define=

> O_PATH to 0, then attempts to traverse paths will fail where the could
> have otherwise succeeded, but failure is okay (the CVE was that we were=

> succeeding at opening through a guest-controlled symlink; whether we no=
w
> fail or guarantee that we are not going through a symlink is a quality
> of implementation, but either way, we are at least immune from
> succeeding through a symlink).

[I hit send too soon]

To put it in perspective, the 9p fixes included code for chmod() that
falls back to fchmodat() - but Linux' fchmodat() is broken (it is not
POSIX-compliant in that there is no race-free way to use
AT_SYMLINK_NOFOLLOW, at least not until Greg gets his kernel patches
approved that implement the fchmodat2() syscall [1]).  The symptoms are
that we now have cases where the guest will get failures where they
could have otherwise succeeded if fchmodat() were not broken, but such
cases are limited to corners where permissions are overly-tight; in the
common case, the permissions will allow opening the file with O_RDONLY
or O_WRONLY and fchmod() can be used.

So a limited-use fix for the CVE that safely succeeds without symlinks
in the common case but fails in the corner case of tight permissions
(which is what defining O_PATH to 0 would do) is better than the pre-CVE
state of code that succeeds but risks going through a user-controlled
symlink.

[1] https://lkml.org/lkml/2017/2/28/461

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--46HWIu5Qrd7U542MwKQieLh7r2iucfADH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZ26AAoJEKeha0olJ0NqPb0IAKnzHsMM9nMQh1V2WLsLW6/d
buXhQWB/kifD7nF8iXcPt5A/fIqGVG86eLzMK03qCIG0nQnyRLvoiQtSBrdHaE2t
PpLRGH7ioHhWSJuDn2uP7kFgGHV3v+58Ntsu4TfyI3H2hzuyp80mkRGTDsIBCbvJ
tUYp7nSGgNHVao8HqAGEC9dRK6gNm8mEhRqsPTqjJ7nu7JR1Vsn5pnTLl3bGoKyu
M0QVoUKHwFebRU0bjezE6I8c5MEm5krzl19p86RIeuk4ypWo74aS8+XzePw+aWtS
8/X72CIBqYOOvev0Y4U9PhBt+cxtnk0tv1DT9m0gTsaqObGgZVPAug597IVogww=
=AyBU
-----END PGP SIGNATURE-----

--46HWIu5Qrd7U542MwKQieLh7r2iucfADH--
