Received: from eggs.gnu.org ([209.51.188.92]:33020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4fh-0000fb-Fs
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4fg-0004X6-Fl
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:13:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gk4fg-0004Tn-8X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:13:12 -0500
Received: by mail-wm1-x32d.google.com with SMTP id f188so400752wmf.5
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:13:12 -0800 (PST)
Date: Thu, 17 Jan 2019 10:13:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190117101309.GA27840@stefanha-x1.localdomain>
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 10:05:58PM +0300, Julia Suvorova via Qemu-devel wro=
te:
> On 16.01.2019 0:51, Alistair Francis wrote:
> > On Tue, Jan 15, 2019 at 7:04 AM Julia Suvorova via Qemu-devel
> > <qemu-devel@nongnu.org> wrote:
> > >=20
> > > If the memory is set using a file, and PC is specified on the command
> > > line, it will be overwritten with the value 'entry'. This is not only
> > > illogical, but also incorrect, because the load_ * functions do not t=
ake
> > > into account the specifics of the ARM-M PC.
> >=20
> > How does this come up?
> > I see that the value of entry will force overwrite the PC addr, but
> > doesn't force_raw fix that? Is there a common use case of loading an
> > ELF/uimage but having to manually specify a start address?
>=20
> generic_loader_reset() is called after arm_cpu_reset() and damages PC
> (it is wrong to call arm_cpu_set_pc() with entry to set ARM PC reset
> value). Therefore, I tried to configure PC manually and ran into this
> problem.
>=20
> By the way, I do not know the right way to fix the original issue. Try
> to replace generic_loader_reset() with the device reset function or
> change the reset order or transfer PC reset value setting to a separate
> function and associate it with cpu. What do you think about it?

generic_loader_reset() calls cpu_reset(s->cpu) followed by
CPUClass->set_pc(s->cpu, s->addr).

ARM's arm_cpu_set_pc() doesn't special-case the Thumb bit (that's only
done in arm_cpu_reset()) so we end up with an invalid PC for Thumb mode
addresses.

Maybe the following arm_cpu_reset() code should be moved to
arm_cpu_set_pc():

  env->regs[15] =3D initial_pc & ~1;
  env->thumb =3D initial_pc & 1;

Then arm_cpu_reset() can call arm_cpu_set_pc() instead of duplicating
this code.

I haven't checked whether more special logic is needed in
arm_cpu_set_pc() aside from setting Thumb mode, but I think this should
do the trick?

Stefan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQFU0AAoJEJykq7OBq3PIAYcIAJLrREPwYDfjMKjSXREhhnSY
dXnVmwEh5kJoBqlz+DrkxC0jM+YKv2unNfpw4MfGMRTjad77wVS1cD17HuOlWPQo
3+Tp6BnQtY49D06z4Xhs/7SA8zF1lCeg3bTIH7l91F2EIaap4/WbFn6J7N3TGNLA
YrJHg+f4tS3fd/StWzCLlN0sQwHPHrnJh1gajAVtFSMMtRafyzv1S/ojlybBUnVP
yC36nV94UYK7v0zNWKH+EELfkiniJRWVHi9I8+GlceFpYWe7BqDOuG3Mapg76Qzv
6BJETk7+jWGT03em8z0ysKhkHrhAn3rz3wEDtQ3RBsfTUq2YRw0Cco+V9LbsFZ8=
=Ss+9
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
