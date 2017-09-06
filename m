Received: from eggs.gnu.org ([2001:4830:134:3::10]:38629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpaLp-0007rS-Ge
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpaLk-0005XC-Jr
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpaLk-0005Wh-Bv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:26:36 -0400
Date: Wed, 6 Sep 2017 14:26:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170906132624.GA8457@work-vm>
References: <20170822170212.27347-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: qemu-devel@nongnu.org, quintela@redhat.com, stefanha@redhat.com, christian.ehrhardt@canonical.com
Cc: peterx@redhat.com, lvivier@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
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

Queued for migration.

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
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
