Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dASt6-0001F1-1F
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dASt2-0003gm-Pc
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dASt2-0003gK-G2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:11:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29F2A368E7
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 03:10:59 +0000 (UTC)
Date: Tue, 16 May 2017 11:10:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170516031052.GE31572@pxdev.xzpeter.org>
References: <20170512155436.8936-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512155436.8936-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Move check_migratable() into
 qdev.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Fri, May 12, 2017 at 05:54:36PM +0200, Juan Quintela wrote:
> The function is only used once, and nothing else in migration knows
> about objects.  Create the function vmstate_device_is_migratable() in
> savem.c that really do the bit that is related with migration.

(may need to touch up the commit message as well, since we don't have
 vmstate_device_is_migratable() now)

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

For the build error for linux-user on previous v1, not sure defining
one only_migratable in stubs/vmstate.c can work. Anyway, I think
current patch is okay as well (considering that our goal is to cleanup
the header "#include"s). So, best with the commit message touched up:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> ---
> 
> - move only_migrateble use back to savevm.c to fix linux-user compilation.
> 
> 
>  hw/core/qdev.c                | 20 ++++++++++++++++----
>  include/migration/migration.h |  6 ------
>  include/migration/vmstate.h   |  2 ++
>  include/sysemu/sysemu.h       |  2 +-
>  migration/migration.c         | 15 ---------------
>  migration/savevm.c            | 10 ++++++++++
>  stubs/vmstate.c               |  5 ++---
>  7 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 02b632f..6f1b070 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -37,7 +37,7 @@
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "qapi-event.h"
> -#include "migration/migration.h"
> +#include "migration/vmstate.h"
>  
>  bool qdev_hotplug = false;
>  static bool qdev_hot_added = false;
> @@ -861,6 +861,20 @@ static bool device_get_realized(Object *obj, Error **errp)
>      return dev->realized;
>  }
>  
> +static bool check_only_migratable(Object *obj, Error **err)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(obj);
> +
> +    if (!vmstate_check_only_migratable(dc->vmsd)) {
> +        error_setg(err, "Device %s is not migratable, but "
> +                   "--only-migratable was specified",
> +                   object_get_typename(obj));
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void device_set_realized(Object *obj, bool value, Error **errp)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -870,7 +884,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      Error *local_err = NULL;
>      bool unattached_parent = false;
>      static int unattached_count;
> -    int ret;
>  
>      if (dev->hotplugged && !dc->hotpluggable) {
>          error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
> @@ -878,8 +891,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      }
>  
>      if (value && !dev->realized) {
> -        ret = check_migratable(obj, &local_err);
> -        if (ret < 0) {
> +        if (!check_only_migratable(obj, &local_err)) {
>              goto fail;
>          }
>  
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 1e23536..7ce3a7e 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -22,7 +22,6 @@
>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
> -#include "qom/object.h"
>  
>  #define QEMU_VM_FILE_MAGIC           0x5145564d
>  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> @@ -39,9 +38,6 @@
>  #define QEMU_VM_COMMAND              0x08
>  #define QEMU_VM_SECTION_FOOTER       0x7e
>  
> -/* for vl.c */
> -extern int only_migratable;
> -
>  /* Messages sent on the return path from destination to source */
>  enum mig_rp_message_type {
>      MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
> @@ -268,8 +264,6 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  void ram_postcopy_migrated_memory_release(MigrationState *ms);
>  
> -int check_migratable(Object *obj, Error **err);
> -
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 81af5fb..dacb052 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1066,4 +1066,6 @@ int64_t self_announce_delay(int round)
>  
>  void dump_vmstate_json_to_file(FILE *out_fp);
>  
> +bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
> +
>  #endif
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 3340202..83ecd13 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -15,7 +15,7 @@
>  /* vl.c */
>  
>  extern const char *bios_name;
> -
> +extern int only_migratable;
>  extern const char *qemu_name;
>  extern QemuUUID qemu_uuid;
>  extern bool qemu_uuid_set;
> diff --git a/migration/migration.c b/migration/migration.c
> index a6a9922..55c3958 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1162,21 +1162,6 @@ void migrate_del_blocker(Error *reason)
>      migration_blockers = g_slist_remove(migration_blockers, reason);
>  }
>  
> -int check_migratable(Object *obj, Error **err)
> -{
> -    DeviceClass *dc = DEVICE_GET_CLASS(obj);
> -    if (only_migratable && dc->vmsd) {
> -        if (dc->vmsd->unmigratable) {
> -            error_setg(err, "Device %s is not migratable, but "
> -                       "--only-migratable was specified",
> -                       object_get_typename(obj));
> -            return -1;
> -        }
> -    }
> -
> -    return 0;
> -}
> -
>  void qmp_migrate_incoming(const char *uri, Error **errp)
>  {
>      Error *local_err = NULL;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b24946f..de85e06 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2310,3 +2310,13 @@ void vmstate_register_ram_global(MemoryRegion *mr)
>  {
>      vmstate_register_ram(mr, NULL);
>  }
> +
> +bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
> +{
> +    /* check needed if --only-migratable is specified */
> +    if (!only_migratable) {
> +        return true;
> +    }
> +
> +    return !(vmsd && vmsd->unmigratable);
> +}
> diff --git a/stubs/vmstate.c b/stubs/vmstate.c
> index 6d52f29..6399474 100644
> --- a/stubs/vmstate.c
> +++ b/stubs/vmstate.c
> @@ -1,7 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "migration/vmstate.h"
> -#include "migration/migration.h"
>  
>  const VMStateDescription vmstate_dummy = {};
>  
> @@ -21,7 +20,7 @@ void vmstate_unregister(DeviceState *dev,
>  {
>  }
>  
> -int check_migratable(Object *obj, Error **err)
> +bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>  {
> -    return 0;
> +    return true;
>  }
> -- 
> 2.9.3
> 

-- 
Peter Xu
