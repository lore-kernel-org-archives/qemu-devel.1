Received: from eggs.gnu.org ([2001:4830:134:3::10]:53567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8pj2-0001nf-Rd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8piz-0006Lg-KC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8piz-0006La-Aj
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FA2ACA1C5
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:09:52 +0000 (UTC)
Date: Thu, 11 May 2017 16:09:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170511150946.GH2078@work-vm>
References: <20170511143901.6340-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511143901.6340-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Move check_migratable() into
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> The function is only used once, and nothing else in migration knows
> about objects.  Create the function vmstate_device_is_migratable() in
> savem.c that really do the bit that is related with migration.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Yes, OK - please check it compiles with a user-mode only compile
I remember this case caught us a couple of times before, but you've
got the stub so you should be OK; also please add the comment as you
followed up with.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/core/qdev.c                | 25 +++++++++++++++++++++----
>  include/migration/migration.h |  6 ------
>  include/migration/vmstate.h   |  2 ++
>  include/sysemu/sysemu.h       |  2 +-
>  migration/migration.c         | 15 ---------------
>  migration/savevm.c            |  5 +++++
>  stubs/vmstate.c               |  5 ++---
>  7 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 02b632f..463e8dd 100644
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
> @@ -861,6 +861,25 @@ static bool device_get_realized(Object *obj, Error **errp)
>      return dev->realized;
>  }
>  
> +static bool check_only_migratable(Object *obj, Error **err)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(obj);
> +
> +    /* check needed if --only-migratable is specified */
> +    if (!only_migratable) {
> +        return true;
> +    }
> +
> +    if (!vmstate_device_is_migratable(dc->vmsd)) {
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
> @@ -870,7 +889,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      Error *local_err = NULL;
>      bool unattached_parent = false;
>      static int unattached_count;
> -    int ret;
>  
>      if (dev->hotplugged && !dc->hotpluggable) {
>          error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
> @@ -878,8 +896,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
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
> index e29cb01..0c9b6af 100644
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
>  struct MigrationParams {
>      bool blk;
>      bool shared;
> @@ -293,8 +289,6 @@ int migrate_add_blocker(Error *reason, Error **errp);
>   */
>  void migrate_del_blocker(Error *reason);
>  
> -int check_migratable(Object *obj, Error **err);
> -
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f4bf3f1..1a5bf9c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1067,4 +1067,6 @@ int64_t self_announce_delay(int round)
>  
>  void dump_vmstate_json_to_file(FILE *out_fp);
>  
> +bool vmstate_device_is_migratable(const VMStateDescription *vmsd);
> +
>  #endif
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 15656b7..9240fdb 100644
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
> index 799952c..fe62f15 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1158,21 +1158,6 @@ void migrate_del_blocker(Error *reason)
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
> index 352a8f2..0012de3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2323,3 +2323,8 @@ void vmstate_register_ram_global(MemoryRegion *mr)
>  {
>      vmstate_register_ram(mr, NULL);
>  }
> +
> +bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
> +{
> +    return !(vmsd && vmsd->unmigratable);
> +}
> diff --git a/stubs/vmstate.c b/stubs/vmstate.c
> index 6d52f29..5af824b 100644
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
> +bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
>  {
> -    return 0;
> +    return true;
>  }
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
