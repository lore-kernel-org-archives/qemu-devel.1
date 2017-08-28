Received: from eggs.gnu.org ([2001:4830:134:3::10]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmOBD-0000by-Id
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmOB8-0003MY-IX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:50:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linuxram@us.ibm.com>) id 1dmOB8-0003MA-91
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:50:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SHnTTf066017
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:50:23 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0fhu3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:50:23 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <linuxram@us.ibm.com>;
	Mon, 28 Aug 2017 13:50:22 -0400
Date: Mon, 28 Aug 2017 10:50:11 -0700
From: Ram Pai <linuxram@us.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170824181122.GA5632@ram.oc3035372033.ibm.com>
	<20170825042313.GD2772@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825042313.GD2772@umbus.fritz.box>
Message-Id: <20170828175011.GA26893@ram.oc3035372033.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>

On Fri, Aug 25, 2017 at 02:23:13PM +1000, David Gibson wrote:
> On Thu, Aug 24, 2017 at 11:11:22AM -0700, Ram Pai wrote:
> > On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wro=
te:
> > > > LoPAPR says:
> > > >=20
> > > >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> > > >=20
> > > >     property name indicating the number of virtual storage keys s=
upported
> > > >     by the processor described by this node.
> > > >=20
> > > >     prop-encoded-array: Consists of two cells encoded as with enc=
ode-int.
> > > >     The first cell represents the number of virtual storage keys =
supported
> > > >     for data accesses while the second cell represents the number=
 of
> > > >     virtual storage keys supported for instruction accesses. The =
cell value
> > > >     of zero indicates that no storage keys are supported for the =
access
> > > >     type.
> > > >=20
> > > > pHyp provides the property above but there's a bug in P8 firmware=
 where the
> > > > second cell is zero even though POWER8 supports instruction acces=
s keys.
> > > > This bug will be fixed for P9.
> > > >=20
> > > > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 =
machine.
> > > >=20
> > > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com=
>
> > > > ---
> > > >=20
> > > > The sysfs files are provided by this patch for Linux:
> > >=20
> > > Those sysfs files relate to the kernel's support for userspace
> > > processes using storage keys.  That is quite distinct from KVM's
> > > support for guests using storage keys, so I think that using those
> > > sysfs files to indicate what the guest can do is wrong.
> > >=20
> > > In fact KVM allows guests to specify storage keys in the HPTE value=
s
> > > that they set, except that there is a bug (for which Ram Pai has
> > > posted a patch) that means that KVM loses the top two bits of the k=
ey
> > > number.
> > >=20
> > > What I would suggest is that we use the 'pad' field in the struct
> > > kvm_ppc_smmu_info to report the number of keys supported by KVM for
> > > guest use.  That will be 0 in all current kernels, indicating that
> > > keys are not supported, which is reasonable because of the bug.  I
> > > will make sure the patch fixing the bug goes in first.
> >=20
> > with the current kernels, even with the bug, KVM can still support 8
> > keys. Should we say 8 instead of 0?  It will help enable keys on KVM
> > earlier and give a jump start to its adaption by applications.
>=20
> But the point isn't really what we *can* say, it's with what is
> implicitly said by kernels that don't advertise anything
> specifically.  Which is 0.
>=20

Right. I was pointing to the case where nothing is said implicitly by
the kernel (no advertised values), to default to 8 instead of defaulting
to 0.

> If we're going to change the kernel to put something else in smmu
> info, we can also change it to fix the storage key stuff anyway, so we
> can put the full value in there.

right.=20

>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



--=20
Ram Pai
