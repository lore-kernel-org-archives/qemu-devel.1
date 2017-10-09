Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1Qra-0002be-0q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1QrW-00007L-RO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:44:26 -0400
Date: Mon, 9 Oct 2017 07:44:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171009074415.71d9dbba@nial.brq.redhat.com>
In-Reply-To: <20171006112503.GB10050@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-19-git-send-email-imammedo@redhat.com>
	<20171006083419.GW3260@umbus.fritz.box>
	<20171006113054.2af54a45@nial.brq.redhat.com>
	<20171006112503.GB10050@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/23] ppc: pnv: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

On Fri, 6 Oct 2017 22:25:03 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Oct 06, 2017 at 11:30:54AM +0200, Igor Mammedov wrote:
> > On Fri, 6 Oct 2017 19:34:19 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Thu, Oct 05, 2017 at 06:24:45PM +0200, Igor Mammedov wrote:  
> > > > use common cpu_model prasing in vl.c and set default cpu_model
> > > > using generic MachineClass::default_cpu_type.
> > > > 
> > > > Beside of switching to generic infrastructure it solves several
> > > > issues.
> > > > 
> > > >  * ppc_cpu_class_by_name() is used to deal with lower/upper case
> > > >    and alias translations into actual cpu type, which fixes
> > > >     '-M powernv -cpu power8' and '-M powernv -cpu power9_v1.0'
> > > >    usecases which error out with:
> > > >     'invalid CPU model 'FOO' for powernv machine'
> > > >  * allows to switch to lower-case typenames in pnv chip/core name
> > > >    (by convention typnames should be lower-case)
> > > >  * replace aliased names /power8, power9, .../ with exact cpu model
> > > >    names (i.e. typenames should be stable but aliases might decide to
> > > >    point to other cpu model withi family or changed by kvm). It will
> > > >    also help to simplify pnv_chip/core code and get rid of dependency
> > > >    on cpu_model parsing.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  include/hw/ppc/pnv.h |  8 ++++----
> > > >  hw/ppc/pnv.c         | 22 ++++++++++------------
> > > >  hw/ppc/pnv_core.c    |  2 +-
> > > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > > > index 9c5437d..2525f7f 100644
> > > > --- a/include/hw/ppc/pnv.h
> > > > +++ b/include/hw/ppc/pnv.h
> > > > @@ -80,19 +80,19 @@ typedef struct PnvChipClass {
> > > >      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> > > >  } PnvChipClass;
> > > >  
> > > > -#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-POWER8E"
> > > > +#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
> > > >  #define PNV_CHIP_POWER8E(obj) \
> > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
> > > >  
> > > > -#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-POWER8"
> > > > +#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
> > > >  #define PNV_CHIP_POWER8(obj) \
> > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
> > > >  
> > > > -#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-POWER8NVL"
> > > > +#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
> > > >  #define PNV_CHIP_POWER8NVL(obj) \
> > > >      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
> > > >  
> > > > -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-POWER9"
> > > > +#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"    
> > > 
> > > Uh.. we really should add a DD2 power9 before we make this change.
> > > Making a DD1.0 (read, buggy as hell) chip the default is not
> > > sensible.  Especially since we don't implement the various DD1 bugs
> > > and differences in qemu.  
> > I guess pnv owner will have to it,
> > I can't help here /me uses whatever is in code right now/  
> 
> I just committed a patch to ppc-for-2.11 that adds POWER9 v2.0 to the
> code (and makes it the default).  Sorry, this will probably require a
> rebase of your stuff.
Do you have a pointer to the patch or even better ppc staging tree to rebase on?
