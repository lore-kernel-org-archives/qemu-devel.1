Received: from eggs.gnu.org ([209.51.188.92]:33770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZQN-0008H0-2f
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZQ7-00080R-CL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:14:42 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
Date: Mon, 7 Jan 2019 19:14:09 +0100
MIME-Version: 1.0
In-Reply-To: <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZhnRHJwLvoGjBYNFojC1fEb6uQUMwkr5c"
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
--ZhnRHJwLvoGjBYNFojC1fEb6uQUMwkr5c
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <b52f88bd-754e-d5ea-844b-cb05a4bbd9a7@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
 <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
In-Reply-To: <94a72d7e-a8c9-09d4-fad3-00b09ffd7eb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.01.19 18:59, Eric Blake wrote:
> On 1/7/19 11:50 AM, Max Reitz wrote:
>=20
>>>>> Note I didn't set optreset.  It's not present in glibc and the "har=
d
>>>>> reset" is not necessary in this context.
>>>>
>>>> But it sure sounds like FreeBSD requires you to set it, doesn't it?
>=20
> No.  Quoting https://www.freebsd.org/cgi/man.cgi?getopt(3)
>=20
>      The variables opterr and optind are both initialized to 1.	 The op=
tind
>      variable may be set to another value before a set of calls	to
> getopt() in
>      order to skip over	more or	less argv entries.
>=20
> so resetting it to 1 as a soft reset is no different to setting it to 2=

> to skip argv[1].

In theory it is very much different because the text clearly says "in
order to skip", not "in order to re-parse or use a different argv".
Especially the fact that we use different argvs is something that
implementations may not expect.

> It just means that you didn't get the hard reset of
> internal state (there is definitely internal state if argv[1] was merge=
d
> short options - but that state is cleared if you run getopt() until it
> returns -1;

While I agree that this is probably the case in practice, I see no
reason why this should be the case if it isn't guaranteed.  Why should
the state be cleared once you reach the end?

> there may also be internal state if you used extensions, but
> when you don't use extensions, such internal state is irrelevant).
>=20
> I think the BSD man page needs updating, and that will probably happen
> if I file my promised POSIX defect.

Sure.  But as it is, it doesn't tell me that resetting optind to 1 is
sufficient to be able to parse a new argv.
>>> At the end of the day, both GNU optind=3D0 and BSD optreset=3D1 are
>>> sufficient to force a hard reset of all hidden state.  But if you don=
't
>>> use POSIX extensions, and always run getopt() until a -1 return, then=

>>> setting optind=3D1 is a portable soft reset, regardless of how the hi=
dden
>>> state is implemented, and regardless of how (or even if) libc offers =
a
>>> hard reset, even though POSIX itself is currently lacking that mentio=
n.
>>> (I should probably file a POSIX defect to get that wording listed in =
POSIX)
>>
>> Hm, OK?  Is there any guarantee for that behavior for FreeBSD, or is
>> that just how it is?  Because the man page is very clear on it:
>> "optreset must be set to 1".  It doesn't talk about soft or hard reset=
s
>> like the glibc man page does.
>>
>> And if optreset not being available for glibc is the only issue, I'd s=
ay
>> adding it as a weak global variable would work without #ifdefs.
>=20
> I don't see the point - Richard has already tested that optind =3D 1
> worked on BSD machines for our purposes, so we don't have to worry abou=
t
> the hard reset aspect of optreset=3D1.

Well, and as far as I remember glibc's memcpy() at one point only copied
in one direction and things broke badly once they reversed it at some
point for some CPUs.

Just because it works now doesn't mean it will work always if the
specification allows for different behavior.

> (But yes, it would also be nice if
> BSD and glibc folks could agree on how to do hard resets, instead of
> having two different incompatible ways)
I don't see why we should have a general code path if there is no
standard way of resetting getopt() other than "This seems to work".
What's so bad about a weak optreset or an
"#ifdef __FreeBSD__; optreset =3D 1; #endif"?

Sure, if you can get POSIX to define the fact that optind =3D 1 after
getopt() =3D=3D -1 will be sufficient to start parsing a new argv, that'd=
 be
great.  But there is no such standard yet (other than "Why would that
not work?").

Max


--ZhnRHJwLvoGjBYNFojC1fEb6uQUMwkr5c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwzlvEACgkQ9AfbAGHV
z0Cg/gf+PY8j2hQSqYd7muHLaXTAg2Fwb51v97STGBgblVL8sd9oomwywSRWeVdt
55cgdLRB2/f2j2GiDZPVyqrGjf9+Zj/3kdd0GfnJ4CrsmFr9k77lgiKJSwwu8BiN
grCoUbr7UhTBtTtDdsTX1/5/T6UH1eskatCK9GJM3luh7PXuyw+Ms4akK1t+S4+u
ezlNvRlQdfJ6SP+Ax9qHnQfl20kpXS7FB8ZBmVWom9uInJT7AFWgdIapJepfPOAW
y1q5iMEOmQbnnaHurCxwQrHZyU/qDqTtSC/klE1ZoQu3yQ9FJySkU4w6GgiHJ8hM
bRsFZsFb9NMWr8t/5oDAO3morQr0aA==
=ucIw
-----END PGP SIGNATURE-----

--ZhnRHJwLvoGjBYNFojC1fEb6uQUMwkr5c--
