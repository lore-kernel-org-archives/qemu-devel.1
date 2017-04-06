Received: from eggs.gnu.org ([2001:4830:134:3::10]:42507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cwEAv-0006YQ-U6
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cwEAs-0002q8-R3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:38:37 -0400
Received: from quartz.orcorp.ca ([184.70.90.242]:45097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1cwEAs-0002oO-Hu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:38:34 -0400
Date: Thu, 6 Apr 2017 14:38:23 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Message-ID: <20170406203823.GB25893@obsidianresearch.com>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<f7f3fc0e-0a75-2fdc-b3c2-6c3d34ff2978@redhat.com>
	<20170403062314.GO20443@mtr-leonro.local>
	<aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
	<20170404160155.GA1750@obsidianresearch.com>
	<20170406194218.GA2170@yuval-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406194218.GA2170@yuval-lap>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pvrdma: Proposal of a new pvrdma
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Leon Romanovsky <leon@kernel.org>, Doug Ledford <dledford@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org

On Thu, Apr 06, 2017 at 10:42:20PM +0300, Yuval Shaia wrote:

> > I'd rather see someone optimize the loopback path of soft roce than
> > see KDBR :)
> 
> Can we assume that the optimized loopback path will be as fast as direct
> copy between one VM address space to another VM address space?

Well, you'd optimize it until it was a direct memory copy, so I think
that is a reasonable starting assumption.

> > > 3. Our intention is for KDBR to be used in other contexts as well when we need
> > >    inter VM data exchange, e.g. backend for virtio devices. We didn't see how this
> > >    kind of requirement can be implemented inside SoftRoce as we don't see any
> > >    connection between them.
> > 
> > KDBR looks like weak RDMA to me, so it is reasonable question why not
> > use full RDMA with loopback optimization instead of creating something
> > unique.
> 
> True, KDBR exposes RDMA-like API because it's sole user is currently
> pvrdma device.  But, by design it can be expand to support other
> clients for example virtio device which might have other attributes,
> can we expect the same from SoftRoCE?

RDMA handles all sorts of complex virtio-like protocols just
fine. Unclear what 'other attributes' would be. Sounds like over
designing??

> > IMHO, it also makes more sense for something like KDBR to live as a
> > RDMA transport, not as a unique char device, it is obviously very
> > RDMA-like.
> 
> Can you elaborate more on this?
> What exactly it will solve?
> How it will be better than kdbr?

If you are going to do RDMA, then the uAPI for it from the kernel
should be the RDMA subsystem, don't invent unique cdevs that overlap
established kernel functionality without a very, very good reason.

> > .. and the char dev really can't be used when implementing user space
> > RDMA, that would just make a big mess..
> 
> The position of kdbr is not to be a layer *between* user space and device -
> it is *the device* from point of view of the process.

Any RDMA device built on top of kdbr certainly needs to support
/dev/uverbs0 and all the usual RDMA stuff, so again, I fail to see the
point of the special cdev.. Trying to mix /dev/uverbs0 and /dev/kdbr
in your provider would be too goofy and weird.

> > But obviously if you connect pvrdma to real hardware then the page pin
> > comes back.
> 
> The fact that page pin is not needed with Soft RoCE device but is needed
> with real RoCE device is exactly where kdbr can help as it isolates this
> fact from user space process.

I don't see how KDBR helps at all.

To do virtual RDMA you must transfer RDMA objects and commands
unmodified from VM to HV and implement a fairly complicated SW stack
inside the HV.

Once you do that, micro-optimizing for same-machine VM-to-VM copy is
not really such a big deal, IMHO.

The big challenge is keeping the real HW (or softrocee) RDMA objects
in sync with the VM ones and implementing some kind of RDMA-in-RDMA
tunnel to enable migration when using today's HW offload.

I see nothing in kdbr that helps with any of this. All it seems to do
is obfuscate the transfer of RDMA objects and commands to the
hypervisor, and make the transition of a RDMA channel from loopback to
network far, far, more complicated.

> Sorry, we didn't mean "easy" but "simple", and simplest solutions
> are always preferred.  IMHO, currently there is no good solution to
> do data copy between two VMs.

Don't confuse 'simple' with under featured. :)

> Can you comment on the second point - migration? Please note that we need
> it to work both with Soft RoCE and with real device.

I don't see how kdbr helps with migration, you still have to setup the
HW NIC and that needs sharing all the RDMA centric objects from VM to
HV.

Jason
