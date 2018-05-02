Received: from eggs.gnu.org ([2001:4830:134:3::10]:53011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDvvW-0000sQ-L4
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDvvV-0005xu-Kg
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:52:26 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1b70360-a112-2d7c-33df-0ed5ec0ec3f9@redhat.com>
Date: Wed, 2 May 2018 12:52:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] block: Add Error parameter to
 bdrv_amend_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/21/2018 11:54 AM, Max Reitz wrote:
> Looking at the qcow2 code that is riddled with error_report() calls,
> this is really how it should have been from the start.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/block/qcow2.c
> @@ -4049,7 +4049,8 @@ static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>    * have to be removed.
>    */
>   static int qcow2_downgrade(BlockDriverState *bs, int target_version,
> -                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
> +                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
> +                           Error **errp)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       int current_version = s->qcow_version;
> @@ -4058,13 +4059,17 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>       if (target_version == current_version) {
>           return 0;
>       } else if (target_version > current_version) {
> +        error_setg(errp, "Cannot downgrade an image from version %i to %i",

%i is unusual compared to %d, but as they do the same, I won't make you 
change it, if we keep it.  That said, this function is static; and the 
lone caller qcow2_amend_options is already doing sanity checks, right? 
(Yes - it does qemu_opt_get(opts, BLOCK_OPT_COMPAT_LEVEL), and then 
validates that the user's information is in range, which already filters 
out everything but v2 and v3; then _this_ function is called exactly for 
3 downto 2).  So this should be an assert() instead of an error message.


> +                   current_version, target_version);
>           return -EINVAL;
>       } else if (target_version != 2) {
> +        error_setg(errp, "Cannot downgrade an image to version %i (only "
> +                   "target version 2 is supported)", target_version);

And again.

> @@ -4072,6 +4077,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>       if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
>           ret = qcow2_mark_clean(bs);
>           if (ret < 0) {
> +            error_setg(errp, "Failed to make the image clean: %s",
> +                       strerror(-ret));

error_setg_errno(), please.


> @@ -4094,6 +4103,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>   
>       ret = qcow2_expand_zero_clusters(bs, status_cb, cb_opaque);
>       if (ret < 0) {
> +        error_setg(errp, "Failed to turn zero into data clusters: %s",
> +                   strerror(-ret));

and again

>           return ret;
>       }
>   
> @@ -4101,6 +4112,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
>       ret = qcow2_update_header(bs);
>       if (ret < 0) {
>           s->qcow_version = current_version;
> +        error_setg(errp, "Failed to update the image header: %s",
> +                   strerror(-ret));

etc.  I'll quit pointing it out, but there are more.

> @@ -4293,18 +4311,17 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>           int refcount_order = ctz32(refcount_bits);
>   
>           if (new_version < 3 && refcount_bits != 16) {
> -            error_report("Different refcount widths than 16 bits require "
> -                         "compatibility level 1.1 or above (use compat=1.1 or "
> -                         "greater)");
> +            error_setg(errp, "Different refcount widths than 16 bits require "
> +                       "compatibility level 1.1 or above (use compat=1.1 or "
> +                       "greater)");

Not your fault, but that reads poorly.  Better would be:

Refcount widths other than 16 bits require compatibility level 1.1 or above

> +++ b/qemu-img.c
> @@ -3730,10 +3730,10 @@ static int img_amend(int argc, char **argv)
>   
>       /* In case the driver does not call amend_status_cb() */
>       qemu_progress_print(0.f, 0);
> -    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL);
> +    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
>       qemu_progress_print(100.f, 0);
>       if (ret < 0) {
> -        error_report("Error while amending options: %s", strerror(-ret));
> +        error_report_err(err);

Definitely nicer, but does change various outputs; glad you fixed 
iotests to match.

Overall a nice patch, looking forward to v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
