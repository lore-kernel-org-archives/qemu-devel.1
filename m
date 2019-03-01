Received: from eggs.gnu.org ([209.51.188.92]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzbJB-0006ry-MQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzbJA-0006VT-OX
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:06:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzbJA-0006RJ-H5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:06:08 -0500
Date: Fri, 1 Mar 2019 07:05:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190301060551.xxnzbgf64b6pjusw@sirius.home.kraxel.org>
References: <1551413588-36475-1-git-send-email-08005325@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551413588-36475-1-git-send-email-08005325@163.com>
Subject: Re: [Qemu-devel] [PATCH] Fix coredump when using virtio-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 08005325@163.com
Cc: qemu-devel@nongnu.org, Michael Qiu <qiudayu@huayun.com>

On Fri, Mar 01, 2019 at 12:13:08PM +0800, 08005325@163.com wrote:
> From: Michael Qiu <qiudayu@huayun.com>
> 
> When using command -device virtio-vga,virgl=on
> the default max_outputs is 0, this will lead coredump,

The default is 1.

> @@ -46,6 +46,11 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      int i;
>      Error *local_error = NULL;
>  
> +    if (g->conf.max_outputs <= 0) {
> +        qemu_log("WARNING: virtio gpu max_outputs must greater than 1");
> +        g->conf.max_outputs = 1;
> +    }

There already is a sanity check in virtio_gpu_device_realize().
You can extend that to also throw an error in case max_outputs
is 0.  Fixing things up and continuing is a bad idea.  Yes there
are places in the qemu code base still doing that, for backward
compatibility with old versions, but we should not add new
instances of this.

cheers,
  Gerd
