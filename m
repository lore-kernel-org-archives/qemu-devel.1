Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZXfY-00031p-RL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZXfV-0006Gl-LV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:20:44 -0400
Message-ID: <1500880826.10674.66.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jul 2017 17:20:26 +1000
In-Reply-To: <20170724053827.GI17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
	<1500872645.10674.52.camel@kernel.crashing.org>
	<20170724053827.GI17228@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-24 at 15:38 +1000, David Gibson wrote:
> 
> Can we assign our logical numbers sparsely, or will that cause other
> problems?

The main issue is that they probably needs to be the same between XICS
and XIVE because by the time we get the CAS call to chose between XICS
and XIVE, we have already handed out interrupts and constructed the DT,
no ? Unless we do a real CAS reboot...

Otherwise, there's no reason they can't be sparse no.

> Note that for PAPR we also have the question of finding logical
> interrupts for legacy PAPR VIO devices.

We just make them another range ? With KVM legacy today, I just use the
generic interrupt facility for those. So when you do the ioctl to
"trigger" one, I just do an MMIO to the corresponding page and the
interrupt magically shows up wherever the guest is running the target
vcpu. In fact, I'd like to add a way to mmap that page into qemu so
that qemu can triggers them without an ioctl.

The guest doesn't care, from the guest perspective they are interrupts
coming from the DT, so they are like PCI etc...

> > We can fix the number of "generic" interrupts given to a guest. The
> > only requirements from a PAPR perspective is that there should be at
> > least as many as there are possible threads in the guest so they can be
> > used as IPIs.
> 
> Ok.  If we can do things sparsely, allocating these well away from the
> hw interrupts would make things easier.
> 
> > But we may need more for other things. We can make this a machine
> > parameter with a default value of something like 4096. If we call N
> > that number of extra generic interrupts, then the number of generic
> > interrutps would be #possible-vcpu's + N, or something like that.
> 
> That seems reasonable.
> 
> > > > But it's fundamentally an allocator that sits in the hypervisor, so in
> > > > our case, I would say in the spapr "component" of XIVE, rather than the
> > > > XIVE HW model itself.
> > > 
> > > Maybe..
> > 
> > You are right in that a mapping is a better term than an allocator
> > here.
> > 
> > > > Now what Cedric did, because XIVE is very complex and we need something
> > > > for PAPR quickly, is not a complete HW model, but a somewhat simplified
> > > > one that only handles what PAPR exposes. So in that case where the
> > > > allocator sits is a bit of a TBD...
> > > 
> > > Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> > > machine type level needs extreme caution, or the irqs may not be
> > > stable which will generally break migration.
> > 
> > Yes you are right. We should probably create a more "static" scheme.
> 
> Sounds like we're in violent agreement.

Yup :)

Cheers,
Ben.
