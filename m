Received: from eggs.gnu.org ([209.51.188.92]:55744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZeM-0002Ob-T8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZeH-00088x-Ut
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hLZeG-00088D-Po
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:45 -0400
Date: Tue, 30 Apr 2019 17:46:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190430204636.GK28722@habkost.net>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426003652.32633-2-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v15 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, yi.z.zhang@linux.intel.com, Haozhong Zhang <haozhong.zhang@intel.com>

Hi,

On Fri, Apr 26, 2019 at 08:36:51AM +0800, Wei Yang wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> When a file supporting DAX is used as vNVDIMM backend, mmap it with
> MAP_SYNC flag in addition which can ensure file system metadata
> synced in each guest writes to the backend file, without other QEMU
> actions (e.g., periodic fsync() by QEMU).
> 
> Current, We have below different possible use cases:
> 
> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>    a: backend is a dax supporting file.
>     - MAP_SYNC will active.
>    b: backend is not a dax supporting file.
>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> 
> 2. The rest of cases:
>    - we will never pass the MAP_SYNC to mmap2
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> [ehabkost: Rebased patch to latest code on master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Tested-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> ---
> v15: fix compile issue on pre-linux4.15
> v14: rebase on top of current upstream

Note that v14 was already merged, so the build fix would need to
be submitted separately.  However:

[...]
> +#ifdef CONFIG_LINUX
> +#include <linux/mman.h>
> +#endif /* CONFIG_LINUX */
> +
> +#ifndef MAP_SYNC
> +#define MAP_SYNC 0
> +#endif
> +#ifndef MAP_SHARED_VALIDATE
> +#define MAP_SHARED_VALIDATE 0
> +#endif

Why would we need this, if we added copies of mman.h to
linux-headers?

-- 
Eduardo
