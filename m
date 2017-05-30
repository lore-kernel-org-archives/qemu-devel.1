Received: from eggs.gnu.org ([2001:4830:134:3::10]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFasi-0004tB-SN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFasf-0000sQ-PX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:43:52 -0400
Date: Tue, 30 May 2017 16:15:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170530061523.GD12163@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-3-david@gibson.dropbear.id.au>
	<20170529224605.0d1c31ef@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20170529224605.0d1c31ef@bahia.ttt.fr.ibm.com>
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
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 10:46:05PM +0200, Greg Kurz wrote:
> On Fri, 26 May 2017 15:23:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > As a rule, CPU internal state should never be updated when
> > !cpu->kvm_vcpu_dirty (or the HAX equivalent).  If that is done, then
> > subsequent calls to cpu_synchronize_state() - usually safe and idempote=
nt -
> > will clobber state.
> >=20
> > However, we routinely do this during a loadvm or incoming migration.
> > Usually this is called shortly after a reset, which will clear all the =
cpu
> > dirty flags with cpu_synchronize_all_post_reset().  Nothing is expected
> > to set the dirty flags again before the cpu state is loaded from the
> > incoming stream.
> >=20
> > This means that it isn't safe to call cpu_synchronize_state() from a
> > post_load handler, which is non-obvious and potentially inconvenient.
> >=20
> > We could cpu_synchronize_all_state() before the loadvm, but that would =
be
> > overkill since a) we expect the state to already be synchronized from t=
he
> > reset and b) we expect to completely rewrite the state with a call to
> > cpu_synchronize_all_post_init() at the end of qemu_loadvm_state().
> >=20
> > To clear this up, this patch introduces cpu_synchronize_pre_loadvm() and
> > associated helpers, which simply marks the cpu state as dirty without
> > actually changing anything.  i.e. it says we want to discard any existi=
ng
> > KVM (or HAX) state and replace it with what we're going to load.
> >=20
>=20
> This makes sense and looks nicer than adding a post-load specific path to
> ppc_set_compat() indeed.
>=20
> Just one remark below.
>=20
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Dave Gilbert <dgilbert@redhat.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  cpus.c                    |  9 +++++++++
> >  include/sysemu/cpus.h     |  1 +
> >  include/sysemu/hax.h      |  1 +
> >  include/sysemu/hw_accel.h | 10 ++++++++++
> >  include/sysemu/kvm.h      |  1 +
> >  kvm-all.c                 | 10 ++++++++++
> >  migration/savevm.c        |  2 ++
> >  target/i386/hax-all.c     | 10 ++++++++++
> >  8 files changed, 44 insertions(+)
> >=20
> > diff --git a/cpus.c b/cpus.c
> > index 516e5cb..6398439 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -921,6 +921,15 @@ void cpu_synchronize_all_post_init(void)
> >      }
> >  }
> > =20
> > +void cpu_synchronize_all_pre_loadvm(void)
> > +{
> > +    CPUState *cpu;
> > +
> > +    CPU_FOREACH(cpu) {
> > +        cpu_synchronize_pre_loadvm(cpu);
> > +    }
> > +}
> > +
> >  static int do_vm_stop(RunState state)
> >  {
> >      int ret =3D 0;
> > diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> > index a8053f1..731756d 100644
> > --- a/include/sysemu/cpus.h
> > +++ b/include/sysemu/cpus.h
> > @@ -27,6 +27,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType=
 type);
