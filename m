Received: from eggs.gnu.org ([209.51.188.92]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggZBn-000322-94
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggZBm-0005uc-4g
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:59:51 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
Date: Mon, 7 Jan 2019 11:59:28 -0600
MIME-Version: 1.0
In-Reply-To: <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jWrjf7NvR1U72Xyq3GzUBMGJKD1F986Pi"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jWrjf7NvR1U72Xyq3GzUBMGJKD1F986Pi
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
In-Reply-To: <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 11:50 AM, Max Reitz wrote:

>>>> Note I didn't set optreset.  It's not present in glibc and the "hard=

>>>> reset" is not necessary in this context.
>>>
>>> But it sure sounds like FreeBSD requires you to set it, doesn't it?

No.  Quoting https://www.freebsd.org/cgi/man.cgi?getopt(3)

     The variables opterr and optind are both initialized to 1.	 The opti=
nd
     variable may be set to another value before a set of calls	to
getopt() in
     order to skip over	more or	less argv entries.

so resetting it to 1 as a soft reset is no different to setting it to 2
to skip argv[1].  It just means that you didn't get the hard reset of
internal state (there is definitely internal state if argv[1] was merged
short options - but that state is cleared if you run getopt() until it
returns -1; there may also be internal state if you used extensions, but
when you don't use extensions, such internal state is irrelevant).

I think the BSD man page needs updating, and that will probably happen
if I file my promised POSIX defect.


>> At the end of the day, both GNU optind=3D0 and BSD optreset=3D1 are
>> sufficient to force a hard reset of all hidden state.  But if you don'=
t
>> use POSIX extensions, and always run getopt() until a -1 return, then
>> setting optind=3D1 is a portable soft reset, regardless of how the hid=
den
>> state is implemented, and regardless of how (or even if) libc offers a=

>> hard reset, even though POSIX itself is currently lacking that mention=
=2E
>> (I should probably file a POSIX defect to get that wording listed in P=
OSIX)
>=20
> Hm, OK?  Is there any guarantee for that behavior for FreeBSD, or is
> that just how it is?  Because the man page is very clear on it:
> "optreset must be set to 1".  It doesn't talk about soft or hard resets=

> like the glibc man page does.
>=20
> And if optreset not being available for glibc is the only issue, I'd sa=
y
> adding it as a weak global variable would work without #ifdefs.

I don't see the point - Richard has already tested that optind =3D 1
worked on BSD machines for our purposes, so we don't have to worry about
the hard reset aspect of optreset=3D1.  (But yes, it would also be nice i=
f
BSD and glibc folks could agree on how to do hard resets, instead of
having two different incompatible ways).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jWrjf7NvR1U72Xyq3GzUBMGJKD1F986Pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzk4AACgkQ3g5py3or
ov1skwf/Qxa1kJe2iyN9hUJFuBtcuZnaDdLkVI6FFtxmAt7vqt6xvZka1mKXCCZ7
iFh2SsAoPVmBi/5ugnYSTY6Bq5Bu/P0VmduK2ODuE/IUFfqxAzPSvVjo/na2t06f
EC6RCkFH5sRb3hYCZhsSQc0iOoSGZYNa5BvT+mmgVQxlJt+UYT+DHYRVawAscrwd
ZlnCtGuIy/BSxrtzX8G9lBDw6G8sP68gZm6mOC7s0rorao+kxbhA5JthNrBJDVMU
k9NuwgjTYPAdPl5mFGJ4lmsexrVQRhstSKpvBIRX1OHYWgsTDUjNCfDxQHiegY2k
OxXQiS9v9KvIUeMe5NeXxXJ7vg+HFQ==
=WY+V
-----END PGP SIGNATURE-----

--jWrjf7NvR1U72Xyq3GzUBMGJKD1F986Pi--
