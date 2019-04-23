Received: from eggs.gnu.org ([209.51.188.92]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpXe-0001LY-Vp
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpJr-0001vj-AB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:54:20 -0400
Date: Tue, 23 Apr 2019 16:47:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190423064737.GE31496@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591658718.20338.10108476276907741991.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <155591658718.20338.10108476276907741991.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v8 2/6] Wrapper function to wait on
 condition for the main loop mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org, mahesh@linux.vnet.ibm.com


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:33:07PM +0530, Aravinda Prasad wrote:
> Introduce a wrapper function to wait on condition for
> the main loop mutex. This function atomically releases
> the main loop mutex and causes the calling thread to
> block on the condition. This wrapper is required because
> qemu_global_mutex is a static variable.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  cpus.c                   |    5 +++++
>  include/qemu/main-loop.h |    8 ++++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index e83f72b..d9379e7 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1858,6 +1858,11 @@ void qemu_mutex_unlock_iothread(void)
>      qemu_mutex_unlock(&qemu_global_mutex);
>  }
> =20
> +void qemu_cond_wait_iothread(QemuCond *cond)
> +{
> +    qemu_cond_wait(cond, &qemu_global_mutex);
> +}
> +
>  static bool all_vcpus_paused(void)
>  {
>      CPUState *cpu;
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index f6ba78e..a6d20b0 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file,=
 int line);
>   */
>  void qemu_mutex_unlock_iothread(void);
> =20
> +/*
> + * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
> + *
> + * This function atomically releases the main loop mutex and causes
> + * the calling thread to block on the condition.
> + */
> +void qemu_cond_wait_iothread(QemuCond *cond);
> +
>  /* internal interfaces */
> =20
>  void qemu_fd_register(int fd);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly+tQkACgkQbDjKyiDZ
s5LJ1BAAgKQ9jKuGBWJ7td4pp/tblbdTB51ZqSgVTO9Eu6owlj3y2ukc64VNf2Bi
/wqbPYN9LhztW4wTXVn4rJp1N1NBBH9KSCdLNYJZkY0Jb47EabToVkm3KiHr4GM7
qGozdqqj9NDTqGbzaF0rQmAPpl+fcif3qfULpoevTOLtW93rsvNmrIjzeQXi7hTm
IvcLbtbkVIqfYMkTecpa0E9unqabGHclw/lmlJuosQ2E2bnu/1gq217wO2Itt3T/
yD6uf6DagQaN9KMaBfnFyMfR8juRjywIftucg3PieD3FOpndewEBuPLvrCSVQf4Q
dQksvGj7VamHXfUKikoUAB/npBxWSgnw+1ER2eScfgTkKpfhkxRNA/9HPLQ/sE5s
XZaUumtWMsA+NyvXhi+UOz9RM2VR+iCZ10hw+PAde7SkymOVybYETzbZ0Ax8ZB3N
EnIe7SY7ZYOWPDGw/mc8cSlginGuWyCLV3ofbQNHSvGropniMWee9OVf73z61FEt
EU6X8Ry62DAvOKgLn7GhC5CKHQ3MjppTWSkhjV94eQj6HenfVci8vSq5N/lhFjPd
hGXHoceF/73Gf7vyW1V7eH+895NFtY01R8ekhn3DRYbArIHgYWobYcg11WepKA9c
pSfxdwY6bB0C4IdIeKCKXzVTYv+70DE+FOzIOl2QA3HnPmrR2UU=
=Zn4U
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
