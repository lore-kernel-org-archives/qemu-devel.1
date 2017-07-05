Received: from eggs.gnu.org ([2001:4830:134:3::10]:41921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSfyk-0007bw-S5
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSfyh-0004Gi-Qj
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:48:10 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:41525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSfyh-0004G4-K8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:48:07 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 19A8D7DDCC
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 10:48:03 +0200 (CEST)
Date: Wed, 5 Jul 2017 10:47:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170705104751.041323f5@bahia.lan>
In-Reply-To: <41cfc821-c7f8-0c3d-3bc8-d2877ac5db04@redhat.com>
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
	<20170704114151.GG2180@umbus.fritz.box>
	<20170704150239.2e4adb64@bahia.lan>
	<20170705063641.GK2180@umbus.fritz.box>
	<41cfc821-c7f8-0c3d-3bc8-d2877ac5db04@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/I2KXfsP98/S0VPteMXm5H7O";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

--Sig_/I2KXfsP98/S0VPteMXm5H7O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Jul 2017 09:56:15 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05.07.2017 08:36, David Gibson wrote:
> > On Tue, Jul 04, 2017 at 03:02:39PM +0200, Greg Kurz wrote: =20
> >> On Tue, 4 Jul 2017 21:41:51 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >> =20
> >>> On Tue, Jul 04, 2017 at 01:15:00PM +0200, Greg Kurz wrote: =20
> >>>> On Tue,  4 Jul 2017 13:01:26 +0200
> >>>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>>    =20
> >>>>> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> >>>>> disables compatibility mode for POWER9 DD1 to allow to
> >>>>> boot on POWER9 DD1 host with KVM.
> >>>>>
> >>>>> As the workaround has been added in kvmppc_host_cpu_class_init(),
> >>>>> it applies only on CPU created with "-cpu host".
> >>>>> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> >>>>> host, this patch moves the workaround from kvmppc_host_cpu_class_in=
it()
> >>>>> to init_proc_POWER9().
> >>>>>    =20
> >>>>
> >>>> As with ppc_cpu_initfn() in your previous version, init_proc_POWER9(=
) is
> >>>> called for every CPU instance.. ie, all CPU will adjust the @pcr_sup=
ported
> >>>> class attribute...   =20
> >>>
> >>> Ah.. yeah.. I didn't notice that before.  That's definitely not right.
> >>> =20
> >>>> What about moving the workaround to ppc_POWER9_cpu_family_class_init=
()
> >>>> instead ? This would just require to expose mfpvr() in some header. =
  =20
> >>>
> >>> Yeah, as someone else pointed out using the host PVR is also
> >>> definitely not right (unless you're in a function specifically
> >>> connected to the host cpu class).
> >>> =20
> >>
> >> I agree but the root issue is that we accept to pass -cpu POWER9 inste=
ad of
> >> -cpu host with -enable-kvm. And the host cpu class isn't involved in t=
his
> >> case. =20
> >=20
> > Well.. it sort of is.  I believe the way we make this work (since
> > Thomas' cleanup) is that when KVM is active, we alter the alias for
> > the host cpu's family to point to the host cpu class, instead of
> > whatever specific version it usually points to. =20
>=20

Yeah, I saw that and I guess there's a problem: we alter the alias to
point to the class with the same PVR as the host CPU, not to the
host CPU class itself. The CPUs don't belong to TYPE_HOST_POWERPC_CPU
and aren't configured according to kvmppc_host_cpu_class_init().

> Right, it's the code at the and of the kvm_ppc_register_host_cpu_type()
> function. Maybe that function could also be a good spot to move the DD1
> workaround into (just a quick idea, I haven't checked whether it's
> feasible)?
>=20

I have a patch to change the alias to point to TYPE_HOST_POWERPC_CPU. This
allows to use "-cpu POWER9" with KVM on a DD1 host.

Cheers,

--
Greg

>  Thomas
>=20


--Sig_/I2KXfsP98/S0VPteMXm5H7O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllcp7cACgkQAvw66wEB28LSkQCgirD7w+FEzrozlyEJG8Fg70Wk
b4QAn220am9FYYS7ytlHO3QlwOwYziA3
=43wX
-----END PGP SIGNATURE-----

--Sig_/I2KXfsP98/S0VPteMXm5H7O--
