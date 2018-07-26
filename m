Received: from eggs.gnu.org ([2001:4830:134:3::10]:58161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ficBT-0006jL-QY
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ficBQ-0002Mc-S3
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:03:43 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ficBQ-000299-JV
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:03:40 -0400
Received: from player697.ha.ovh.net (unknown [10.109.146.173])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B7F22C0138
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 11:03:29 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <adea078d-3e69-9ba3-aea7-1e4f8affb1c4@kaod.org>
Date: Thu, 26 Jul 2018 11:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180628083633.12413-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Ben,

I have found out recently that the QEMU PowerNV could hang while accessing
the disk. 

The issue seems to be the phb3_msi_try_send() routine when called from 
the resend() handler. The 'P' is ignored in that case but not the 'Q' 
bit which means that no interrupt will be resent if P|Q are set. 

See the log extract below  :

  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005000000fd eff pq=0 prio=5 server=8 ignore_p=0
  PHB3(phb3_msi_set_p): MSI 0: setting P
  PHB3(phb3_msi_set_p):  IVE readback: 0x2005010000fd
  PHB3(phb3_msi_reject): MSI 0 rejected
  PHB3(phb3_msi_resend): MSI resend...
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010000fd eff pq=0 prio=5 server=8 ignore_p=1
  PHB3(phb3_msi_set_p): MSI 0: setting P
  PHB3(phb3_msi_set_p):  IVE readback: 0x2005010000fd
  PHB3(phb3_msi_reject): MSI 0 rejected
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010000fd eff pq=2 prio=5 server=8 ignore_p=0
  PHB3(phb3_msi_set_q): MSI 0: setting Q
  PHB3(phb3_msi_set_q):  IVE readback: 0x2005010100fd
  PHB3(phb3_msi_resend): MSI resend...
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010100fd eff pq=1 prio=5 server=8 ignore_p=1
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010100fd eff pq=3 prio=5 server=8 ignore_p=0
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010100fd eff pq=3 prio=5 server=8 ignore_p=0
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010100fd eff pq=3 prio=5 server=8 ignore_p=0
  PHB3(phb3_msi_try_send): MSI 0: try_send, ive=0x2005010100fd eff pq=3 prio=5 server=8 ignore_p=0
  ... goes on and on ...
  hangs

I have added the relevant code at the bottom of the email. 


If the 'Q' bit is ignored also, the results are good with a SATA drive 
or a SCSI drive using the megasas model. Do you think this is correct ?
I would say so but I am still discovering that part.

I have no idea why it didn't show up before. May be because we mostly 
used virtio-blk.

Thanks,

C. 

> +static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool ignore_p)
> +{
> +    ICSState *ics = ICS_BASE(msi);
> +    uint64_t ive;
> +    uint64_t server, prio, pq, gen;
> +
> +    if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
> +        return;
> +    }
> +
> +    server = GETFIELD(IODA2_IVT_SERVER, ive);
> +    prio = GETFIELD(IODA2_IVT_PRIORITY, ive);
> +    pq = GETFIELD(IODA2_IVT_Q, ive);
> +    if (!ignore_p) {
> +        pq |= GETFIELD(IODA2_IVT_P, ive) << 1;
> +    }
> +    gen = GETFIELD(IODA2_IVT_GEN, ive);
> +
> +    /*
> +     * The low order 2 bits are the link pointer (Type II interrupts).
> +     * Shift back to get a valid IRQ server.
> +     */
> +    server >>= 2;
> +
> +    switch (pq) {
> +    case 0: /* 00 */
> +        if (prio == 0xff) {
> +            /* Masked, set Q */
> +            phb3_msi_set_q(msi, srcno);
> +        } else {
> +            /* Enabled, set P and send */
> +            phb3_msi_set_p(msi, srcno, gen);
> +            icp_irq(ics, server, srcno + ics->offset, prio);
> +        }
> +        break;
> +    case 2: /* 10 */
> +        /* Already pending, set Q */
> +        phb3_msi_set_q(msi, srcno);
> +        break;
> +    case 1: /* 01 */
> +    case 3: /* 11 */
> +    default:
> +        /* Just drop stuff if Q already set */
> +        break;
> +    }
> +}
> +
> +static void phb3_msi_set_irq(void *opaque, int srcno, int val)
> +{
> +    Phb3MsiState *msi = PHB3_MSI(opaque);
> +
> +    if (val) {
> +        phb3_msi_try_send(msi, srcno, false);
> +    }
> +}

[ ... ]
 
> +static void phb3_msi_resend(ICSState *ics)
> +{
> +    Phb3MsiState *msi = PHB3_MSI(ics);
> +    unsigned int i, j;
> +
> +    if (msi->rba_sum == 0) {
> +        return;
> +    }
> +
> +    for (i = 0; i < 32; i++) {
> +        if ((msi->rba_sum & (1u << i)) == 0) {
> +            continue;
> +        }
> +        msi->rba_sum &= ~(1u << i);
> +        for (j = 0; j < 64; j++) {
> +            if ((msi->rba[i] & (1ull << j)) == 0) {
> +                continue;
> +            }
> +            msi->rba[i] &= ~(1u << j);
> +            phb3_msi_try_send(msi, i * 64 + j, true);
> +        }
> +    }
> +}
