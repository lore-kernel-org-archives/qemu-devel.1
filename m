Received: from eggs.gnu.org ([2001:4830:134:3::10]:51235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558b-00026e-96
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558Z-0004qs-Pk
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:49 -0400
Date: Mon, 1 May 2017 16:45:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501064534.GP13773@umbus.fritz.box>
References: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
	<20170427063203.GC11487@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PdAWLd+WEPmMbsbx"
Content-Disposition: inline
In-Reply-To: <20170427063203.GC11487@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc/xics: preserve P and Q bits for
 KVM IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--PdAWLd+WEPmMbsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 04:32:03PM +1000, Sam Bobroff wrote:
> Kernel commit 17d48610ae0f ("KVM: PPC: Book 3S: XICS: Implement ICS
> P/Q states") added new bits to the state used by KVM IRQs. Currently,
> QEMU does not preserve these bits, so migrating (or otherwise saving
> and restoring) the guest state causes the P and Q bits to be cleared.
>=20
> Clearing the P bit has no effect, because the kernel will set it based
> on other data, but the loss of a set Q bit will cause a lost
> interrupt.
>=20
> This patch preserves the P and Q bits, correcting the problem.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

So, I've applied this to ppc-for-2.10, because AFAICT it makes some
situations better, and can't make any worse.

However, it bothers me that this is effectively adding two bits to the
TCG XICS state, but isn't putting any TCG logic to handle them
correctly.  I'm rather hoping corresponding TCG logic is coming.

I don't believe TCG<->KVM migration works at present, but I don't
think there's a theoretical reason it couldn't, and I'd certainly
prefer not to introduce reasons for it not to work.

> ---
>  hw/intc/xics_kvm.c    | 12 ++++++++++++
>  include/hw/ppc/xics.h |  2 ++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 03c1fc77cb..dd93531ae3 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -229,6 +229,12 @@ static void ics_get_kvm_state(ICSState *ics)
>                      | XICS_STATUS_REJECTED;
>              }
>          }
> +        if (state & KVM_XICS_PRESENTED) {
> +                irq->status |=3D XICS_STATUS_PRESENTED;
> +        }
> +        if (state & KVM_XICS_QUEUED) {
> +                irq->status |=3D XICS_STATUS_QUEUED;
> +        }
>      }
>  }
> =20
> @@ -266,6 +272,12 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
>                  state |=3D KVM_XICS_PENDING;
>              }
>          }
> +        if (irq->status & XICS_STATUS_PRESENTED) {
> +                state |=3D KVM_XICS_PRESENTED;
> +        }
> +        if (irq->status & XICS_STATUS_QUEUED) {
> +                state |=3D KVM_XICS_QUEUED;
> +        }
> =20
>          ret =3D ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
>          if (ret !=3D 0) {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9a5e715fe5..36c79eb45c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -131,6 +131,8 @@ struct ICSIRQState {
>  #define XICS_STATUS_SENT               0x2
>  #define XICS_STATUS_REJECTED           0x4
>  #define XICS_STATUS_MASKED_PENDING     0x8
> +#define XICS_STATUS_PRESENTED          0x10
> +#define XICS_STATUS_QUEUED             0x20
>      uint8_t status;
>  /* (flags & XICS_FLAGS_IRQ_MASK) =3D=3D 0 means the interrupt is not all=
ocated */
>  #define XICS_FLAGS_IRQ_LSI             0x1

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PdAWLd+WEPmMbsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBtmNAAoJEGw4ysog2bOSbAcP/jGBmZE4ez+YBNMGu0ENW8Qr
x1TvIBxAgGgUNaOEZEDi0y6RRBmy55Pa0KP70MjSfqEK5UP7lb49BsaQRR7ug8lz
mPYN4p96uZQxwinLPMEUve7tN89k+g7QsnSZAGhdhwMuJ4+Tw5A86QhXkWNtXE9i
3cyTWbzCWOsZrpaOvgYgy91h46A+bbUDJLXzpCaLPLn6n+MQQv3bM/hdZPcvDEfj
3yWmFqMZnkJ2d1sXnsuMp3FstQcleENY+NN5MYhwixai45uRcZ/4FqAuwI0MQww+
ABHLrnYfHwlugE1uThRJqUq1prVIa6Qu2uw4sLY6Jv555diz7CoqR3LPxob3e3DQ
GD7fgJNAQTc/pLsmNNlshMipt7djKsl57A/DEZrBlcpjCuin0rPeYYqYWdWfUq33
3JNBKCT81tnYHPzrsgaH9Y2r6lJZ1o/w7GvthhjVgMG9fJhVDn4wzOdauQ6oNZkT
GKJJor778+M0pzJwlgwW2Ce0GisDPfsgyfuIcPGaxnpDbusR1LA6pyFEj4LLNYj8
g/jHYUyJi8CTQ/cEQCymuaU3Kknlld+ILP7VPGROBsTms0tG/1YZq09bUFtcxIwv
aErK21sOQIJrsxMtDNzcC4tDVmgGH2td/B9izMCOFXOg2ZbBA/RPl3u0WX0sE7dO
trwxMFSZK2l92muVESot
=E83S
-----END PGP SIGNATURE-----

--PdAWLd+WEPmMbsbx--
