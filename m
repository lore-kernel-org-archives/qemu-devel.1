Received: from eggs.gnu.org ([2001:4830:134:3::10]:60738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1feGuX-0000IX-Km
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 05:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1feGuW-0006YL-Ap
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 05:32:17 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1feGuV-0006VP-4v
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 05:32:16 -0400
Date: Sat, 14 Jul 2018 19:26:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180714092632.GB2599@umbus.fritz.box>
References: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
	<20180714010700.GA2599@umbus.fritz.box>
	<eb7a52ea-57ce-46eb-c84e-96b5887d6e71@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <eb7a52ea-57ce-46eb-c84e-96b5887d6e71@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: ppc64: use the correct
 values for F_*LK64s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2018 at 07:37:43AM +0200, Laurent Vivier wrote:
> Le 14/07/2018 =E0 03:07, David Gibson a =E9crit=A0:
> > On Fri, Jul 13, 2018 at 07:34:46AM -0500, Shivaprasad G Bhat wrote:
> >> Qemu includes the glibc headers for the host defines and target header=
s are
> >> part of the qemu source themselves. The glibc has the F_GETLK64, F_SET=
LK64
> >> and F_SETLKW64 defined to 12, 13 and 14 for all archs in
> >> sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
> >> definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as seen=
 in
> >> include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the ker=
nel
> >> assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* as
> >> can be seen in include/linux/fcntl.h in linux source.
> >>
> >> On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
> >> explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.
> >> Whereas, a PPC64 host doesn't have such a definition in
> >> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
> >> the sources on PPC64 host sees the default value of F_*LK64*
> >> as 12, 13 & 14(fcntl-linux.h).
> >>
> >> Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl sys=
call
> >> implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64* =
value
> >> convertion back to F_*LK* values on PPC64 as seen in
> >> sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_C=
MD()
> >> macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6 =
and 7
> >> and no adjustments are needed.
> >>
> >> Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on =
its
> >> own, the PPC64 qemu is calling the syscall with 12, 13, and 14(without
> >> adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W all
> >> fail by all pplications run on PPC64 host user emulation.
> >>
> >> The fix here could be to see why on PPC64 the glibc is still keeping
> >> F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 bef=
ore
> >> the syscall for PPC only. See if we can make the
> >> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
> >> 5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. That
> >> way, qemu sources see the kernel supported values in glibc headers.
> >>
> >> OR
> >>
> >> On PPC64 host, qemu sources see both F_*LK & F_*LK64* as same and set =
to
> >> 12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
> >> sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
> >> Do the value adjustment just like it is done by glibc source by using
> >> F_GETLK value of 5. That way, we make the syscalls with the actual
> >> supported values in Qemu. The patch is taking this approach.
> >>
> >> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > I'm not sure if this should go in through my tree or not.
>=20
> I will take it through my linux-user tree, I have some fixes to send for
> the next -rc.

Great, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltJwcMACgkQbDjKyiDZ
s5IkTBAAi0bbucXdOtxWO3yld2fM8vj8XJNtVhxeBFfCV/cp1SlqzLQUecHO0ORS
tfA9ET7WKqc5bsnVhd9YosGXXJX0Z4buHNpofB2aivAgeN2mERZOE99QsEFBDdrv
MFXKRVE2d2q8Xfetpl+vkEjzmHNptaPr9031thbWC2aSN1Mz6rJ7fk+u0TGwlLdY
VnDBCXO1/MmziqZYqxfeCI2a5UNqSJrjqwAnYm6NtlPId9NO2GdhnEAgsn9jfwsA
ivhf0eMEyDo99TICsslDgMU35c9/w6gIWhC/Dngb98Xl/Bz56ZIcU83DB8DLbM7A
hW17Fsa50BLP7NdpOlOf6Qr9w8H4+eAabKotXR8P+qVmM8fPjc650JiAxXOWoCXp
gc4L1YZvMQLSGIuB6rMnWGZW1V01Xl+mk1AcH6YCL044EHjN3ej+hXEeIfACyEhn
GsFcvBrPASVtlUYxYRfh96/VYojezO0hD6Tne84JS5ydUrPvCWf4LIJq7I53mvZ2
CBgOD6WJEHGD8QsUVHdDZm2jj/xvEuYGtHC+b04ejJ/JTxy6gajIQ5oW1gESPirX
ENAZ6tqtfPQ7UXYgowOluNyWJsY6CRNJk9yeiTNkwBJlwznc7OLutkyi5zLy13YG
VTNI0PLd4Et7nYbXe6qtYI49ApZrn7i8A318RKEpqiYw7ftc5Us=
=zZ/+
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
