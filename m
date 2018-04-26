Received: from eggs.gnu.org ([2001:4830:134:3::10]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkqD-0000ct-O8
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkqA-0000Da-Ft
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:37:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBkqA-0000DP-9G
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:37:54 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
Date: Thu, 26 Apr 2018 12:37:45 -0500
MIME-Version: 1.0
In-Reply-To: <1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MfNZ5stYn6r3PJHsO3qbiiW3zOqaM9Vce"
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] error reporting: Use
 error_report_errno in obvious places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MfNZ5stYn6r3PJHsO3qbiiW3zOqaM9Vce
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Daniel_P_._Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
Subject: Re: [RFC PATCH 3/7] error reporting: Use error_report_errno in
 obvious places
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:53 AM, Ian Jackson wrote:
> This patch is the result of
>=20
>   git-grep -l 'error_report.*strerror' | xargs perl -p -i~ ../t
>=20
> with ../t containing
>=20
>   s{error_report\("(.*): \%s"(, .*)?, strerror\(errno\)\)\;}{error_repo=
rt_errno\("$1"$2)\;}
>=20
> Since this is an automatically generated patch, it does not contain
> any cleanups of the occasional idiosyncratic messages.  That is left
> to the future.
>=20
> No functional change, since error_report_errno does exactly what this
> previous open-coded pattern does.
>=20
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  audio/wavcapture.c       |  2 +-
>  hw/i386/xen/xen-hvm.c    |  2 +-
>  hw/tpm/tpm_emulator.c    |  2 +-
>  hw/xen/xen_pt_load_rom.c |  4 ++--
>  migration/postcopy-ram.c | 12 ++++++------
>  net/tap-linux.c          |  2 +-
>  os-posix.c               |  8 ++++----
>  qemu-nbd.c               |  4 ++--
>  scsi/qemu-pr-helper.c    |  4 ++--
>  slirp/misc.c             |  4 ++--
>  util/osdep.c             |  2 +-
>  vl.c                     |  6 +++---
>  12 files changed, 26 insertions(+), 26 deletions(-)

See my other emails about whether this should be
error_report_errno(errno, "...").

Misses a lot of two-line instances, such as:
$ git grep -A1 error_report | grep -C1 strerror.errno
=2E..
block/file-posix.c:            error_report("Failed to restore old file
length:
%s",
block/file-posix.c-                         strerror(errno));
=2E..

If we're going to clean up these instances, we might as well look harder
for them.  Can Coccinelle be coaxed into helping us (at least for
identifying callsites, even if I can't figure out how to make it
slice-and-dice format strings)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MfNZ5stYn6r3PJHsO3qbiiW3zOqaM9Vce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriDmkACgkQp6FrSiUn
Q2opogf/Y3tbX8f/NyLIDz5E+xEyhLLUvs330HmISOzS70cJ7Yz2DV1rlvXucEyL
0fuYmYkXRHU6ciKWL11DNk+b+soYre83/8hbSq7/OzOmXg+pJt4kY94I3eaOl85L
a8x21ZkHHSbG89JFRcwrqqEJZ+Zfn3ThufCOm8KKyu0Z0itd/nATHvzrwgKDhDSs
EyYnhyw9FKulNJqT/cjIVdpZy7Uq+OyedNxMPGDg0RDYs30LoyvMkzd8RbmJFsD4
UnVrHt0uEWiK4dlbStWztn08oephlgwJPnYYR6UJethH/16pIbNoCYK6UIprk1/u
GfwFItzyAXCUKRBBgau3OFNVUN+dZA==
=UAgU
-----END PGP SIGNATURE-----

--MfNZ5stYn6r3PJHsO3qbiiW3zOqaM9Vce--
