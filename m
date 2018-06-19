Received: from eggs.gnu.org ([2001:4830:134:3::10]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fV9Ob-00021r-By
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fV9OW-0007AW-FC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:41:37 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:44184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fV9OW-0007AC-5I
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:41:32 -0400
Received: from player746.ha.ovh.net (unknown [10.109.105.112])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4974E13C678
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:41:30 +0200 (CEST)
Date: Tue, 19 Jun 2018 07:41:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180619074124.5a9968a0@bahia.lan>
In-Reply-To: <20180619000905.GE25461@umbus.fritz.box>
References: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
	<20180619000905.GE25461@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/DVbog3FCbuzshH6Um_xNFS5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr_cpu_core: migrate per-CPU data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/DVbog3FCbuzshH6Um_xNFS5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Jun 2018 10:09:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jun 18, 2018 at 02:26:35PM +0200, Greg Kurz wrote:
> > A per-CPU machine data pointer was recently added to PowerPCCPU. The
> > motivation is to to hide platform specific details from the core CPU
> > code. This per-CPU data can hold state which is revelant to the guest
> > though, eg, Virtual Processor Areas, and we whould migrate this state.
> >=20
> > This patch adds the plumbing so that we can migrate the per-CPU data
> > for PAPR guests. We only do this for newer machine types for the sake
> > of backword compatibility. No state is migrated for the moment: the
> > vmstate_spapr_cpu_state structure will be populated by subsequent
> > patches.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied, though I fixed some spelling and spacing errors along the way.
>=20

Thanks but I now realize I have a nit...

> > ---
> >  hw/ppc/spapr.c                  |    5 +++++
> >  hw/ppc/spapr_cpu_core.c         |   27 +++++++++++++++++++++++----
> >  include/hw/ppc/spapr_cpu_core.h |    1 +
> >  3 files changed, 29 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index db0fb385d4e0..37db3e8bc6ca 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4116,6 +4116,11 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
> >      {                                                                 =
 \
> >          .driver =3D TYPE_POWERPC_CPU,                                 =
   \
> >          .property =3D "pre-3.0-migration",                            =
  \
> > +        .value    =3D "on",                                           =
   \
> > +            },                                                        =
 \
> > +    {                                                                 =
 \
> > +        .driver =3D TYPE_SPAPR_CPU_CORE,                              =
   \
> > +        .property =3D "pre-3.0-migration",                            =
   \
> >          .value    =3D "on",                                           =
   \
> >      },
> > =20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index aef3be33a3bb..96d1dfad00e1 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -129,6 +129,15 @@ static void spapr_cpu_core_unrealize(DeviceState *=
dev, Error **errp)
> >      g_free(sc->threads);
> >  }
> > =20
> > +static const VMStateDescription vmstate_spapr_cpu_state =3D {
> > +    .name =3D "spapr_cpu",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
> >                                 Error **errp)
> >  {
> > @@ -164,7 +173,8 @@ error:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > -static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **=
errp)
> > +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
> > +                                     sPAPRMachineState *spapr, Error *=
*errp)

... here. This spapr argument comes from a previous version. I didn't need =
it
in the end, but I forgot to remove it :(

Do you want me to resend or can you fix that in your tree ?

> >  {
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
> >      CPUCore *cc =3D CPU_CORE(sc);
> > @@ -194,6 +204,10 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore =
*sc, int i, Error **errp)
> >      }
> > =20
> >      cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
> > +    if (!sc->pre_3_0_migration) {
> > +        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
> > +                         cpu->machine_data);
> > +    }
> > =20
> >      object_unref(obj);
> >      return cpu;
> > @@ -204,10 +218,13 @@ err:
> >      return NULL;
> >  }
> > =20
> > -static void spapr_delete_vcpu(PowerPCCPU *cpu)
> > +static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
> >  {
> >      sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > =20
> > +    if (!sc->pre_3_0_migration) {
> > +        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machin=
e_data);
> > +    }
> >      cpu->machine_data =3D NULL;
> >      g_free(spapr_cpu);
> >      object_unparent(OBJECT(cpu));
> > @@ -233,7 +250,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> > =20
> >      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > -        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
> > +        sc->threads[i] =3D spapr_create_vcpu(sc, i, spapr, &local_err);
> >          if (local_err) {
> >              goto err;
> >          }
> > @@ -253,7 +270,7 @@ err_unrealize:
> >      }
> >  err:
> >      while (--i >=3D 0) {
> > -        spapr_delete_vcpu(sc->threads[i]);
> > +        spapr_delete_vcpu(sc->threads[i], sc);
> >      }
> >      g_free(sc->threads);
> >      error_propagate(errp, local_err);
> > @@ -261,6 +278,8 @@ err:
> > =20
> >  static Property spapr_cpu_core_properties[] =3D {
> >      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA=
_NODE_ID),
> > +    DEFINE_PROP_BOOL("pre-3.0-migration", sPAPRCPUCore, pre_3_0_migrat=
ion,
> > +                     false),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> > =20
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 8ceea2973a93..9e2821e4b31f 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -31,6 +31,7 @@ typedef struct sPAPRCPUCore {
> >      /*< public >*/
> >      PowerPCCPU **threads;
> >      int node_id;
> > +    bool pre_3_0_migration; /* older machine don't know about sPAPRCPU=
State */
> >  } sPAPRCPUCore;
> > =20
> >  typedef struct sPAPRCPUCoreClass {
> >  =20
>=20


--Sig_/DVbog3FCbuzshH6Um_xNFS5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsol4QACgkQcdTV5YIv
c9YkSQ//YVeJ0xYxocYCSMjzHZ3HzcKQIzMq4SSRImUpsGoNotQSHEQp7BQuJut/
GBqbmZGBsYvv2fykUX8qoFvFfu1ETHcHiH3/78jEizxVZv7fzEO+z+PsgEQqFJju
H5Zzswq+emnmNiUs6zvAMxH9kVY+6kmzCM5/5tFJFXxiqPxm0CxZexRqqWkv7EtF
VSKNJPyee/GZIm0XfmjmWtvxb3qOwGCXZE1/4rfvAQXLf6lYhfcBPe641pC8gLQx
l7kZckykiyqb0Cmq5azOugPOI6j9v5sZe6aOtkblhQM0F4g0rxbRd635h1RmfFfh
OMuhmaixkgkBYWpLsIR6KfA2HONGvqYtRKp++YxJ87yIpRELc3WCbFAfjxR5zuyp
Q2JCcphJTelvDF2reXCwu2uJIV7f65d+pK/OoDLFdtiNUsiyQPlywccRnFTHQz71
4VsZypBog3Md3A2wEtQdOkwVg9pBnNKKVsMFBZmED0QhkJYXIzYluv4xBhAJ4iot
/inQykr5tn5MhEQz8ILvQTjbWSknMKKn+1ou/5Sq5oaiN4JtNu2pdEeRNt7o8bCI
uGFXiWRzwGRvFtkPYq+14dnOM6NApef4szHUyd7jbiS3UaBFhqbv8HwbrrgfeGoO
A7sQHuLd1YCfeBbMWwNKYgNMUvXYeNsCesIfu7sXx81jM3nBF0Y=
=FgGf
-----END PGP SIGNATURE-----

--Sig_/DVbog3FCbuzshH6Um_xNFS5--
