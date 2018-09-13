Received: from eggs.gnu.org ([2001:4830:134:3::10]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TPV-00085D-R1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TPV-0006YK-4y
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:20:01 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-11-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2973246-b3e2-3daf-f44c-9c15ac9f20d6@redhat.com>
Date: Thu, 13 Sep 2018 17:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/17] block-backend: Fix potential
 double blk_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 13/09/2018 14:52, Kevin Wolf wrote:
> blk_unref() first decreases the refcount of the BlockBackend and calls
> blk_delete() if the refcount reaches zero. Requests can still be in
> flight at this point, they are only drained during blk_delete():
> 
> At this point, arbitrary callbacks can run. If any callback takes a
> temporary BlockBackend reference, it will first increase the refcount to
> 1 and then decrease it to 0 again, triggering another blk_delete(). This
> will cause a use-after-free crash in the outer blk_delete().
> 
> Fix it by draining the BlockBackend before decreasing to refcount to 0.
> Assert in blk_ref() that it never takes the first refcount (which would
> mean that the BlockBackend is already being deleted).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index efa8d8011c..1b2d7a6ff5 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -435,6 +435,7 @@ int blk_get_refcnt(BlockBackend *blk)
>   */
>  void blk_ref(BlockBackend *blk)
>  {
> +    assert(blk->refcnt > 0);
>      blk->refcnt++;
>  }
>  
> @@ -447,7 +448,11 @@ void blk_unref(BlockBackend *blk)
>  {
>      if (blk) {
>          assert(blk->refcnt > 0);
> -        if (!--blk->refcnt) {
> +        if (blk->refcnt > 1) {
> +            blk->refcnt--;
> +        } else {
> +            blk_drain(blk);

Maybe "assert(blk->refcnt == 1);" here to ensure that blk_drain() cannot
resurrect the block device, or alternatively

+    if (blk->refcnt == 1) {
+        blk_drain(blk);
+        assert(blk->refcnt == 1);
+    }
     if (!--blk->refcnt) {
         blk_delete(blk);
     }

Paolo
