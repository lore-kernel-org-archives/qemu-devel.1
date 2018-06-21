Received: from eggs.gnu.org ([2001:4830:134:3::10]:57573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVncd-0005Ka-38
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 20:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVncb-0006Kw-To
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 20:38:47 -0400
Date: Thu, 21 Jun 2018 10:37:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621003758.GB32328@umbus.fritz.box>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
	<1529500053-21704-4-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1529500053-21704-4-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC 3/6] kvm: add kvm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, agraf@suse.de, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 03:07:30PM +0200, Eric Auger wrote:
> Add the kvm_get_max_vm_phys_shift() helper that returns the
> log of the maximum IPA size supported by KVM. This capability
> needs to be known to create the VM with a correct IPA max size
> (kvm_type passed along KVM_CREATE_VM ioctl.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  accel/kvm/kvm-all.c    | 7 +++++++
>  accel/stubs/kvm-stub.c | 5 +++++
>  include/sysemu/kvm.h   | 1 +
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 0590986..137c38e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -280,6 +280,13 @@ static int kvm_set_user_memory_region(KVMMemoryListe=
ner *kml, KVMSlot *slot)
>      return ret;
>  }
> =20
> +int kvm_get_max_vm_phys_shift(MachineState *ms)
> +{
> +    KVMState *s =3D KVM_STATE(ms->accelerator);
> +
> +    return kvm_ioctl(s, KVM_ARM_GET_MAX_VM_PHYS_SHIFT, 0);

=46rom the ioctl() name, I'm assuming this is an ARM specific call.

In which case, shouldn't it be in target/arm.kvm.c, not kvm-all.c ?

> +}
> +
>  int kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s =3D kvm_state;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 02d5170..7575ba7 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -161,6 +161,11 @@ bool kvm_has_free_slot(MachineState *ms)
>      return false;
>  }
> =20
> +int kvm_get_max_vm_phys_shift(MachineState *ms)
> +{
> +    return 0;
> +}
> +
>  void kvm_init_cpu_signals(CPUState *cpu)
>  {
>      abort();
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0b64b8e..240e3d9 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -206,6 +206,7 @@ extern KVMState *kvm_state;
>  /* external API */
> =20
>  bool kvm_has_free_slot(MachineState *ms);
> +int kvm_get_max_vm_phys_shift(MachineState *ms);
>  bool kvm_has_sync_mmu(void);
>  int kvm_has_vcpu_events(void);
>  int kvm_has_robust_singlestep(void);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsq82YACgkQbDjKyiDZ
s5IPLg/+Mwp3WKz9NlTwx9vNw6c+GjPztP2ZHvAp0ZxofimFfaMjGlvmmXmgv72u
H403Df2B53L3Dbu01krp0DFeNF8Vzw8s7IoyyacmO2FyXgSfzIk9eedX9VakY9UA
tviyK8bAI7o0BqVSZa9BKAPzTumn2GSXJPEuzoEgoW7fqLzLYG+LFFpQDYCapi2R
Gj40XeMlk4uz6RmTI6q/dRqi79QsuIrQPHUwXpFUclLFoexNR6OcoeBDk73bMkdU
uy+JmM1elwS0DjgeGjAcg1JR/X5K4adAhJ4JeUbqXdNfhzwFFYtmDZuwp4P16dve
x05Xos6VKPMM0nZuQsmZih5M7/RE1oLM+GSL4BgODrDIlDfhM54ZVlgto1p3T0ny
H+nwSqNKKIt2jioqdP53Pb/Ws++OyBI4bLWHCxh9Z9BTQGzxa3Xre19S5ZArFTF8
wQjwTIL4t+AtTG4uP5tKGOgoJN8aPK7Yjz/6LigDIHQpzsFLKMLiY7AMubSHisKG
EHcWWnNgt8K1U8n7RIICQLETZkM3K4O3Z/TcPhfGICXE9a1QgNLmLAhGxnU7Vrys
L8qPYFre+esnDhtQA3u/MI+mvdR9MZ4Z6Q0NAD0214wGppZHxiwX2u8vuz1GIn9x
WGVdmaHCBiBTJxuExmgWFMqUpyd7j5FOu9OUyy4SwKuVJCFRp7M=
=qEwn
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
