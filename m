Received: from eggs.gnu.org ([2001:4830:134:3::10]:59739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbY9T-0006a6-Mk
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbY9S-00030E-Mq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:20:27 -0400
References: <20180706164542.9476-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be1b9d41-1eb3-c24c-c459-cc6d6599de22@redhat.com>
Date: Fri, 6 Jul 2018 16:20:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180706164542.9476-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Fix copy-on-read crash with partial
 final cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 07/06/2018 11:45 AM, Kevin Wolf wrote:
> If the virtual disk size isn't aligned to full clusters,
> bdrv_co_do_copy_on_readv() may get pnum == 0 before having the full
> cluster completed, which will let it run into an assertion failure:
> 
> qemu-io: block/io.c:1203: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> 
> Check for EOF, assert that we read at least as much as the read request
> originally wanted to have (which is true at EOF because otherwise
> bdrv_check_byte_request() would already have returned an error) and
> return success early even though we couldn't copy the full cluster.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c                 | 6 ++++++
>   tests/qemu-iotests/197     | 9 +++++++++
>   tests/qemu-iotests/197.out | 8 ++++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 038449f81f..4c0831149c 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1200,6 +1200,12 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>               pnum = MIN(cluster_bytes, max_transfer);
>           }
>   
> +        /* Stop at EOF if the image ends in the middle of the cluster */
> +        if (ret == 0 && pnum == 0) {

Is it any smarter to check for 'ret & BDRV_BLOCK_EOF' instead of pnum == 0?

But as far as I can tell, right now those two conditions are synonymous.

>   
> +echo
> +echo '=== Partial final cluster ==='
> +echo
> +
> +_make_test_img 1024
> +$QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io

Here, $TEST_IMG has no backing file, and does not have the final cluster 
allocated; all we have to do is properly read all zeroes.  Is it worth 
also explicitly testing reading of allocated data under COR, and/or the 
case of one image with another backing image (with same or differing 
partial cluster sizes), where COR actually has to write the partial 
cluster?  However, the logic in the code appears to cover all of those, 
whether or not the testsuite does as well.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
