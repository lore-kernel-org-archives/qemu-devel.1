Received: from eggs.gnu.org ([2001:4830:134:3::10]:58527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fe97F-0007I5-FD
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 21:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fe97B-0007SY-8p
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 21:12:53 -0400
Received: from ozlabs.org ([203.11.71.1]:53837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fe97A-0007BU-8M
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 21:12:49 -0400
Date: Sat, 14 Jul 2018 11:07:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180714010700.GA2599@umbus.fritz.box>
References: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
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
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-devel@nongnu.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 07:34:46AM -0500, Shivaprasad G Bhat wrote:
> Qemu includes the glibc headers for the host defines and target headers a=
re
> part of the qemu source themselves. The glibc has the F_GETLK64, F_SETLK64
> and F_SETLKW64 defined to 12, 13 and 14 for all archs in
> sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
> definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as seen in
> include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the kernel
> assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* as
> can be seen in include/linux/fcntl.h in linux source.
>=20
> On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
> explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.
> Whereas, a PPC64 host doesn't have such a definition in
> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
> the sources on PPC64 host sees the default value of F_*LK64*
> as 12, 13 & 14(fcntl-linux.h).
>=20
> Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl syscall
> implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64* val=
ue
> convertion back to F_*LK* values on PPC64 as seen in
> sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_CMD()
> macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6 and=
 7
> and no adjustments are needed.
>=20
> Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on its
> own, the PPC64 qemu is calling the syscall with 12, 13, and 14(without
> adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W all
> fail by all pplications run on PPC64 host user emulation.
>=20
> The fix here could be to see why on PPC64 the glibc is still keeping
> F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 before
> the syscall for PPC only. See if we can make the
> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
> 5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. That
> way, qemu sources see the kernel supported values in glibc headers.
>=20
> OR
>=20
> On PPC64 host, qemu sources see both F_*LK & F_*LK64* as same and set to
> 12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
> sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
> Do the value adjustment just like it is done by glibc source by using
> F_GETLK value of 5. That way, we make the syscalls with the actual
> supported values in Qemu. The patch is taking this approach.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I'm not sure if this should go in through my tree or not.

> ---
>  v3 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02923.html
>  Changes from v3:
>     - Fixed the tabs for case statements
>     - Addressed the comments on v3 wrt to the variable initialisation
>       and break from default case.
>  v2 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02920.html
>  Changes from v2:
>     - Fixed the braces, and indentation for comments.
>  v1 - https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02567.html
>  Changes from v1:
>     - Changed the overwrite of F*LK64* with 5, 6 and 7 in using #define
>       instead using the adjustment code similar to glibc as suggested.
>     - Dropped __linux__ check for the adjustment code as suggested.
>     - Moved the adjustment code inside target_to_host_fcntl_cmd to address
>       all possible|future cases.
>=20
>  linux-user/syscall.c |  126 ++++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 80 insertions(+), 46 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 643b8833de..b5274f657a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6475,63 +6475,97 @@ static int do_fork(CPUArchState *env, unsigned in=
t flags, abi_ulong newsp,
>  /* warning : doesn't handle linux specific flags... */
>  static int target_to_host_fcntl_cmd(int cmd)
>  {
> +    int ret;
> +
>      switch(cmd) {
> -	case TARGET_F_DUPFD:
> -	case TARGET_F_GETFD:
> -	case TARGET_F_SETFD:
> -	case TARGET_F_GETFL:
> -	case TARGET_F_SETFL:
> -            return cmd;
> -        case TARGET_F_GETLK:
> -            return F_GETLK64;
> -        case TARGET_F_SETLK:
> -            return F_SETLK64;
> -        case TARGET_F_SETLKW:
> -            return F_SETLKW64;
> -	case TARGET_F_GETOWN:
> -	    return F_GETOWN;
> -	case TARGET_F_SETOWN:
> -	    return F_SETOWN;
> -	case TARGET_F_GETSIG:
> -	    return F_GETSIG;
> -	case TARGET_F_SETSIG:
> -	    return F_SETSIG;
> +    case TARGET_F_DUPFD:
> +    case TARGET_F_GETFD:
> +    case TARGET_F_SETFD:
> +    case TARGET_F_GETFL:
> +    case TARGET_F_SETFL:
> +        ret =3D cmd;
> +        break;
> +    case TARGET_F_GETLK:
> +        ret =3D F_GETLK64;
> +        break;
> +    case TARGET_F_SETLK:
> +        ret =3D F_SETLK64;
> +        break;
> +    case TARGET_F_SETLKW:
> +        ret =3D F_SETLKW64;
> +        break;
> +    case TARGET_F_GETOWN:
> +        ret =3D F_GETOWN;
> +        break;
> +    case TARGET_F_SETOWN:
> +        ret =3D F_SETOWN;
> +        break;
> +    case TARGET_F_GETSIG:
> +        ret =3D F_GETSIG;
> +        break;
> +    case TARGET_F_SETSIG:
> +        ret =3D F_SETSIG;
> +        break;
>  #if TARGET_ABI_BITS =3D=3D 32
> -        case TARGET_F_GETLK64:
> -	    return F_GETLK64;
> -	case TARGET_F_SETLK64:
> -	    return F_SETLK64;
> -	case TARGET_F_SETLKW64:
> -	    return F_SETLKW64;
> -#endif
> -        case TARGET_F_SETLEASE:
> -            return F_SETLEASE;
> -        case TARGET_F_GETLEASE:
> -            return F_GETLEASE;
> +    case TARGET_F_GETLK64:
> +        ret =3D F_GETLK64;
> +        break;
> +    case TARGET_F_SETLK64:
> +        ret =3D F_SETLK64;
> +        break;
> +    case TARGET_F_SETLKW64:
> +        ret =3D F_SETLKW64;
> +        break;
> +#endif
> +    case TARGET_F_SETLEASE:
> +        ret =3D F_SETLEASE;
> +        break;
> +    case TARGET_F_GETLEASE:
> +        ret =3D F_GETLEASE;
> +        break;
>  #ifdef F_DUPFD_CLOEXEC
> -        case TARGET_F_DUPFD_CLOEXEC:
> -            return F_DUPFD_CLOEXEC;
> +    case TARGET_F_DUPFD_CLOEXEC:
> +        ret =3D F_DUPFD_CLOEXEC;
> +        break;
>  #endif
> -        case TARGET_F_NOTIFY:
> -            return F_NOTIFY;
> +    case TARGET_F_NOTIFY:
> +        ret =3D F_NOTIFY;
> +        break;
>  #ifdef F_GETOWN_EX
> -	case TARGET_F_GETOWN_EX:
> -	    return F_GETOWN_EX;
> +    case TARGET_F_GETOWN_EX:
> +        ret =3D F_GETOWN_EX;
> +        break;
>  #endif
>  #ifdef F_SETOWN_EX
> -	case TARGET_F_SETOWN_EX:
> -	    return F_SETOWN_EX;
> +    case TARGET_F_SETOWN_EX:
> +        ret =3D F_SETOWN_EX;
> +        break;
>  #endif
>  #ifdef F_SETPIPE_SZ
> -        case TARGET_F_SETPIPE_SZ:
> -            return F_SETPIPE_SZ;
> -        case TARGET_F_GETPIPE_SZ:
> -            return F_GETPIPE_SZ;
> +    case TARGET_F_SETPIPE_SZ:
> +        ret =3D F_SETPIPE_SZ;
> +        break;
> +    case TARGET_F_GETPIPE_SZ:
> +        ret =3D F_GETPIPE_SZ;
> +        break;
>  #endif
> -	default:
> -            return -TARGET_EINVAL;
> +    default:
> +        ret =3D -TARGET_EINVAL;
> +        break;
>      }
> -    return -TARGET_EINVAL;
> +
> +#if defined(__powerpc64__)
> +    /* On PPC64, glibc headers has the F_*LK* defined to 12, 13 and 14 a=
nd
> +     * is not supported by kernel. The glibc fcntl call actually adjusts
> +     * them to 5, 6 and 7 before making the syscall(). Since we make the
> +     * syscall directly, adjust to what is supported by the kernel.
> +     */
> +    if (ret >=3D F_GETLK64 && ret <=3D F_SETLKW64) {
> +        ret -=3D F_GETLK64 - 5;
> +    }
> +#endif
> +
> +    return ret;
>  }
> =20
>  #define TRANSTBL_CONVERT(a) { -1, TARGET_##a, -1, a }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltJTLIACgkQbDjKyiDZ
s5LzmBAA1nGGZ+on8JFk/kT2zrhLAnXtStfXzZ5pB8uMzujXAcSykQLvtu1krNX4
nmhOyg+2vzbL6Lp2TVn7kE5dnQ8WOziVPX8vjmfl5uj9xP91ZVkxRuoezCl6xfoc
/ul9zvtznSgeL7fWO7FKBm/S4naDSNhmD+8uYDUFM7ELMUoWyWfu7aG0CE3btWRh
KHsZ4jGEE9aAysWqM1GMGEBGYEsXCghFvngsKsxYzX3c7n2YJOPFebR6W1r3dfAB
K3xJM0AtYVVRQii8JarCH3VF69r6L64TgRTsGiWpo3PEsjEDINCyoy0De+M8y5tQ
eTo/O+3f71SoAQFUUQlNFT9FOmuwls1Ifs2b/Ax++yW9Kr4kcySnL18msxU6gtcv
5IHGCjpD+ftuSxYrz3YJFEj/aOOju2SUt1LrYPnbmt51O9W3GvcQWqzhwg9GTFYa
cSTPKeaLHhtJP6jmAYoE1535I0Otd8n3ZlBJaraySXv8AEicl3MZ3HmtDVkVJCbC
hAqsa/sm078AKDlBX4nAzo7pok5E34gOtucfFOtPZAEzpB6lWQOzX2s0TQO57pP7
ecVJDPoARFNG6u0zpUUolgymRIveKhONlhWQJXafX07HBDfxPccHG1DLrPc2/okZ
IUfa6tJB9GB+GyqJ/83JpJVEtTNXauMjxP0hM0gfIJnIwRurjtk=
=uOru
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
