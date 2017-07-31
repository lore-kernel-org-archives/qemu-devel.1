Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dc6TY-0000D5-AF
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dc6TU-0001o3-Ea
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dc6TU-0001nr-5O
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:54:52 -0400
Date: Mon, 31 Jul 2017 10:54:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170731105447.70428667@gondolin>
In-Reply-To: <20170728155048.GB5874@bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727114603.77b801e2@gondolin>
	<20170728092108.GE15504@bjsdjshi@linux.vnet.ibm.com>
	<20170728135301.0b510793@gondolin>
	<20170728155048.GB5874@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Channel Path realted CRW generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Fri, 28 Jul 2017 23:50:48 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-07-28 13:53:01 +0200]:

> > > > You're bound to get different kinds of notifications: via a CRW with
> > > > source channel path, via event information retrievable via CHSC
> > > > (indicated by a CRW with source CSS),    
> > > Ha, I was not awre of this one before!  
> > 
> > That's the 'link incident' and 'resource accessibility' stuff.  
> My focus was trying to have the minimum stuff to make a Linux guest
> working well -- basically, my working on prototype targeted to make the
> output lschp and lscss corect and uptodate. I
> 
> I will dig this and see if I need to do more stuff.

You can probably skip this for now, unless you want to propagate the
ficon-related stuff. Just plain channel-path related changes should
already cover the interesting stuff.

> > > My prototype work tries to sync the belowing information from host
> > > kernel to qemu:
> > > 1. the real SCHIB, so stsch from guest could get the updated path masks.  
> > 
> > How far do you want to go with mirroring? I think you need to modify at
> > least the devno in the pmcw, no?  
> I didn't think this very deep. For now, I only sync the PIM, POM, PAM
> and CHPIDs lazily.

Also consider the pno bit and the pnom.

> For devno... I need to think more. If the qemu command has a given
> "devno" for the vfio-ccw device, maybe we should not override its dev_id
> with the real one "device number".

The guest should not be surprised by a different devno, so you need to
be sure everything is consistent.


> > > 3. still working on support CHSC store channel path description command.  
> > 
> > I'm currently wondering how many of those chscs are optional. OTOH, if
> > a modern Linux guest cannot work properly without them, it makes no
> > sense to leave them out.  
> Nod.
> 
> But I think I need to define the criteria for "work properly". For
> example, with the current code, a Linux guest with a passed through
> device works, while lschp shows the Cfg. as 3 (not recognized), and the
> Shared and PCHID as "-". For this case, do you think it "work properly"?

It depends upon what you want to expose to the guest. Some
configuration checking or management tools might be reporting a
configuration deficiency (*might*, I do not know).

Shared and PGID may be useful if the operator wants to perform some
maintenance on the hardware (so they can figure out which systems/disks
are affected), but the information should be available in the
hypervisor as well, so I'm not sure whether it's a big deal.
