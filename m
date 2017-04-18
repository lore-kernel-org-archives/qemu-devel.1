Received: from eggs.gnu.org ([2001:4830:134:3::10]:54986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0Jp5-0003yR-MO
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 23:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0Jp1-0007IP-E4
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 23:28:59 -0400
Date: Tue, 18 Apr 2017 12:15:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418021514.GB12235@umbus.fritz.box>
References: <1492069906-11300-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <1492069906-11300-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] cpus: Fix CPU unplug for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, nikunj@linux.vnet.ibm.com, alex.bennee@linaro.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 01:21:46PM +0530, Bharata B Rao wrote:
> Ensure that the unplugged CPU thread is destroyed and the waiting
> thread is notified about it. This is needed for CPU unplug to work
> correctly in MTTCG mode.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.10, thanks.

> ---
>  cpus.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index 740b8dc..79f780b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1483,6 +1483,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                  /* Ignore everything else? */
>                  break;
>              }
> +        } else if (cpu->unplug) {
> +            qemu_tcg_destroy_vcpu(cpu);
> +            cpu->created =3D false;
> +            qemu_cond_signal(&qemu_cpu_cond);
> +            qemu_mutex_unlock_iothread();
> +            return NULL;
>          }
> =20
>          atomic_mb_set(&cpu->exit_request, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9XayAAoJEGw4ysog2bOS92YQAKO6HdKvQdHbRLvBnxcX2/rw
ivY2yvzX62aqNQdPgVKPaKbvZPZEuPQt6gsP0b97ke463fxVCwVWRS3bsQZO+8AO
FnShpKFr8JsO8+1khSFzvqC+zahXCgsQ4Ccswp966F6dFwPMFqq+fkZWbW1Xc+TT
Wt2uJg6gNobe15d+5ihQ8NvyHYPF7w+gx6Bi83YOWBEvlMlyzCJvYeKHgTVdLrJN
HQVY/3nkrqAmRh1bNwl879PghpvC9EiWgW3AwOfx0wgdw0h2Yn39f09ggegLbg6A
fmlyVozOzablrfMHzTqkc3RDVhF1GRLf8c1v37Xt0m8UZYOv5KrIrjwThHKO6Ern
h++PYWyQR1u3q+7AKSI67ZCK8O83ZKfDHj4MvaGplJCkh33AGYcJUF2ZS4el83mD
VLy7HdK2JcRVhhDHRWh25j7NF2UDq22FKWtm4BhH6L3bF05b/MTv9py9m28haoLo
/ayYjhjlarsV41fIjbxowvrbWHV8F9GrRuyML1ITLIu5gDNLvVeaxmVWOzFavbt/
hRharjGIQh4d4c/jEKk4HxXbBU/MX/HdCHTwUDf0xVFNR3KPlmD+bufiMvVxPe/u
//Uohey+NBO9SxY50iBbtXJxrkHGUqHCastqYysClKOqOBdq3S0RNO+AhcgpoGJB
OHCWtj9MAVEZUU3RGv1F
=FXt0
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
