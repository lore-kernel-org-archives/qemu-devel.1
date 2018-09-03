Received: from eggs.gnu.org ([2001:4830:134:3::10]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fwf5t-0001im-51
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fwepl-0001F0-P3
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 22:43:22 -0400
Date: Mon, 3 Sep 2018 11:47:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180903014708.GC2679@umbus.fritz.box>
References: <20180902141904.14479-1-joserz@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20180902141904.14479-1-joserz@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Fix a deadlock case in the CPU hotplug flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2018 at 11:19:04AM -0300, Jose Ricardo Ziviani wrote:
> We need to set cs->halted to 1 before calling ppc_set_compat. The reason
> is that ppc_set_compat kicks up the new thread created to manage the
> hotplugged KVM virtual CPU and the code drives directly to KVM_RUN
> ioctl. When cs->halted is 1, the code:
>=20
> int kvm_cpu_exec(CPUState *cpu)
> ...
>      if (kvm_arch_process_async_events(cpu)) {
>          atomic_set(&cpu->exit_request, 0);
>          return EXCP_HLT;
>      }
> ...
>=20
> returns before it reaches KVM_RUN, giving time to the main thread to
> finish its job. Otherwise we can fall in a deadlock because the KVM
> thread will issue the KVM_RUN ioctl while the main thread is setting up
> KVM registers. Depending on how these jobs are scheduled we'll end up
> freezing QEMU.
>=20
> The following output shows kvm_vcpu_ioctl sleeping because it cannot get
> the mutex and never will.
> PS: kvm_vcpu_ioctl was triggered kvm_set_one_reg - compat_pvr.
>=20
> STATE: TASK_UNINTERRUPTIBLE|TASK_WAKEKILL
>=20
> PID: 61564  TASK: c000003e981e0780  CPU: 48  COMMAND: "qemu-system-ppc"
>  #0 [c000003e982679a0] __schedule at c000000000b10a44
>  #1 [c000003e98267a60] schedule at c000000000b113a8
>  #2 [c000003e98267a90] schedule_preempt_disabled at c000000000b11910
>  #3 [c000003e98267ab0] __mutex_lock at c000000000b132ec
>  #4 [c000003e98267bc0] kvm_vcpu_ioctl at c00800000ea03140 [kvm]
>  #5 [c000003e98267d20] do_vfs_ioctl at c000000000407d30
>  #6 [c000003e98267dc0] ksys_ioctl at c000000000408674
>  #7 [c000003e98267e10] sys_ioctl at c0000000004086f8
>  #8 [c000003e98267e30] system_call at c00000000000b488
>=20
> crash> struct -x kvm.vcpus 0xc000003da0000000
> vcpus =3D {0xc000003db4880000, 0xc000003d52b80000, 0xc0000039e9c80000, 0x=
c000003d0e200000, 0xc000003d58280000, 0x0, 0x0, ...}
>=20
> crash> struct -x kvm_vcpu.mutex.owner 0xc000003d58280000
>   mutex.owner =3D {
>     counter =3D 0xc000003a23a5c881 <- flag 1: waiters
>   },
>=20
> crash> bt 0xc000003a23a5c880
> PID: 61579  TASK: c000003a23a5c880  CPU: 9   COMMAND: "CPU 4/KVM"
> (active)
>=20
> crash> struct -x kvm_vcpu.mutex.wait_list 0xc000003d58280000
>   mutex.wait_list =3D {
>     next =3D 0xc000003e98267b10,
>     prev =3D 0xc000003e98267b10
>   },
>=20
> crash> struct -x mutex_waiter.task 0xc000003e98267b10
>   task =3D 0xc000003e981e0780
>=20
> The following command-line was used to reproduce the problem (note: gdb
> and trace can change the results).
>=20
>  $ qemu-ppc/build/ppc64-softmmu/qemu-system-ppc64 -cpu host \
>      -enable-kvm -m 4096 \
>      -smp 4,maxcpus=3D8,sockets=3D1,cores=3D2,threads=3D4 \
>      -display none -nographic \
>      -drive file=3Ddisk1.qcow2,format=3Dqcow2
>  ...
>  (qemu) device_add host-spapr-cpu-core,core-id=3D4
> [no interaction is possible after it, only SIGKILL to take the terminal
> back]
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>

Applied, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 876f0b3d9d..a73b244a3f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -34,16 +34,16 @@ static void spapr_cpu_reset(void *opaque)
> =20
>      cpu_reset(cs);
> =20
> -    /* Set compatibility mode to match the boot CPU, which was either set
> -     * by the machine reset code or by CAS. This should never fail.
> -     */
> -    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
> -
>      /* All CPUs start halted.  CPU0 is unhalted from the machine level
>       * reset code and the rest are explicitly started up by the guest
>       * using an RTAS call */
>      cs->halted =3D 1;
> =20
> +    /* Set compatibility mode to match the boot CPU, which was either set
> +     * by the machine reset code or by CAS. This should never fail.
> +     */
> +    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
> +
>      env->spr[SPR_HIOR] =3D 0;
> =20
>      lpcr =3D env->spr[SPR_LPCR];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluMkpkACgkQbDjKyiDZ
s5I9chAA1JE8u3AYe1YjGRvJyRDIpE5vFsV8ISUgoeIc6cwKnFQrTrQ0OaQP7s8j
zE56XTvYbog/BUdZY3kOahVO+/1hduaoWvqFsd+niIkwayHm+JTPyHm1BCt4pUJK
q3qO9tsKErAlKgw8C0RP9i+KH9kaLt1fjdq1REXwkG+nkLC8fB6vhMRwyd4M3eyF
mrGDAY+EIPuNRBGlLoygrnbAmMxICI/MsFcMvCbsFLPMy2YGqIABhUXar6WKBJqT
704cKnttBQZjdmeGPh5GjoimVssl3TUo9SpNImI/qpBhv+6gl61c3n8VxwzwREax
XbIaHWbavMCj7rSEqlw8clB+Y9+mDyE5HzgFflaOflm1482Q48Ato7AxRYSH47AH
Fp8MsA+WeTMtw7DM5aNaPJMikwFlb9GZOl/CezXunIP//fg2hqzDICo0o8PEmLGe
r5XsZT8uXWjt16gLQLRr5z52RqDoaGOFeLjSyZGmfwCQKodfJQabT9smEjFwLXvB
7ggIZmG2tDyrWINMRcSHi3UkSTmUtqyLktP1RUHYFL899sZ/5KFx27PhOKf71PpK
JPuMl6vP2RVAhyyiCNCkaD/bGCCLXJbD5Wh6dxRs4eUhJaWHH7x9VohKF40MN5Cn
FJSbrKFptSDrDDbWvjZ/jnC/pDgX+4EZrTPcFEtnzHpn7HCo6uA=
=n7Ta
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
