Received: from eggs.gnu.org ([2001:4830:134:3::10]:51581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds75a-0006y5-8d
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds75W-0003oO-8o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:48:22 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:46079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ds75V-0003mb-U1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:48:18 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4ED58AB821
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:48:16 +0200 (CEST)
Date: Wed, 13 Sep 2017 14:48:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170913144810.750b81b0@bahia.lan>
In-Reply-To: <20170913121403.GA3972@umbus.fritz.box>
References: <150529882490.818.398056435765712294.stgit@bahia.lan>
	<20170913121403.GA3972@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6feB7g9mlIW_7QDXsk1xyUv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: fix the value of SDR1 in
 kvmppc_put_books_sregs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>

--Sig_/6feB7g9mlIW_7QDXsk1xyUv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2017 22:14:03 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Sep 13, 2017 at 12:41:07PM +0200, Greg Kurz wrote:
> > When running with KVM PR, if a new HPT is allocated we need to inform
> > KVM about the HPT address and size. This is currently done by hacking
> > the value of SDR1 and pushing it to KVM in several places.
> >=20
> > Also, migration breaks the guest since it is very unlikely the HPT has
> > the same address in source and destination, but we push the incoming
> > value of SDR1 to KVM anyway.
> >=20
> > This patch introduces a new virtual hypervisor hook so that the spapr
> > code can provide the correct value of SDR1 to be pushed to KVM each
> > time kvmppc_put_books_sregs() is called.
> >=20
> > It allows to get rid of all the hacking in the spapr/kvmppc code and
> > it fixes migration of nested KVM PR.
> >=20
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > Unfortunately, this doesn't fix migration when using KVM PR on baremeta=
l.
> > I get tons of instruction emulation errors in the console when the guest
> > resumes execution at the destination:
> >=20
> > [  833.585957] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> > [  833.586818] kvmppc_exit_pr_progint: emulation at 60000000600e5bfc fa=
iled
> >  (00000000)
> > [  833.674684] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> > [  833.675370] kvmppc_exit_pr_progint: emulation at 60000000600e5bfc fa=
iled
> >  (00000000)
> > [  833.676297] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> >=20
> > I still don't know what's happening here but I guess this is an issue in
> > KVM. =20
>=20
> Not necessarily, those could just be because we don't have meaningful
> hash table.  It's possible we're just not pushing the sregs info to
> KVM after the incoming migration.

I'll check this out.

> I still think whatever fix we'll
> need for that will be simpler than the earlier versions.
>=20
> I'll need to test this with HPT resizing (unless you already have).

I had tested with the previous version and it worked. I'll try again with
this patch.

> I think there is a small problem..
>=20
> [snip]
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 57bb411394ed..840abff0e371 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -732,14 +732,6 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU=
 *cpu,
> >          qemu_vfree(spapr->htab);
> >          spapr->htab =3D pending->hpt;
> >          spapr->htab_shift =3D pending->shift;
> > -
> > -        if (kvm_enabled()) {
> > -            /* For KVM PR, update the HPT pointer */
> > -            target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->htab
> > -                | (spapr->htab_shift - 18);
> > -            kvmppc_update_sdr1(sdr1);
> > -        }
> > - =20
>=20
> I don't think we can completely eliminate this for KVM PR.  The sregs
> aren't written back to KVM on every re-entry, only rarely.  So we'll
> still need to force a writeback of all the sregs stuff in order to get
> PR updated properly.
>=20

Oops you're right. Since this isn't a hot path, would it be acceptable to
call kvmppc_put_books_sregs() for all CPUs instead of keeping all the sdr1
specific hack ?

> >          pending->hpt =3D NULL; /* so it's not free()d */
> >      }
> > =20
> > @@ -1564,12 +1556,6 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
> >               * the point this is called, nothing should have been
> >               * entered into the existing HPT */
> >              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> > -            if (kvm_enabled()) {
> > -                /* For KVM PR, update the HPT pointer */
> > -                target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->=
htab
> > -                    | (spapr->htab_shift - 18);
> > -                kvmppc_update_sdr1(sdr1);
> > -            }

Same here.

> >          }
> >      }
> > =20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c9d3ffa89bcb..12e0b6e74876 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1243,6 +1243,8 @@ struct PPCVirtualHypervisorClass {
> >      void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
> >                         uint64_t pte0, uint64_t pte1);
> >      uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
> > +    void (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp,
> > +                                  target_ulong *hpt);
> >  };
> > =20
> >  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 6442dfcb95b3..8edc05fc6a83 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -941,7 +941,11 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> > =20
> >      sregs.pvr =3D env->spr[SPR_PVR];
> > =20
> > -    sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> > +    if (cpu->vhyp) {
> > +        PPCVirtualHypervisorClass *vhc =3D
> > +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > +        vhc->encode_hpt_for_kvm_pr(cpu->vhyp, &sregs.u.s.sdr1);
> > +    }
> > =20
> >      /* Sync SLB */
> >  #ifdef TARGET_PPC64
> > @@ -2806,30 +2810,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, ta=
rget_ulong flags, int shift)
> >      return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhp=
t);
> >  }
> > =20
> > -static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
> > -{
> > -    target_ulong sdr1 =3D arg.target_ptr;
> > -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    CPUPPCState *env =3D &cpu->env;
> > -
> > -    /* This is just for the benefit of PR KVM */
> > -    cpu_synchronize_state(cs);
> > -    env->spr[SPR_SDR1] =3D sdr1;
> > -    if (kvmppc_put_books_sregs(cpu) < 0) {
> > -        error_report("Unable to update SDR1 in KVM");
> > -        exit(1);
> > -    }
> > -}
> > -
> > -void kvmppc_update_sdr1(target_ulong sdr1)
> > -{
> > -    CPUState *cs;
> > -
> > -    CPU_FOREACH(cs) {
> > -        run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr=
1));
> > -    }
> > -}
> > -
> >  /*
> >   * This is a helper function to detect a post migration scenario
> >   * in which a guest, running as KVM-HV, freezes in cpu_post_load becau=
se
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index f780e6ec7b72..21571edd7910 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -68,7 +68,6 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> >  void kvmppc_check_papr_resize_hpt(Error **errp);
> >  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int=
 shift);
> >  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int =
shift);
> > -void kvmppc_update_sdr1(target_ulong sdr1);
> >  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> > =20
> >  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> > @@ -331,11 +330,6 @@ static inline int kvmppc_resize_hpt_commit(PowerPC=
CPU *cpu,
> >      return -ENOSYS;
> >  }
> > =20
> > -static inline void kvmppc_update_sdr1(target_ulong sdr1)
> > -{
> > -    abort();
> > -}
> > -
> >  #endif
> > =20
> >  #ifndef CONFIG_KVM
> >  =20
>=20


--Sig_/6feB7g9mlIW_7QDXsk1xyUv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbkpCgAKCRAC/DrrAQHb
whznAJ9Gq9Zks8tIJlu+5tsY3ahMUBBSbwCfc+Zz3VR3uwP+99rGn6MH5mV5mL8=
=pt8q
-----END PGP SIGNATURE-----

--Sig_/6feB7g9mlIW_7QDXsk1xyUv--
