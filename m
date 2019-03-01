Received: from eggs.gnu.org ([209.51.188.92]:47924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gznts-0007r3-Tu
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzntm-0002IC-Rp
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:50 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98d945ac-a57b-eb0d-7bb8-319675834c61@redhat.com>
Date: Fri, 1 Mar 2019 13:32:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block/dirty-bitmaps: add
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 3/1/19 1:15 PM, John Snow wrote:
> Add an inconsistent bit to dirty-bitmaps that allows us to report a bitmap as
> persistent but potentially inconsistent, i.e. if we find bitmaps on a qcow2
> that have been marked as "in use".
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json         | 13 +++++++++----
>  include/block/dirty-bitmap.h |  2 ++
>  block/dirty-bitmap.c         | 19 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6e543594b3..e639ef6d1c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -467,15 +467,20 @@
>  #        and cannot be modified via QMP or used by another operation.
>  #        Replaces `locked` and `frozen` statuses. (since 4.0)
>  #
> -# @persistent: true if the bitmap will eventually be flushed to persistent
> -#              storage (since 4.0)
> +# @persistent: true if the bitmap was stored on disk, is scheduled to be stored
> +#              on disk, or both. (since 4.0)
> +#
> +# @inconsistent: true if this is a persistent bitmap that was improperly
> +#                stored. Implies @persistent to be true; @recording and
> +#                @busy to be false. This bitmap cannot be used. To remove
> +#                it, use @block-dirty-bitmap-remove. (Since 4.0)
>  #

I know we waffled on word-smithing this, but this turned out nicely.


>  
> +/* Called with BQL taken. */
> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
> +{
> +    qemu_mutex_lock(bitmap->mutex);
> +    bitmap->inconsistent = true;
> +    bitmap->disabled = true;
> +    qemu_mutex_unlock(bitmap->mutex);

Worth an assert that persistent is true?  Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
