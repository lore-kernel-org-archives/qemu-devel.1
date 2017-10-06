Received: from eggs.gnu.org ([2001:4830:134:3::10]:47463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OlV-0007xW-7L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OlT-0003Xk-Cc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:17:53 -0400
Date: Fri, 6 Oct 2017 20:17:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006091741.GI10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-13-git-send-email-imammedo@redhat.com>
	<20171006035447.GP3260@umbus.fritz.box>
	<20171006110352.64b7a814@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <20171006110352.64b7a814@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/23] ppc: move '-cpu foo,
 compat=xxx' parsing into ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:03:52AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 14:54:47 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 05, 2017 at 06:24:39PM +0200, Igor Mammedov wrote:
> > > there is a dedicated callback CPUClass::parse_features
> > > which purpose is to convert -cpu features into a set of
> > > global properties AND deal with compat/legacy features
> > > that couldn't be directly translated into CPU's properties.
> > >=20
> > > Create ppc variant of it (ppc_cpu_parse_featurestr) and
> > > move 'compat=3Dval' handling from spapr_cpu_core.c into it.
> > > That removes a dependency of board/core code on cpu_model
> > > parsing and would let to reuse common -cpu parsing
> > > introduced by 6063d4c0
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Hrm.  I'm a bit unsure about this.  The fact that the board code is
> > involved in the parsing here is deliberate.  Basically 'compat=3D' never
> > made sense as a cpu property, it always should have been a machine
> > property.
> >=20
> > With this patch we'll still (correctly) fail on a non spapr machine at
> > the point where we do:
> >=20
> > +            object_property_set_str(machine, v, "max-cpu-compat", &loc=
al_err);
> >=20
> > Though probably with a rather cryptic error.
> I's possible to guard it and apply to only SPAPR machine
> or trying to find property first before setting it.

Yeah, I think we should do that.  Or possibly we could do something
with the vhyp interface.  If there was ever a vhyp machine other than
spapr (unlikely) then compat modes would also make sense for it (vhyp
being non-NULL basically means that our vcpu is never allowed to enter
hypervisor mode, so hypervisor privileged registers like LPCR need to
be handled by the machine instead).

> > It still pollutes the cpu code with spapr's past mistake though.  I'm
> > not sure if this is a good tradeoff.
> CPUClass::parse_features callback was introduced to deal with=20
> legacy and compatibility nuances of "-cpu" CLI option, so I'm moving
> compat mistake back where it belongs so it will pollute code dealing
> with hacks.

Hm, ok.  Still seems a bit odd to me, but I'll take your word for it.

> It also cleans the road for removal of global cpu_model by moving
> dependency from board code to a callback designed to parse cpu_model.
>=20
>=20
> > > ---
> > >  include/hw/ppc/spapr.h      |  1 -
> > >  target/ppc/cpu-qom.h        |  1 +
> > >  hw/ppc/spapr.c              |  2 +-
> > >  hw/ppc/spapr_cpu_core.c     | 50 -----------------------------------=
---
> > >  target/ppc/translate_init.c | 58 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  5 files changed, 60 insertions(+), 52 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index c1b365f..8ca4f94 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -659,7 +659,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPR=
DRConnectorType drc_type,
> > >                                              uint32_t count, uint32_t=
 index);
