Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKNnH-0003Bc-J4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKNnE-00007x-DX
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKNnE-00007r-45
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B7E75F7B6
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:45:59 +0000 (UTC)
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-9-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5b6891c7-46e3-309e-cfa1-12ffa3245a62@redhat.com>
Date: Mon, 12 Jun 2017 13:45:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170601212921.30241-9-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] migration: create global_state.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 01/06/2017 23:29, Juan Quintela wrote:
> It don't belong anywhere else, just the global state where everybody
> can stick other things.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/i386/pc_piix.c                |   1 +
>  hw/ppc/spapr.c                   |   1 +
>  hw/xen/xen-common.c              |   1 +
>  include/migration/global_state.h |  25 +++++++
>  include/migration/migration.h    |   4 --
>  migration/Makefile.objs          |   2 +-
>  migration/global_state.c         | 140 +++++++++++++++++++++++++++++++++++++++
>  migration/migration.c            | 121 +--------------------------------
>  migration/savevm.c               |   1 +
>  vl.c                             |   1 +
>  10 files changed, 172 insertions(+), 125 deletions(-)
>  create mode 100644 include/migration/global_state.h
>  create mode 100644 migration/global_state.c
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2234bd0..dc19d96 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -52,6 +52,7 @@
>  #include <xen/hvm/hvm_info_table.h>
>  #include "hw/xen/xen_pt.h"
>  #endif
> +#include "migration/global_state.h"
>  #include "migration/migration.h"
>  #include "kvm_i386.h"
>  #include "sysemu/numa.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a44efbf..ac8a317 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -39,6 +39,7 @@
>  #include "sysemu/hw_accel.h"
>  #include "kvm_ppc.h"
>  #include "migration/migration.h"
> +#include "migration/global_state.h"
>  #include "migration/register.h"
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index a9055e9..e265445 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -14,6 +14,7 @@
>  #include "sysemu/char.h"
>  #include "sysemu/accel.h"
>  #include "migration/migration.h"
> +#include "migration/global_state.h"
>  
>  //#define DEBUG_XEN
>  
> diff --git a/include/migration/global_state.h b/include/migration/global_state.h
> new file mode 100644
> index 0000000..90faea7
> --- /dev/null
> +++ b/include/migration/global_state.h
> @@ -0,0 +1,25 @@
> +/*
> + * Global State configuration
> + *
> + * Copyright (c) 2014-2017 Red Hat Inc
> + *
> + * Authors:
> + *  Juan Quintela <quintela@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_GLOBAL_STATE_H
> +#define QEMU_MIGRATION_GLOBAL_STATE_H
> +
> +#include "sysemu/sysemu.h"
> +
> +void register_global_state(void);
> +void global_state_set_optional(void);
> +int global_state_store(void);
> +void global_state_store_running(void);
> +bool global_state_received(void);
> +RunState global_state_get_runstate(void);
> +
> +#endif
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index cb894b8..5050454 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -172,10 +172,6 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
>  
>  void savevm_skip_section_footers(void);
> -void register_global_state(void);
> -void global_state_set_optional(void);
>  void savevm_skip_configuration(void);
> -int global_state_store(void);
> -void global_state_store_running(void);
>  
>  #endif
> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> index 90f8c1f..1c7770d 100644
> --- a/migration/Makefile.objs
> +++ b/migration/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-y += migration.o socket.o fd.o exec.o
>  common-obj-y += tls.o channel.o savevm.o
>  common-obj-y += colo-comm.o colo.o colo-failover.o
>  common-obj-y += vmstate.o vmstate-types.o page_cache.o
> -common-obj-y += qemu-file.o
> +common-obj-y += qemu-file.o global_state.o
>  common-obj-y += qemu-file-channel.o
>  common-obj-y += xbzrle.o postcopy-ram.o
>  common-obj-y += qjson.o
> diff --git a/migration/global_state.c b/migration/global_state.c
> new file mode 100644
> index 0000000..16ac63f
> --- /dev/null
> +++ b/migration/global_state.c
> @@ -0,0 +1,140 @@
> +/*
> + * Global State configuration
> + *
> + * Copyright (c) 2014-2017 Red Hat Inc
> + *
> + * Authors:
> + *  Juan Quintela <quintela@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/util.h"
> +#include "migration/global_state.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/sysemu.h"
> +#include "trace.h"
> +
> +typedef struct {
> +    bool optional;
> +    uint32_t size;
> +    uint8_t runstate[100];
> +    RunState state;
> +    bool received;
> +} GlobalState;
> +
> +static GlobalState global_state;
> +
> +int global_state_store(void)
> +{
> +    if (!runstate_store((char *)global_state.runstate,
> +                        sizeof(global_state.runstate))) {
> +        error_report("runstate name too big: %s", global_state.runstate);
> +        trace_migrate_state_too_big();
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +void global_state_store_running(void)
> +{
> +    const char *state = RunState_lookup[RUN_STATE_RUNNING];
> +    strncpy((char *)global_state.runstate,
> +           state, sizeof(global_state.runstate));
> +}
> +
> +bool global_state_received(void)
> +{
> +    return global_state.received;
> +}
> +
> +RunState global_state_get_runstate(void)
> +{
> +    return global_state.state;
> +}
> +
> +void global_state_set_optional(void)
> +{
> +    global_state.optional = true;
> +}
> +
> +static bool global_state_needed(void *opaque)
> +{
> +    GlobalState *s = opaque;
> +    char *runstate = (char *)s->runstate;
> +
> +    /* If it is not optional, it is mandatory */
> +
> +    if (s->optional == false) {
> +        return true;
> +    }
> +
> +    /* If state is running or paused, it is not needed */
> +
> +    if (strcmp(runstate, "running") == 0 ||
> +        strcmp(runstate, "paused") == 0) {
> +        return false;
> +    }
> +
> +    /* for any other state it is needed */
> +    return true;
> +}
> +
> +static int global_state_post_load(void *opaque, int version_id)
> +{
> +    GlobalState *s = opaque;
> +    Error *local_err = NULL;
> +    int r;
> +    char *runstate = (char *)s->runstate;
> +
> +    s->received = true;
> +    trace_migrate_global_state_post_load(runstate);
> +
> +    r = qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
> +                                -1, &local_err);
> +
> +    if (r == -1) {
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +        return -EINVAL;
> +    }
> +    s->state = r;
> +
> +    return 0;
> +}
> +
> +static void global_state_pre_save(void *opaque)
> +{
> +    GlobalState *s = opaque;
> +
> +    trace_migrate_global_state_pre_save((char *)s->runstate);
> +    s->size = strlen((char *)s->runstate) + 1;
> +}
> +
> +static const VMStateDescription vmstate_globalstate = {
> +    .name = "globalstate",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = global_state_post_load,
> +    .pre_save = global_state_pre_save,
> +    .needed = global_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(size, GlobalState),
> +        VMSTATE_BUFFER(runstate, GlobalState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +void register_global_state(void)
> +{
> +    /* We would use it independently that we receive it */
> +    strcpy((char *)&global_state.runstate, "");
> +    global_state.received = false;
> +    vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 603d39d..6a7620b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -23,6 +23,7 @@
>  #include "socket.h"
>  #include "rdma.h"
>  #include "ram.h"
> +#include "migration/global_state.h"
>  #include "migration/migration.h"
>  #include "savevm.h"
>  #include "qemu-file-channel.h"
> @@ -164,126 +165,6 @@ void migration_incoming_state_destroy(void)
>      qemu_event_destroy(&mis->main_thread_load_event);
>  }
>  
> -
> -typedef struct {
> -    bool optional;
> -    uint32_t size;
> -    uint8_t runstate[100];
> -    RunState state;
> -    bool received;
> -} GlobalState;
> -
> -static GlobalState global_state;
> -
> -int global_state_store(void)
> -{
> -    if (!runstate_store((char *)global_state.runstate,
> -                        sizeof(global_state.runstate))) {
> -        error_report("runstate name too big: %s", global_state.runstate);
> -        trace_migrate_state_too_big();
> -        return -EINVAL;
> -    }
> -    return 0;
> -}
> -
> -void global_state_store_running(void)
> -{
> -    const char *state = RunState_lookup[RUN_STATE_RUNNING];
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> -}
> -
> -static bool global_state_received(void)
> -{
> -    return global_state.received;
> -}
> -
> -static RunState global_state_get_runstate(void)
> -{
> -    return global_state.state;
> -}
> -
> -void global_state_set_optional(void)
> -{
> -    global_state.optional = true;
> -}
> -
> -static bool global_state_needed(void *opaque)
> -{
> -    GlobalState *s = opaque;
> -    char *runstate = (char *)s->runstate;
> -
> -    /* If it is not optional, it is mandatory */
> -
> -    if (s->optional == false) {
> -        return true;
> -    }
> -
> -    /* If state is running or paused, it is not needed */
> -
> -    if (strcmp(runstate, "running") == 0 ||
> -        strcmp(runstate, "paused") == 0) {
> -        return false;
> -    }
> -
> -    /* for any other state it is needed */
> -    return true;
> -}
> -
> -static int global_state_post_load(void *opaque, int version_id)
> -{
> -    GlobalState *s = opaque;
> -    Error *local_err = NULL;
> -    int r;
> -    char *runstate = (char *)s->runstate;
> -
> -    s->received = true;
> -    trace_migrate_global_state_post_load(runstate);
> -
> -    r = qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
> -                                -1, &local_err);
> -
> -    if (r == -1) {
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -        return -EINVAL;
> -    }
> -    s->state = r;
> -
> -    return 0;
> -}
> -
> -static void global_state_pre_save(void *opaque)
> -{
> -    GlobalState *s = opaque;
> -
> -    trace_migrate_global_state_pre_save((char *)s->runstate);
> -    s->size = strlen((char *)s->runstate) + 1;
> -}
> -
> -static const VMStateDescription vmstate_globalstate = {
> -    .name = "globalstate",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .post_load = global_state_post_load,
> -    .pre_save = global_state_pre_save,
> -    .needed = global_state_needed,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(size, GlobalState),
> -        VMSTATE_BUFFER(runstate, GlobalState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
> -void register_global_state(void)
> -{
> -    /* We would use it independently that we receive it */
> -    strcpy((char *)&global_state.runstate, "");
> -    global_state.received = false;
> -    vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
> -}
> -
>  static void migrate_generate_event(int new_state)
>  {
>      if (migrate_use_events()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 543635b..265e908 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -38,6 +38,7 @@
>  #include "migration/snapshot.h"
>  #include "migration/misc.h"
>  #include "migration/register.h"
> +#include "migration/global_state.h"
>  #include "ram.h"
>  #include "qemu-file-channel.h"
>  #include "qemu-file.h"
> diff --git a/vl.c b/vl.c
> index 80b86c0..bf9aa6a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -88,6 +88,7 @@ int main(int argc, char **argv)
>  #include "hw/block/block.h"
>  #include "migration/misc.h"
>  #include "migration/snapshot.h"
> +#include "migration/global_state.h"
>  #include "sysemu/tpm.h"
>  #include "sysemu/dma.h"
>  #include "hw/audio/soundhw.h"
> 
