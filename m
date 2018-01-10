Received: from eggs.gnu.org ([2001:4830:134:3::10]:35334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZFcq-0002rY-Je
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZFcm-0008GM-HE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:37:00 -0500
Date: Wed, 10 Jan 2018 12:36:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110123651.GJ3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1514907465-14530-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1514907465-14530-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto/ivgen-essiv: Fix problem with
 address sanitizer of Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue, Jan 02, 2018 at 04:37:45PM +0100, Thomas Huth wrote:
> When compiling QEMU with clang and -fsanitize=3Daddress, I get the
> following error:
>=20
> =3D=3D9185=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addre=
ss 0x7ffc7e9adf2f at pc 0x564cba001d88 bp 0x7ffc7e9adeb0 sp 0x7ffc7e9adea=
8
> READ of size 16 at 0x7ffc7e9adf2f thread T0
>     #0 0x564cba001d87 in qcrypto_ivgen_essiv_calculate .../crypto/ivgen=
-essiv.c:83
>     #1 0x564cba001367 in qcrypto_ivgen_calculate .../crypto/ivgen.c:72
>     #2 0x564cb9fec630 in test_ivgen .../tests/test-crypto-ivgen.c:148
>     #3 0x7f98f4224b39 (/lib64/libglib-2.0.so.0+0x6fb39)
>     #4 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
>     #5 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
>     #6 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
>     #7 0x7f98f4224f0d (/lib64/libglib-2.0.so.0+0x6ff0d)
>     #8 0x7f98f4224f30 (/lib64/libglib-2.0.so.0+0x6ff30)
>     #9 0x564cb9fec446 in main .../tests/test-crypto-ivgen.c:173
>     #10 0x7f98f294fc04 in __libc_start_main (/lib64/libc.so.6+0x21c04)
>     #11 0x564cb9fec1ac in _start (.../tests/test-crypto-ivgen+0xdb1ac)
>=20
> Address 0x7ffc7e9adf2f is located in stack of thread T0 at offset 47 in=
 frame
>     #0 0x564cba00192f in qcrypto_ivgen_essiv_calculate .../crypto/ivgen=
-essiv.c:76
>=20
> And indeed, the code is doing a "memcpy(data, (uint8_t *)&sector, ndata=
)"
> here with "sector" being a uint64_t variable and ndata =3D 16.
>=20
> Fix it by limiting the size of the memcpy correctly.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/ivgen-essiv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI, this is a dupe of the same fix posted  Marc-Andr=C3=A9 Lureau last
year with subject "crypto: fix stack-buffer-overflow error", which I
already have queued.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