> > >  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType =
drc_type,
> > >                                                 uint32_t count, uint3=
2_t index);
> > > -void spapr_cpu_parse_features(sPAPRMachineState *spapr);
> > >  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> > >  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> > >                            Error **errp);
> > > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > > index d0cf6ca..429b47f 100644
> > > --- a/target/ppc/cpu-qom.h
> > > +++ b/target/ppc/cpu-qom.h
> > > @@ -181,6 +181,7 @@ typedef struct PowerPCCPUClass {
> > >      DeviceRealize parent_realize;
> > >      DeviceUnrealize parent_unrealize;
> > >      void (*parent_reset)(CPUState *cpu);
> > > +    void (*parent_parse_features)(const char *type, char *str, Error=
 **errp);
> > > =20
> > >      uint32_t pvr;
> > >      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ff87f15..01b3012 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2366,7 +2366,7 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_def=
ault_cpu;
> > >      }
> > > =20
> > > -    spapr_cpu_parse_features(spapr);
> > > +    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
> > > =20
> > >      spapr_set_vsmt_mode(spapr, &error_fatal);
> > > =20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 3dea5ff..427d47f 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -21,56 +21,6 @@
> > >  #include "sysemu/hw_accel.h"
> > >  #include "qemu/error-report.h"
> > > =20
> > > -void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > > -{
> > > -    /*
> > > -     * Backwards compatibility hack:
> > > -     *
> > > -     *   CPUs had a "compat=3D" property which didn't make sense for
> > > -     *   anything except pseries.  It was replaced by "max-cpu-compa=
t"
> > > -     *   machine option.  This supports old command lines like
> > > -     *       -cpu POWER8,compat=3Dpower7
> > > -     *   By stripping the compat option and applying it to the machi=
ne
> > > -     *   before passing it on to the cpu level parser.
> > > -     */
> > > -    gchar **inpieces;
> > > -    gchar *newprops;
> > > -    int i, j;
> > > -    gchar *compat_str =3D NULL;
> > > -
> > > -    inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> > > -
> > > -    /* inpieces[0] is the actual model string */
> > > -    i =3D 1;
> > > -    j =3D 1;
> > > -    while (inpieces[i]) {
> > > -        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> > > -            /* in case of multiple compat=3D options */
> > > -            g_free(compat_str);
> > > -            compat_str =3D inpieces[i];
> > > -        } else {
> > > -            j++;
> > > -        }
> > > -
> > > -        i++;
> > > -        /* Excise compat options from list */
> > > -        inpieces[j] =3D inpieces[i];
> > > -    }
> > > -
> > > -    if (compat_str) {
> > > -        char *val =3D compat_str + strlen("compat=3D");
> > > -
> > > -        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> > > -                                &error_fatal);
> > > -
> > > -    }
> > > -
> > > -    newprops =3D g_strjoinv(",", inpieces);
> > > -    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
> > > -    g_free(newprops);
> > > -    g_strfreev(inpieces);
> > > -}
> > > -
> > >  static void spapr_cpu_reset(void *opaque)
> > >  {
> > >      PowerPCCPU *cpu =3D opaque;
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index c6399a3..5ee91e8 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -10313,6 +10313,62 @@ static ObjectClass *ppc_cpu_class_by_name(co=
nst char *name)
> > > =20
> > >      return NULL;
> > >  }
> > > +static void ppc_cpu_parse_featurestr(const char *typename, char *fea=
tures,
> > > +                                     Error **errp)
> > > +{
> > > +    const PowerPCCPUClass *pcc;
> > > +    char *compat_str =3D NULL;
> > > +    char *s =3D features;
> > > +    char **inpieces;
> > > +    Error *local_err =3D NULL;
> > > +    int i;
> > > +
> > > +    if (!features) {
> > > +        return;
> > > +    }
> > > +
> > > +    /*
> > > +     * Backwards compatibility hack:
> > > +     *
> > > +     *   CPUs had a "compat=3D" property which didn't make sense for
> > > +     *   anything except pseries.  It was replaced by "max-cpu-compa=
t"
> > > +     *   machine option.  This supports old command lines like
> > > +     *       -cpu POWER8,compat=3Dpower7
> > > +     *   By stripping the compat option and applying it to the machi=
ne
> > > +     *   before passing it on to the cpu level parser.
> > > +     */
> > > +    inpieces =3D g_strsplit(features, ",", 0);
> > > +    *s =3D '\0';
> > > +    for (i =3D 0; inpieces[i]; i++) {
> > > +        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> > > +            compat_str =3D inpieces[i];
> > > +            continue;
> > > +        }
> > > +        if ((i !=3D 0) && (s !=3D features)) {
> > > +            s =3D g_stpcpy(s, ",");
> > > +        }
> > > +        s =3D g_stpcpy(s, inpieces[i]);
> > > +    }
> > > +
> > > +    if (compat_str) {
> > > +        Object *machine =3D qdev_get_machine();
> > > +        if (machine) {
> > > +            char *v =3D compat_str + strlen("compat=3D");
> > > +            object_property_set_str(machine, v, "max-cpu-compat", &l=
ocal_err);
> > > +        } else {
> > > +            error_setg(&local_err, "Not supported property: %s", com=
pat_str);
> > > +        }
> > > +    }
> > > +    g_strfreev(inpieces);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        return;
> > > +    }
> > > +
> > > +    /* do property processing with generic handler */
> > > +    pcc =3D POWERPC_CPU_CLASS(object_class_by_name(typename));
> > > +    pcc->parent_parse_features(typename, features, errp);
> > > +}
> > > =20
> > >  const char *ppc_cpu_lookup_alias(const char *alias)
> > >  {
> > > @@ -10706,6 +10762,8 @@ static void ppc_cpu_class_init(ObjectClass *o=
c, void *data)
> > >      cc->reset =3D ppc_cpu_reset;
> > > =20
> > >      cc->class_by_name =3D ppc_cpu_class_by_name;
> > > +    pcc->parent_parse_features =3D cc->parse_features;
> > > +    cc->parse_features =3D ppc_cpu_parse_featurestr;
> > >      cc->has_work =3D ppc_cpu_has_work;
> > >      cc->do_interrupt =3D ppc_cpu_do_interrupt;
> > >      cc->cpu_exec_interrupt =3D ppc_cpu_exec_interrupt; =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXSjQACgkQbDjKyiDZ
s5LKvxAAmAXPjvXJ/bfcB0JUQAXCREjHhQCcFs2aY5LHnk68wizooEApw4DnQa1R
ITQ9SGMLcbugbPE8jmvFmEzNIRYAdTbmGcE8OqA0rmgqweobomVheiD6JTbD2Y1u
yaGF3Z/i/A4QHRQPkPpQZK2g3ojBw3Tx4lUAoWzkS599e5LmEynnUaZQedCH39z5
tj4X8MS7iZCmQL1hU0IMhBIgJXFR0e+8PWLf2z1dLFN1tSIoYWt86lt93f4Tf4Wr
JXVRxwqaNmO5dcqVNJdd5fnVT5ijEu0YEgZsS7Nk7npZ+T+n3PaAMtSO0kPOucG6
ZCuCne9tAM5Jn1NMzGpP5isQltBTfpBuc5ccfHcHiF0D11/4iEcGD3eOw32v9OwH
EeyoQkomcVFF11ZadDHeCCxQSr1L08jEY+A/o8UTelpMhGucXNG5wzFBkmiTaB06
TMOrC+auP8MFx1IdEWj9s2Yse3TP6+seeCDd5qoTQaJxDgqsTEGcJwCnxyZ1r1vO
0COz0RMvIXpuNhT3wOxT+4XllvQ2qJ+93nqV91Wpyd7t09pTQFe5oOw02Zr2vvWn
2aQ+YyG3cuBQsRewtodwRSzraIIWiaSTBMj1dnQxhDMzU/QsPjnxk8PjBuWqeFbQ
DhXZ2f3iYUtaRjUCrBYh3n8UbpU+56BSnhNtvnuoef+Sc4oaRVI=
=yZhu
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
