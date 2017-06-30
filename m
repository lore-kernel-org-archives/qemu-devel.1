Received: from eggs.gnu.org ([2001:4830:134:3::10]:47148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dR3JF-0005tQ-G4
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dR3JA-0000qV-CA
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:18:37 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dR3JA-0000p1-6m
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:18:32 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so16956183qkq.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 14:18:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170628113106.5248-1-quintela@redhat.com>
	<20170628113106.5248-5-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
Date: Fri, 30 Jun 2017 18:18:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170628113106.5248-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 04/14] migration: let MigrationState be a
 qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Peter, Juan,

On 06/28/2017 08:30 AM, Juan Quintela wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Let the old man "MigrationState" join the object family. Direct benefit
> is that we can start to use all the property features derived from
> current QDev, like: HW_COMPAT_* bits, command line setup for migration
> parameters (so will never need to set them up each time using HMP/QMP,
> this is really, really attractive for test writters), etc.
> 
> I see no reason to disallow this happen yet. So let's start from this
> one, to see whether it would be anything good.
> 
> Now we init the MigrationState struct statically in main() to make sure
> it's initialized after global properties are applied, since we'll use
> them during creation of the object.
> 
> No functional change at all.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <1498536619-14548-5-git-send-email-peterx@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   include/migration/misc.h |  1 +
>   migration/migration.c    | 78 ++++++++++++++++++++++++++++++++++--------------
>   migration/migration.h    | 19 ++++++++++++
>   vl.c                     |  6 ++++
>   4 files changed, 81 insertions(+), 23 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 65c7070..2d36cf5 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -45,6 +45,7 @@ void savevm_skip_section_footers(void);
>   void savevm_skip_configuration(void);
>   
>   /* migration/migration.c */
> +void migration_object_init(void);
>   void qemu_start_incoming_migration(const char *uri, Error **errp);
>   bool migration_is_idle(void);
>   void add_migration_state_change_notifier(Notifier *notify);
> diff --git a/migration/migration.c b/migration/migration.c
> index f588329..2c25927 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -98,32 +98,21 @@ enum mig_rp_message_type {
>      migrations at once.  For now we don't need to add
>      dynamic creation of migration */
>   
> +static MigrationState *current_migration;
> +
> +void migration_object_init(void)
> +{
> +    /* This can only be called once. */
> +    assert(!current_migration);
> +    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> +}
> +
>   /* For outgoing */
>   MigrationState *migrate_get_current(void)
>   {
> -    static bool once;
> -    static MigrationState current_migration = {
> -        .state = MIGRATION_STATUS_NONE,
> -        .xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE,
> -        .mbps = -1,
> -        .parameters = {
> -            .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
> -            .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
> -            .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
> -            .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
> -            .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
> -            .max_bandwidth = MAX_THROTTLE,
> -            .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
> -            .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
> -        },
> -    };
> -
> -    if (!once) {
> -        current_migration.parameters.tls_creds = g_strdup("");
> -        current_migration.parameters.tls_hostname = g_strdup("");
> -        once = true;
> -    }
> -    return &current_migration;
> +    /* This can only be called after the object created. */
> +    assert(current_migration);

This this pull I'v been unable to run qemu:

qemu-system-arm: migration/migration.c:127: migrate_get_current: 
Assertion `current_migration' failed.

I'v bisected to this commit using the following script:

#! /usr/bin/env bash
test -f test.qcow2 || qemu-img create -f qcow test.qcow2 1G
make -C build/system-arm subdir-arm-softmmu -j4 || exit 125
echo q | build/system-arm/arm-softmmu/qemu-system-arm -M virt \
   -drive if=none,file=test.qcow2,format=qcow,id=hd \
   -device virtio-blk-device,drive=hd \
   -nographic -serial null -monitor stdio
test $? -eq 0 || exit 1

Regards,

Phil.

> +    return current_migration;
>   }
>   
>   MigrationIncomingState *migration_incoming_get_current(void)
> @@ -1987,3 +1976,46 @@ void migrate_fd_connect(MigrationState *s)
>       s->migration_thread_running = true;
>   }
>   
> +static void migration_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->user_creatable = false;
> +}
> +
> +static void migration_instance_init(Object *obj)
> +{
> +    MigrationState *ms = MIGRATION_OBJ(obj);
> +
> +    ms->state = MIGRATION_STATUS_NONE;
> +    ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
> +    ms->mbps = -1;
> +    ms->parameters = (MigrationParameters) {
> +        .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
> +        .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
> +        .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
> +        .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
> +        .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
> +        .max_bandwidth = MAX_THROTTLE,
> +        .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
> +        .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
> +    };
> +    ms->parameters.tls_creds = g_strdup("");
> +    ms->parameters.tls_hostname = g_strdup("");
> +}
> +
> +static const TypeInfo migration_type = {
> +    .name = TYPE_MIGRATION,
> +    .parent = TYPE_DEVICE,
> +    .class_init = migration_class_init,
> +    .class_size = sizeof(MigrationClass),
> +    .instance_size = sizeof(MigrationState),
> +    .instance_init = migration_instance_init,
> +};
> +
> +static void register_migration_types(void)
> +{
> +    type_register_static(&migration_type);
> +}
> +
> +type_init(register_migration_types);
> diff --git a/migration/migration.h b/migration/migration.h
> index d9a268a..3fca364 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -19,6 +19,7 @@
>   #include "qapi-types.h"
>   #include "exec/cpu-common.h"
>   #include "qemu/coroutine_int.h"
> +#include "hw/qdev.h"
>   
>   /* State for the incoming migration */
>   struct MigrationIncomingState {
> @@ -62,8 +63,26 @@ struct MigrationIncomingState {
>   MigrationIncomingState *migration_incoming_get_current(void);
>   void migration_incoming_state_destroy(void);
>   
> +#define TYPE_MIGRATION "migration"
> +
> +#define MIGRATION_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
> +#define MIGRATION_OBJ(obj) \
> +    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
> +#define MIGRATION_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
> +
> +typedef struct MigrationClass {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +} MigrationClass;
> +
>   struct MigrationState
>   {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
>       size_t bytes_xfer;
>       size_t xfer_limit;
>       QemuThread thread;
> diff --git a/vl.c b/vl.c
> index c0cdb17..f0a0515 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4596,6 +4596,12 @@ int main(int argc, char **argv, char **envp)
>        */
>       register_global_properties(current_machine);
>   
> +    /*
> +     * Migration object can only be created after global properties
> +     * are applied correctly.
> +     */
> +    migration_object_init();
> +
>       /* This checkpoint is required by replay to separate prior clock
>          reading from the other reads, because timer polling functions query
>          clock values from the log. */
> 
