Received: from eggs.gnu.org ([2001:4830:134:3::10]:38049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYZB3-0003BB-OZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYZB2-0001Q6-O1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:49:45 -0400
References: <20180628153937.26097-1-kwolf@redhat.com>
	<20180628153937.26097-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0aa3ea2-c91e-3534-248e-b64791fb39ae@redhat.com>
Date: Thu, 28 Jun 2018 10:49:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180628153937.26097-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Free allocated clusters on
 write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 06/28/2018 10:39 AM, Kevin Wolf wrote:
> If we managed to allocate the clusters, but then failed to write the
> data, there's a good chance that we'll still be able to free the
> clusters again in order to avoid cluster leaks (the refcounts are
> cached, so even if we can't write them out right now, we may be able to
> do so when the VM is resumed after a werror=stop/enospc pause).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.h         |  1 +
>   block/qcow2-cluster.c | 11 +++++++++++
>   block/qcow2.c         |  2 ++
>   3 files changed, 14 insertions(+)

Hmm, I wonder if this interacts poorly with my proposed test addition 
for HUGE images, which is still pending review:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05488.html
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04542.html

(time for me to go testing...)

> +++ b/block/qcow2.c
> @@ -1777,6 +1777,8 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
>               if (ret) {
>                   goto out;
>               }
> +        } else {
> +            qcow2_alloc_cluster_abort(bs, l2meta);
>           }

None of our existing tests caught this? But it looks right to me.
Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
