Received: from eggs.gnu.org ([209.51.188.92]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZ5M-0004kk-MQ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZ3R-0007fA-OG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:51:15 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
Date: Mon, 7 Jan 2019 18:50:53 +0100
MIME-Version: 1.0
In-Reply-To: <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pasqoSyxmUE8x6f8zynOIVP5RQQwifN8I"
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
--pasqoSyxmUE8x6f8zynOIVP5RQQwifN8I
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
In-Reply-To: <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.01.19 18:46, Eric Blake wrote:
> On 1/7/19 11:17 AM, Max Reitz wrote:
>> On 03.01.19 10:47, Richard W.M. Jones wrote:
>>> On FreeBSD 11.2:
>>>
>>>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 5=
12" $nbd'
>>>   Parsing error: non-numeric argument, or extraneous/unrecognized suf=
fix -- aio_write
>>>
>>> After main option parsing, we reinitialize optind so we can parse eac=
h
>>> command.  However reinitializing optind to 0 does not work on FreeBSD=
=2E
>>> What happens when you do this is optind remains 0 after the option
>>> parsing loop, and the result is we try to parse argv[optind] =3D=3D
>>> argv[0] =3D=3D "aio_write" as if it was the first parameter.
>>>
>>> The FreeBSD manual page says:
>>>
>>>   In order to use getopt() to evaluate multiple sets of arguments, or=
 to
>>>   evaluate a single set of arguments multiple times, the variable opt=
reset
>>>   must be set to 1 before the second and each additional set of calls=
 to
>>>   getopt(), and the variable optind must be reinitialized.
>>
>> [...]
>>
>>> Note I didn't set optreset.  It's not present in glibc and the "hard
>>> reset" is not necessary in this context.
>>
>> But it sure sounds like FreeBSD requires you to set it, doesn't it?
>=20
> The reason BSD and glibc have a hard reset path is because of hidden
> state - both BSD and glibc track state that remembers if the options
> began with '+' or '-' (both of those are extensions beyond POSIX), and
> whether POSIXLY_CORRECT was set.  Beyond that hidden state is a corner
> case of one more piece of state that you can trigger using only POSIX:
> if the user passes './prog -ab' while you had code:
>=20
> swich (getopt(argc, argv, "ab")) {
>   case 'a': optind =3D 1; ...
>=20
> then things fall apart for both BSD and glibc, because getopt() has to
> track invisible state in order to remember that the next call will
> process the -b portion of the merged short-option in argv[optind=3D=3D1=
]
> rather than repeating the -a half and before moving on to optind=3D=3D2=
=2E
> But this latter corner case can only happen when getopt() did not retur=
n -1.
>=20
> At the end of the day, both GNU optind=3D0 and BSD optreset=3D1 are
> sufficient to force a hard reset of all hidden state.  But if you don't=

> use POSIX extensions, and always run getopt() until a -1 return, then
> setting optind=3D1 is a portable soft reset, regardless of how the hidd=
en
> state is implemented, and regardless of how (or even if) libc offers a
> hard reset, even though POSIX itself is currently lacking that mention.=

> (I should probably file a POSIX defect to get that wording listed in PO=
SIX)

Hm, OK?  Is there any guarantee for that behavior for FreeBSD, or is
that just how it is?  Because the man page is very clear on it:
"optreset must be set to 1".  It doesn't talk about soft or hard resets
like the glibc man page does.

And if optreset not being available for glibc is the only issue, I'd say
adding it as a weak global variable would work without #ifdefs.

Max


--pasqoSyxmUE8x6f8zynOIVP5RQQwifN8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwzkX0ACgkQ9AfbAGHV
z0BjnAf6Ay+sEC6P2HhT+sjGxw8Eu7zoTSbzarRcAY9QMF+2RjRKaX8v0mTRd0Er
UPRUiYhoHAqnESgkma5xzdIFIc0G7cB2dBCt7nUgN6s/vpwvacVwC2NkUzJNTm7o
VzFYWnBakgg6IOws/mpB/waXlyYL01AiVTzr5Bi4FaJ4luYyzH9/9qA8NfeJoTcJ
puM864MD0fpEi9wxFoSQvCUohMBaMjbf69CRmeo7piN6YxtLKHayeXUDuyKwZj8K
dVY9gewQrdoeJxketqqOnntQ2af9tPrzCR1zxxGsR4fyiWLAU0NBp4GdCtBOJdn+
RH8V59jHK4MX1lTMPpt/fnNDXVZDYQ==
=VK6V
-----END PGP SIGNATURE-----

--pasqoSyxmUE8x6f8zynOIVP5RQQwifN8I--
