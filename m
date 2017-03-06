Received: from eggs.gnu.org ([2001:4830:134:3::10]:53347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyDO-0007Zd-L1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyDN-0003Bw-KL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:22:38 -0500
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
	<1488826849-32384-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3291b737-2a70-ce2b-1094-92b06e58ce5b@redhat.com>
Date: Mon, 6 Mar 2017 13:22:27 -0600
MIME-Version: 1.0
In-Reply-To: <1488826849-32384-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pq6cL17ah26eUI5fmBvQt6CFwjbhstP7W"
Subject: Re: [Qemu-devel] [PATCH v2 01/15] sheepdog: Defuse time bomb in
 sd_open() error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pq6cL17ah26eUI5fmBvQt6CFwjbhstP7W
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, f4bug@amsat.org
Message-ID: <3291b737-2a70-ce2b-1094-92b06e58ce5b@redhat.com>
Subject: Re: [PATCH v2 01/15] sheepdog: Defuse time bomb in sd_open() error
 handling
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
 <1488826849-32384-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 01:00 PM, Markus Armbruster wrote:
> When qemu_opts_absorb_qdict() fails, sd_open() closes stdin, because
> sd->fd is still zero.  Fortunately, qemu_opts_absorb_qdict() can't
> fail, because:
>=20
> 1. it only fails when qemu_opt_parse() fails, and
> 2. the only member of runtime_opts.desc[] is a QEMU_OPT_STRING, and
> 3. qemu_opt_parse() can't fail for QEMU_OPT_STRING.
>=20
> Defuse this ticking time bomb by jumping behind the file descriptor
> cleanup on error.
>=20
> Also do that for the error paths where sd->fd is still -1.  The file
> descriptor cleanup happens to do nothing then, but let's not rely on
> that here.
>=20
> While there, rename label out to err, because it's on the error path,
> not the normal path out of the function.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Pq6cL17ah26eUI5fmBvQt6CFwjbhstP7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvbbzAAoJEKeha0olJ0NqTu0IAINh0NE+jDR/QVSC5YVdkWB2
PW6CHK5ZBKFcuELePAITNdFX7PzkhNuzGOiu5PsJ8hP9/qS68T4QYJIKpGfZl1z+
ya5lNT+7hS9cb8NpCIkUjp5PiYlIeXip7dMXqL5RAuPqbhJj609gn4nx7jXxfchf
E6tnkqJPt2yDBkv9h7clGf3ev+hGYZVnOLJvt7EkqVZZA3nSP7RW8vLo+c3pH4Wj
IMYQUJwpCDvLzunJfbQO3AEu9NE7J9wifuHjXN1pKBlkJdpAxIqYMr7YM5jUIY0k
iopnOh7TxjuL1RtIVkkOE+csef3topFpAna0GGmqUmZrSodiY+PoGQ0LhgehuiM=
=pe+t
-----END PGP SIGNATURE-----

--Pq6cL17ah26eUI5fmBvQt6CFwjbhstP7W--
