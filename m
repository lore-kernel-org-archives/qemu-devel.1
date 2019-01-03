Received: from eggs.gnu.org ([208.118.235.92]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gf7ZP-0004S1-OT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gf7ZL-0007CZ-Ug
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:18:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gf7ZL-0007CE-MO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F34DC2C9776
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 18:18:10 +0000 (UTC)
Date: Thu, 3 Jan 2019 13:18:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190103130406-mutt-send-email-mst@kernel.org>
References: <20190103175113.18196-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103175113.18196-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] include: update Linux headers to 4.21/5.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com

On Thu, Jan 03, 2019 at 06:51:13PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Note that in the past we just updated what we needed.
That approach has some advantages as linux doesn't
stand in place, so whatever renames we handle now
just might have to get undone down the road.
And, it allows cherry-picking headers from netdev-next etc.

So maybe include a bit of motivation in the commit log.
E.g. do you plan to do this every linux release from now on?

> ---
>  include/standard-headers/drm/drm_fourcc.h     |   63 +
>  include/standard-headers/linux/ethtool.h      |   19 +-
>  .../linux/input-event-codes.h                 |   17 +
>  include/standard-headers/linux/pci_regs.h     |    1 +
>  include/standard-headers/linux/vhost_types.h  |  128 ++
>  .../standard-headers/linux/virtio_balloon.h   |    8 +
>  include/standard-headers/linux/virtio_blk.h   |   54 +
>  .../standard-headers/linux/virtio_config.h    |    3 +
>  include/standard-headers/linux/virtio_gpu.h   |   18 +
>  include/standard-headers/linux/virtio_ring.h  |   52 +
>  linux-headers/asm-arm/unistd-common.h         |    1 +
>  linux-headers/asm-arm64/unistd.h              |    1 +
>  linux-headers/asm-generic/unistd.h            |   10 +-
>  linux-headers/asm-mips/sgidefs.h              |    8 -
>  linux-headers/asm-mips/unistd.h               | 1074 +----------------
>  linux-headers/asm-mips/unistd_n32.h           |  338 ++++++
>  linux-headers/asm-mips/unistd_n64.h           |  334 +++++
>  linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
>  linux-headers/asm-powerpc/unistd.h            |  389 +-----
>  linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
>  linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
>  linux-headers/linux/kvm.h                     |   29 +
>  linux-headers/linux/vfio.h                    |   92 ++
>  linux-headers/linux/vhost.h                   |  113 +-
>  linux-headers/linux/vhost_types.h             |    1 +
>  scripts/update-linux-headers.sh               |   11 +
>  26 files changed, 2302 insertions(+), 1589 deletions(-)
>  create mode 100644 include/standard-headers/linux/vhost_types.h
>  create mode 100644 linux-headers/asm-mips/unistd_n32.h
>  create mode 100644 linux-headers/asm-mips/unistd_n64.h
>  create mode 100644 linux-headers/asm-mips/unistd_o32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_64.h
>  create mode 100644 linux-headers/linux/vhost_types.h

I'd prefer the shell script part and the new vhost_types header which
are actually reviewable to be split out to a separate patch.
And maybe split out unistd stuff that just happened to be there
since it's mostly just a jumbo list of numbers.


> diff --git a/linux-headers/linux/vhost_types.h b/linux-headers/linux/vhost_types.h
> new file mode 100644
> index 0000000000..473e3c0d81
> --- /dev/null
> +++ b/linux-headers/linux/vhost_types.h
> @@ -0,0 +1 @@
> +#include "standard-headers/linux/vhost_types.h"

Maybe add a comment here explaining where this came from and why?

BTW it can't hurt to add a preamble to each header we import that
says "this came from pdate-linux-headers.sh" - as it is once
in a while we have people try to edit these headers directly.
Doesn't need to be done right now naturally.

> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 0a964fe240..c933489cbc 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -101,6 +101,13 @@ for arch in $ARCHLIST; do
>  
>      if [ $arch = mips ]; then
>          cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
> +        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
> +        cp "$tmpdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
> +        cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
> +    fi
> +    if [ $arch = powerpc ]; then
> +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
> +        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
>      fi
>  
>      rm -rf "$output/include/standard-headers/asm-$arch"

A bit of an explanation about what happened here can't hurt.

> @@ -162,6 +169,9 @@ EOF
>  cat <<EOF >$output/linux-headers/linux/virtio_ring.h
>  #include "standard-headers/linux/virtio_ring.h"
>  EOF
> +cat <<EOF >$output/linux-headers/linux/vhost_types.h
> +#include "standard-headers/linux/vhost_types.h"
> +EOF

I guess this is because we want vhost_types.h on non-linux systems,
but vhost.h only on linux systems? The disadvantage to this
approach is that one can use #include <linux/vhost_types.h> by mistake
and it will only break on non-linux.
An alternative is to replace #include <linux/vhost_types.h> with
#include "standard-headers/linux/vhost_types.h"
when we are importing vhost.h

Not a big deal, but I thought I'd mention this.


>  
>  rm -rf "$output/include/standard-headers/linux"
>  mkdir -p "$output/include/standard-headers/linux"
> @@ -171,6 +181,7 @@ for i in "$tmpdir"/include/linux/*virtio*.h \
>           "$tmpdir/include/linux/input-event-codes.h" \
>           "$tmpdir/include/linux/pci_regs.h" \
>           "$tmpdir/include/linux/ethtool.h" "$tmpdir/include/linux/kernel.h" \
> +         "$tmpdir/include/linux/vhost_types.h" \
>           "$tmpdir/include/linux/sysinfo.h"; do
>      cp_portable "$i" "$output/include/standard-headers/linux"
>  done
> -- 
> 2.20.1
