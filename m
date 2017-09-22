Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLEQ-0004Qt-Jk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLEP-0004t2-Dr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:30:50 -0400
Date: Fri, 22 Sep 2017 20:15:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922101501.GI4998@umbus.fritz.box>
References: <150600964184.30533.472565821627831467.stgit@bahia.lan>
	<150600965332.30533.14702405809647835716.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <150600965332.30533.14702405809647835716.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] kvm: check KVM_CAP_SYNC_MMU with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 06:00:53PM +0200, Greg Kurz wrote:
> On a server-class ppc host, this capability depends on the KVM type,
> ie, HV or PR. If both KVM are present in the kernel, we will always
> get the HV specific value, even if we explicitely requested PR on
> the command line.
>=20
> This can have an impact if we're using hugepages or a balloon device.
>=20
> Since we've already created the VM at the time any user calls
> kvm_has_sync_mmu(), switching to kvm_vm_check_extension() is
> enough to fix any potential issue.
>=20
> It is okay for the other archs that also implement KVM_CAP_SYNC_MMU,
> ie, mips, s390, x86 and arm, because they don't depend on the VM being
> created or not.
>=20
> While here, let's cache the state of this extension in a bool variable,
> since it has several users in the code, as suggested by Thomas Huth.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/kvm/kvm-all.c    |    8 +++++---
>  accel/stubs/kvm-stub.c |    4 ++--
>  include/sysemu/kvm.h   |    2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b0181d722083..4d96c1fee9fe 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -87,6 +87,7 @@ struct KVMState
>  #endif
>      int many_ioeventfds;
>      int intx_set_mask;
> +    bool sync_mmu;
>      /* The man page (and posix) say ioctl numbers are signed int, but
>       * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
>       * unsigned, and treating them as signed here can break things */
> @@ -1665,6 +1666,8 @@ static int kvm_init(MachineState *ms)
> =20
>      s->many_ioeventfds =3D kvm_check_many_ioeventfds();
> =20
> +    s->sync_mmu =3D !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU=
);
> +
>      return 0;
> =20
>  err:
> @@ -2131,10 +2134,9 @@ int kvm_device_access(int fd, int group, uint64_t =
attr,
>      return err;
>  }
> =20
> -/* Return 1 on success, 0 on failure */
> -int kvm_has_sync_mmu(void)
> +bool kvm_has_sync_mmu(void)
>  {
> -    return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> +    return kvm_state->sync_mmu;
>  }
> =20
>  int kvm_has_vcpu_events(void)
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 3965c528d348..c964af3e1c97 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -64,9 +64,9 @@ int kvm_cpu_exec(CPUState *cpu)
>      abort();
>  }
> =20
> -int kvm_has_sync_mmu(void)
> +bool kvm_has_sync_mmu(void)
>  {
> -    return 0;
> +    return false;
>  }
> =20
>  int kvm_has_many_ioeventfds(void)
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 3a458f50e9f4..bbf12a172339 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -207,7 +207,7 @@ extern KVMState *kvm_state;
>  /* external API */
> =20
>  bool kvm_has_free_slot(MachineState *ms);
> -int kvm_has_sync_mmu(void);
> +bool kvm_has_sync_mmu(void);
>  int kvm_has_vcpu_events(void);
>  int kvm_has_robust_singlestep(void);
>  int kvm_has_debugregs(void);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE4qUACgkQbDjKyiDZ
s5INLg//e2Lwo8I5tRTLAYwE7sWVcBwd6WAEX42zA0XlBZNaZeVx2VwUquYN+i71
PS732pAfybrpSz+sw5utnqdIJi2jYjMX+7iCloGFd1kuaUJ+8JZF2qoaB+cK3f1K
u79p/lXy23OJLWXG4rzroh0SOmUhYV290VkiKlykpMUlk0oPsKxM8phgZOKmDZ4L
fMAdCqA2ncsFaJa3vQIilbbYNYJSJW2BJdLKxHXa2hueL4noNR6cGpwrxqhewONm
y3PLuCHvhnIAPyO0A6rdkXF6eBa8i5DA5EhAhvS6wcLaDGeAryfEahTbOYi7epOI
I0LJzHFlaugCHfzduCTEZoTgtoSWIzHJktidEn+xq6SgM0sePx2Sg6CoD0lL306S
9e55thY53KKo4KUuc1bB/ct8gV5epTbX4yoh+D2nZBg4P81wnrBqda3GXsqfLNnG
mhp6xsE6SDEIgTC8sZOMmQ/A5Twf4V4kXPcqNFfmV23ge5FQT2vA79O8Oicj/ieC
1Hha/0wIg2HXlejypuD4C6uMZri1AWrr/kv9GnnDaRp2V3E07UgSYGCr2sVYQngp
jj7Kuhnak9uVbLcg75Kw5acByijlGF6FHiVkmyDESUPcTmC5+D3JM13JpXBTflV0
MnNZitGLQ4eL0OTbWTTyrT7hy9fuGsVnJm0hDjBG/OtI4XCC53c=
=/qkX
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
