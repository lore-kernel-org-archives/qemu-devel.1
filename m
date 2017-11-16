Received: from eggs.gnu.org ([2001:4830:134:3::10]:50092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFLSL-00018B-NW
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFLSI-0004r1-Ic
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:47:53 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eFLSI-0004qo-7r
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:47:50 -0500
Received: by mail-wm0-x233.google.com with SMTP id v186so606220wma.2
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 06:47:50 -0800 (PST)
Date: Thu, 16 Nov 2017 14:47:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171116144746.GE29106@stefanha-x1.localdomain>
References: <20171115115246.GA1955@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20171115115246.GA1955@redhat.com>
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: libguestfs@redhat.com, pl@kamp.de, qemu-devel@nongnu.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 11:52:46AM +0000, Richard W.M. Jones wrote:
> [CC to qemu-devel since I'm obviously doing something wrong here,
> I'm just not sure what.]
>=20
> I was getting ready to add multiple threads to =E2=80=98qemu-img convert=
=E2=80=99 (the
> longest part of v2v conversions) when I noticed that it had them
> already!  (To be fair this was only added in February this year so no
> wonder we didn't notice.)
>=20
> To enable parallel convert we would need to use the =E2=80=98qemu-img con=
vert
> -W=E2=80=99 option (which allows out-of-order writes to the destination) =
and
> =E2=80=98qemu-img convert -m <#num-coroutines>=E2=80=99 option to select =
the
> parallelism (defaults to 8).  The documentation refers to coroutines
> but I verified from strace that it is using real threads.

The threads you observed are the thread pool that performs
preadv(2)/pwritev(2) syscalls.  The Linux AIO API could be used instead
and does not use threads for read and write operations.  So these
threads are just an implementation detail.  The caller doing the reads
and writes is not multi-threaded but a number of coroutines executing in
a single thread.

The qemu-img convert logic runs in coroutines from just one main loop
thread in qemu-img.c:convert_do_copy():

  for (i =3D 0; i < s->num_coroutines; i++) {
      s->co[i] =3D qemu_coroutine_create(convert_co_do_copy, s);
      s->wait_sector_num[i] =3D -1;
      qemu_coroutine_enter(s->co[i]);
  }

  while (s->running_coroutines) {
      main_loop_wait(false);
  }

>=20
> I did some testing to see what effect this has.  For this I used a
> large guest image which is approximately a third full of random data
> (the rest being sparsely allocated):
>=20
>   Source format:       raw
>   Source virtual size: 100 GB
>   Source used space:   31 GB =20
>   Target format:       qcow2
>   Version:             qemu-img-2.10.0-7.fc28.x86_64
>   Conversion command:
>     rm -f /to/target
>     time qemu-img convert [-W] [-m ##] -f raw source.img -O qcow2 /to/tar=
get
>=20
> Source and target are regular files on two different disks.  The test
> machine is a Xeon E5 with 16 real cores.
>=20
> ----------------------------------------------------------------------
>                   Non-preallocated output
>                   (times are in seconds)
>                    without -W       -W
>=20
> -m 1                153              -
>=20
> -m 4                155             157
>=20
> -m 8 [default]      158             231
>=20
> -m 16 [max]         166             166
> ----------------------------------------------------------------------
>=20
> The documentation for =E2=80=98-W=E2=80=99 notes that this is only recomm=
ended for
> preallocated outputs (which the test above does not use).  So let's
> try using a preallocated qcow2 output.
>=20
>   Conversion command:
>     # the same target file is reused each time
>     time qemu-img convert -n [-W] [-m ##] -f raw source.img -O qcow2 /to/=
target
>=20
> ----------------------------------------------------------------------
>                    Preallocated output
>                   (times are in seconds)
>                    without -W       -W
>=20
> -m 1                147              -
>=20
> -m 4                146             145
>=20
> -m 8 [default]      146             199
>=20
> -m 16 [max]         147             146
> ----------------------------------------------------------------------
>=20
> Based on this there seems to be some issue with the =E2=80=98-W=E2=80=99 =
option -- I
> even thought I might have it backwards, but checking the code it does
> seem like =E2=80=98-W=E2=80=99 enables (rather than disables) out of orde=
r writes.
> Also some bizarre interaction between =E2=80=98-W=E2=80=99 and =E2=80=98-=
m 8=E2=80=99.

Interesting.  Did you perform multiple runs of each setting to verify
that the benchmark results are stable with little volatility?

Which command-line did you use to create the preallocated qcow2 file?

Are the source and target files on the same file system and host block
device?  The benefit of using multiple coroutines depends on the
performance characteristics of the source and target files.

I don't think this qemu-img convert mode has been heavily tested, so it
wouldn't be surprising if you encounter unexpected behavior.  Hopefully
it can be fixed to get even better performance.

Stefan

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDaUSAAoJEJykq7OBq3PIT4sIAJ52w0PubmGb2ufDAjHC6Pf3
bxXts54N3YcvtLNM1OIMQshJfEIrerlEdXKEaSG4jK3e/0llRvfhZpe5Zh1VDTgn
GU4lGXA1lf7ZHRNK0o9BWDsHIvi3s+BLEPpeMgS+nLtU0OKZeKwzFsJeL0mpOuxq
Toi38WxtyUmXl7PXdIxWW6Owz3YuuIWg4ZR6ZFnS56ZGyFPrcoykDfdBEnnIy3Lf
SsCeLgT1HzpY9ZN70u819kopZZdtqXRTZ71dw+riZ43ZCRg6oaTyEbiVyKNoj2uA
h/HJpiPQi2s2rq4kavJslxBYGvSFsr5/VPtnaOL8gP7sZh6zc0+AG6HRCm/tiaA=
=Foq8
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
