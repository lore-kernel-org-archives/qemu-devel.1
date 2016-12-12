Received: from eggs.gnu.org ([2001:4830:134:3::10]:59545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRFt-0004um-5i
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRFq-0004hL-FQ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRFq-0004gs-9J
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:06:58 -0500
Date: Mon, 12 Dec 2016 14:06:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212140655.GE4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] exec: introduce MemoryRegionCache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:50PM +0100, Paolo Bonzini wrote:
> diff --git a/exec.c b/exec.c
> index d4b3656..8d4bb0e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3077,6 +3077,82 @@ void cpu_physical_memory_unmap(void *buffer, hwadd=
r len,
>  #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
>  #include "memory_ldst.inc.c"
> =20
> +int64_t address_space_cache_init(MemoryRegionCache *cache,
> +                                 AddressSpace *as,
> +                                 hwaddr addr,
> +                                 hwaddr len,
> +                                 bool is_write)
> +{
> +    hwaddr l, xlat;
> +    MemoryRegion *mr;
> +    void *ptr;
> +
> +    assert(len > 0);
> +
> +    l =3D len;
> +    mr =3D address_space_translate(as, addr, &xlat, &l, is_write);
> +    if (!memory_access_is_direct(mr, is_write)) {
> +        return -EINVAL;
> +    }
> +
> +    l =3D address_space_extend_translation(as, addr, len, mr, xlat, l, i=
s_write);
> +    ptr =3D qemu_ram_ptr_length(mr->ram_block, xlat, &l);
> +
> +    cache->xlat =3D xlat;
> +    cache->is_write =3D is_write;
> +    cache->mr =3D mr;
> +    cache->ptr =3D ptr;
> +    cache->len =3D l;
> +    memory_region_ref(cache->mr);
> +
> +    return l;
> +}

What happens when [addr, addr + len) overlaps a MemoryRegion boundary?
It looks like this function silently truncates the MemoryRegionCache,
leading to an assertion failure in address_space_translate_cached().

Perhaps it would be better to fail address_space_cache_init() if the
length is truncated.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTq7/AAoJEJykq7OBq3PICMMH/iQb1TjzOQQ6v9ipZKdt+zV5
N5iwoyicD8GtxlJ+9LJmUvgtBfn69uWEEfRf+F/20vUZbNvnTmf1lxcAGLc7CV8G
Daw3+U9R6WuBy6e9rxx54yQcfrTDSaQWWAcfyul5NYijCvx2cP+rRb+RE2Aa3Fb/
Mw/r6rtH+kwpZ9vdzb84PrEKg0KIIGcfAMfJxGnbKBdwEZ11W2kHM8Lxp6jAZhnf
Bai+p1Pzxc2lZytEozjueAKx5F6cJ6nfuLiyzPR1w65hIarUmLMqn5jNKn9xkiSB
0jGSSqNN8+/bofRWc8QFkIpDKyy+OwF6MUIgBl9DU4QjYIO4AXzogkIo5u7W+8I=
=KwB3
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
