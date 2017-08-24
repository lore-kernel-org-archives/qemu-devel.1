Received: from eggs.gnu.org ([2001:4830:134:3::10]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkjM4-0008AW-LQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 00:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkjM3-00069s-IB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 00:02:52 -0400
Date: Thu, 24 Aug 2017 14:02:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824040243.GF5379@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OzigliFs3e0dNr73"
Content-Disposition: inline
In-Reply-To: <20170824025448.GA27401@fergus.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>


--OzigliFs3e0dNr73
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> > LoPAPR says:
> >=20
> >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> >=20
> >     property name indicating the number of virtual storage keys support=
ed
> >     by the processor described by this node.
> >=20
> >     prop-encoded-array: Consists of two cells encoded as with encode-in=
t.
> >     The first cell represents the number of virtual storage keys suppor=
ted
> >     for data accesses while the second cell represents the number of
> >     virtual storage keys supported for instruction accesses. The cell v=
alue
> >     of zero indicates that no storage keys are supported for the access
> >     type.
> >=20
> > pHyp provides the property above but there's a bug in P8 firmware where=
 the
> > second cell is zero even though POWER8 supports instruction access keys.
> > This bug will be fixed for P9.
> >=20
> > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machin=
e.
> >=20
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > ---
> >=20
> > The sysfs files are provided by this patch for Linux:
>=20
> Those sysfs files relate to the kernel's support for userspace
> processes using storage keys.  That is quite distinct from KVM's
> support for guests using storage keys, so I think that using those
> sysfs files to indicate what the guest can do is wrong.

Ah!  Glad someone pointed that out.

> In fact KVM allows guests to specify storage keys in the HPTE values
> that they set, except that there is a bug (for which Ram Pai has
> posted a patch) that means that KVM loses the top two bits of the key
> number.
>=20
> What I would suggest is that we use the 'pad' field in the struct
> kvm_ppc_smmu_info to report the number of keys supported by KVM for
> guest use.

Is there a particular reason to put it there rather than a new KVM capabili=
ty?

> That will be 0 in all current kernels, indicating that
> keys are not supported, which is reasonable because of the bug.  I
> will make sure the patch fixing the bug goes in first.

Note that the same migration concerns still apply, so we'll still want
machine properties to control this in qemu, which are validated
against what the host can do.  Since current kernels are buggy, I
suggest we have these properties default to 0 - i.e. you need to
explicitly request storage keys on the command line if you want your
guest to use them.  Once fixed kernels are rolled out we can look at
changing that in a future machine type.

> We could either have two u16 fields for the number of keys for data
> and instruction, or we could have a u32 field for the number of keys
> and a separate bit in the flags field to indicate that instruction
> keys are supported.  Which would be preferable?

I'd prefer the separate numbers for I and D.  It's more flexible and
no harder to implement AFAICT.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OzigliFs3e0dNr73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeT+MACgkQbDjKyiDZ
s5JGJQ//SStb8t/IltzEt4tLUK/zKDk3Zb3eJ3LtOZNZ64Apm2YHVYaSzWQObVxp
+k4gGDZNUKz/I39YxL1ih5SSGNAj2tcZFg6YPjiQPqGe/90hh6trTUYPDDsK/NzB
K54U35BSYz0Ba4XcyhTa9IjYf8ZFH3/JKao0NSHLSPbrL8EkmLob57phSvYwaXCX
66azX8UDtAnhh5SRj9n2B4PEJZeZPwRyWrvFUbe9tO0bdD6r8KpBkwrJoAOKUw01
eMrw3n80oxJyOy9APFuk6zOBYssOnZJWPxTTeHv2x/nsyKyaBxzVDawigpuRvWtt
az1BF7mctsOlproBt88G/8rHtvni7N0/GfmDi2rHFP5KLrDmk/LFOrHq8ay2bYiX
Z6WUi5VWDBj3DNPzkgMa0grSk7CNe9Leph/Y9OgKTqLArY0ThmrUDTDboF94SFCL
MxNMx6V+MYW7IuJ15NH162qr9xGDJ6f5cs+3EHeiMO2wKqEZfENTyduVJrbw/CZl
i7f9zUJPDEzsyY27RBSYKsij9D0G8RRmwxzCYjckLJxhv97EwxzmafSkFKtZBMiA
p9kocpUr+KmW1Mg13viAWYglKZHtoiQuAwlR5bKWgoeoenIMpYUgSEzyILeebWfP
NZqHsmcMoONdL+W9+LJulBhCbjc3oUHM1MXOsFpe/wHCOiX2l14=
=okHE
-----END PGP SIGNATURE-----

--OzigliFs3e0dNr73--
