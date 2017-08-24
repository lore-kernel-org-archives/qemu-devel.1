Received: from eggs.gnu.org ([2001:4830:134:3::10]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1dkjY0-0002Zq-Bn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 00:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1dkjXw-0003bh-30
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 00:15:12 -0400
Date: Thu, 24 Aug 2017 14:15:01 +1000
From: Paul Mackerras <paulus@ozlabs.org>
Message-ID: <20170824041501.GC27401@fergus.ozlabs.ibm.com>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170824040243.GF5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824040243.GF5379@umbus.fritz.box>
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
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, Aug 24, 2017 at 02:02:43PM +1000, David Gibson wrote:
> On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote=
:
> > > LoPAPR says:
> > >=20
> > >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> > >=20
> > >     property name indicating the number of virtual storage keys sup=
ported
> > >     by the processor described by this node.
> > >=20
> > >     prop-encoded-array: Consists of two cells encoded as with encod=
e-int.
> > >     The first cell represents the number of virtual storage keys su=
pported
> > >     for data accesses while the second cell represents the number o=
f
> > >     virtual storage keys supported for instruction accesses. The ce=
ll value
> > >     of zero indicates that no storage keys are supported for the ac=
cess
> > >     type.
> > >=20
> > > pHyp provides the property above but there's a bug in P8 firmware w=
here the
> > > second cell is zero even though POWER8 supports instruction access =
keys.
> > > This bug will be fixed for P9.
> > >=20
> > > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 ma=
chine.
> > >=20
> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > ---
> > >=20
> > > The sysfs files are provided by this patch for Linux:
> >=20
> > Those sysfs files relate to the kernel's support for userspace
> > processes using storage keys.  That is quite distinct from KVM's
> > support for guests using storage keys, so I think that using those
> > sysfs files to indicate what the guest can do is wrong.
>=20
> Ah!  Glad someone pointed that out.
>=20
> > In fact KVM allows guests to specify storage keys in the HPTE values
> > that they set, except that there is a bug (for which Ram Pai has
> > posted a patch) that means that KVM loses the top two bits of the key
> > number.
> >=20
> > What I would suggest is that we use the 'pad' field in the struct
> > kvm_ppc_smmu_info to report the number of keys supported by KVM for
> > guest use.
>=20
> Is there a particular reason to put it there rather than a new KVM capa=
bility?

Just that storage keys are an aspect of the "server" (i.e. HPT) MMU,
so it seemed to make sense to put it together with the other
information about the HPT MMU (segment sizes, page sizes, etc.).

> > That will be 0 in all current kernels, indicating that
> > keys are not supported, which is reasonable because of the bug.  I
> > will make sure the patch fixing the bug goes in first.
>=20
> Note that the same migration concerns still apply, so we'll still want
> machine properties to control this in qemu, which are validated
> against what the host can do.  Since current kernels are buggy, I
> suggest we have these properties default to 0 - i.e. you need to
> explicitly request storage keys on the command line if you want your
> guest to use them.  Once fixed kernels are rolled out we can look at
> changing that in a future machine type.
>=20
> > We could either have two u16 fields for the number of keys for data
> > and instruction, or we could have a u32 field for the number of keys
> > and a separate bit in the flags field to indicate that instruction
> > keys are supported.  Which would be preferable?
>=20
> I'd prefer the separate numbers for I and D.  It's more flexible and
> no harder to implement AFAICT.

OK.

> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Paul.
