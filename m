Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn0a2-0000lt-C1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn0Zy-00074O-Vv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:50:42 -0400
Date: Wed, 30 Aug 2017 12:50:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170830125033.340d7ca2@nial.brq.redhat.com>
In-Reply-To: <20170825093229.GH2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-6-git-send-email-imammedo@redhat.com>
	<20170825041644.GB2772@umbus.fritz.box>
	<20170825094037.4973225e@nial.brq.redhat.com>
	<20170825093229.GH2772@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/6] ppc: simplify cpu model
 lookup by PVR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Fri, 25 Aug 2017 19:32:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Aug 25, 2017 at 09:40:37AM +0200, Igor Mammedov wrote:
> > On Fri, 25 Aug 2017 14:16:44 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Thu, Aug 24, 2017 at 10:21:50AM +0200, Igor Mammedov wrote:  
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  target/ppc/translate_init.c | 27 +++++++++++----------------
> > > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > > index f1a559d..ca9f1e3 100644
> > > > --- a/target/ppc/translate_init.c
> > > > +++ b/target/ppc/translate_init.c
> > > > @@ -34,6 +34,7 @@
> > > >  #include "hw/ppc/ppc.h"
> > > >  #include "mmu-book3s-v3.h"
> > > >  #include "sysemu/qtest.h"
> > > > +#include "qemu/cutils.h"
> > > >  
> > > >  //#define PPC_DUMP_CPU
> > > >  //#define PPC_DEBUG_SPR
> > > > @@ -10203,22 +10204,16 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
> > > >      char *cpu_model, *typename;
> > > >      ObjectClass *oc;
> > > >      const char *p;
> > > > -    int i, len;
> > > > -
> > > > -    /* Check if the given name is a PVR */
> > > > -    len = strlen(name);
> > > > -    if (len == 10 && name[0] == '0' && name[1] == 'x') {
> > > > -        p = name + 2;
> > > > -        goto check_pvr;
> > > > -    } else if (len == 8) {
> > > > -        p = name;
> > > > -    check_pvr:
> > > > -        for (i = 0; i < 8; i++) {
> > > > -            if (!qemu_isxdigit(*p++))
> > > > -                break;
> > > > -        }
> > > > -        if (i == 8) {
> > > > -            return OBJECT_CLASS(ppc_cpu_class_by_pvr(strtoul(name, NULL, 16)));
> > > > +    unsigned long pvr;
> > > > +
> > > > +    /* Lookup by PVR if cpu_model is valid 8 digit hex number
> > > > +     * (excl: 0x prefix if present)
> > > > +     */
> > > > +    if (!qemu_strtoul(name, &p, 16, &pvr)) {
> > > > +        int len = p - name;
> > > > +        len = (len == 10) && (name[1] == 'x') ? len - 2 : len;
> > > > +        if (len == 8) {
> > > > +            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));    
> > > 
> > > This doesn't look quite right.  A hex string of a PVR followed by
> > > other stuff isn't a valid option, so if p (endptr) doesn't point to
> > > the end of the string, then we shouldn't be using this path  
> > yep, my mistake, I've lost somewhere *p == '\0' check when cleaning up the patch  
> 
> Ok.
> 
> > >(from the
> > > looks of qemu_strtoul() we can simply omit the endptr parameter to get
> > > that behaviour).  I'm not sure what the messing around with len is
> > > for, either.  If it's a valid hex string we can try this, I don't see
> > > that we need further checks.  
> > I've tried to keep current limitation here i.e. 8 hex symbols,
> > but if any hex number is fine then doing
> >  qemu_strtoul(name, NULL, 16, &pvr)
> > is even better, so would you prefer to drop 8 symbol check altogether?  
> 
> Yeah, I don't see any value to the 8 character check.
there are cpu models consisting of pure numbers => valid hex number
so if check is dropped then it lookup will go PVR route,
that will fail there.
So check should be there to avoid regression.

I'll fix whole string consumption check that I've missed before
and respin with it.
