Received: from eggs.gnu.org ([209.51.188.92]:51057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Gq-0007i3-LQ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu72q-0003Lh-K1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:46:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gu72q-0003KC-C1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:46:36 -0500
Date: Thu, 14 Feb 2019 10:46:24 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214024624.GC21877@stefanha-x1.localdomain>
References: <20190213071401.11544-1-stefanha@redhat.com>
	<20190213081318.GA9754@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20190213081318.GA9754@richard>
Subject: Re: [Qemu-devel] [PATCH v2] hostmem-file: reject invalid pmem file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Zhang Yi <yi.z.zhang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 04:13:18PM +0800, Wei Yang wrote:
> On Wed, Feb 13, 2019 at 03:14:01PM +0800, Stefan Hajnoczi wrote:
> >diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> >index ba601ce940..d62689179b 100644
> >--- a/backends/hostmem-file.c
> >+++ b/backends/hostmem-file.c
> >@@ -46,6 +46,28 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
> >     gchar *name;
> > #endif
> >=20
> >+    /*
> >+     * Verify pmem file size since starting a guest with an incorrect s=
ize
> >+     * leads to confusing failures inside the guest.
> >+     */
> >+    if (fb->is_pmem && fb->mem_path) {
> >+        Error *local_err =3D NULL;
> >+        uint64_t size;
> >+
> >+        size =3D qemu_get_pmem_size(fb->mem_path, &local_err);
> >+        if (!size) {
> >+            error_propagate(errp, local_err);
> >+            return;
> >+        }
> >+
> >+        if (backend->size > size) {
> >+            error_setg(errp, "size property %" PRIu64 " is larger than "
> >+                       "pmem file \"%s\" size %" PRIu64, backend->size,
> >+                       fb->mem_path, size);
> >+            return;
> >+        }
> >+    }
> >+
> >     if (!backend->size) {
> >         error_setg(errp, "can't create backend with size 0");
> >         return;
>=20
> Would it be reasonable to move the above check after checking size and
> mem_path?

Thanks, will fix in v3.

Stefan

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZNaAAAoJEJykq7OBq3PIZo4H/RPzSnMwr3Q4TcQq/CXkeZts
J1lOusMLwaR56AOAOmFtMxpQoP497fwTm78HjbjfkaxfRjv397jQbyISCzGVnffC
+3JU3aCNjmiVtt60ZrEsYKhH0IzDBHnXfC+h5PbGdF4P5V7KnP0EHj8CcgWnDHWT
PGZxACvRMwQKybCXmYOauZ2YOBMx0aJ43Soi7vNW4RJOwKsvTdnXIBCzkQ/jrHws
kX7wP6cZlk+MtjrSBECsnRYdjbA8EPtJcWeyx2yGfxpfKO7d0QLZa070viTdDQv4
Pzd7LnUcWd5Gq+rn+yzNsgC/pYwaHBOffxhMu47b33gS7nF2EY8/fhwC1pXwDIs=
=T/YS
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
