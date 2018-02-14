Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1elzig-000155-8Z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1elzic-0002xz-29
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:15:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1elzib-0002xY-T3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:15:38 -0500
Date: Wed, 14 Feb 2018 18:15:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180214175303-mutt-send-email-mst@kernel.org>
References: <20180212180819.82556-1-marcel@redhat.com>
	<20180212180819.82556-4-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212180819.82556-4-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V10 3/9] include/standard-headers: add
 pvrdma related headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, dotanb@mellanox.com, yanjun.zhu@oracle.com

On Mon, Feb 12, 2018 at 08:08:13PM +0200, Marcel Apfelbaum wrote:
> Also modify update-linux-headers.sh script to manage
> the headers needed by the pvrdma device.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---

Would be best to make script update a separate patch.
Automatically generated stuff can come later.

Overall comments below are minor. if you do not respin
you can address them later as a patch on top.

> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 135a10d96a..c1a7c1e99c 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -38,6 +38,7 @@ cp_portable() {
>                                       -e 'linux/if_ether' \
>                                       -e 'input-event-codes' \
>                                       -e 'sys/' \
> +                                     -e 'pvrdma_verbs' \
>                                       > /dev/null
>      then
>          echo "Unexpected #include in input file $f".
> @@ -46,6 +47,7 @@ cp_portable() {
>  
>      header=$(basename "$f");
>      sed -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
> +        -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
>          -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
>          -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
>          -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
> @@ -56,6 +58,7 @@ cp_portable() {
>          -e 's/__inline__/inline/' \
>          -e '/sys\/ioctl.h/d' \
>          -e 's/SW_MAX/SW_MAX_/' \
> +        -e 's/atomic_t/int/' \
>          "$f" > "$to/$header";
>  }
>  
> @@ -147,6 +150,30 @@ for i in "$tmpdir"/include/linux/*virtio*.h "$tmpdir/include/linux/input.h" \
>      cp_portable "$i" "$output/include/standard-headers/linux"
>  done
>  
> +rm -rf "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
> +mkdir -p "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
> +
> +# Remove the unused functions from pvrdma_verbs.h avoiding the unnecessary
> +# import of several infiniband/networking/other headers
> +tmp_pvrdma_verbs="$tmpdir/pvrdma_verbs.h"
> +sed  -e '1h;2,$H;$!d;g'

what does this do exactly?

>  -e 's/[^};]*pvrdma[^(| ]*([^)]*);//g' \

and this?

> +    "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h" > \
> +    "$tmp_pvrdma_verbs";
> +

I suspect you want the enums from these headers but not the
rest of stuff there?

> +for i in "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h" \
> +         "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h" \
> +         "$tmp_pvrdma_verbs"; do \
> +    cp_portable "$i" \
> +         "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/"
> +done

Is the maintainer aware these are an interface? If yes
is there a chance to move at least some of these out to uapi?
That will split the code logically, and qemu could import
files without hacks.


> +
> +rm -rf "$output/include/standard-headers/rdma/"
> +mkdir -p "$output/include/standard-headers/rdma/"
> +for i in "$tmpdir/include/rdma/vmw_pvrdma-abi.h"; do
> +    cp_portable "$i" \
> +         "$output/include/standard-headers/rdma/"
> +done
> +
>  cat <<EOF >$output/include/standard-headers/linux/types.h
>  /* For QEMU all types are already defined via osdep.h, so this
>   * header does not need to do anything.
> -- 
> 2.13.5
