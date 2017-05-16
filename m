Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAf3L-0007KX-KZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAf3G-00063P-LD
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:10:27 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAf3G-00060t-Cf
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:10:22 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9563FB5AE1
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:10:14 +0200 (CEST)
Date: Tue, 16 May 2017 18:10:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170516181004.624cf441@bahia.lan>
In-Reply-To: <45db5bad-e1f3-d2d0-7014-878391638f6d@kaod.org>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
	<20170426070034.10727-20-david@gibson.dropbear.id.au>
	<0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
	<1a7e5576-6464-6d5b-f4a8-44dceb8a17af@kaod.org>
	<0dc5ffde-39b7-6fd4-dc88-d66789414e4e@redhat.com>
	<45db5bad-e1f3-d2d0-7014-878391638f6d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/99J_qDZPIzscxB3+pTClfh+";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 19/48] spapr: allocate the ICPState object
 from under sPAPRCPUCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org

--Sig_/99J_qDZPIzscxB3+pTClfh+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 May 2017 17:18:27 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/16/2017 02:55 PM, Laurent Vivier wrote:
> > On 16/05/2017 14:50, C=C3=A9dric Le Goater wrote: =20
> >> On 05/16/2017 02:03 PM, Laurent Vivier wrote: =20
> >>> On 26/04/2017 09:00, David Gibson wrote: =20
> >>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>>
> >>>> Today, all the ICPs are created before the CPUs, stored in an array
> >>>> under the sPAPR machine and linked to the CPU when the core threads
> >>>> are realized. This modeling brings some complexity when a lookup in
> >>>> the array is required and it can be simplified by allocating the ICPs
> >>>> when the CPUs are.
> >>>>
> >>>> This is the purpose of this proposal which introduces a new 'icp_typ=
e'
> >>>> field under the machine and creates the ICP objects of the right type
> >>>> (KVM or not) before the PowerPCCPU object are.
> >>>>
> >>>> This change allows more cleanups : the removal of the icps array und=
er
> >>>> the sPAPR machine and the removal of the xics_get_cpu_index_by_dt_id=
()
> >>>> helper.
> >>>>
> >>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>> ---
> >>>>  hw/intc/xics.c          | 11 -----------
> >>>>  hw/ppc/spapr.c          | 47 ++++++++++++++------------------------=
---------
> >>>>  hw/ppc/spapr_cpu_core.c | 18 ++++++++++++++----
> >>>>  include/hw/ppc/spapr.h  |  2 +-
> >>>>  include/hw/ppc/xics.h   |  2 --
> >>>>  5 files changed, 29 insertions(+), 51 deletions(-)
> >>>> =20
> >>>
> >>> This commit breaks CPU re-hotplugging with KVM
> >>>
> >>> the sequence "device_add, device_del, device_add" brings to the
> >>> following error message:
> >>>
> >>>     Unable to connect CPUx to kernel XICS: Device or resource busy
> >>>
> >>> It comes from icp_kvm_cpu_setup():
> >>>
> >>> ...
> >>>     ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_=
fd,
> >>>                               kvm_arch_vcpu_id(cs));
> >>>     if (ret < 0) {
> >>>         error_report("Unable to connect CPU%ld to kernel XICS: %s",
> >>>                      kvm_arch_vcpu_id(cs), strerror(errno));
> >>>         exit(1);
> >>>     }
> >>> ..
> >>>
> >>> It should be protected by cap_irq_xics_enabled:
> >>>
> >>> ...
> >>>     /*
> >>>      * If we are reusing a parked vCPU fd corresponding to the CPU
> >>>      * which was hot-removed earlier we don't have to renable
> >>>      * KVM_CAP_IRQ_XICS capability again.
> >>>      */
> >>>     if (icp->cap_irq_xics_enabled) {
> >>>         return;
> >>>     }
> >>>
> >>> ...
> >>>     ret =3D kvm_vcpu_enable_cap(...);
> >>> ...
> >>>     icp->cap_irq_xics_enabled =3D true;
> >>> ...
> >>>
> >>> But since this commit, "icp" is a new object on each call:
> >>>
> >>> spapr_cpu_core_realize_child()
> >>> ...
> >>>     obj =3D object_new(spapr->icp_type);
> >>> ...
> >>>     xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
> >>>     ...
> >>>             icpc->cpu_setup(icp, cpu); -> icp_kvm_cpu_setup()
> >>>     ...
> >>> ...
> >>>
> >>> and "cap_irq_xics_enabled" is reinitialized.
> >>>
> >>> Any idea how to fix that? =20
> >>
> >> it seems that a cleanup is not done in the kernel. We are missing
> >> a way to call kvmppc_xics_free_icp() from QEMU. Today the only
> >> way is to destroy the vcpu.  =20
> >=20
> > The commit introducing this hack, for reference:
> >=20
> > commit a45863bda90daa8ec39e5a312b9734fd4665b016
> > Author: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Date:   Thu Jul 2 16:23:20 2015 +1000
> >=20
> >     xics_kvm: Don't enable KVM_CAP_IRQ_XICS if already enabled
> >    =20
> >     When supporting CPU hot removal by parking the vCPU fd and reusing
> >     it during hotplug again, there can be cases where we try to reenable
> >     KVM_CAP_IRQ_XICS CAP for the vCPU for which it was already enabled.
> >     Introduce a boolean member in ICPState to track this and don't
> >     reenable the CAP if it was already enabled earlier.
> >    =20
> >     Re-enabling this CAP should ideally work, but currently it results =
in
> >     kernel trying to create and associate ICP with this vCPU and that
> >     fails since there is already an ICP associated with it. Hence this
> >     patch is needed to work around this problem in the kernel.
> >    =20
> >     This change allows CPU hot removal to work for sPAPR.
> >    =20
> >     Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >     Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >     Signed-off-by: Alexander Graf <agraf@suse.de> =20
>=20
> OK.=20
>=20
> Greg is looking at re-adding the ICPState array because of a=20
> migration issue with older machines. We might need to do so=20
> unconditionally ...
>=20

That would be a pity to carry on with the pre-allocated ICPStates for
new machine types just because of that... What about keeping track
of all the cap_irq_xics_enabled flags in a separate max_cpus sized
static array ?

> But for that specific issue, I think it would have been better=20
> to clean up the kernel state. Is that possible ?=20
>=20

Commit 4c055ab54fae ("cpu: Reclaim vCPU objects") gives some more details
on why we don't destroy the vCPU in KVM on unplug, but rather park the vCPU
fd for later use... so I'm not sure we can clean up the kernel state.

But since the vCPU is still present, maybe we can find a way to tell KVM
that we want to reuse an already present ICP ?

> Thanks,
>=20
> C.
> =20
>=20
> >> Else we need to reintroduce the array of icps (again) to keep some=20
> >> xics state ... but that just sucks :/ Let me think about it.=20
> >> =20
> >=20
> > Thanks,
> > Laurent =20
> >> C.
> >> =20
> >  =20
>=20


--Sig_/99J_qDZPIzscxB3+pTClfh+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkbJFwACgkQAvw66wEB28LrIACfSnL44qbhzY0vdLJ0iJ6+pW6g
dtUAoIJ8zC2SG7eXcNdUqm+GeTQopjOS
=3Qnw
-----END PGP SIGNATURE-----

--Sig_/99J_qDZPIzscxB3+pTClfh+--
