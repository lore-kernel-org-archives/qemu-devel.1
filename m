Received: from eggs.gnu.org ([2001:4830:134:3::10]:42193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cvQuE-0002uw-2z
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgunthorpe@obsidianresearch.com>) id 1cvQuA-00081w-Tv
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:02:06 -0400
Received: from quartz.orcorp.ca ([184.70.90.242]:33911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1cvQuA-00081I-Kv
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:02:02 -0400
Date: Tue, 4 Apr 2017 10:01:55 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Message-ID: <20170404160155.GA1750@obsidianresearch.com>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<f7f3fc0e-0a75-2fdc-b3c2-6c3d34ff2978@redhat.com>
	<20170403062314.GO20443@mtr-leonro.local>
	<aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>, Doug Ledford <dledford@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org, yuval.shaia@oracle.com

On Tue, Apr 04, 2017 at 04:38:40PM +0300, Marcel Apfelbaum wrote:

> Here are some thoughts regarding the Soft RoCE usage in our project.
> We thought about using it as backend for QEMU pvrdma device
> we didn't how it will support our requirements.
> 
> 1. Does Soft RoCE support inter process (VM) fast path ? The KDBR
>    removes the need for hw resources, emulated or not, concentrating
>    on one copy from a VM to another.

I'd rather see someone optimize the loopback path of soft roce than
see KDBR :)

> 3. Our intention is for KDBR to be used in other contexts as well when we need
>    inter VM data exchange, e.g. backend for virtio devices. We didn't see how this
>    kind of requirement can be implemented inside SoftRoce as we don't see any
>    connection between them.

KDBR looks like weak RDMA to me, so it is reasonable question why not
use full RDMA with loopback optimization instead of creating something
unique.

IMHO, it also makes more sense for something like KDBR to live as a
RDMA transport, not as a unique char device, it is obviously very
RDMA-like.

.. and the char dev really can't be used when implementing user space
RDMA, that would just make a big mess..

> 4. We don't want all the VM memory to be pinned since it disable memory-over-commit
>    which in turn will make the pvrdma device useless.
>    We weren't sure how nice would play Soft RoCE with memory pinning and we wanted
>    more control on memory management. It may be a solvable issue, but combined
>    with the others lead us to our decision to come up with our kernel bridge (char

soft roce certainly can be optimized to remove the page pin and always
run in an ODP-like mode.

But obviously if you connect pvrdma to real hardware then the page pin
comes back.

>    device or not, we went for it since it was the easiest to
>    implement for a POC)

I can see why it would be easy to implement, but not sure how this
really improves the kernel..

Jason
