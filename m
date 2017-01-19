Received: from eggs.gnu.org ([2001:4830:134:3::10]:32814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUJnL-000107-Ut
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUJnI-0003X9-2i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:58:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUJnH-0003W7-QZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:58:52 -0500
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
	<87r33zii2m.fsf@dusky.pond.sub.org>
	<8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
	<8737gfb2dn.fsf@dusky.pond.sub.org>
	<20170119212409-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57dd50a6-73ce-ecfa-4f5e-bca433465e6b@redhat.com>
Date: Thu, 19 Jan 2017 14:58:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170119212409-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RFEqUhm2AMWQh60D8coFOT5bXsoI37ftD"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RFEqUhm2AMWQh60D8coFOT5bXsoI37ftD
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <57dd50a6-73ce-ecfa-4f5e-bca433465e6b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
 <1484772931-16272-4-git-send-email-mst@redhat.com>
 <87r33zii2m.fsf@dusky.pond.sub.org>
 <8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
 <8737gfb2dn.fsf@dusky.pond.sub.org>
 <20170119212409-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170119212409-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 01:25 PM, Michael S. Tsirkin wrote:

>>>>> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - siz=
eof(int))
>>>
>>> Linux here uses:
>>>
>>> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>>>
>>> and the issue is that sizeof(int[(x) ? -1 : 1]) could be
>>> runtime-evaluated (the type is a variable-length array).

Use of the struct with an int bitfield forces 'e' to be a non-zero
compile-time constant to compile; while [(x) ? -1 : 1] could indeed
compile even if not a compile-time constant.  So I agree that we want to
prefer something that forces x to be a compile-time constant.

>>
>> Let's copy both macros from Linux.
>=20
> I prefer our variant, I don't think it's portable to assume that
> sizeof(struct {int:0}) is 0. Besides, Linux code is GPLv2 only and this=

> file is 2 or later.

I agree that using the Linux version is problematic from a licensing
perspective, as well as the portability of getting sizeof() to produce
0.  But at least it uses bitfields to force a compile time constant.

Here's a third approach: gnulib has a LGPLv2+ version that does:

=3D=3D=3D=3D
# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
    struct { unsigned int _gl_verify_error_if_negative: (R) ? 1 : -1; }

#define _GL_VERIFY_TRUE(R, DIAGNOSTIC) \
   (!!sizeof (_GL_VERIFY_TYPE (R, DIAGNOSTIC)))

/* Verify requirement R at compile-time, as a declaration without a
   trailing ';'.  If R is false, fail at compile-time, preferably
   with a diagnostic that includes the string-literal DIAGNOSTIC.

   Unfortunately, unlike C11, this implementation must appear as an
   ordinary declaration, and cannot appear inside struct { ... }.  */

#ifdef _GL_HAVE__STATIC_ASSERT
# define _GL_VERIFY _Static_assert
#else
# define _GL_VERIFY(R, DIAGNOSTIC)                                     \
    extern int (*_GL_GENSYM (_gl_verify_function) (void))              \
      [_GL_VERIFY_TRUE (R, DIAGNOSTIC)]
#endif

/* Verify requirement R at compile-time.  Return the value of the
   expression E.  */

#define verify_expr(R, E) \
   (_GL_VERIFY_TRUE (R, "verify_expr (" #R ", " #E ")") ? (E) : (E))

/* Verify requirement R at compile-time, as a declaration without a
   trailing ';'.  */

#define verify(R) _GL_VERIFY (R, "verify (" #R ")")
=3D=3D=3D=3D

where BUILD_BUG_ON_ZERO(e) pretty much maps to verify_expr(!(e), 0), if
you want to copy any of those ideas.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RFEqUhm2AMWQh60D8coFOT5bXsoI37ftD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgSiIAAoJEKeha0olJ0Nq7ywIAI8KTfc15clr94FVIAayY1SF
15z0/fufKB3cl9aalptO5CdHhUcgvtGf/LDnG29slGlEirk5KZknHzaWskAyTNW4
VQYbMU9kCaj4dbR0AEhv2kLOXAbLYIEjeID+g+HXCPohnvh8uWs+4OEPLZKe+0Ko
c1T1YAQ2D9PeanHWfx/Y4ypPblhMdSXzAM4jeXL7A48cxBGGzT/1noHQkhxxwJex
qaHLK/fVHMZdiDNfKOAGr73OzzcHWTC45Cy3AsrBF9jbFFF9aMuEcpym3hiSlNCs
nvGSbm8s2nzqppqqBOMnJDOqKcosFV0lljrwS77/RmcRdudwOoLSEYGmYHqqDiU=
=1Hcq
-----END PGP SIGNATURE-----

--RFEqUhm2AMWQh60D8coFOT5bXsoI37ftD--
