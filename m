Received: from eggs.gnu.org ([2001:4830:134:3::10]:58149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG4SI-0005Ef-Rj
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG4SH-0003hA-Sn
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:18:34 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
Date: Wed, 31 May 2017 16:18:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170524202842.26724-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wv6EpmSMfJthLIaNX3HVcwTgP5fadTUpa"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wv6EpmSMfJthLIaNX3HVcwTgP5fadTUpa
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
Subject: Re: [PATCH v2 1/5] qemu-io: Don't die on second open
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-2-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-24 22:28, Eric Blake wrote:
> Most callback commands in qemu-io return 0 to keep the interpreter
> loop running, or 1 to quit immediately.  However, open_f() just
> passed through the return value of openfile(), which has different
> semantics of returning 0 if a file was opened, or 1 on any failure.
>=20
> As a result of mixing the return semantics, we are forcing the
> qemu-io interpreter to exit early on any failures, which is rather
> annoying when some of the failures are obviously trying to give
> the user a hint of how to proceed (if we didn't then kill qemu-io
> out from under the user's feet):
>=20
> $ qemu-io
> qemu-io> open foo
> qemu-io> open foo
> file open already, try 'help close'
> $ echo $?
> 0
>=20
> Meanwhile, we WANT openfile() to report failures, as it is the
> way that 'qemu-io -c "$something" no_such_file' knows to exit
> early rather than attempting $something.  So the solution is to
> fix open_f() to always return 0 (when we are in interactive mode,
> even failure to open should not end the session), and save the
> return value of openfile() for command line use in main().
>=20
> This has been awkward since at least as far back as commit
> e3aff4f, in 2009.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

This still makes qemu-io -c "$something" no_such_file fail, right. But
now qemu-io -c "open no_such_file" -c "$something" will execute
$something; and I'm not sure we can convert all -c open users to not use
that command (maybe we can, now that we have --image-opts).

I don't think it's absolutely necessary for -c open to exit on error,
but you seem to do, if I understand your penultimate paragraph
correctly. :-)

Max


--wv6EpmSMfJthLIaNX3HVcwTgP5fadTUpa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLtCwEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAOs
B/9pI2siEuKDe/2df45nhiISA8s+UDH7SpyX9/xOLo5FK24Hl+u2nLPB1L+fNEPP
mAbHkKNZLz1cDf/WQ8AFUtVjIXCpvqaYDhL7V0xr65n8xLsl3r+A4GkcuhCm3cps
1JhRBmQ1XrXQaMzu9v4OMpW67w5HMvHJ7bMf8rMNgn/YXTGr8VNujAJbpQC0Uefx
TkDxxRUAv4Lgq9RwnMuOV/uN5DlA1ZET4TnxTtoOVKOEYoZiuEmowXyQaeAlxHDB
xJ92GoSacLBThmlAHmXPvJ7qXZuXx1zjiiEquUmHGMQe5gh3mfydbeGDN3EHPsbJ
4LAHKc2gV+H/Q/BY4XQbdaco
=4VBE
-----END PGP SIGNATURE-----

--wv6EpmSMfJthLIaNX3HVcwTgP5fadTUpa--
