Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dOCE2-0000E4-2Y
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dOCDx-0007Li-3w
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:13:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:60542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dOCDw-0007Cs-S0
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 20:13:21 -0400
Date: Fri, 23 Jun 2017 08:13:13 +0800
From: <haozhong.zhang@intel.com>
Message-ID: <20170623001313.n6cms5sunwuqnf4h@hz-desktop>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622140827.GA29936@stefanha-x1.localdomain>
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

On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> I tried live migrating a guest with NVDIMM on qemu.git/master (edf8bc984):
> 
>   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
>          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> 	 -drive if=virtio,file=test.img,format=raw
> 
>   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
>          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> 	 -drive if=virtio,file=test.img,format=raw \
> 	 -incoming tcp::1234
> 
>   (qemu) migrate tcp:127.0.0.1:1234
> 
> The guest kernel panics or hangs every time on the destination.  It
> happens as long as the nvdimm device is present - I didn't even mount it
> inside the guest.
> 
> Is migration expected to work?

Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
have a look at this issue.

Haozhong

> 
> If not we need a migration blocker so that users get a graceful error
> message.
> 
> Stefan
