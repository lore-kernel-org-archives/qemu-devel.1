Received: from eggs.gnu.org ([2001:4830:134:3::10]:53862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUX-000238-Rr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUU-0004BA-V4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:33 -0400
Date: Fri, 4 May 2018 10:15:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504001527.GJ13229@umbus.fritz.box>
References: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
	<20180417011427.GE20551@umbus.fritz.box>
	<20180417090909.GB3942@in.ibm.com>
	<20180418033344.GF2317@umbus.fritz.box>
	<20180503143421.30dd2b67@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D85EWoRcDXv1uhH1"
Content-Disposition: inline
In-Reply-To: <20180503143421.30dd2b67@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com


--D85EWoRcDXv1uhH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 02:34:21PM +0200, Greg Kurz wrote:
> On Wed, 18 Apr 2018 13:33:44 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Apr 17, 2018 at 02:39:09PM +0530, Bharata B Rao wrote:
> > > On Tue, Apr 17, 2018 at 11:14:27AM +1000, David Gibson wrote: =20
> > > > >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> > > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > > index d60b7c6d7a..5e044c44af 100644
> > > > > --- a/include/hw/ppc/spapr.h
> > > > > +++ b/include/hw/ppc/spapr.h
> > > > > @@ -149,6 +149,7 @@ struct sPAPRMachineState {
> > > > >      sPAPROptionVector *ov5;         /* QEMU-supported option vec=
tors */
> > > > >      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) opti=
on vectors */
> > > > >      uint32_t max_compat_pvr;
> > > > > +    bool use_ibm_dynamic_memory_v2; =20
> > > >=20
> > > > TBH, I'm not really sure we even need to adjust this by machine typ=
e. =20
> > >=20
> > > There are other similar features controlled by ov5 bits that
> > > are also determined by machine type version:
> > >=20
> > > Memory hotplug support -- sPAPRMachineClass.dr_lmb_enabled
> > > Dedicated HP event support -- sPAPRMachineState.use_hotplug_event_sou=
rce =20
> >=20
> > As for user settability the issue isn't that it's set by ov5, but what
> > the effect of the feature is.  Those other features alter runtime
> > hypervisor behaviour and that behaviour has to remain the same across
> > a migration.  Therefore we have to keep the behaviour consistent for
> > old machine types.
> >=20
> > This feature affects only boot time behaviour.  It has a similar
> > effect to what a firmware update might, on real hardware.  Furthermore
> > the way CAS and the device tree work, this is vanishingly unlikely to
> > break existing guests.
> >=20
>=20
> The logic in spapr_ov5_cas_needed() assumes that pre 2.8 machine types on=
ly
> expose OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY to guests. Adding OV5_DRM=
EM_V2
> unconditionally breaks this assumption and backward migration to pre 2.8 =
QEMU
> versions because they don't expect the "spapr_option_vector_ov5_cas" subs=
ection.
>=20
> This can cause problems in cloud environments that still have systems with
> older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) whic=
h are
> likely to stay around until admins could transition to some newer OS.

Ah, good point.

> > > Are you saying that presence of ibm,dynamic-memory-v2 probably should=
n't
> > > be dependent on machine type ? =20
> >=20
> > Yes, I am.
> >=20
>=20
> I agree but we should also not put it in the migration stream then, like =
we
> already do for OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY.
>=20
> I've spotted another backward migration breakage wrt old, but still
> in use, QEMU versions. I'll send a series for both issues ASAP, so
> that it has a chance to land in QEMU 2.11.2.

Thanks.  I've merged your patch for 2.13 now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D85EWoRcDXv1uhH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrph4ACgkQbDjKyiDZ
s5K6QRAAyMp3IsMS94P99+d3EYcQSfw9/Lm6VCEZmS1ikdRQcgdlY0wZ5MS/1QeN
UbcdLQhMupUUQpzhrD6K+SWE1PsxUQxihfCPLQoWJ5sCyVR6GKrrlPdR8t/m0v8b
IHE9Xm00/9QG5qTFEGyvh1HIBSzLSdG95N76f2L2nUAid2lRv2ed0ClXxJgrZgeE
YEsGK4bOCDNMqWohwG/vvW+ZCqP5YgOAP2L3SbtyCY5q5hnLM8Z/hqy6jciwSk8y
56c0vrDleLpQaDL7yUkiNjTijWJzr1+s41IRUM+aqurfArJIYxXYAfYfbSUjOsFM
XbbxCZUJwPkrm+ly0zUK5VMPnFqofnw5svQcICI736j8/OO1eMhbCSq0lLp5B0Cj
ENPO90tci8L0qWA27YphAEi6zqxWVqxx5xb09SAVQidjlH3n7M93yKUz+8N5BcD/
Ztj2CFwR2gPCg/0b5I31/JlM8AUHHQVAve4cxCqk8wp+0GvD5g5hhGwxWIvcTlR+
V5JdfQ45SiMTHmolLQX/7knwiZrHavxD3UqqlcDD9cmnJX8RR67GQO/Cjm53fGvh
K7D7ot8qexpr4+H6J97paMi73AMbVg2V8qdnl1mAkFK905fqf6YXsAy+xiGgwl2+
AkTWJdnvZfrJ+5rISzZHdP4Xe54udU7SL8RdH5QsdIZ9aFDv7dA=
=Rrxi
-----END PGP SIGNATURE-----

--D85EWoRcDXv1uhH1--
