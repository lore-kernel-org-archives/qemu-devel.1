Received: from eggs.gnu.org ([2001:4830:134:3::10]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKdj-00069x-Mp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKdi-00039J-KT
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cWKdi-00039B-Bq
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:17:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91011C05AA63
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:17:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-7-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 6 Jan 2017 18:28:14 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-7-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jan 2017 11:17:12 +0100
Message-ID: <87inp378bb.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/15] postcopy: Record largest page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Record the largest page size in use; we'll need it soon for allocating
> temporary buffers.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Not that I object, but .... could we store this in ram_list, and update it
it at RAMBlock creation time?  Why searh for the value later when we can
store it from the beggining.  Instead of putting it on migration_state,
put it on the ram_list itself?

Later, Juan.


> ---
>  exec.c                        | 13 +++++++++++++
>  include/exec/cpu-common.h     |  1 +
>  include/migration/migration.h |  1 +
>  migration/migration.c         |  1 +
>  4 files changed, 16 insertions(+)
>
> diff --git a/exec.c b/exec.c
> index 8d4bb0e..69331d0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1485,6 +1485,19 @@ size_t qemu_ram_pagesize(RAMBlock *rb)
>      return rb->page_size;
>  }
>  
> +/* Returns the largest size of page in use */
> +size_t qemu_ram_pagesize_largest(void)
> +{
> +    RAMBlock *block;
> +    size_t largest = 0;
> +
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        largest = MAX(largest, qemu_ram_pagesize(block));
> +    }
> +
> +    return largest;
> +}
> +
>  static int memory_try_enable_merging(void *addr, size_t len)
>  {
>      if (!machine_mem_merge(current_machine)) {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index bd15853..0e67727 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -64,6 +64,7 @@ void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
>  size_t qemu_ram_pagesize(RAMBlock *block);
> +size_t qemu_ram_pagesize_largest(void);
>  
>  void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
>                              int len, int is_write);
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 0188bcf..7b311dd 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -89,6 +89,7 @@ struct MigrationIncomingState {
>       */
>      QemuEvent main_thread_load_event;
>  
> +    size_t         largest_page_size;
>      bool           have_fault_thread;
>      QemuThread     fault_thread;
>      QemuSemaphore  fault_thread_sem;
> diff --git a/migration/migration.c b/migration/migration.c
> index f498ab8..d8dafde 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -387,6 +387,7 @@ static void process_incoming_migration_co(void *opaque)
>      int ret;
>  
>      mis = migration_incoming_state_new(f);
> +    mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
>                        MIGRATION_STATUS_ACTIVE);
