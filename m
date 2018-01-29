Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7pi-0006YY-DK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg7pd-0006Gm-PG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:42:42 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg7pd-0006Fx-Hu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:42:37 -0500
Received: by mail-wm0-x22f.google.com with SMTP id f3so33076932wmc.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 03:42:37 -0800 (PST)
Date: Mon, 29 Jan 2018 11:42:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129114234.GC20446@stefanha-x1.localdomain>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20180125175949.7780-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2018 at 06:59:46PM +0100, Paolo Bonzini wrote:
> +struct QemuLockable {
> +    void *object;
> +    QemuLockUnlockFunc *lock;
> +    QemuLockUnlockFunc *unlock;
> +};
...
> +/* In C, compound literals have the lifetime of an automatic variable.
> + * In C++ it would be different, but then C++ wouldn't need QemuLockable
> + * either...
> + */
> +#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {    \
> +        .object = (x),                               \
> +        .lock = QEMU_LOCK_FUNC(x),                   \
> +        .unlock = QEMU_UNLOCK_FUNC(x),               \
> +    })

After all these tricks we still end up with a struct containing function
pointers.  That's a little sad because the power of generics is
specializing code at compile time.

IMO the generics usage here doesn't have a big pay-off.  The generated
code is more or less the same as without generics!

It makes me wonder if the API would be more maintainable with:

  typedef struct {
      QemuLockUnlockFunc *lock;
      QemuLockUnlockFunc *unlock;
  } LockableOps;

  extern const LockableOps co_mutex_lockable_ops;
  extern const LockableOps qemu_spin_lockable_ops;
  ...

The user passes in the appropriate LockableOps instance for their type
and generics are not needed.

This approach means future changes do not require digging through the
macros to understand how this stuff works.

Maybe I've missed something?

Stefan

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabwiqAAoJEJykq7OBq3PI35MIALORBDDvSSn8E/EM/WvQFKOj
AvkqeIikl2QdUeAt892lkd9yuykFYkJraj1Hg3cEjYYUiu+SxTSYf2BAhREiC2v3
XvOtjoGDnOztb1KOxNIrVUO3DrobPJL5S2FhTx3zp2+UKqPSoIffYeU4W8DOJfw6
zrYl46gqPbpKPBA6Hsi3lwPia5jz6m9kSB1dxYMn+kgla/xZbCGtvG6vlv4QLkxq
kTu/vg05r+QkQVDyhi4pjUqyV19w3yYVvYL9ubAY6fDnruKqbHbQgsyjy0ss/yR8
HR1txMnsOx6rbbQM/kHhif2pgrDDT5ak3oCKrdqEAK2r7am7+LZUIPAq+u/ofqo=
=Sv08
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
