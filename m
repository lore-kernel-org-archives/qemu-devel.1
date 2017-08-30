Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmtJf-0000eo-Hg
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmtJb-0005Bg-8S
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:05:19 -0400
Date: Wed, 30 Aug 2017 13:05:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170830030501.GE3386@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-5-git-send-email-imammedo@redhat.com>
	<20170825041208.GA2772@umbus.fritz.box>
	<20170825093432.6e0d4512@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <20170825093432.6e0d4512@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/6] ppc: replace inter-function
 cyclic dependency/recurssion with 2 simple lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 09:34:32AM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 14:12:08 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Aug 24, 2017 at 10:21:49AM +0200, Igor Mammedov wrote:
> > > previous patches cleaned up cpu model/alias naming which
> > > allows to simplify cpu model/alias to cpu type lookup a bit
> > > byt removing recurssion and dependency of ppc_cpu_class_by_name() /
> > > ppc_cpu_class_by_alias() on each other.
> > > Besides of simplifying code it reduces it by ~15LOC.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Urm.. I think this is probably good.  But I'm having a little trouble
> > convincing myself this really has the same effect as before.
> It's hard to wrap brain around current cyclic recursion and
> how to 2 simple linear lookups could replace it.

I noticed :)

> By itself this patch won't work, it depends on 2-3/6 for
> normalized cpu type names and recursion-less alias table.
>=20
> The only change in behavior here is that it does alias
> translation first and only then cpu_model to type translation.

I've had a closer look and convinced myself of that now.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I'm sorry, I've lost track of these patches a bit, since I wasn't
originally expecting to queue them.  I can't actually remember if
there were any comments needing a respin.

Regardless, can you resend the series (including my R-bs) and I'll
queue it for 2.11.

>=20
> >=20
> > > ---
> > >  target/ppc/translate_init.c | 43 +++++++++++++----------------------=
--------
> > >  1 file changed, 13 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index 0325226..f1a559d 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -10176,22 +10176,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(u=
int32_t pvr)
> > >      return pcc;
> > >  }
> > > =20
> > > -static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointe=
r b)
> > > -{
> > > -    ObjectClass *oc =3D (ObjectClass *)a;
> > > -    const char *name =3D b;
> > > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> > > -
> > > -    if (strncasecmp(name, object_class_get_name(oc), strlen(name)) =
=3D=3D 0 &&
> > > -        ppc_cpu_is_valid(pcc) &&
> > > -        strcmp(object_class_get_name(oc) + strlen(name),
> > > -               POWERPC_CPU_TYPE_SUFFIX) =3D=3D 0) {
> > > -        return 0;
> > > -    }
> > > -    return -1;
> > > -}
> > > -
> > > -
> > >  static ObjectClass *ppc_cpu_class_by_name(const char *name);
> > > =20
> > >  static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> > > @@ -10216,8 +10200,8 @@ static ObjectClass *ppc_cpu_class_by_alias(Po=
werPCCPUAlias *alias)
> > > =20
> > >  static ObjectClass *ppc_cpu_class_by_name(const char *name)
> > >  {
> > > -    GSList *list, *item;
> > > -    ObjectClass *ret =3D NULL;
> > > +    char *cpu_model, *typename;
> > > +    ObjectClass *oc;
> > >      const char *p;
> > >      int i, len;
> > > =20
> > > @@ -10238,21 +10222,20 @@ static ObjectClass *ppc_cpu_class_by_name(c=
onst char *name)
> > >          }
> > >      }
> > > =20
> > > -    list =3D object_class_get_list(TYPE_POWERPC_CPU, false);
> > > -    item =3D g_slist_find_custom(list, name, ppc_cpu_compare_class_n=
ame);
> > > -    if (item !=3D NULL) {
> > > -        ret =3D OBJECT_CLASS(item->data);
> > > +    cpu_model =3D g_ascii_strup(name, -1);
> > > +    p =3D ppc_cpu_lookup_alias(cpu_model);
> > > +    if (p) {
> > > +        g_free(cpu_model);
> > > +        cpu_model =3D g_strdup(p);
> > >      }
> > > -    g_slist_free(list);
> > > =20
> > > -    if (ret) {
> > > -        return ret;
> > > -    }
> > > +    typename =3D g_strdup_printf("%s" POWERPC_CPU_TYPE_SUFFIX, cpu_m=
odel);
> > > +    oc =3D object_class_by_name(typename);
> > > +    g_free(typename);
> > > +    g_free(cpu_model);
> > > =20
> > > -    for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> > > -        if (strcasecmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
> > > -            return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
> > > -        }
> > > +    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
> > > +        return oc;
> > >      }
> > > =20
> > >      return NULL; =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmmK10ACgkQbDjKyiDZ
s5KB6hAAu+qx5+MPDQ2giPSwfuGWOPIbMgUv+I1eN5s3gysT1bM2TB53widpQY3W
aJtD/vC/1vJPaL8jjc/2Aeu7318t4q1zmnbN68X5Vpi92NfGyind22fk92NBpPRk
aCQ9ejOZw9w3uz0oEwuW9A4FPFX+LQbMuI2bhwYuI+ZZyhhZkCt1HRdf1CZQln48
VzJN6dVWLLipeuc2tesCCvuNn2wZuARdmG+jiRbkyJn/K8YBVhXES0eJc4LN2kC1
WZqxtafp211hpGuGWhoRILcz5+ddR/pyqNjkwy9hT+xG879M4IxZTNRMYYyDJ3nD
Y3oGuKrpAml7QC5EpPodjfbkmQ6E6gB/klpdpveZnPeWxAX1nzuUc9zhtj7bxfsY
CDTVYo/PLYcMQ5PMr+Ql4luyQHKeMyKZSwC2CoWFsAQyAYjC9411OaDOCnKxRezT
+/ozCT+lAZdGMFC03sdKyzHuY+fyHy/m5d55xDhzsYA1m38zFflPJgP3fxtWGx4o
12tqbta6fiSShudFYE6uGwZ7Zoipu/xmSuwv8QIox/K05qC/zs5nnmdwqttET+24
ELVivGREU+eMrQlbSLD7MXCWcfV8grKeEkJe+L2vgnBC1usAWBE6H78dYSc3zoON
jauArYc2mCsl7pghJfIPBYk204BPbYJcVnFR39NJ7MKKN5qdShs=
=9fAq
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
