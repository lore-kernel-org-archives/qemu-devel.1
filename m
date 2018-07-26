Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fiosV-0003mG-UL
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 18:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fiosQ-0002Mc-UB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 18:36:59 -0400
Message-ID: <1c0ea35e33f56f5127e5c934ca107775fd4933f1.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Jul 2018 08:36:30 +1000
In-Reply-To: <adea078d-3e69-9ba3-aea7-1e4f8affb1c4@kaod.org>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<adea078d-3e69-9ba3-aea7-1e4f8affb1c4@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 2018-07-26 at 11:03 +0200, C=C3=A9dric Le Goater wrote:
> Ben,
>=20
> I have found out recently that the QEMU PowerNV could hang while access=
ing
> the disk.=20
>=20
> The issue seems to be the phb3_msi_try_send() routine when called from=20
> the resend() handler. The 'P' is ignored in that case but not the 'Q'=20
> bit which means that no interrupt will be resent if P|Q are set.=20

I'd have to remember how PQ works on P8 ... my gut feeling is that we
should resend if P=3D1 but I'm no 100% certain.

> See the log extract below  :
>=20
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005000000fd eff pq=
=3D0 prio=3D5 server=3D8 ignore_p=3D0
>   PHB3(phb3_msi_set_p): MSI 0: setting P
>   PHB3(phb3_msi_set_p):  IVE readback: 0x2005010000fd
>   PHB3(phb3_msi_reject): MSI 0 rejected
>   PHB3(phb3_msi_resend): MSI resend...
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010000fd eff pq=
=3D0 prio=3D5 server=3D8 ignore_p=3D1
>   PHB3(phb3_msi_set_p): MSI 0: setting P
>   PHB3(phb3_msi_set_p):  IVE readback: 0x2005010000fd
>   PHB3(phb3_msi_reject): MSI 0 rejected
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010000fd eff pq=
=3D2 prio=3D5 server=3D8 ignore_p=3D0
>   PHB3(phb3_msi_set_q): MSI 0: setting Q
>   PHB3(phb3_msi_set_q):  IVE readback: 0x2005010100fd
>   PHB3(phb3_msi_resend): MSI resend...
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010100fd eff pq=
=3D1 prio=3D5 server=3D8 ignore_p=3D1
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010100fd eff pq=
=3D3 prio=3D5 server=3D8 ignore_p=3D0
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010100fd eff pq=
=3D3 prio=3D5 server=3D8 ignore_p=3D0
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010100fd eff pq=
=3D3 prio=3D5 server=3D8 ignore_p=3D0
>   PHB3(phb3_msi_try_send): MSI 0: try_send, ive=3D0x2005010100fd eff pq=
=3D3 prio=3D5 server=3D8 ignore_p=3D0
>   ... goes on and on ...
>   hangs
>=20
> I have added the relevant code at the bottom of the email.=20
>=20
>=20
> If the 'Q' bit is ignored also, the results are good with a SATA drive=20
> or a SCSI drive using the megasas model. Do you think this is correct ?
> I would say so but I am still discovering that part.
>=20
> I have no idea why it didn't show up before. May be because we mostly=20
> used virtio-blk.
>=20
> Thanks,
>=20
> C.=20
>=20
> > +static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool ign=
ore_p)
> > +{
> > +    ICSState *ics =3D ICS_BASE(msi);
> > +    uint64_t ive;
> > +    uint64_t server, prio, pq, gen;
> > +
> > +    if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
> > +        return;
> > +    }
> > +
> > +    server =3D GETFIELD(IODA2_IVT_SERVER, ive);
> > +    prio =3D GETFIELD(IODA2_IVT_PRIORITY, ive);
> > +    pq =3D GETFIELD(IODA2_IVT_Q, ive);
> > +    if (!ignore_p) {
> > +        pq |=3D GETFIELD(IODA2_IVT_P, ive) << 1;
> > +    }
> > +    gen =3D GETFIELD(IODA2_IVT_GEN, ive);
> > +
> > +    /*
> > +     * The low order 2 bits are the link pointer (Type II interrupts=
).
> > +     * Shift back to get a valid IRQ server.
> > +     */
> > +    server >>=3D 2;
> > +
> > +    switch (pq) {
> > +    case 0: /* 00 */
> > +        if (prio =3D=3D 0xff) {
> > +            /* Masked, set Q */
> > +            phb3_msi_set_q(msi, srcno);
> > +        } else {
> > +            /* Enabled, set P and send */
> > +            phb3_msi_set_p(msi, srcno, gen);
> > +            icp_irq(ics, server, srcno + ics->offset, prio);
> > +        }
> > +        break;
> > +    case 2: /* 10 */
> > +        /* Already pending, set Q */
> > +        phb3_msi_set_q(msi, srcno);
> > +        break;
> > +    case 1: /* 01 */
> > +    case 3: /* 11 */
> > +    default:
> > +        /* Just drop stuff if Q already set */
> > +        break;
> > +    }
> > +}
> > +
> > +static void phb3_msi_set_irq(void *opaque, int srcno, int val)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(opaque);
> > +
> > +    if (val) {
> > +        phb3_msi_try_send(msi, srcno, false);
> > +    }
> > +}
>=20
> [ ... ]
> =20
> > +static void phb3_msi_resend(ICSState *ics)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(ics);
> > +    unsigned int i, j;
> > +
> > +    if (msi->rba_sum =3D=3D 0) {
> > +        return;
> > +    }
> > +
> > +    for (i =3D 0; i < 32; i++) {
> > +        if ((msi->rba_sum & (1u << i)) =3D=3D 0) {
> > +            continue;
> > +        }
> > +        msi->rba_sum &=3D ~(1u << i);
> > +        for (j =3D 0; j < 64; j++) {
> > +            if ((msi->rba[i] & (1ull << j)) =3D=3D 0) {
> > +                continue;
> > +            }
> > +            msi->rba[i] &=3D ~(1u << j);
> > +            phb3_msi_try_send(msi, i * 64 + j, true);
> > +        }
> > +    }
> > +}
>=20
>=20
