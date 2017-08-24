Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1dkiIY-0006H2-Rg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1dkiIY-0005P0-0h
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:10 -0400
Date: Thu, 24 Aug 2017 12:54:48 +1000
From: Paul Mackerras <paulus@ozlabs.org>
Message-ID: <20170824025448.GA27401@fergus.ozlabs.ibm.com>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> LoPAPR says:
>=20
>     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
>=20
>     property name indicating the number of virtual storage keys support=
ed
>     by the processor described by this node.
>=20
>     prop-encoded-array: Consists of two cells encoded as with encode-in=
t.
>     The first cell represents the number of virtual storage keys suppor=
ted
>     for data accesses while the second cell represents the number of
>     virtual storage keys supported for instruction accesses. The cell v=
alue
>     of zero indicates that no storage keys are supported for the access
>     type.
>=20
> pHyp provides the property above but there's a bug in P8 firmware where=
 the
> second cell is zero even though POWER8 supports instruction access keys=
.
> This bug will be fixed for P9.
>=20
> Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machin=
e.
>=20
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>=20
> The sysfs files are provided by this patch for Linux:

Those sysfs files relate to the kernel's support for userspace
processes using storage keys.  That is quite distinct from KVM's
support for guests using storage keys, so I think that using those
sysfs files to indicate what the guest can do is wrong.

In fact KVM allows guests to specify storage keys in the HPTE values
that they set, except that there is a bug (for which Ram Pai has
posted a patch) that means that KVM loses the top two bits of the key
number.

What I would suggest is that we use the 'pad' field in the struct
kvm_ppc_smmu_info to report the number of keys supported by KVM for
guest use.  That will be 0 in all current kernels, indicating that
keys are not supported, which is reasonable because of the bug.  I
will make sure the patch fixing the bug goes in first.

We could either have two u16 fields for the number of keys for data
and instruction, or we could have a u32 field for the number of keys
and a separate bit in the flags field to indicate that instruction
keys are supported.  Which would be preferable?

Paul.
