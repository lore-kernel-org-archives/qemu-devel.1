Received: from eggs.gnu.org ([2001:4830:134:3::10]:59441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE5Zt-0001Be-2V
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE5Zp-0004pm-TS
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:06:13 -0400
Date: Fri, 26 May 2017 11:24:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526012412.GG12929@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
	<20170502162455.4f7a226e@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <20170502162455.4f7a226e@bahia>
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 04:24:55PM +0200, Greg Kurz wrote:
> On Thu, 27 Apr 2017 17:28:41 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
[snip]
> > @@ -45,18 +48,21 @@ static const CompatInfo compat_table[] =3D {
> >          .max_threads =3D 2,
> >      },
> >      { /* POWER7, ISA2.06 */
> > +        .name =3D "power7",
> >          .pvr =3D CPU_POWERPC_LOGICAL_2_06,
> >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |=
 PCR_TM_DIS,
> >          .pcr_level =3D PCR_COMPAT_2_06,
> >          .max_threads =3D 4,
> >      },
> >      {
> > +        .name =3D "power7+",
> >          .pvr =3D CPU_POWERPC_LOGICAL_2_06_PLUS,
> >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |=
 PCR_TM_DIS,
> >          .pcr_level =3D PCR_COMPAT_2_06,
> >          .max_threads =3D 4,
> >      },
> >      { /* POWER8, ISA2.07 */
> > +        .name =3D "power8",
> >          .pvr =3D CPU_POWERPC_LOGICAL_2_07,
> >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
> >          .pcr_level =3D PCR_COMPAT_2_07,
>=20
> And now we also have POWER9 in the list, so:
>=20
>          .max_threads =3D 8,
>      },
>      { /* POWER9, ISA3.00 */
> +        .name =3D "power9",
>          .pvr =3D CPU_POWERPC_LOGICAL_3_00,
>          .pcr =3D PCR_COMPAT_3_00,
>          .pcr_level =3D PCR_COMPAT_3_00,

Updated for the next spin.

> > @@ -189,3 +195,62 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
> > =20
> >      return n_threads;
> >  }
> > +
> > +void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
> > +                         void *opaque, Error **errp)
> > +{
> > +    uint32_t compat_pvr =3D *((uint32_t *)opaque);
> > +    const char *value;
> > +
> > +    if (!compat_pvr) {
> > +        value =3D "";
> > +    } else {
> > +        const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
> > +
> > +        g_assert(compat);
> > +
> > +        value =3D compat->name;
> > +    }
> > +
> > +    visit_type_str(v, name, (char **)&value, errp);
> > +}
> > +
> > +void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
> > +                         void *opaque, Error **errp)
> > +{
> > +    Error *error =3D NULL;
> > +    char *value;
> > +    uint32_t compat_pvr;
> > +
> > +    visit_type_str(v, name, &value, &error);
> > +    if (error) {
> > +        error_propagate(errp, error);
> > +        return;
> > +    }
> > +
> > +    if (strcmp(value, "") =3D=3D 0) {
> > +        compat_pvr =3D 0;
>=20
> The current implementation in powerpc_get_compat() considers "" to be an
> invalid compatibility mode. Is there a reason to behave differently with
> max-cpu-compat ?

Hrm.  Symmetry, really.  In ppc_compat_prop_get() we represent no
compatibility mode set as an empty string.  Setting the same value
back should have the corresponding effect.

[snip]
> > +static void getset_compat_deprecated(Object *obj, Visitor *v, const ch=
ar *name,
> > +                                     void *opaque, Error **errp)
> >  {
> > -    Error *error =3D NULL;
> > -    char *value =3D NULL;
> > -    Property *prop =3D opaque;
> > -    uint32_t *max_compat =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > -
> > -    visit_type_str(v, name, &value, &error);
> > -    if (error) {
> > -        error_propagate(errp, error);
> > -        return;
> > -    }
> > -
> > -    if (strcmp(value, "power6") =3D=3D 0) {
> > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_05;
> > -    } else if (strcmp(value, "power7") =3D=3D 0) {
> > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_06;
> > -    } else if (strcmp(value, "power8") =3D=3D 0) {
> > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_07;
> > -    } else {
> > -        error_setg(errp, "Invalid compatibility mode \"%s\"", value);
> > -    }
> > -
> > -    g_free(value);
> > +    error_report("CPU 'compat' property is deprecated and has no effec=
t; use max-cpu-compat machine property instead");
> > +    visit_type_null(v, name, errp);
> >  }
> > =20
>=20
> As suggested in another mail, maybe NULL should be passed instead of errp=
 if
> we really want to implement the "has no effect". Otherwise, it has the ef=
fect
> of terminating QEMU when passing a compat prop that isn't "".

Good point.  I'll change that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ4O5AAoJEGw4ysog2bOSLH0QAKxUkWRqwATUIlQS+0ea5v/U
ln/CChiGaOUonxeFVcnsNjb28Ugby2ZTfmZS1mC/p1KLPShyPqlcyDGsW6BActm/
gNaBW43pA9j7+55cO2QpxwRjRPJZSrei2CgC+9wJR3BOUMCjAAs44VNMPIpWNoOV
+aafmQuZsarXiCzvqdEl+KrcPQQfUDzwJpcEUARgZj4TmKMvqKQ1FeoDojpDO46a
kqILbW8NuwYj8w4/RfWQ2kSTbOPdzXIXMdtBvRMLOZyyzlf3wH33UZhBNZbynjyk
yZbx8yksDAC0x1LvOlo6JUVYXTBx8OlgNm+ZbIcJmbuk9SFUKowUk5wIUOlaos/E
FfjNl6IQjKqIgZ+C6s3JVGfnSW7vwePWT7yaeLoouuMZeyXe4+yx16fp4KS3X3CX
boGPRoYOHSrXW2P0BrSPGA/7P/hAocGQkZUjlUucu+/UJLQ15mJs+WK+Y6NNF3+l
czMvH8eatUnN7cQ7aTwHQlHuQCZ8Kl6bBdvzEP9Xb4Z2rB0+kTGxfX5w9Ia3vL4W
lMcDF2pwGqc2+oeNjVCHd0tqR8RHKUG1KY/XTM+NClYemYb/NG/5eAVA31fz3MDg
wyJmmWOnXWItNaFhnOW+MHQRSm67ouQ3ta1ATui4rY+m2A5Tz7pFvR77WC67PVdB
e619AdGschinYh0ZSk87
=T7Ek
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
