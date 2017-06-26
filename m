Received: from eggs.gnu.org ([2001:4830:134:3::10]:43251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dPJOn-00038p-D0
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dPJOk-00066c-9L
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:05:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:13237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dPJOk-00066G-0C
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 22:05:06 -0400
Date: Mon, 26 Jun 2017 10:05:01 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170626020501.xq54xlnqmhika3zw@hz-desktop>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
	<20170623095522.GB12689@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623095522.GB12689@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>

On 06/23/17 10:55 +0100, Stefan Hajnoczi wrote:
> On Fri, Jun 23, 2017 at 08:13:13AM +0800, haozhong.zhang@intel.com wrote:
> > On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> > > I tried live migrating a guest with NVDIMM on qemu.git/master (edf8bc984):
> > > 
> > >   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
> > >          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> > > 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> > > 	 -drive if=virtio,file=test.img,format=raw
> > > 
> > >   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
> > >          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> > > 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> > > 	 -drive if=virtio,file=test.img,format=raw \
> > > 	 -incoming tcp::1234
> > > 
> > >   (qemu) migrate tcp:127.0.0.1:1234
> > > 
> > > The guest kernel panics or hangs every time on the destination.  It
> > > happens as long as the nvdimm device is present - I didn't even mount it
> > > inside the guest.
> > > 
> > > Is migration expected to work?
> > 
> > Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
> > have a look at this issue.
> 
> Great, thanks!
> 
> David Gilbert suggested the following on IRC, it sounds like a good
> starting point for debugging:
> 
> Launch the destination QEMU with -S (vcpus will be paused) and after
> migration has completed, compare the NVDIMM contents on source and
> destination.
> 

Which host and guest kernel are you testing? Is any workload running
in guest when migration?

I just tested QEMU commit edf8bc984 with host/guest kernel 4.8.0, and
could not reproduce the issue.

Haozhong
