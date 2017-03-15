Received: from eggs.gnu.org ([208.118.235.92]:47581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coF5W-0000g5-4n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 16:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coF5S-0004q8-V1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 16:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coF5S-0004q0-M1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:59:58 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64AC1201FB
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 19:59:58 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-31-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbffcbd2-e614-884f-9a8f-77bf198d9d58@redhat.com>
Date: Wed, 15 Mar 2017 14:59:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170313195547.21466-31-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MqRkoa67qU9gXQqxRPwLgmNh7SRduTSd6"
Subject: Re: [Qemu-devel] [RFC PATCH v2 30/30] trace: Force compiler
 warnings on trace parameter type mismatches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MqRkoa67qU9gXQqxRPwLgmNh7SRduTSd6
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <dbffcbd2-e614-884f-9a8f-77bf198d9d58@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 30/30] trace: Force compiler warnings
 on trace parameter type mismatches
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-31-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-31-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 02:55 PM, Eric Blake wrote:

> ---
>=20
> RFC for two reasons:
> 1. the Makefile issue documented above means that incremental
> builds won't benefit from this patch without manual intervention
> (fresh builds, including docker, manage to test it, though)

Dan's posted the fix for this one.

> 2. there are still failures under 'make docker-test-mingw@fedora'
> due to more type mismatches that still need to be squashed. I'm
> still working on fixing those, but wanted to at least post this
> series for initial review, especially so the maintainer can weigh
> in on how much (or little) belongs in 2.9

mingw is a nightmare.  Things like ntohl() having non-standard behavior
on 32-bit mingw can only be worked around by hairy redefinitions in
osdep.h or by casts at the callsites. See the conversation in 6/30, but
I'm hoping gcc will give us a new knob to tone down the level of
-Wformat warnings for two types that have different rank but the same
width; if gcc gives us that, then we'd add a configure test, and
conditionally generate the type-mismatch checking code ONLY when gcc is
smart enough to not care about rank mismatch.  Until then, this RFC
30/30 proved useful for flushing out the earlier cleanups (many of which
you can/should still accept), but should NOT be incorporated as-is, not
even when 2.10 opens.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MqRkoa67qU9gXQqxRPwLgmNh7SRduTSd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyZ07AAoJEKeha0olJ0NqDHoH/A0mnhanDbAYuwI2XZ/znn5i
3WoF7E5IxEGRohY2ccnugIlt2rcMt+dREXKN5B5v/Yc13a0DyPWnloRw70OQ6YvK
eT1gjrjKfhNKjT6cu3hAtpqO+wO8ZgL7i+d7VqNGzY3azlXlHZ6ANBeubuaVJOxD
PZuRVSuUntnJj7UZaKSWGCzcBMj71Ves5EvAQrWvgJqmGpkwNfqN4Fo0s2Hx50Nq
Ti3zIV8LOPBzg58/clY7Ts5/1ffND8UPDq1GbbTYZWRdx0xd9THGXJbNKNqQHoxY
f5Ttvp6//0A4BKYc0swTQuzNo/lGcBDX28foyaVHRjK4imf6i3mB80iSshqCbCw=
=ou38
-----END PGP SIGNATURE-----

--MqRkoa67qU9gXQqxRPwLgmNh7SRduTSd6--
