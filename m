Received: from eggs.gnu.org ([2001:4830:134:3::10]:47955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEDRd-0000a5-OZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEDRa-0000Oc-L9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:45 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:54161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fEDRa-0000Jh-Eo
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:42 -0400
Received: from player760.ha.ovh.net (unknown [10.109.108.50])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 39D191B2B57
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 14:34:32 +0200 (CEST)
Date: Thu, 3 May 2018 14:34:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180503143421.30dd2b67@bahia.lan>
In-Reply-To: <20180418033344.GF2317@umbus.fritz.box>
References: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
	<20180417011427.GE20551@umbus.fritz.box>
	<20180417090909.GB3942@in.ibm.com>
	<20180418033344.GF2317@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/kfY2LMqBXJY_r_asT8IWYtq";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com

--Sig_/kfY2LMqBXJY_r_asT8IWYtq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2018 13:33:44 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Apr 17, 2018 at 02:39:09PM +0530, Bharata B Rao wrote:
> > On Tue, Apr 17, 2018 at 11:14:27AM +1000, David Gibson wrote: =20
> > > >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index d60b7c6d7a..5e044c44af 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -149,6 +149,7 @@ struct sPAPRMachineState {
> > > >      sPAPROptionVector *ov5;         /* QEMU-supported option vecto=
rs */
> > > >      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option=
 vectors */
> > > >      uint32_t max_compat_pvr;
> > > > +    bool use_ibm_dynamic_memory_v2; =20
> > >=20
> > > TBH, I'm not really sure we even need to adjust this by machine type.=
 =20
> >=20
> > There are other similar features controlled by ov5 bits that
> > are also determined by machine type version:
> >=20
> > Memory hotplug support -- sPAPRMachineClass.dr_lmb_enabled
> > Dedicated HP event support -- sPAPRMachineState.use_hotplug_event_sourc=
e =20
>=20
> As for user settability the issue isn't that it's set by ov5, but what
> the effect of the feature is.  Those other features alter runtime
> hypervisor behaviour and that behaviour has to remain the same across
> a migration.  Therefore we have to keep the behaviour consistent for
> old machine types.
>=20
> This feature affects only boot time behaviour.  It has a similar
> effect to what a firmware update might, on real hardware.  Furthermore
> the way CAS and the device tree work, this is vanishingly unlikely to
> break existing guests.
>=20

The logic in spapr_ov5_cas_needed() assumes that pre 2.8 machine types only
expose OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY to guests. Adding OV5_DRMEM=
_V2
unconditionally breaks this assumption and backward migration to pre 2.8 QE=
MU
versions because they don't expect the "spapr_option_vector_ov5_cas" subsec=
tion.

This can cause problems in cloud environments that still have systems with
older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) which =
are
likely to stay around until admins could transition to some newer OS.

> > Are you saying that presence of ibm,dynamic-memory-v2 probably shouldn't
> > be dependent on machine type ? =20
>=20
> Yes, I am.
>=20

I agree but we should also not put it in the migration stream then, like we
already do for OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY.

I've spotted another backward migration breakage wrt old, but still
in use, QEMU versions. I'll send a series for both issues ASAP, so
that it has a chance to land in QEMU 2.11.2.

Cheers,

--
Greg

--Sig_/kfY2LMqBXJY_r_asT8IWYtq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrrAc0ACgkQcdTV5YIv
c9bHdxAAgqJ9Q8fUhGVYhC1YSdZwCWngN+2GSE+xe7APX/xxaHL7WYAhjwCgl8IS
o0naiLpwjyUVDDNXXfWoJVmPwC60THELnNiVrZb3S7tkQYsPC9hrT5PCQA/wdh93
8cZmEjDGW+Vpmm7v67TebskBPCoxKzzOaEUnlHz1nC9hpNgR+nr0GhMHZtjvZ+uM
3pn0zz43yFvOloCXRUBtPKbES1MJ36FxTwpJ2GpBX3usgfgJuakCclC1v6MVyPiw
4KKoRx8IHfw2geMp+Zu6hvmaBncwtTsMEA8BblO6FD+/sEcXGokh5wm5nVYN26EM
7YNyrHSOyvuBE36B03AHHQ3RNdgw4fg2NuBDcSCK49Ig8JMcdTmi84yBrrzPdDc3
ak2JvqISYYEPeqSiLCQNRXRKfxa7C20gyQfUxGxXPg4EFinVAcPfyMoc0eWVQc8D
oS+hk5jp5vNiIFYtPSzaFw1NP0T1nEscgl1d+0c+V6TxXmxF7U/TjD0qW8K4IDDD
/jdbHWlzutKyuLUpc5uwAhq4LzuWKBgjq42jNAXdC5JKZpI8YMPU3imVwUdP1lJr
9vV74lvStrM2400iCaPceFNDwXi4kt9Vm/qzW0W2rOTSYUHPXtLXqGWqwko4Mhhz
sCgJXcqdb+IgM6uzwdC20dEuIYSym9nEHUEFnwzJHodSiO23DnE=
=B5nL
-----END PGP SIGNATURE-----

--Sig_/kfY2LMqBXJY_r_asT8IWYtq--
