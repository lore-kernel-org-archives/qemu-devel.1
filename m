Received: from eggs.gnu.org ([209.51.188.92]:38173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghD0Y-0001Z1-14
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghD0W-0006rL-PM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:30:54 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
	<b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
	<0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa7cdff7-64ff-5d1b-f4e2-288fa3e82e44@redhat.com>
Date: Wed, 9 Jan 2019 13:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tSFgA2LdMTufiFEcLxsn9pxQZs7B9KS7x"
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
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tSFgA2LdMTufiFEcLxsn9pxQZs7B9KS7x
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <fa7cdff7-64ff-5d1b-f4e2-288fa3e82e44@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
 <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
 <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
 <0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
In-Reply-To: <0b9f2b6f-4838-7f7f-0fb3-be65a359936b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.01.19 19:45, Eric Blake wrote:
> On 1/7/19 12:14 PM, Max Reitz wrote:
>> On 07.01.19 18:59, Eric Blake wrote:
>>> On 1/7/19 11:50 AM, Max Reitz wrote:
>>>
>>>>>>> Note I didn't set optreset.  It's not present in glibc and the "h=
ard
>>>>>>> reset" is not necessary in this context.
>>>>>>
>>>>>> But it sure sounds like FreeBSD requires you to set it, doesn't it=
?
>>>
>>> No.  Quoting https://www.freebsd.org/cgi/man.cgi?getopt(3)
>>>
>>>      The variables opterr and optind are both initialized to 1.	 The =
optind
>>>      variable may be set to another value before a set of calls	to
>>> getopt() in
>>>      order to skip over	more or	less argv entries.
>>>
>>> so resetting it to 1 as a soft reset is no different to setting it to=
 2
>>> to skip argv[1].
>>
>> In theory it is very much different because the text clearly says "in
>> order to skip", not "in order to re-parse or use a different argv".
>> Especially the fact that we use different argvs is something that
>> implementations may not expect.
>=20
> Consider the following input:
>=20
> ./prog -ab -cd -ef
>=20
> against
>=20
> while ((opt =3D getopt(argc, argv, "abcdef")) !=3D -1) {
>   switch (opt) {
>    case 'a': case 'b': case 'f': break;
>    case 'c': optind =3D 3; break;
>    case 'd': case 'e': abort();
>   }
> }
>=20
> What does that do on BSD?  On glibc, after the third call, optind is
> still 2 (but I hard-set it to 3), then the fourth call returns 'd' and
> increments optind to 4, before abort()ing, never reaching 'e' or 'f'.
> But if BSD goes from 'c' to 'f' and skips 'd' and 'e', it is because BS=
D
> tracks internal state differently from glibc.  Either way, the fact tha=
t
> setting optind =3D 3 does NOT make glibc return 'e' or 'f' means that I=

> did NOT skip ahead to argument 3 (glibc still returned 'd' then skipped=

> to argument 4; either BSD does the same, or BSD skips to 'f'), and thus=

> I can argue that the BSD man page is incomplete, and SHOULD be correcte=
d
> to mention that assigning to optind to skip to a future argument is saf=
e
> ONLY when the hidden state is not affected by being mid-parse of merged=

> short options.  But how do you get out of the hidden state of merged
> short options? By parsing until getopt() returns -1.  And once you've
> reached that point, then hidden state is clear, and skipping backwards
> is just as reasonable as skipping forwards.

Is it?

Why wouldn't FreeBSD just set optind to -1 at that point and just have
an "if (optind < 0) { return -1; }" at the beginning of getopt(),
without having cleared the internal state?

I agree that the variable _sp you define below should be reset, because
that is the sane thing to do whenever you jump to a new index in argv[]
(i.e. a new optind).  But that doesn't guarantee to me that there isn't
additional state that may not be cleared.

No, I cannot imagine why there should be such additional state.  I'm
just arguing based on the interface description, i.e. the man page.

>>> I think the BSD man page needs updating, and that will probably happe=
n
>>> if I file my promised POSIX defect.
>>
>> Sure.  But as it is, it doesn't tell me that resetting optind to 1 is
>> sufficient to be able to parse a new argv.
>=20
> But arguing that something that worked for Richard's testing is wrong,
> without reading the BSD source code, isn't going to help us either.

Come on, it's not like I'm demanding something impossible when I'm
asking for a weak global optreset. ;-)

>>> I don't see the point - Richard has already tested that optind =3D 1
>>> worked on BSD machines for our purposes, so we don't have to worry ab=
out
>>> the hard reset aspect of optreset=3D1.
>>
>> Well, and as far as I remember glibc's memcpy() at one point only copi=
ed
>> in one direction and things broke badly once they reversed it at some
>> point for some CPUs.
>=20
> That was because of buggy software that didn't read the function
> contracts, and should have been using memmove( insta

Well, and right now this here is a patch that does not conform to the
function contract and that should use optreset =3D 1 in addition.

You're arguing with "Why would it not work?".  And I just feel like you
could have argued the same for memcpy(), "Why would it copy backwards?".

Please don't take this as an accusation, but I feel like you are trying
to make a point of how the standard should be.  I can fully understand
that, but I personally don't feel like qemu is the place to make such a
point (until the standard truly has been fixed).

Sure, this is a minor issue and I don't mind if someone else (i.e.
Kevin) merges it.  But maybe I want to make a point, too, which is to
take interface descriptions as they are, not as they should be.  Making
the interface more nice for all user software is distinct from making
our user software just assume it is nice already.

>> Just because it works now doesn't mean it will work always if the
>> specification allows for different behavior.
>=20
> Yes, but that's why I need to file a POSIX defect, so that BSD won't
> change their current behavior because POSIX will require the soft reset=

> behavior.
>=20
> Here's the current thread on the POSIX list:
> https://www.mail-archive.com/austin-group-l@opengroup.org/msg03210.html=

>=20
> which I hope to turn into a formal defect soon.

Thanks!

Max


--tSFgA2LdMTufiFEcLxsn9pxQZs7B9KS7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw16V8ACgkQ9AfbAGHV
z0AbsAf/a2yx2oWdnmJD+AUEqBVQUIcc+oVpgPrIUkLOykOh2AqYcB5Hc7dY5PTj
s2qknDJUC8Yl9ZlLPJVFDw3qqToAAqD/rhgBdmiYGQE3p2LmiKE9w/VPx3Gs5iiO
fzi0aiKbvV0rzdjkgTLGOY/vOgN37P8DpEX+y+GBSddArwMXoradN/vCi4bTve7q
yOOzFfSC/80VQGeGSjNQde7NcovZ3+//miMcZXACh3ZFOxCXbLdpbdKZxLU3WIj8
BqkVcnjm4sKwnWFXrw46IxJF3O5dB3c/TY4UV119kpyNsjJBP97o8w1onJG2eUe8
aU74kM8Oe/2lbAC2xRB2jRJKfyUJSA==
=0aj5
-----END PGP SIGNATURE-----

--tSFgA2LdMTufiFEcLxsn9pxQZs7B9KS7x--
