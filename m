Received: from eggs.gnu.org ([2001:4830:134:3::10]:53243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFRYd-0007qO-4l
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFRYY-0003yG-84
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:46:31 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:36128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFRYX-0003xi-TB
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:46:26 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BD921FBF91
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 22:46:22 +0200 (CEST)
Date: Mon, 29 May 2017 22:46:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170529224605.0d1c31ef@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170526052319.28096-3-david@gibson.dropbear.id.au>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/O9Tp8sF_XWf3x5byspWrPwy";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv4 2/5] migration: Mark CPU states dirty
 before incoming migration/loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

--Sig_/O9Tp8sF_XWf3x5byspWrPwy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 May 2017 15:23:16 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> As a rule, CPU internal state should never be updated when
> !cpu->kvm_vcpu_dirty (or the HAX equivalent).  If that is done, then
> subsequent calls to cpu_synchronize_state() - usually safe and idempotent=
 -
> will clobber state.
>=20
> However, we routinely do this during a loadvm or incoming migration.
> Usually this is called shortly after a reset, which will clear all the cpu
> dirty flags with cpu_synchronize_all_post_reset().  Nothing is expected
> to set the dirty flags again before the cpu state is loaded from the
> incoming stream.
>=20
> This means that it isn't safe to call cpu_synchronize_state() from a
> post_load handler, which is non-obvious and potentially inconvenient.
>=20
> We could cpu_synchronize_all_state() before the loadvm, but that would be
> overkill since a) we expect the state to already be synchronized from the
> reset and b) we expect to completely rewrite the state with a call to
> cpu_synchronize_all_post_init() at the end of qemu_loadvm_state().
>=20
> To clear this up, this patch introduces cpu_synchronize_pre_loadvm() and
> associated helpers, which simply marks the cpu state as dirty without
> actually changing anything.  i.e. it says we want to discard any existing
> KVM (or HAX) state and replace it with what we're going to load.
>=20

This makes sense and looks nicer than adding a post-load specific path to
ppc_set_compat() indeed.

Just one remark below.

> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dave Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  cpus.c                    |  9 +++++++++
>  include/sysemu/cpus.h     |  1 +
>  include/sysemu/hax.h      |  1 +
>  include/sysemu/hw_accel.h | 10 ++++++++++
>  include/sysemu/kvm.h      |  1 +
>  kvm-all.c                 | 10 ++++++++++
>  migration/savevm.c        |  2 ++
>  target/i386/hax-all.c     | 10 ++++++++++
>  8 files changed, 44 insertions(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index 516e5cb..6398439 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -921,6 +921,15 @@ void cpu_synchronize_all_post_init(void)
>      }
>  }
> =20
> +void cpu_synchronize_all_pre_loadvm(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_synchronize_pre_loadvm(cpu);
> +    }
> +}
> +
>  static int do_vm_stop(RunState state)
>  {
>      int ret =3D 0;
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index a8053f1..731756d 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -27,6 +27,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType t=
ype);
>  void cpu_synchronize_all_states(void);
>  void cpu_synchronize_all_post_reset(void);
>  void cpu_synchronize_all_post_init(void);
> +void cpu_synchronize_all_pre_loadvm(void);
> =20
>  void qtest_clock_warp(int64_t dest);
> =20
> diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
> index d9f0239..232a68a 100644
> --- a/include/sysemu/hax.h
> +++ b/include/sysemu/hax.h
> @@ -33,6 +33,7 @@ int hax_populate_ram(uint64_t va, uint32_t size);
>  void hax_cpu_synchronize_state(CPUState *cpu);
>  void hax_cpu_synchronize_post_reset(CPUState *cpu);
>  void hax_cpu_synchronize_post_init(CPUState *cpu);
> +void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
> =20
>  #ifdef CONFIG_HAX
> =20
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index c9b3105..469ffda 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -45,4 +45,14 @@ static inline void cpu_synchronize_post_init(CPUState =
*cpu)
>      }
>  }
> =20
> +static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +    if (kvm_enabled()) {
> +        kvm_cpu_synchronize_pre_loadvm(cpu);
> +    }
> +    if (hax_enabled()) {
> +        hax_cpu_synchronize_pre_loadvm(cpu);
> +    }
> +}
> +
>  #endif /* QEMU_HW_ACCEL_H */
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 5cc83f2..a45c145 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -459,6 +459,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, v=
oid *ram_addr,
>  void kvm_cpu_synchronize_state(CPUState *cpu);
>  void kvm_cpu_synchronize_post_reset(CPUState *cpu);
>  void kvm_cpu_synchronize_post_init(CPUState *cpu);
> +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
> =20
>  void kvm_init_cpu_signals(CPUState *cpu);
> =20
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..a8485bd 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1896,6 +1896,16 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
>      run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>  }
> =20
> +static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_=
data arg)
> +{
> +    cpu->kvm_vcpu_dirty =3D true;
> +}
> +
> +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +    run_on_cpu(cpu, do_kvm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);

Do we really need to run_on_cpu() since we only set the dirty flag ?

> +}
> +
>  #ifdef KVM_HAVE_MCE_INJECTION
>  static __thread void *pending_sigbus_addr;
>  static __thread int pending_sigbus_code;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d971e5e..6391131 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2011,6 +2011,8 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
> =20
> +    cpu_synchronize_all_pre_loadvm();
> +
>      ret =3D qemu_loadvm_state_main(f, mis);
>      qemu_event_set(&mis->main_thread_load_event);
> =20
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index ef13015..1306722 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -635,6 +635,16 @@ void hax_cpu_synchronize_post_init(CPUState *cpu)
>      run_on_cpu(cpu, do_hax_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>  }
> =20
> +static void do_hax_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_=
data arg)
> +{
> +    cpu->hax_vcpu_dirty =3D true;
> +}
> +
> +void hax_cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +    run_on_cpu(cpu, do_hax_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
> +}
> +
>  int hax_smp_cpu_exec(CPUState *cpu)
>  {
>      CPUArchState *env =3D (CPUArchState *) (cpu->env_ptr);


--Sig_/O9Tp8sF_XWf3x5byspWrPwy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlksiI0ACgkQAvw66wEB28LUlACfR42SBXYra81IvyLKP9PNhqUH
2jcAnjrt57qh8CxMMsuOwF5MpCY0mGZE
=jGWP
-----END PGP SIGNATURE-----

--Sig_/O9Tp8sF_XWf3x5byspWrPwy--
