Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhuS-0002is-E2
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhuN-0004jB-H0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqhuN-0004iM-8Y
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 296877DD06
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 15:10:43 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-12-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b23e659-880b-f9ea-f286-3a3f41e5e9c8@redhat.com>
Date: Wed, 22 Mar 2017 10:10:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170313195547.21466-12-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KVUwgJwHh5QmxXsH5efEjfJMCaCpHFS5O"
Subject: Re: [Qemu-devel] [PATCH v2 11/30] trace: Fix parameter types in
 hw/audio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KVUwgJwHh5QmxXsH5efEjfJMCaCpHFS5O
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com
Message-ID: <7b23e659-880b-f9ea-f286-3a3f41e5e9c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/30] trace: Fix parameter types in
 hw/audio
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-12-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 02:55 PM, Eric Blake wrote:
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/audio/trace-events | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

>  # hw/audio/milkymist-ac97.c
> -milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr %08x v=
alue %08x"
> -milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr %08x =
value %08x"
> +milkymist_ac97_memory_read(hwaddr addr, uint32_t value) "addr %08" HWA=
DDR_PRIx " value %08x"
> +milkymist_ac97_memory_write(hwaddr addr, uint64_t value) "addr %08" HW=
ADDR_PRIx " value %08" PRIx64

Stefan pointed out to me on IRC that hwaddr is not a valid type when
using --enable-trace-backend=3Dust.  If hwaddr is always a 64-bit type,
then using uint64_t/PRIx64 is a reasonable substitute to
hwaddr/HWADDR_PRIx, but I wasn't sure if that was the case.  But it
certainly invalidates a large chunk of the series as I proposed it,
where I'd have to switch any of my additions of hwaddr over to uint64_t.

Using -Wformat to catch type mismatches catches both widening and
narrowing issues, but maybe we only care about narrowing issues.  As
long as there are no varargs involved, silently widening a 32-bit input
to a 64-bit function parameter before printing is safe; but my hack of
adding a dead printf() means that it then fails to go through varargs
correctly and forces type-correctness on the caller.

We _want_ to cleanup callers that have 64-bit types passed to a 32-bit
log format string, as that is silent loss of information.  But if the
only way to do that costs a lot of maintenance in also annotating source
code to explicitly widen 32-bit types passed into 64-bit log format
strings just to satisfy -Wformat, then it's a tougher sale.

And then there's still the idea that maybe the rest of this series is
not worth pursuing until gcc gives us some way to ignore things like
__u64 being the same width but a different type than uint64_t (at least
on 64-bit Linux). We can certainly take the cleanups that are safe, now
that I've done one round of auditing (I still haven't finished a 32-bit
Linux audit to see if it pops up more mismatches, and mingw already
proved a bear to audit because of the ntohl() bug).  But if we can't
accept the final patch that uses the -Wformat hack, then I'm worried
that we will slip in regressions over time, negating some of the effort
I even put in on the initial audit.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KVUwgJwHh5QmxXsH5efEjfJMCaCpHFS5O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0pPsAAoJEKeha0olJ0Nqfn8H/AuE3I3vjvjH4TrF7dG6i89K
c7mewaSOg42AGSTRBbotwJOvm9eGC4RmyszxGHbqy4wbdPG5T/2atoaG3Td4zwq0
rDFlby25cPmVXg7jFZuph1Z0CPUmHETshAvmdrlIctDhb48fzUvGQbH2VRLR6aZq
hgttkLmxKr95eC7KW/c7PUp8xeDyf47RAvPIwDKikei8WORvR8DJQ+XL+/NdmSWM
orqctmZhSfQwf1n1xrKqepl9f+lvolrh++G6T5nA2eO8N/cg0iCeY3XC3WPDrIxr
/T5w12/3YCGDOhJq9RR8kcivSPYkFYx078vWvNz7uBA7LBcEV2zD+JPJlai671g=
=Rs7r
-----END PGP SIGNATURE-----

--KVUwgJwHh5QmxXsH5efEjfJMCaCpHFS5O--
