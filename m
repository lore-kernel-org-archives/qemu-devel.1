Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQ1Ju-00064O-WC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dQ1Ju-0002O2-1V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:59:03 -0400
Message-ID: <1498611529.655.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 28 Jun 2017 10:58:49 +1000
In-Reply-To: <0ccd9fbf-cf3f-cd98-540c-e7bbae36ff88@redhat.com>
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<0ccd9fbf-cf3f-cd98-540c-e7bbae36ff88@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 2017-06-23 at 18:05 +0200, Thomas Huth wrote:
> On 23.06.2017 11:21, David Gibson wrote:
> > On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
> > > On 22.06.2017 13:26, Laurent Vivier wrote:
> > > > CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9
> > > > v1.0.
> > > > 
> > > > When we run qemu on a POWER9 DD1 host, we must use either
> > > > "-cpu host" or "-cpu POWER9", but in the latter case it fails
> > > > with
> > > > 
> > > >     Unable to find sPAPR CPU Core definition
> > > > 
> > > > because POWER9 DD1 doesn't appear in the list of known CPUs.
> > > > 
> > > > This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> > > > PVR instead of CPU_POWERPC_POWER9_BASE.
> > > > 
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > ---
> > > >  target/ppc/cpu-models.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > > > index 4d3e635..a22363c 100644
> > > > --- a/target/ppc/cpu-models.c
> > > > +++ b/target/ppc/cpu-models.c
> > > > @@ -1144,7 +1144,7 @@
> > > >      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,         
> > > >        970,
> > > >                  "PowerPC 970 v2.2")
> > > >  
> > > > -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,     
> > > >        POWER9,
> > > > +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,      
> > > >        POWER9,
> > > >                  "POWER9 v1.0")
> > > >  
> > > >      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,       
> > > >        970,
> > > > 
> > > 
> > > I think this also makes sense for running in TCG mode to get a
> > > valid
> > > real PVR there.
> > 
> > I'm not so convinced.
> > 
> > IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's
> > a)
> > probably not what anyone wants - who'd select a buggy prototype and
> > b)
> > not accurate - TCG does not implement DD1's bugs.
> 
> But DD1 = v1.0. There is no real chip which is using
> CPU_POWERPC_POWER9_BASE as PVR ... so using that is also not
> accurate,
> and also likely not what users expect when the select "POWER9_v1.0",
> and
> it just does not work as soon as KVM is enabled. So I think Laurent's
> patch is the right way to go. Or do you have a better suggestion?
> 

I guess we have do decide what we want to be the primary behaviour when
someone puts -cpu POWER9 on the command line. Does that mean that they
want an ISAv3.0 compliant cpu or do they want a POWER9 cpu...

FWIW: Currently POWER8 is aliased to POWER8_v2.0 which afaik is the
last POWER8 revision. Should POWER9 just alias to the most recent
POWER9 cpu (currently DD1)? Then how would you specify an ISAv3.0
compliant processor?

TCG only implements a ISAv3 compliant POWER9 cpu so it doesn't make
sense, and should even refuse to boot with POWER9_DD1 since I think it
will fail to boot if we let it.

My personal preference would be to have POWER9 alias to the base and
the user have to explicitly select if they want a DD* version. But that
might frustrate/confuse people. Maybe we should have some table in
KVM_HV of allowable processor combinations so that if the user is on
ISA compliant hardware then they can specify any such cpu on the
command line and KVM_HV still start successfully.

>  Thomas
> 
