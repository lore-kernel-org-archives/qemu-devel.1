Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egwLa-0004dE-7F
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egwLW-0007lQ-Pl
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:38:58 -0500
Date: Wed, 31 Jan 2018 18:38:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180131183845.4e3cb8c8.cohuck@redhat.com>
In-Reply-To: <69d20ca7-4134-4343-383e-80420225c65f@redhat.com>
References: <20180129165210.21086-1-cohuck@redhat.com>
	<20180129165210.21086-2-cohuck@redhat.com>
	<69d20ca7-4134-4343-383e-80420225c65f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de

On Tue, 30 Jan 2018 14:00:12 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 29.01.2018 17:52, Cornelia Huck wrote:
> > On s390x, pci support is implemented via a set of instructions
> > (no mmio). Unfortunately, none of them are documented in the
> > PoP; the code is based upon the existing implementation for KVM
> > and the Linux zpci driver.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/helper.h      |   9 ++++
> >  target/s390x/insn-data.def |  13 +++++
> >  target/s390x/misc_helper.c | 123 +++++++++++++++++++++++++++++++++++++++++++++
> >  target/s390x/translate.c   | 123 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 268 insertions(+)
> > 

> > diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> > index 11ee43dcbc..2ffc051072 100644
> > --- a/target/s390x/insn-data.def
> > +++ b/target/s390x/insn-data.def
> > @@ -1067,4 +1067,17 @@
> >      /* ??? Not listed in PoO ninth edition, but there's a linux driver that
> >         uses it: "A CHSC subchannel is usually present on LPAR only."  */
> >      C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
> > +
> > +/* zPCI Instructions */
> > +    /* None of these instructions are documented in the PoP, so this is all
> > +       based upon target/s390x/kvm.c and Linux code and likely incomplete */
> > +    C(0xebd0, PCISTB, RSY_a, PCI, 0, 0, 0, 0, pcistb, 0)
> > +    C(0xebd1, SIC, RSY_a, PCI, 0, 0, 0, 0, sic, 0)
> > +    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
> > +    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
> > +    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
> > +    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
> > +    C(0xe3d0, MPCIFC, RXY_a, PCI, 0, 0, 0, 0, mpcifc, 0)
> > +    C(0xe3d4, STPCIFC, RXY_a, PCI, 0, 0, 0, 0, stpcifc, 0)
> > +
> >  #endif /* CONFIG_USER_ONLY */

> b) we will handle !s390_has_feat(S390_FEAT_ZPCI) although available
> later just as other instructions via the "PCI" flag you attached to the
> instructions (Richard once posted a patch to do that).

> > @@ -5708,6 +5830,7 @@ enum DisasInsnEnum {
> >  #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
> >  #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
> >  #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
> > +#define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */

Thinking again: We should probably not attach the PCI flag to SIC, it
is independent of it (although only in use for pci adapters right now).
