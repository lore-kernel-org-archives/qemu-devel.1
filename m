Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d41p0-0004wH-IQ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d41oy-0004Ry-9R
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d41oy-0004Rq-0T
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:04:12 -0400
Date: Fri, 28 Apr 2017 17:04:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428090405.GC24485@pxdev.xzpeter.org>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065753eucas1p1639528c4df0b459db96579fd5bee281c@eucas1p1.samsung.com>
	<1493362658-8179-3-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493362658-8179-3-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 2/6] migration: pass ptr to
 MigrationIncomingState into migration ufd_version_check &
 postcopy_ram_supported_by_host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On Fri, Apr 28, 2017 at 09:57:34AM +0300, Alexey Perevalov wrote:
> That tiny refactoring is necessary to be able to set
> UFFD_FEATURE_THREAD_ID while requesting features, and then
> to create downtime context in case when kernel supports it.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/migration/postcopy-ram.h |  2 +-
>  migration/migration.c            |  2 +-
>  migration/postcopy-ram.c         | 10 +++++-----
>  migration/savevm.c               |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
> index 8e036b9..809f6db 100644
> --- a/include/migration/postcopy-ram.h
> +++ b/include/migration/postcopy-ram.h
> @@ -14,7 +14,7 @@
>  #define QEMU_POSTCOPY_RAM_H
>  
>  /* Return true if the host supports everything we need to do postcopy-ram */
> -bool postcopy_ram_supported_by_host(void);
> +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
>  
>  /*
>   * Make all of RAM sensitive to accesses to areas that haven't yet been written
> diff --git a/migration/migration.c b/migration/migration.c
> index 353f272..569a7f6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -804,7 +804,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>           * special support.
>           */
>          if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
> -            !postcopy_ram_supported_by_host()) {
> +            !postcopy_ram_supported_by_host(NULL)) {
>              /* postcopy_ram_supported_by_host will have emitted a more
>               * detailed message
>               */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 85fd8d7..4c859b4 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -60,7 +60,7 @@ struct PostcopyDiscardState {
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> -static bool ufd_version_check(int ufd)
> +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)

This patch is mostly passing the incoming state around. IMHO it'll be
nicer if we squash this patch into the one that really uses the state.
What do you think?

Thanks,

-- 
Peter Xu
