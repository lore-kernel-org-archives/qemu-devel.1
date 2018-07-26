Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiYVP-00029u-1i
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiYVM-0004Db-0p
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:08:03 -0400
Date: Thu, 26 Jul 2018 15:07:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180726050746.GC12001@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 11:20:44PM -0500, Michael Roth wrote:
> In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> via a runstate hook so we can restore it on qmp_cont(). If a migration
> occurs in between those events we end up saving it again, this time
> based on the current timebase the guest would be seeing had it been
> running. This has the effect of advancing the guest timebase while
> it is stopped, which is not what the code intends.
>=20
> Other than simple jumps in time, this has been seen to trigger what
> appear to be RCU-related crashes in recent kernels when the advance
> exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> common operations such as `virsh migrate ... --timeout 60`.
>=20
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Sorry, this fell off my radar for ages, but I've finally had a chance
to look at it properly.

I'm not totally convinced this handle all the possible edge cases
correctly, but I am convinced it gives behaviour that's more correct
than we have now.  It doesn't introduce changes to the interface or
migration stream that would break things in future, so I've applied it
to ppc-for-3.1.

> ---
>  hw/ppc/ppc.c         | 12 ++++++++++++
>  target/ppc/cpu-qom.h |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ec4be25f49..ff0a107864 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -865,6 +865,15 @@ static void timebase_save(PPCTimebase *tb)
>      uint64_t ticks =3D cpu_get_host_ticks();
>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> =20
> +    /* since we generally save timebase just after the guest
> +     * has stopped, avoid trying to save it again since we will
> +     * end up advancing it by the amount of ticks that have
> +     * elapsed in the host since the initial save
> +     */
> +    if (tb->saved) {
> +        return;
> +    }
> +
>      if (!first_ppc_cpu->env.tb_env) {
>          error_report("No timebase object");
>          return;
> @@ -877,6 +886,7 @@ static void timebase_save(PPCTimebase *tb)
>       * there is no need to update it from KVM here
>       */
>      tb->guest_timebase =3D ticks + first_ppc_cpu->env.tb_env->tb_offset;
> +    tb->saved =3D true;
>  }
> =20
>  static void timebase_load(PPCTimebase *tb)
> @@ -908,6 +918,8 @@ static void timebase_load(PPCTimebase *tb)
>                          &pcpu->env.tb_env->tb_offset);
>  #endif
>      }
> +
> +    tb->saved =3D false;
>  }
> =20
>  void cpu_ppc_clock_vm_state_change(void *opaque, int running,
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index deaa46a14b..ec2dbcdcae 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -210,6 +210,7 @@ typedef struct PowerPCCPUClass {
>  typedef struct PPCTimebase {
>      uint64_t guest_timebase;
>      int64_t time_of_the_day_ns;
> +    bool saved;
>  } PPCTimebase;
> =20
>  extern const struct VMStateDescription vmstate_ppc_timebase;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltZVyIACgkQbDjKyiDZ
s5IC/w/9H3g5NxT2Ftb2HJkjPtBvqQI4Wu2GCawKrtZ06j3iybTtsBMeVbzI9utM
p7j39REJ2dDjB+OItAfOX6KBDHKO+sy/fiFJU2ME7jsFKjHEdKxPH5YrQ/QoRoX0
cm30w/Hu6LGZguliLy83eUQXBkvs5eTBeDTNvdfjU2au0Rr4HzMznURWpvZG9kjL
kBDgzJX7k45+7ujeIIRGPOwvbGlC31juRjTjU6jdp+d8StnXZSBl14RY9J2vnaBT
uy228Zq/GYx2mK9Qhp8QHU4FX3RNmV6JdYEhHtzn9MKd35YIyuJHzygjWHI8GoVR
O5DwLLA0rMvQvX0tiR3N31/JCG2gsmnveQqd7EUOFIj+IgoTZmamu9QsTGO/lmyC
wcjSU5xfJYxgbGVEEpCtTMvPenF3yeC73nuS+dF4xGa8Ky7w0kMWMzELIzgGH+Zh
vCMleyebO8UUoo/mpXA9xQMKwXd038Sphd8cjuAm9vXUNTfmsqR2pNuTrxSlKDlA
ckEFKm8+Hxu0wXljvMBIhoxHyld7x2HdLwlizvljmpbWl/GwuCy7TZyT+eWXJo93
Jq8wqWc9FIHVgIc4u9zaKtTxSNnpkWNAaDtC2w2ZwULaONDS6OdawkOTLbgKE4Fq
s4Dkpr6fi4oVicW8/SrIHH3TKnOvLVMOFDKY9ekCCeGi5USdt/w=
=hYxz
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