> >  void cpu_synchronize_all_states(void);
> >  void cpu_synchronize_all_post_reset(void);
> >  void cpu_synchronize_all_post_init(void);
> > +void cpu_synchronize_all_pre_loadvm(void);
> > =20
> >  void qtest_clock_warp(int64_t dest);
> > =20
> > diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
> > index d9f0239..232a68a 100644
> > --- a/include/sysemu/hax.h
> > +++ b/include/sysemu/hax.h
> > @@ -33,6 +33,7 @@ int hax_populate_ram(uint64_t va, uint32_t size);
> >  void hax_cpu_synchronize_state(CPUState *cpu);
> >  void hax_cpu_synchronize_post_reset(CPUState *cpu);
> >  void hax_cpu_synchronize_post_init(CPUState *cpu);
> > +void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
> > =20
> >  #ifdef CONFIG_HAX
> > =20
> > diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> > index c9b3105..469ffda 100644
> > --- a/include/sysemu/hw_accel.h
> > +++ b/include/sysemu/hw_accel.h
> > @@ -45,4 +45,14 @@ static inline void cpu_synchronize_post_init(CPUStat=
e *cpu)
> >      }
> >  }
> > =20
> > +static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> > +{
> > +    if (kvm_enabled()) {
> > +        kvm_cpu_synchronize_pre_loadvm(cpu);
> > +    }
> > +    if (hax_enabled()) {
> > +        hax_cpu_synchronize_pre_loadvm(cpu);
> > +    }
> > +}
> > +
> >  #endif /* QEMU_HW_ACCEL_H */
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 5cc83f2..a45c145 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -459,6 +459,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s,=
 void *ram_addr,
> >  void kvm_cpu_synchronize_state(CPUState *cpu);
> >  void kvm_cpu_synchronize_post_reset(CPUState *cpu);
> >  void kvm_cpu_synchronize_post_init(CPUState *cpu);
> > +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
> > =20
> >  void kvm_init_cpu_signals(CPUState *cpu);
> > =20
> > diff --git a/kvm-all.c b/kvm-all.c
> > index 90b8573..a8485bd 100644
> > --- a/kvm-all.c
> > +++ b/kvm-all.c
> > @@ -1896,6 +1896,16 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
> >      run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
> >  }
> > =20
> > +static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cp=
u_data arg)
> > +{
> > +    cpu->kvm_vcpu_dirty =3D true;
> > +}
> > +
> > +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> > +{
> > +    run_on_cpu(cpu, do_kvm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL=
);
>=20
> Do we really need to run_on_cpu() since we only set the dirty flag ?

Um.. yeah.. I'm not sure.  I left it in out of paranoia, because I
wasn't sure if there could be memory ordering issues between the qemu
threads if we just set it from the migration thread.

I'm hoping Dave or Juan will have a better idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLQ37AAoJEGw4ysog2bOS4FwQALmSWxhdkqzk6mygn3aqswKN
Wr/VLeE3QbqAC0d340ty/s2IsT0Ft4JN1raJPpOBUxB4WYtfZJernJuK/onmyRTP
Q4PL3JlT9xiK9aKgk9p/stAd7WvBEYbSl+7obdXbzxhaRIgZLbvdfXerZXxJvr7F
Ae/Rw+aZOUV1TL6YXYOXS2S3WbpFr8qO2qH4j/EV6ktgbddOlAhNXQwNM63aWa9P
jyLO0ohiRuTlExZ8Alj4N4ep+sA61eqdrxvgARsDvMtC1192NH+3ttS9ZsEPdwty
YNnhMhRVaVX0sI1rWQdptiHbU3CDkjFEOJWHNrfZ0Y03k4EtebT6n1hcRB1aopbP
/tZaP3Uqi4wE1adYsmKG5HL5084oRaC+3/FlwaEBp/M47OF5azDmV8uryyzIJKr4
Hkp72rDMCV4MGHAAFksDKX+xxOaY09Soj1XYiA5tk6ySj1g/gl6v1gcoHGqEi+fu
i4TDDhKX60uQodcPoGYVypoofx5OWBzKhQfOLlJW7u2lQehvxuTqAqudC85tz23z
7y0jIqxe9sR6zUapheFDRFK9saFqiIR3k0OZJZ9lFZTuoACvwerWF/JVo8UD0vZt
gXoqmM8zGFSiLs3pRGZTf4MbheRO9KeIJeoJ8h9Y6oUNDa4H1qDs8jE4Kjk4Ujh2
s41UnGK0g/d2rfLhZxJk
=WM2X
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
