Received: from eggs.gnu.org ([2001:4830:134:3::10]:46155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ctpWs-0001UO-9m
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ctpWr-0000lO-DW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:55:22 -0400
Date: Fri, 31 Mar 2017 13:55:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170331055510.GC11195@lemon.lan>
References: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
	<1490440701-12037-3-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490440701-12037-3-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] vmdk: Rename get_whole_cluster() to
 vmdk_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Sat, 03/25 16:48, Ashijeet Acharya wrote:
> Rename the existing function get_whole_cluster() to vmdk_perform_cow()
> as its sole purpose is to perform COW for the first and the last
> allocated clusters if needed.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/vmdk.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 7795c5f..f5fda2c 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1036,8 +1036,8 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
>      }
>  }
>  
> -/**
> - * get_whole_cluster
> +/*
> + * vmdk_perform_cow
>   *
>   * Copy backing file's cluster that covers @sector_num, otherwise write zero,
>   * to the cluster at @cluster_sector_num.
> @@ -1045,13 +1045,18 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
>   * If @skip_start_sector < @skip_end_sector, the relative range
>   * [@skip_start_sector, @skip_end_sector) is not copied or written, and leave
>   * it for call to write user data in the request.
> + *
> + * Returns:
> + *   VMDK_OK:       on success
> + *
> + *   VMDK_ERROR:    in error cases
>   */
> -static int get_whole_cluster(BlockDriverState *bs,
> -                             VmdkExtent *extent,
> -                             uint64_t cluster_offset,
> -                             uint64_t offset,
> -                             uint64_t skip_start_bytes,
> -                             uint64_t skip_end_bytes)
> +static int vmdk_perform_cow(BlockDriverState *bs,
> +                            VmdkExtent *extent,
> +                            uint64_t cluster_offset,
> +                            uint64_t offset,
> +                            uint64_t skip_start_bytes,
> +                            uint64_t skip_end_bytes)
>  {
>      int ret = VMDK_OK;
>      int64_t cluster_bytes;
> -- 
> 2.6.2
> 
> 

Rule: each and every patch must be compilable.  A rename patch must take care of
all the users. Please find all get_whole_cluster occasions in the file and
change them to use the new name.

Fam
