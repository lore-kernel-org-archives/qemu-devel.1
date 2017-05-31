Received: from eggs.gnu.org ([2001:4830:134:3::10]:42469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG7px-0000tJ-5U
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG7ps-0007UD-F1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG7ps-0007Sa-6k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:55:08 -0400
Date: Wed, 31 May 2017 18:54:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531175458.GG3342@work-vm>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113127eucas1p22dba0fddcc9bcf70e554bf659272f947@eucas1p2.samsung.com>
	<1495539071-12995-3-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495539071-12995-3-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 02/10] migration: pass
 MigrationIncomingState* into migration check functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> That tiny refactoring is necessary to be able to set
> UFFD_FEATURE_THREAD_ID while requesting features, and then
> to create downtime context in case when kernel supports it.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  migration/migration.c    |  2 +-
>  migration/postcopy-ram.c | 10 +++++-----
>  migration/postcopy-ram.h |  2 +-
>  migration/savevm.c       |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0304c01..d735976 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -789,7 +789,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>           * special support.
>           */
>          if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
> -            !postcopy_ram_supported_by_host()) {
> +            !postcopy_ram_supported_by_host(NULL)) {

Why is that NULL rather than migration_incoming_get_current()?
That's on the destination.

Dave

>              /* postcopy_ram_supported_by_host will have emitted a more
>               * detailed message
>               */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a0489f6..4adab36 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -59,7 +59,7 @@ struct PostcopyDiscardState {
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> -static bool ufd_version_check(int ufd)
> +static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>  {
>      struct uffdio_api api_struct;
>      uint64_t ioctl_mask;
> @@ -112,7 +112,7 @@ static int test_range_shared(const char *block_name, void *host_addr,
>   * normally fine since if the postcopy succeeds it gets turned back on at the
>   * end.
>   */
> -bool postcopy_ram_supported_by_host(void)
> +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
>  {
>      long pagesize = getpagesize();
>      int ufd = -1;
> @@ -135,7 +135,7 @@ bool postcopy_ram_supported_by_host(void)
>      }
>  
>      /* Version and features check */
> -    if (!ufd_version_check(ufd)) {
> +    if (!ufd_version_check(ufd, mis)) {
>          goto out;
>      }
>  
> @@ -512,7 +512,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>       * Although the host check already tested the API, we need to
>       * do the check again as an ABI handshake on the new fd.
>       */
> -    if (!ufd_version_check(mis->userfault_fd)) {
> +    if (!ufd_version_check(mis->userfault_fd, mis)) {
>          return -1;
>      }
>  
> @@ -650,7 +650,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
>  
>  #else
>  /* No target OS support, stubs just fail */
> -bool postcopy_ram_supported_by_host(void)
> +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
>  {
>      error_report("%s: No OS support", __func__);
>      return false;
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 52d51e8..587a8b8 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -14,7 +14,7 @@
>  #define QEMU_POSTCOPY_RAM_H
>  
>  /* Return true if the host supports everything we need to do postcopy-ram */
> -bool postcopy_ram_supported_by_host(void);
> +bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
>  
>  /*
>   * Make all of RAM sensitive to accesses to areas that haven't yet been written
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f5e8194..61a6df7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1356,7 +1356,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> -    if (!postcopy_ram_supported_by_host()) {
> +    if (!postcopy_ram_supported_by_host(mis)) {
>          postcopy_state_set(POSTCOPY_INCOMING_NONE);
>          return -1;
>      }
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
