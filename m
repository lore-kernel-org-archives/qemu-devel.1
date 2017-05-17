Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxE-0002jP-0n
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxC-00049H-Bi
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:04 -0400
Date: Wed, 17 May 2017 16:37:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517063752.GI15596@umbus.fritz.box>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
	<20170426070034.10727-20-david@gibson.dropbear.id.au>
	<0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
	<1a7e5576-6464-6d5b-f4a8-44dceb8a17af@kaod.org>
	<0dc5ffde-39b7-6fd4-dc88-d66789414e4e@redhat.com>
	<45db5bad-e1f3-d2d0-7014-878391638f6d@kaod.org>
	<20170516181004.624cf441@bahia.lan>
	<d8354004-1a76-bc67-cd9c-55a2b95ae142@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <d8354004-1a76-bc67-cd9c-55a2b95ae142@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 07:50:42AM +0200, C=E9dric Le Goater wrote:
> On 05/16/2017 06:10 PM, Greg Kurz wrote:
> > On Tue, 16 May 2017 17:18:27 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 05/16/2017 02:55 PM, Laurent Vivier wrote:
> >>> On 16/05/2017 14:50, C=E9dric Le Goater wrote: =20
> >>>> On 05/16/2017 02:03 PM, Laurent Vivier wrote: =20
> >>>>> On 26/04/2017 09:00, David Gibson wrote: =20
> >>>>>> From: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>
> >>>>>> Today, all the ICPs are created before the CPUs, stored in an array
> >>>>>> under the sPAPR machine and linked to the CPU when the core threads
> >>>>>> are realized. This modeling brings some complexity when a lookup in
> >>>>>> the array is required and it can be simplified by allocating the I=
CPs
> >>>>>> when the CPUs are.
> >>>>>>
> >>>>>> This is the purpose of this proposal which introduces a new 'icp_t=
ype'
> >>>>>> field under the machine and creates the ICP objects of the right t=
ype
> >>>>>> (KVM or not) before the PowerPCCPU object are.
> >>>>>>
> >>>>>> This change allows more cleanups : the removal of the icps array u=
nder
> >>>>>> the sPAPR machine and the removal of the xics_get_cpu_index_by_dt_=
id()
> >>>>>> helper.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>>> ---
> >>>>>>  hw/intc/xics.c          | 11 -----------
> >>>>>>  hw/ppc/spapr.c          | 47 ++++++++++++++----------------------=
-----------
> >>>>>>  hw/ppc/spapr_cpu_core.c | 18 ++++++++++++++----
> >>>>>>  include/hw/ppc/spapr.h  |  2 +-
> >>>>>>  include/hw/ppc/xics.h   |  2 --
> >>>>>>  5 files changed, 29 insertions(+), 51 deletions(-)
> >>>>>> =20
> >>>>>
> >>>>> This commit breaks CPU re-hotplugging with KVM
> >>>>>
> >>>>> the sequence "device_add, device_del, device_add" brings to the
> >>>>> following error message:
> >>>>>
> >>>>>     Unable to connect CPUx to kernel XICS: Device or resource busy
> >>>>>
> >>>>> It comes from icp_kvm_cpu_setup():
> >>>>>
> >>>>> ...
> >>>>>     ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xic=
s_fd,
> >>>>>                               kvm_arch_vcpu_id(cs));
> >>>>>     if (ret < 0) {
> >>>>>         error_report("Unable to connect CPU%ld to kernel XICS: %s",
> >>>>>                      kvm_arch_vcpu_id(cs), strerror(errno));
> >>>>>         exit(1);
> >>>>>     }
> >>>>> ..
> >>>>>
> >>>>> It should be protected by cap_irq_xics_enabled:
> >>>>>
> >>>>> ...
> >>>>>     /*
> >>>>>      * If we are reusing a parked vCPU fd corresponding to the CPU
> >>>>>      * which was hot-removed earlier we don't have to renable
> >>>>>      * KVM_CAP_IRQ_XICS capability again.
> >>>>>      */
> >>>>>     if (icp->cap_irq_xics_enabled) {
> >>>>>         return;
> >>>>>     }
> >>>>>
> >>>>> ...
> >>>>>     ret =3D kvm_vcpu_enable_cap(...);
> >>>>> ...
> >>>>>     icp->cap_irq_xics_enabled =3D true;
> >>>>> ...
> >>>>>
> >>>>> But since this commit, "icp" is a new object on each call:
> >>>>>
> >>>>> spapr_cpu_core_realize_child()
> >>>>> ...
> >>>>>     obj =3D object_new(spapr->icp_type);
> >>>>> ...
> >>>>>     xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
> >>>>>     ...
> >>>>>             icpc->cpu_setup(icp, cpu); -> icp_kvm_cpu_setup()
> >>>>>     ...
> >>>>> ...
> >>>>>
> >>>>> and "cap_irq_xics_enabled" is reinitialized.
> >>>>>
> >>>>> Any idea how to fix that? =20
> >>>>
> >>>> it seems that a cleanup is not done in the kernel. We are missing
> >>>> a way to call kvmppc_xics_free_icp() from QEMU. Today the only
> >>>> way is to destroy the vcpu.  =20
> >>>
> >>> The commit introducing this hack, for reference:
> >>>
> >>> commit a45863bda90daa8ec39e5a312b9734fd4665b016
> >>> Author: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >>> Date:   Thu Jul 2 16:23:20 2015 +1000
> >>>
> >>>     xics_kvm: Don't enable KVM_CAP_IRQ_XICS if already enabled
> >>>    =20
> >>>     When supporting CPU hot removal by parking the vCPU fd and reusing
> >>>     it during hotplug again, there can be cases where we try to reena=
ble
> >>>     KVM_CAP_IRQ_XICS CAP for the vCPU for which it was already enable=
d.
> >>>     Introduce a boolean member in ICPState to track this and don't
> >>>     reenable the CAP if it was already enabled earlier.
> >>>    =20
> >>>     Re-enabling this CAP should ideally work, but currently it result=
s in
> >>>     kernel trying to create and associate ICP with this vCPU and that
> >>>     fails since there is already an ICP associated with it. Hence this
> >>>     patch is needed to work around this problem in the kernel.
> >>>    =20
> >>>     This change allows CPU hot removal to work for sPAPR.
> >>>    =20
> >>>     Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >>>     Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>     Signed-off-by: Alexander Graf <agraf@suse.de> =20
> >>
> >> OK.=20
> >>
> >> Greg is looking at re-adding the ICPState array because of a=20
> >> migration issue with older machines. We might need to do so=20
> >> unconditionally ...
> >>
> >=20
> > That would be a pity to carry on with the pre-allocated ICPStates for
> > new machine types just because of that... What about keeping track
> > of all the cap_irq_xics_enabled flags in a separate max_cpus sized
> > static array ?
>=20
> Could we use 'cpu->unplug' instead ?

