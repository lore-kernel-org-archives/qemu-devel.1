Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fZmVr-0006pC-I9
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fZmVq-0003Ak-O7
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:16:15 -0400
Message-ID: <1530490562.3102.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 02 Jul 2018 10:16:02 +1000
In-Reply-To: <20180629062949.GO3422@umbus.fritz.box>
References: <20180629062024.20477-1-sjitindarsingh@gmail.com>
	<20180629062949.GO3422@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] ppc/tcg: Ignore bit 6 in the
 eieio instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 2018-06-29 at 16:29 +1000, David Gibson wrote:
> On Fri, Jun 29, 2018 at 04:20:24PM +1000, Suraj Jitindar Singh wrote:
> > The kernel patch
> > "powerpc/64s: Add support for a store forwarding barrier at kernel
> > entry/exit"
> > adds an eieio barrier instruction to kernel entry and exit points
> > on
> > the POWER9 platform. The eieio instruction form used has bit 6 set.
> > This bit is ignored by hardware however under tcg it causes an
> > illegal
> > instruction.
> > 
> > To allow these kernels to run under tcg, modify the eieio
> > instruction
> > to ignore bit 6.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> Already done by commit c8fd8373 "target/ppc: extend eieio for
> POWER9".

I obviously missed that :)

> 
> > ---
> >  target/ppc/translate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 3457d29f8e..b1ad1e2a22 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -6496,7 +6496,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12,
> > 0x00000001, PPC_STRING),
> >  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
> >  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
> >  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> > -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
> > +GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
> >  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
> >  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE,
> > PPC2_ATOMIC_ISA206),
> >  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE,
> > PPC2_ATOMIC_ISA206),
> 
> 
