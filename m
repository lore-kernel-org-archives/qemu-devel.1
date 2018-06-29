Received: from eggs.gnu.org ([2001:4830:134:3::10]:51279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4j-0004nC-F7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4f-0007m0-4f
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:49 -0400
Date: Fri, 29 Jun 2018 11:16:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629011601.GH23134@umbus.fritz.box>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <20180628121417.1980-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] util/oslib-win32: indicate
 alignment for qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 02:14:15PM +0200, David Hildenbrand wrote:
> Let's set the alignment just like for the posix variant. This will
> implicitly set the alignment of the underlying memory region and
> therefore make memory_region_get_alignment(mr) return something > 0 for
> all memory backends applicable to PCDIMM/NVDIMM.
>=20
> This will allow us to drop special handling in pc.c for
> memory_region_get_alignment(mr) =3D=3D 0, as we can then assume that it is
> always set (and AFAICS >=3D getpagesize()).
>=20
> For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE =3D=3D getpage=
size(),
> therefore alignment of DIMMs will not change, and therefore also not the
> guest physical memory layout.
>=20
> For spapr in spapr_memory_plug(), an alignment of 0 would have been used
> until now. Now getpagesize() is used. But as the size of DIMMs has to be
> multiple of 256MB on spapr, automatic address asignment will not change
> the layout (no memory holes will be created as the alignment change will
> not apply if DIMMs start/end on 256MB boundaries).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

To the very limited extent that I'm able to review a win32 patch:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  util/oslib-win32.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index bb5ad28bd3..6e87721419 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -76,6 +76,10 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align=
, bool shared)
>         memory is page aligned. */
>      ptr =3D VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
>      trace_qemu_anon_ram_alloc(size, ptr);
> +
> +    if (ptr && align) {
> +        *align =3D getpagesize();
> +    }
>      return ptr;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1iFEACgkQbDjKyiDZ
s5LFpBAAixwLnmLxPPwtzZi44yPQDzMn9FO/ZJow0pFGVaHHyXt5hawl9DQcmJ1m
Dm3EKec+S9nNFnyQZ30NrGm2ux/RsHnIfvTuZHl799tGSkNRu3RIHoPVgcazapw6
Ig0YB/lteZpLyiCgp9f8Fhzf9KwP92n5IM0Vz9n8HfXKfrvI6Ev8xIXfs5ReKyT4
sQ1HjMriedm+KrEQ2F6cba+LA1lPEbvyy9mMCpZodqn6SZfVT1S3TV/fMboAaCjr
vJwb2ZUn+EC6rnfcesYKTeRK8eQDk40qIr3MskHs8YDCah2ix6iQWmJR4hxloscS
VZi1zqTg9mZhq2qIvbN4Aim6rwIbMBZHUkmynvBcMMSlKPfjj4kSbNPV99sVUJZh
p9XbeJDuu7UQu4wTIfiUS6XKBZQuXxBtyM81/g3znKNW3OZo3yD5mEPoSvebAH75
Hd45eS+C8VvBeGi9a48+3ta4WpstyEyzqcMZK+8K07wOtkNqOFLh52Juo5TDtuPF
42i+GlGFeyG44Ib8V1IvHwkwAgd5piVltGV6MgouptdHnFyX6flybLknfxuErPPU
oveDbspgNCeL+Vc8yTDhDQ2lefEnuace6+j7U1bOUNv8KR262m6EDJhFrOuoFGSY
vjuZ9qx99BdUZCE7f5Rj0BiU1hNk9skwMGvk+ZG3lQQNE+hTSmo=
=Ze4y
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