I've only half followed this discussion, but fwiw I prefer the idea of
"parking" in-kernel ICP objects, similarly to the way we do for
removed VCPUs, rather than going back to keeping ICP objects around
indefinitely and unconditionally.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG+++AAoJEGw4ysog2bOSxLwP/2o+f05GSPfVKZbN+G7SXFXi
NRin28Y4WEKov72RdnwTHdaGnvYssAcj1YDK+hkszqNAPR3Jo0UW7jAjvfcl+wd8
0cmZoB8c9Dc4aAeGV/5voql0gUJfVOkwK2f3zWrE8R/vVZeSeNVSG6GTg91hgi5E
eWVUq7F//M1NUWQAOPrS/BdL8+Dl7gMGhm9+SWhBxcDMm5NvMynUvWnjPYNl3S0x
q21JD9vIJCti7u9zxmdDIcCsy/1GaRDB4zfQBbxDR42rQoUhZYiAKdbY74YDqgxh
hOosF5Oa/LUH1g8eWsaCB83uhuFfOOgTf98u8k8PZffp8iWqhY00e8f/NVShmGtL
3rkrENQV6C5c3JlrI3JrxHwW+/XzQD9Ux50di1DLp1ndsvwXkY0CvnK4GyWSf94J
8+7GCuPtOjIWKpVcU2SofN8WGbDEcsQ74x/saGs1ESLgtuTIshvUI5RH7Y1JxkCU
zQ8B/Igzj3BNJwfIEp/nyNlTiW+Er/RUcT+6sX78f39fQPgjz/YD/yyHQlIXX72N
vjAKvCWi+tk/fbw/ttZVHb7eKnR9QI1g/lt+Lu83miwXVgQfJF0AC6PCG+nCwlN5
zq0oFnp3RCX/LTqcef2OOqMHRrFOlCQfE7pblD2YR/5OV/kIsFg+hjuBksBL61bW
RTtDmRIHSxIXkjsYkB7Z
=BZ0Z
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
