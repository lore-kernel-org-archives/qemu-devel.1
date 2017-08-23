Received: from eggs.gnu.org ([2001:4830:134:3::10]:39847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkLAs-00018I-D2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkLAo-0007hS-Dw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:13:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dkLAo-0007g9-6w
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:13:38 -0400
Date: Wed, 23 Aug 2017 10:13:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170823021329.GA19071@pxdev.xzpeter.org>
References: <20170822170212.27347-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170822170212.27347-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Report when bdrv_inactivate_all
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, stefanha@redhat.com, christian.ehrhardt@canonical.com, lvivier@redhat.com

On Tue, Aug 22, 2017 at 06:02:12PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> If the bdrv_inactivate_all fails near the end of the migration,
> the migration will fail and often the only diagnostics in the log
> are an I/O error which you can't distinguish from an error on
> the socket connection.
> 
> Add an error so we know when it's actually a block problem.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

IMHO it would be nice if bdrv_inactivate_all() can print some error
message as soon as when the error occurs, then we can know more
details (or allow caller to pass in an Error *).  But at least adding
one more error message never hurts, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/savevm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fdd15fa0a7..7a55023d1a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1157,6 +1157,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>           * bdrv_invalidate_cache_all() on the other end won't fail. */
>          ret = bdrv_inactivate_all();
>          if (ret) {
> +            error_report("%s: bdrv_inactivate_all() failed (%d)",
> +                         __func__, ret);
>              qemu_file_set_error(f, ret);
>              return ret;
>          }
> -- 
> 2.13.5
> 

-- 
Peter Xu
