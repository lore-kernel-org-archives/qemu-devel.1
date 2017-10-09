Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1hV6-0006Sa-4Z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1hV4-00062J-VU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 19:30:19 -0400
Date: Mon, 9 Oct 2017 19:30:07 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171009233007.GB5170@localhost.localdomain>
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009215533.12530-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] qcow2: Fix unaligned
 preallocated truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Oct 09, 2017 at 11:55:31PM +0200, Max Reitz wrote:
> A qcow2 image file's length is not required to have a length that is a
> multiple of the cluster size.  However, qcow2_refcount_area() expects an
> aligned value for its @start_offset parameter, so we need to round
> @old_file_size up to the next cluster boundary.
> 
> Reported-by: pingl <pingl@redhat.com>
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1414049
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2f6a8e1ff8..c3b312cdef 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3193,6 +3193,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>                               "Failed to inquire current file length");
>              return old_file_size;
>          }
> +        old_file_size = ROUND_UP(old_file_size, s->cluster_size);
>  
>          nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
>                                              s->cluster_size);
> -- 
> 2.13.6
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
