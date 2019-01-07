Received: from eggs.gnu.org ([209.51.188.92]:49970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggZ5i-0004kp-5f
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggYyz-0003Ic-Ae
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:46:39 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
Date: Mon, 7 Jan 2019 11:46:28 -0600
MIME-Version: 1.0
In-Reply-To: <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHGGfrbhJ8Hiu7lkinaS8aUlKGfCfTDAq"
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
--BHGGfrbhJ8Hiu7lkinaS8aUlKGfCfTDAq
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
In-Reply-To: <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 11:17 AM, Max Reitz wrote:
> On 03.01.19 10:47, Richard W.M. Jones wrote:
>> On FreeBSD 11.2:
>>
>>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 51=
2" $nbd'
>>   Parsing error: non-numeric argument, or extraneous/unrecognized suff=
ix -- aio_write
>>
>> After main option parsing, we reinitialize optind so we can parse each=

>> command.  However reinitializing optind to 0 does not work on FreeBSD.=

>> What happens when you do this is optind remains 0 after the option
>> parsing loop, and the result is we try to parse argv[optind] =3D=3D
>> argv[0] =3D=3D "aio_write" as if it was the first parameter.
>>
>> The FreeBSD manual page says:
>>
>>   In order to use getopt() to evaluate multiple sets of arguments, or =
to
>>   evaluate a single set of arguments multiple times, the variable optr=
eset
>>   must be set to 1 before the second and each additional set of calls =
to
>>   getopt(), and the variable optind must be reinitialized.
>=20
> [...]
>=20
>> Note I didn't set optreset.  It's not present in glibc and the "hard
>> reset" is not necessary in this context.
>=20
> But it sure sounds like FreeBSD requires you to set it, doesn't it?

The reason BSD and glibc have a hard reset path is because of hidden
state - both BSD and glibc track state that remembers if the options
began with '+' or '-' (both of those are extensions beyond POSIX), and
whether POSIXLY_CORRECT was set.  Beyond that hidden state is a corner
case of one more piece of state that you can trigger using only POSIX:
if the user passes './prog -ab' while you had code:

swich (getopt(argc, argv, "ab")) {
  case 'a': optind =3D 1; ...

then things fall apart for both BSD and glibc, because getopt() has to
track invisible state in order to remember that the next call will
process the -b portion of the merged short-option in argv[optind=3D=3D1]
rather than repeating the -a half and before moving on to optind=3D=3D2.
But this latter corner case can only happen when getopt() did not return =
-1.

At the end of the day, both GNU optind=3D0 and BSD optreset=3D1 are
sufficient to force a hard reset of all hidden state.  But if you don't
use POSIX extensions, and always run getopt() until a -1 return, then
setting optind=3D1 is a portable soft reset, regardless of how the hidden=

state is implemented, and regardless of how (or even if) libc offers a
hard reset, even though POSIX itself is currently lacking that mention.
(I should probably file a POSIX defect to get that wording listed in POSI=
X)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BHGGfrbhJ8Hiu7lkinaS8aUlKGfCfTDAq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzkHQACgkQ3g5py3or
ov0K/ggAjBHzgOUp4mFCHLbJsdg8eK1+pzL6nWFGMkkY0huH6zcivKsjEYkdIu+C
qCITLumprEB3isV5jMtRBEcjRgaMydby/uvKPFlFgnlTx5w5xNfagnx6xgvgDEbm
J/SySeXwJ+gdZ5sWLBsVldg9PCnAKFpIpem6f+AUcf/KIcTp4std1PN9vjUq234N
Db743l7bCjduSWakZeQ96O5MRMln55WsK9+WIHK8OkI0tjaJk0wXHg6slnx7MePe
BUKTu6AlpU5TTEslEts/9TuRJTs8oYs+BJsCSjtQRVF0QAwz/tzgQfAYTHfEo0na
SiGeudi+EDWK1OvylGby7jx0jbUdtw==
=e28r
-----END PGP SIGNATURE-----

--BHGGfrbhJ8Hiu7lkinaS8aUlKGfCfTDAq--
