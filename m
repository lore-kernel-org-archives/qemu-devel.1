Received: from eggs.gnu.org ([2001:4830:134:3::10]:53378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXsYc-0002i0-0C
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXsYb-0001c5-4Q
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:13 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
	<20180222151210.GK4147@localhost.localdomain>
	<c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
	<20180222162147.GL4147@localhost.localdomain>
	<26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
	<e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
Message-ID: <8411faa9-c382-810b-d45f-0ab544d5419b@redhat.com>
Date: Tue, 26 Jun 2018 20:19:03 +0200
MIME-Version: 1.0
In-Reply-To: <e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TnjMqq33QtxLseKbDDxBaApEqgu92e65f"
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TnjMqq33QtxLseKbDDxBaApEqgu92e65f
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <8411faa9-c382-810b-d45f-0ab544d5419b@redhat.com>
Subject: Re: [PATCH v8 03/26] block: Add BDS.backing_overridden
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-4-mreitz@redhat.com>
 <20180222133956.GG4147@localhost.localdomain>
 <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
 <20180222151210.GK4147@localhost.localdomain>
 <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
 <20180222162147.GL4147@localhost.localdomain>
 <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
 <e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
In-Reply-To: <e2b18fb9-af9e-c3b7-7def-0c13b3690d00@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-06-26 19:34, Max Reitz wrote:

[...]

> So I suppose I'll rename my BDS.backing_file_canonical attempt to
> BDS.auto_backing_file, and this will be what the image header contains
> (unless we have opened a BDS from it, in which case it will be that
> BDS's filename, so it is canonicalized).

Update: That seems to go down the drain.  We (stupidly) allow taking a
backing filename from the image header and then enriching it with
options from the command line (so you could take null-co:// from the
image header and then the user could give backing.size.  I won't comment
on how little sense that makes (apart from [1]), but in any case, this
means that "we have opened a BDS from it" is very hard to reliably
recognize, because you need to find out whether the user has given any
strong options for the backing file.  That pretty much brings the
complexity back to backing_overridden, I'd say.

Well, or: Whenever the user has given any backing options, the resulting
BDS is categorized as overridden and the filename is not used as a
canonicalized version of auto_backing_file.

I now pretty much fail to see how any of this is better than
backing_overridden, but whatever.

Max

[1] In fact, it's completely broken, because the user-given backing
options only override the backing filename once the user-given options
contain "file.filename".  So you actually cannot really override
anything unless your new backing file has a protocol driver with a
"filename" option.  Well, you can, but that means creating an own BDS
and then giving a reference to that...


--TnjMqq33QtxLseKbDDxBaApEqgu92e65f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsyg5cACgkQ9AfbAGHV
z0AlvwgAnPQW9+5PpIJRB0GPlfMjEw7+YkGRI2+CkucRfi0CSzK/4kBJdKxcax3s
OrzveMlWtewuaFYuHHUPFxbQ9mNl4o9t0rGv3QZOwgufh8njMPksdzMSxYwCyH4C
QPV8OqN7Nlu1oaDjAdlwk02ojnE1kOL2U7oCgEjj+smyC+QEUMxrIf8v02GKeQQ4
1Ir6VW8GdB8DuL/MBpd+k2lxSX2v1GxC9yZ/9CpsNe6cdvL122tHOviNQXZmA4sT
YPY+ta17t0jpAeluIWB8uq3K6elJ3Dyw2Zvr1EtgFYzOi/AD+jiibq3dnRzHA7TQ
Dp92Drk5lwpRYXKtiucT7xA1ndYcrQ==
=1oS/
-----END PGP SIGNATURE-----

--TnjMqq33QtxLseKbDDxBaApEqgu92e65f--
