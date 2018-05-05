Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEojZ-0007u4-2Q
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEojV-0006SU-RK
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:23:45 -0400
Date: Sat, 5 May 2018 14:20:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505042003.GH13229@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180504113724.64b7b1c0@bahia.lan>
	<152543629398.15508.17426624020859105239@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DnQ8R2kNBE8VLNdv"
Content-Disposition: inline
In-Reply-To: <152543629398.15508.17426624020859105239@sif>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: only save guest
 timebase once after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--DnQ8R2kNBE8VLNdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 07:18:13AM -0500, Michael Roth wrote:
> Quoting Greg Kurz (2018-05-04 04:37:24)
> > On Thu,  3 May 2018 23:20:44 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >=20
> > > In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> > > via a runstate hook so we can restore it on qmp_cont(). If a migration
> > > occurs in between those events we end up saving it again, this time
> > > based on the current timebase the guest would be seeing had it been
> > > running. This has the effect of advancing the guest timebase while
> > > it is stopped, which is not what the code intends.
> > >=20
> >=20
> > Hi Mike,
> >=20
> > The current behavior was introduced by:
> >=20
> > commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
> > Author: Laurent Vivier <lvivier@redhat.com>
> > Date:   Fri Jan 27 13:24:58 2017 +0100
> >=20
> >     spapr: clock should count only if vm is running
> >=20
> > and we have this in the changelog:
> >=20
> >     We keep timebase_pre_save to reduce the clock difference on
> >     migration like in:
> >         6053a86 kvmclock: reduce kvmclock difference on migration
> >=20
> >=20
> > So your patch totally negates ^^ ? Also, I can't see a case where
>=20
> Yah... this is a bit confusing. On one hand, the patch/summary is clearly
> trying to avoid the guest time from advancing while it is stopped, which
> is in the spirit of this patch. But at the same time it is trying to
> compensate for loss of time (relative to host) due to downtime window.
>=20
> I think the subtlety is in the amount of time... saving at pre_save
> rather than vm_stop() compensates for the normal downtime window, which
> is *usually* small (5s is the figure they quote in the notes there and
> in the motivating 6053a86 "kvmclock: reduce kvmclock difference on
> migration"). The delays between vm_stop and vm_cont via something like
> virsh suspend/resume is unbounded, unhowever, hence the rationale for
> the runstate hook (?).

> So maybe small jumps are considered okay, and large ones not? If that's
> the reasoning, then this patch is addressing the later, so it's not
> necessarily in conflict with that motivation, but the implementation
> does negate the small jumps we try to avoid via pre_save hook since
> we'll end up keep the version we saved just after vm_stop instead.

So, the size of the jump is an important difference in practice, but I
don't think it's what we should base our decisions on.  Rather, we
should be basing the decision on the *reason* for the jump.

If it's due to an explicit user requested stoppage, then we should
stop the clock.  The user has basically asked for the VM to be put
into statis, and that won't really work if we don't stop the clock.

If the stoppage is due to an internal detail for what, from the user's
point of view, is supposed to be a still-running VM (i.e. a
migration), then the clock should continue.  Otherwise it will be
wrong, afterwards.

> I would note that the downtime window itself, while usually small, can
> also be quite large. With 1GB hugepages we've seen some guests requiring
> downtime windows to be set to 25s until QEMU would start cut-over. Also
> rcu_cpu_stall_timeout is configurable...it's possible if we set it to
> 5s it could trigger on the jump the guest experiences from pre_save (I
> haven't tested that though).

> Maybe trying to compensate for downtime is a generally bad idea and we
> should just leave it up to NTP/etc? Or maybe we should choose a specific
> upper bound on how much migration downtime we're willing to compensate
> for and enforce that directly? E.g. tb->saved becomes tb->saved_time and
> we check the difference in pre_save before calling timebase_save()
> again.

Yes, downtimes can sometimes be long.  I still think it's correct to
keep the clock going in that case.  The guest may give warnings
because it's seeing something funny with the clock.  Something *is*
funny with the clock, and those warnings are correct.  Basically, when
the downtime is that long we can't really maintain the illusion of a
continuously running VM.  Pretending we can by fudging the clocks is
not doing our users a service

> > So your patch totally negates ^^ ? Also, I can't see a case where
> > timebase_save() could be called from vmstate_save_state() while the
> > VM is running, ie, you could drop timebase_pre_save()... or am I
> > *probably* missing something ?
>=20
> Yah, I didn't notice that my patch completely negated the pre_save
> hook... for some reason I was thinking that would continue to function
> normally if we didn't call qmp_stop() explicitly but that's clearly not
> the case. So yah, dropping timebase_pre_save() is essentially what my
> patch is doing...
>=20
> >=20
> > > Other than simple jumps in time, this has been seen to trigger what
> > > appear to be RCU-related crashes in recent kernels when the advance
> > > exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> > > common operations such as `virsh migrate ... --timeout 60`.
> > >=20
> > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Cc: Laurent Vivier <lvivier@redhat.com>
> > > Cc: qemu-ppc@nongnu.org
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/ppc.c         | 12 ++++++++++++
> > >  target/ppc/cpu-qom.h |  1 +
> > >  2 files changed, 13 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > > index ec4be25f49..ff0a107864 100644
> > > --- a/hw/ppc/ppc.c
> > > +++ b/hw/ppc/ppc.c
> > > @@ -865,6 +865,15 @@ static void timebase_save(PPCTimebase *tb)
> > >      uint64_t ticks =3D cpu_get_host_ticks();
> > >      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> > > =20
> > > +    /* since we generally save timebase just after the guest
> > > +     * has stopped, avoid trying to save it again since we will
> > > +     * end up advancing it by the amount of ticks that have
> > > +     * elapsed in the host since the initial save
> > > +     */
> > > +    if (tb->saved) {
> > > +        return;
> > > +    }
> > > +
> > >      if (!first_ppc_cpu->env.tb_env) {
> > >          error_report("No timebase object");
> > >          return;
> > > @@ -877,6 +886,7 @@ static void timebase_save(PPCTimebase *tb)
> > >       * there is no need to update it from KVM here
> > >       */
> > >      tb->guest_timebase =3D ticks + first_ppc_cpu->env.tb_env->tb_off=
set;
> > > +    tb->saved =3D true;
> > >  }
> > > =20
> > >  static void timebase_load(PPCTimebase *tb)
> > > @@ -908,6 +918,8 @@ static void timebase_load(PPCTimebase *tb)
> > >                          &pcpu->env.tb_env->tb_offset);
> > >  #endif
> > >      }
> > > +
> > > +    tb->saved =3D false;
> > >  }
> > > =20
> > >  void cpu_ppc_clock_vm_state_change(void *opaque, int running,
> > > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > > index deaa46a14b..ec2dbcdcae 100644
> > > --- a/target/ppc/cpu-qom.h
> > > +++ b/target/ppc/cpu-qom.h
> > > @@ -210,6 +210,7 @@ typedef struct PowerPCCPUClass {
> > >  typedef struct PPCTimebase {
> > >      uint64_t guest_timebase;
> > >      int64_t time_of_the_day_ns;
> > > +    bool saved;
> > >  } PPCTimebase;
> > > =20
> > >  extern const struct VMStateDescription vmstate_ppc_timebase;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DnQ8R2kNBE8VLNdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtMPAACgkQbDjKyiDZ
s5LoaxAAoxZV/u/lZ+tYp6jgVUmhfvJsy6G+wF1Cku++WOx3bkV6lCQY7nXuyr9s
2MmxvvwGLnkKy1LikqQsnrcBmQkeoT0aJtS+NfFiR2QTLH+L5AD1peYoBWWzOiCK
VauzYrgxXZNm+KW+0BQ3PoJysLAkSmENUZy5VJgHFmzJ6M22f6gtttOgxWWAy22p
A8QrRUB5eJ13l//kuuGvPs2ekL/mQBer5KJjfRz+HH7ylhvmN/JgC7gB+RuF7pHv
i69bmfYsjf2YOR6YtlA3tJLNDXN32K2uaYyqijEid4/W7jaO6LEoADorW0k+Oq5z
f4vayiQhko729oZFnwBt2iD05PPqXATRUvm0p+XGhXb8VFNmnhgNWGDw4Ingcvn2
JsktiMr4Yaz0uemvg+pHoWOo9nhf3CzGl+VPwSb1KlNFH10KQS+0mebZIl2u2O0m
k+i9o1JloqZnZW7WvxzFvTa107odqLUrJulPQqGJrDMX3kk34vLA33QHZ8YNfof9
G5vrMm9FafeEyZcrtxR27p8ApOXMfcaPjqFNSEPzYxo0brMN+A+WtocpyZatiqVe
0Stvgur8wBdZUZjkhuutAZVpwzdJ+NPE5XwvzwJR/bRsds2hSXVtlAKpz9zzUlPd
Pv33PF3CDUqgANkAlcRW9HFStkxuPLHQnbsSE86FaBunrNY0xbI=
=fxhk
-----END PGP SIGNATURE-----

--DnQ8R2kNBE8VLNdv--
