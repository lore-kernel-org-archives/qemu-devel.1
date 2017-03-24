Received: from eggs.gnu.org ([2001:4830:134:3::10]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crXj7-0002xn-OE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crXj4-0008RJ-JS
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crXj4-0008RF-Av
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:30:30 -0400
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62183d63-73fb-0fa4-09e9-4519de6a003a@redhat.com>
Date: Fri, 24 Mar 2017 17:30:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GfWVdu5c4bWONAxsOfewv7C6xkrEo9PMm"
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GfWVdu5c4bWONAxsOfewv7C6xkrEo9PMm
From: Eric Blake <eblake@redhat.com>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62183d63-73fb-0fa4-09e9-4519de6a003a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
In-Reply-To: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 05:01 PM, Andrew Baumann wrote:
> From: Andrey Shedel <ashedel@microsoft.com>
>=20
> The multithreaded TCG implementation exposed deadlocks in the win32
> condition variables: as implemented, qemu_cond_broadcast waited on
> receivers, whereas the pthreads API it was intended to emulate does
> not. This was causing a deadlock because broadcast was called while
> holding the IO lock, as well as all possible waiters blocked on the
> same lock.
>=20
> This patch replaces all the custom synchronisation code for mutexes
> and condition variables with native Windows primitives (SRWlocks and
> condition variables) with the same semantics as their POSIX
> equivalents. To enable that, it requires a Windows Vista or newer host
> OS.
>=20
> [AB: edited commit message]
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> The major implication of this patch is that it drops support for
> pre-Vista versions of Windows. However, those OSes are past their end
> of life, and other OSS projects have dropped support. e.g.; the last
> Cygwin release supporting XP was in Jun 2016. It doesn't seem like a
> good tradeoff to invest effort in fixing broken code needed to support
> them, so hopefully this isn't too controversial.

I'll leave the technical review to others, but from the pragmatic view,
I'm in favor of this change.  While we still strive to let qemu run
past-their-prime OSs (like pre-Vista) as guests, it is a different story
for the host, and I'm totally fine with stating that our mingw build
requires a host OS that is not past end-of-life.

Furthermore, our recent thread on which OSs should still be supported
for builds should be evidence that we are willing to drop old code for
hosts that cannot be set up as a build-bot; and I see no reason that
anyone running an out-of-date Windows XP box would want to expose it to
the internet to be a build-bot given that it has known security flaws
that will not be patched.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GfWVdu5c4bWONAxsOfewv7C6xkrEo9PMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1Z4DAAoJEKeha0olJ0NqeNMIAKNpAtcn0YlR5GFFwRL6p2pI
ewoe7VY2GkLV5fZ+SegKRUsT+Tj2ZPXrsw8wLNnesmls5UCzWleZbLpHgQDVed6B
cfEnc3bwW8aUOA/v5J4Z6NakhNYF0WXLVKLUdEi0VeLnuNEIABRw2yhMndUZI5x0
IskHPtKxNw9FbpSXiMbTGDORpJnHyMSCMCJ+dIJXfvMVLdiDYi0NmdsyP9elhRyW
ihaaXn4v22RmGRj3LlN3sL2v+vxBVRPJNCnwk6L4FezG46yx2vn6P4DfWnJW6yp3
SzBIHEJnA+EotADSRWXVXaVmck+surcul6xrO0wh53bMeyar+CqWwcBuXeA71AQ=
=sV1K
-----END PGP SIGNATURE-----

--GfWVdu5c4bWONAxsOfewv7C6xkrEo9PMm--
