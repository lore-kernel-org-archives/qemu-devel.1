Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNoS-0001Jm-9i
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNoR-0004ye-Gk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:04:12 -0500
Date: Tue, 17 Jan 2017 15:04:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170117070401.GD21563@lemon.Home>
References: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
	<20170116211201.46601-4-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116211201.46601-4-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: get max_transfer limit for char
 (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

On Mon, 01/16 22:12, Eric Farman wrote:
> Commit 6f607174 introduced a routine to get the maximum number
> of bytes for a single I/O transfer for block devices, however
> scsi generic devices are character devices, not block.  Add
> a condition for this, with slightly different logic because
> the value is already in bytes, and need not be converted from
> blocks as happens for block devices.
> 
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  block/file-posix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2115155..c0843c2 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -679,6 +679,13 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>              if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
>                  bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
>              }
> +        } else if (S_ISCHR(st.st_mode)) {
> +            /* sg returns transfer length in bytes already */
> +            int ret = hdev_get_max_transfer_length(bs, s->fd);
> +            if (ret > 0 &&
> +                (ret >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS) {
> +                bs->bl.max_transfer = pow2floor(ret);
> +            }

Please keep the sectors/bytes quirk in hdev_get_max_transfer_length and always
return bytes from there.

Fam

>          }
>      }
>  
> -- 
> 2.8.4
> 
> 
