Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fa9zR-000170-TB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fa9zQ-0004RS-Cg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:20:21 -0400
Date: Tue, 3 Jul 2018 09:20:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180703012009.GA485@lemon.usersys.redhat.com>
References: <20180702210721.4847-1-mreitz@redhat.com>
	<20180702210721.4847-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702210721.4847-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vmdk: Fix possible segfault with
 non-VMDK backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, 07/02 23:07, Max Reitz wrote:
> VMDK performs a probing check in vmdk_co_create_opts() to prevent the
> user from assigning non-VMDK files as a backing file, because it only
> supports VMDK backing files.  However, with the @backing runtime option,
> it is possible to assign arbitrary nodes as backing nodes, regardless of
> what the image header says.  Therefore, VMDK may not just access backing
> nodes assuming they are VMDK nodes -- which it does, because it needs to
> compare the backing file's CID with the overlay's parentCID value, and
> naturally the backing file only has a CID when it's a VMDK file.
> Instead, it should report the CID of non-VMDK backing files not to match
> the overlay because clearly a non-present CID does not match.
> 
> Without this change, vmdk_read_cid() reads from the backing file's
> bs->file, which may be NULL (in which case we get a segfault).  Also, it
> interprets bs->opaque as a BDRVVmdkState and then reads from the
> .desc_offset field, which usually will just return some arbitrary value
> which then results in either garbage to be read, or bdrv_pread() to
> return an error, both of which result in a non-matching CID to be
> reported.
> 
> (In a very unlikely case, we could read something that looks like a
> VMDK descriptor, and then get a CID which might actually match.  But
> that is highly unlikely, and the only result would be that VMDK accepts
> the backing file which is not too bad (albeit unintentional).)
> 
> ((And in theory, the seek to .desc_offset might leak data from another
> block driver's opaque object.  But then again, the user should realize
> very quickly that a non-VMDK backing file does not work (because the
> read will very likely fail, due to the reasons given above), so this
> should not be exploitable.))
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/vmdk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 84f8bbe480..a9d0084e36 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -333,6 +333,12 @@ static int vmdk_is_cid_valid(BlockDriverState *bs)
>      if (!s->cid_checked && bs->backing) {
>          BlockDriverState *p_bs = bs->backing->bs;
>  
> +        if (strcmp(p_bs->drv->format_name, "vmdk")) {
> +            /* Backing file is not in vmdk format, so it does not have
> +             * a CID, which makes the overlay's parent CID invalid */
> +            return 0;
> +        }
> +

Reviewed-by: Fam Zheng <famz@redhat.com>

>          if (vmdk_read_cid(p_bs, 0, &cur_pcid) != 0) {
>              /* read failure: report as not valid */
>              return 0;
> -- 
> 2.17.1
> 
