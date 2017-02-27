Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDWZ-0005GL-1H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDWX-00057j-Mo
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:07:03 -0500
Date: Mon, 27 Feb 2017 16:06:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227050648.GU17615@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-5-david@gibson.dropbear.id.au>
	<b091dc2d-7608-5bfc-fb2a-47024837715c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="67BqmJg2unxe7d8V"
Content-Disposition: inline
In-Reply-To: <b091dc2d-7608-5bfc-fb2a-47024837715c@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH 4/6] target/ppc: Cleanup HPTE accessors for
 64-bit hash MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--67BqmJg2unxe7d8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:02:54PM +1100, Alexey Kardashevskiy wrote:
> On 23/02/17 13:09, David Gibson wrote:
> > Accesses to the hashed page table (HPT) are complicated by the fact that
> > the HPT could be in one of three places:
> >    1) Within guest memory - when we're emulating a full guest CPU at the
> >       hardware level (e.g. powernv, mac99, g3beige)
> >    2) Within qemu, but outside guest memory - when we're emulating user=
 and
> >       supervisor instructions within TCG, but instead of emulating
> >       the CPU's hypervisor mode, we just emulate a hypervisor's behavio=
ur
> >       (pseries in TCG)
> >    3) Within KVM - a pseries machine using KVM acceleration.  Mostly
> >       accesses to the HPT are handled by KVM, but there are a few cases
> >       where qemu needs to access it via a special fd for the purpose.
> >=20
> > In order to batch accesses to the fd in case (3), we use a somewhat awk=
ward
> > ppc_hash64_start_access() / ppc_hash64_stop_access() pair, which for ca=
se
> > (3) reads / releases a whole PTEG from the kernel.  For cases (1) & (2)
> > it just returns an address value.  The actual HPTE load helpers then ne=
ed
> > to interpret the returned token differently in the 3 cases.
> >=20
> > This patch keeps the same basic structure, but simplfiies the details.
> > First start_access() / stop_access() are renamed to get_pteg() and
> > put_pteg() to make their operation more obvious.

[snip]
> >  /*********************************************************************=
********/
> > -/* Types used to describe some PowerPC registers */
> > +/* Types used to describe some PowerPC registers etc. */
> >  typedef struct DisasContext DisasContext;
> >  typedef struct ppc_spr_t ppc_spr_t;
> >  typedef union ppc_avr_t ppc_avr_t;
> >  typedef union ppc_tlb_t ppc_tlb_t;
> > +typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
> > =20
> >  /* SPR access micro-ops generations callbacks */
> >  struct ppc_spr_t {
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 52bbea5..9d3e57e 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2601,17 +2601,17 @@ struct kvm_get_htab_buf {
> >      /*
> >       * We require one extra byte for read
> >       */
> > -    target_ulong hpte[(HPTES_PER_GROUP * 2) + 1];
> > +    ppc_hash_pte64_t hpte[HPTES_PER_GROUP];
>=20
>=20
> The "one extra byte" (which was ulong) is not needed any more why?
>=20
>=20
> >  };
> > =20
> > -uint64_t kvmppc_hash64_read_pteg(PowerPCCPU *cpu, target_ulong pte_ind=
ex)
> > +const ppc_hash_pte64_t *kvmppc_map_hptes(hwaddr ptex, int n)
>=20
>=20
> This "int n" is ignored here by a reason?

So looking at these comments, I realized the current code for reading
the HPTEs from KVM is just broken.  So, for v2, I've prepended a patch
to fix that first, after which I don't need to touch the KVM side for
the rest of the series.

[snip]
> > +const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,\
>=20
>=20
> You do not need the trailing '\'.

Missed this comment on my first pass, fixed now, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--67BqmJg2unxe7d8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs7PmAAoJEGw4ysog2bOS8rsP/RQHrYQFrb8wqMjU2ksC+mNt
ZvVb6YhTBobS3otqAzxZ9DwSziK1QpwbqfKCXrPzYP/QjpNf15uSGIh08fYv69eC
2813FnjShu73yaDPr04hP4A6ckSGTMtUhS9xPC5ajk7XX+gFhdpdLDUIVauuE2Le
xG6zJu1ZVXt2F1dM35KLaiODgWDC/NobwjxolRSr7e2+eEItTHH0MJrARY+TPkqN
sHyRyOBzUj/c0BQQTMVN238PlGZ/3nTRkmMOeGXY31pANGhiPDMEPACGK5LzBJly
fXkPziirpRp6OxYaxnSOTAijEwUYtG/njOaQgyfhDN2Nc0UK++1WjLwHrNYZ4/gz
2uTIEaFG/UgUrwvGA9gf582ihF7kg0ZjZ9Bn2nBX3F+YR3H375aZL5Wz5VDwub8B
OasHrRP9JI4dHX1poXdPK/Pzc7AyWB2HkNHm673j0JIn6biFk72i6RcIXRnH1NGT
urVUK/qT8Wn4dIBA5BXe/f2R3AiyMIAZLdeygDXt1KxgRR25Xb7OUmgjFKE8LAzT
WfUWXEL43127JrRPcTJrlcH/T16v28kOHHYEnw0Q4Kl4nmnAIH+NWNXkZ6xWLvYP
l8OVOcqpwUJnL3amamj9G6qlgvxFVFhT7TfjPZIcgk97vLt/iAZMDhaz+iH7x623
PsXpqPKSxW0H/jtc/jQk
=A/kq
-----END PGP SIGNATURE-----

--67BqmJg2unxe7d8V--
