Received: from eggs.gnu.org ([209.51.188.92]:45513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggZu4-0007YN-R8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggZu3-0003yD-Fz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:45:36 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
	<b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
Date: Mon, 7 Jan 2019 12:45:29 -0600
MIME-Version: 1.0
In-Reply-To: <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6qhq9vZJ4JHCDNNdnUIiPMuVMIOpX92qI"
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
--6qhq9vZJ4JHCDNNdnUIiPMuVMIOpX92qI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
 <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
 <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
In-Reply-To: <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 12:14 PM, Max Reitz wrote:
> On 07.01.19 18:59, Eric Blake wrote:
>> On 1/7/19 11:50 AM, Max Reitz wrote:
>>
>>>>>> Note I didn't set optreset.  It's not present in glibc and the "ha=
rd
>>>>>> reset" is not necessary in this context.
>>>>>
>>>>> But it sure sounds like FreeBSD requires you to set it, doesn't it?=

>>
>> No.  Quoting https://www.freebsd.org/cgi/man.cgi?getopt(3)
>>
>>      The variables opterr and optind are both initialized to 1.	 The o=
ptind
>>      variable may be set to another value before a set of calls	to
>> getopt() in
>>      order to skip over	more or	less argv entries.
>>
>> so resetting it to 1 as a soft reset is no different to setting it to =
2
>> to skip argv[1].
>=20
> In theory it is very much different because the text clearly says "in
> order to skip", not "in order to re-parse or use a different argv".
> Especially the fact that we use different argvs is something that
> implementations may not expect.

Consider the following input:

=2E/prog -ab -cd -ef

against

while ((opt =3D getopt(argc, argv, "abcdef")) !=3D -1) {
  switch (opt) {
   case 'a': case 'b': case 'f': break;
   case 'c': optind =3D 3; break;
   case 'd': case 'e': abort();
  }
}

What does that do on BSD?  On glibc, after the third call, optind is
still 2 (but I hard-set it to 3), then the fourth call returns 'd' and
increments optind to 4, before abort()ing, never reaching 'e' or 'f'.
But if BSD goes from 'c' to 'f' and skips 'd' and 'e', it is because BSD
tracks internal state differently from glibc.  Either way, the fact that
setting optind =3D 3 does NOT make glibc return 'e' or 'f' means that I
did NOT skip ahead to argument 3 (glibc still returned 'd' then skipped
to argument 4; either BSD does the same, or BSD skips to 'f'), and thus
I can argue that the BSD man page is incomplete, and SHOULD be corrected
to mention that assigning to optind to skip to a future argument is safe
ONLY when the hidden state is not affected by being mid-parse of merged
short options.  But how do you get out of the hidden state of merged
short options? By parsing until getopt() returns -1.  And once you've
reached that point, then hidden state is clear, and skipping backwards
is just as reasonable as skipping forwards.


>> I think the BSD man page needs updating, and that will probably happen=

>> if I file my promised POSIX defect.
>=20
> Sure.  But as it is, it doesn't tell me that resetting optind to 1 is
> sufficient to be able to parse a new argv.

But arguing that something that worked for Richard's testing is wrong,
without reading the BSD source code, isn't going to help us either.

>> I don't see the point - Richard has already tested that optind =3D 1
>> worked on BSD machines for our purposes, so we don't have to worry abo=
ut
>> the hard reset aspect of optreset=3D1.
>=20
> Well, and as far as I remember glibc's memcpy() at one point only copie=
d
> in one direction and things broke badly once they reversed it at some
> point for some CPUs.

That was because of buggy software that didn't read the function
contracts, and should have been using memmove( insta

>=20
> Just because it works now doesn't mean it will work always if the
> specification allows for different behavior.

Yes, but that's why I need to file a POSIX defect, so that BSD won't
change their current behavior because POSIX will require the soft reset
behavior.

Here's the current thread on the POSIX list:
https://www.mail-archive.com/austin-group-l@opengroup.org/msg03210.html

which I hope to turn into a formal defect soon.

>=20
>> (But yes, it would also be nice if
>> BSD and glibc folks could agree on how to do hard resets, instead of
>> having two different incompatible ways)
> I don't see why we should have a general code path if there is no
> standard way of resetting getopt() other than "This seems to work".
> What's so bad about a weak optreset or an
> "#ifdef __FreeBSD__; optreset =3D 1; #endif"?
>=20
> Sure, if you can get POSIX to define the fact that optind =3D 1 after
> getopt() =3D=3D -1 will be sufficient to start parsing a new argv, that=
'd be
> great.  But there is no such standard yet (other than "Why would that
> not work?").


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6qhq9vZJ4JHCDNNdnUIiPMuVMIOpX92qI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwznkkACgkQ3g5py3or
ov0/eQf+K14ybaWBLEFsUNMD7osB84lPKhJXElUeQ1c9ZXZEeVgR/5QJPNET0iXX
wxanOdJzC/VFy0IUI4d+xI5n7IaLZdF7g4ULnoKQWjpZvcKajiVhamn76Xjh4FSV
OYgUQshInefyl74zXvxDsNNN6Po/B/3DYdPmyW00j+8zFBJMWFl/t62MN9/LbhKy
gfXZiE7ji8nZ+h6M54+WEBUgvL9omDEYkWdVZCJpONvCqbNkpNASJA3ohwGPD3pF
H3xpQjhLZ7mxH/aaGayfmD0tAg9wVfzRXCC67lR565Nt5xYZr5VmSDSSvrbsFXU9
FEAVm+DqdvNv7IkxSYDerTOWDKbofg==
=Mnxc
-----END PGP SIGNATURE-----

--6qhq9vZJ4JHCDNNdnUIiPMuVMIOpX92qI--
