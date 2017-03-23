Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4aP-0002zm-06
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4aK-0008BU-0g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:23:37 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr4aJ-0008B8-N9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:23:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id 20so3632464wrx.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:23:31 -0700 (PDT)
Date: Thu, 23 Mar 2017 15:23:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323152327.GF12560@stefanha-x1.localdomain>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <20170313195547.21466-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/30] trace: Avoid abuse of
 amdvi_mmio_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, stefanha@redhat.com, Richard Henderson <rth@twiddle.net>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 02:55:20PM -0500, Eric Blake wrote:
> hw/i386/trace-events has an amdvi_mmio_read trace that is used for
> both normal reads (listing the register name, address, size, and
> offset) and for an error case (abusing the register name to show
> an error message, the address to show the maximum value supported,
> then shoehorning address and size into the size and offset
> parameters).  The change from a wide address to a narrower size
> parameter could truncate a (rather-large) bogus read attempt, so
> it's better to create a separate dedicated trace with correct types,
> rather than abusing the trace mechanism.  Broken since its
> introduction in commit d29a09c.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/i386/amd_iommu.c  | 3 +--
>  hw/i386/trace-events | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index e0732cc..f86a40a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -572,8 +572,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr =
addr, unsigned size)
>=20
>      uint64_t val =3D -1;
>      if (addr + size > AMDVI_MMIO_SIZE) {
> -        trace_amdvi_mmio_read("error: addr outside region: max ",
> -                (uint64_t)AMDVI_MMIO_SIZE, addr, size);
> +        trace_amdvi_mmio_read_invalid(AMDVI_MMIO_SIZE, addr, size);
>          return (uint64_t)-1;
>      }
>=20
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 88ad5e4..a213bfd 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -37,6 +37,7 @@ amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t=
 slot, uint8_t func, uint
>  amdvi_completion_wait_fail(uint64_t addr) "error: fail to write at addre=
ss 0x%"PRIx64
>  amdvi_mmio_write(const char *reg, uint64_t addr, unsigned size, uint64_t=
 val, uint64_t offset) "%s write addr 0x%"PRIx64", size %u, val 0x%"PRIx64"=
, offset 0x%"PRIx64
>  amdvi_mmio_read(const char *reg, uint64_t addr, unsigned size, uint64_t =
offset) "%s read addr 0x%"PRIx64", size %u offset 0x%"PRIx64
> +amdvi_mmio_read_invalid(int max, hwaddr addr, unsigned size) "error: add=
r outside region (max 0x%x): read addr 0x%" HWADDR_PRIx ", size %u"

This breaks the ust backend because hwaddr isn't defined.
docs/tracing.txt documents restrictions on types:

  Trace events should use types as follows:

   * Use stdint.h types for fixed-size types.  Most offsets and guest memory
     addresses are best represented with uint32_t or uint64_t.  Use fixed-s=
ize
     types over primitive types whose size may change depending on the host
     (32-bit versus 64-bit) so trace events don't truncate values or break
     the build.

   * Use void * for pointers to structs or for arrays.  The trace.h header
     cannot include all user-defined struct declarations and it is therefore
     necessary to use void * for pointers to structs.

   * For everything else, use primitive scalar types (char, int, long) with=
 the
     appropriate signedness.

I think it is technically possible to allow user-defined types but it
would require full testing with all backends.  The tracetool generator
for some backends will require tweaks to teach them about user-defined
types (e.g. #include "qemu-common.h").

I have merged this patch and changed hwaddr to uint64_t, HWADDR_PRIx to
PRIx64.

Stefan

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0+hvAAoJEJykq7OBq3PIgOcIAIfnWeTrnyjbUMKDTLMZ+TeA
EX3TMYFKyYbDEJwYSZpRhJDWQpZB9ikmL8pLJSgu22kWl7eHYax8Aj0L6l792rPF
o/KOfRUxeWgrj1E+FDbJWBywxLppViVYrFO7rmBk7tHXDgck5RPRb7/XhSO81pKZ
BIaPXf8RdztRhmBOLPX9OCNtDSMvETglwqdO3SAx2kpnd303aSO01xKSPMoJOcjr
gYOrWGF1kHoxgEURi2haY9yLrGR8piDU+cwL6Udsoj4pVx8JSGQzhg4buqZc49vk
rbT61B2HBj/L3PRAEZmzWpf7qyvML75WKivRwq7g2UaG1NlSVfy56x6nV7TT4hg=
=Iv3+
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
