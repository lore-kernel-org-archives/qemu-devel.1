Received: from eggs.gnu.org ([2001:4830:134:3::10]:35005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwwg-0006nz-Vi
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwwZ-0005pf-QD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:58:23 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIwwZ-0005pT-DS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:58:15 -0400
Received: by mail-wm0-x22b.google.com with SMTP id a137-v6so1180495wme.1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:58:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515160257.GD2749@work-vm>
References: <20180514165424.12884-1-zhangckid@gmail.com>
	<20180514165424.12884-7-zhangckid@gmail.com>
	<20180515160257.GD2749@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 May 2018 21:58:12 +0800
Message-ID: <CAK3tnv+Vjn-u+LZKfSbhOE4jqBVSjNowPR6zWxrQd0gF-eWvFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V7 RESEND 06/17] COLO: Remove colo_state
 migration struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Wed, May 16, 2018 at 12:02 AM, Dr. David Alan Gilbert <
dgilbert@redhat.com> wrote:

> * Zhang Chen (zhangckid@gmail.com) wrote:
> > We need to know if migration is going into COLO state for
> > incoming side before start normal migration.
> >
> > Instead by using the VMStateDescription to send colo_state
> > from source side to destination side, we use MIG_CMD_ENABLE_COLO
> > to indicate whether COLO is enabled or not.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> Yes, that simplifies it a bit.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Thanks your review.
Zhang Chen


>
> > ---
> >  include/migration/colo.h |  5 +--
> >  migration/Makefile.objs  |  2 +-
> >  migration/colo-comm.c    | 76 ----------------------------------------
> >  migration/colo.c         | 13 ++++++-
> >  migration/migration.c    | 23 +++++++++++-
> >  migration/savevm.c       | 20 +++++++++++
> >  migration/savevm.h       |  1 +
> >  migration/trace-events   |  1 +
> >  vl.c                     |  2 --
> >  9 files changed, 60 insertions(+), 83 deletions(-)
> >  delete mode 100644 migration/colo-comm.c
> >
> > diff --git a/include/migration/colo.h b/include/migration/colo.h
> > index fefb2fcf4c..99ce17aca7 100644
> > --- a/include/migration/colo.h
> > +++ b/include/migration/colo.h
> > @@ -28,8 +28,9 @@ void migrate_start_colo_process(MigrationState *s);
> >  bool migration_in_colo_state(void);
> >
> >  /* loadvm */
> > -bool migration_incoming_enable_colo(void);
> > -void migration_incoming_exit_colo(void);
> > +void migration_incoming_enable_colo(void);
> > +void migration_incoming_disable_colo(void);
> > +bool migration_incoming_colo_enabled(void);
> >  void *colo_process_incoming_thread(void *opaque);
> >  bool migration_incoming_in_colo_state(void);
> >
> > diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> > index c83ec47ba8..a4f3bafd86 100644
> > --- a/migration/Makefile.objs
> > +++ b/migration/Makefile.objs
> > @@ -1,6 +1,6 @@
> >  common-obj-y += migration.o socket.o fd.o exec.o
> >  common-obj-y += tls.o channel.o savevm.o
> > -common-obj-y += colo-comm.o colo.o colo-failover.o
> > +common-obj-y += colo.o colo-failover.o
> >  common-obj-y += vmstate.o vmstate-types.o page_cache.o
> >  common-obj-y += qemu-file.o global_state.o
> >  common-obj-y += qemu-file-channel.o
> > diff --git a/migration/colo-comm.c b/migration/colo-comm.c
> > deleted file mode 100644
> > index df26e4dfe7..0000000000
> > --- a/migration/colo-comm.c
> > +++ /dev/null
> > @@ -1,76 +0,0 @@
> > -/*
> > - * COarse-grain LOck-stepping Virtual Machines for Non-stop Service
> (COLO)
> > - * (a.k.a. Fault Tolerance or Continuous Replication)
> > - *
> > - * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > - * Copyright (c) 2016 FUJITSU LIMITED
> > - * Copyright (c) 2016 Intel Corporation
> > - *
> > - * This work is licensed under the terms of the GNU GPL, version 2 or
> > - * later. See the COPYING file in the top-level directory.
> > - *
> > - */
> > -
> > -#include "qemu/osdep.h"
> > -#include "migration.h"
> > -#include "migration/colo.h"
> > -#include "migration/vmstate.h"
> > -#include "trace.h"
> > -
> > -typedef struct {
> > -     bool colo_requested;
> > -} COLOInfo;
> > -
> > -static COLOInfo colo_info;
> > -
> > -COLOMode get_colo_mode(void)
> > -{
> > -    if (migration_in_colo_state()) {
> > -        return COLO_MODE_PRIMARY;
> > -    } else if (migration_incoming_in_colo_state()) {
> > -        return COLO_MODE_SECONDARY;
> > -    } else {
> > -        return COLO_MODE_UNKNOWN;
> > -    }
> > -}
> > -
> > -static int colo_info_pre_save(void *opaque)
> > -{
> > -    COLOInfo *s = opaque;
> > -
> > -    s->colo_requested = migrate_colo_enabled();
> > -
> > -    return 0;
> > -}
> > -
> > -static bool colo_info_need(void *opaque)
> > -{
> > -   return migrate_colo_enabled();
> > -}
> > -
> > -static const VMStateDescription colo_state = {
> > -    .name = "COLOState",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > -    .pre_save = colo_info_pre_save,
> > -    .needed = colo_info_need,
> > -    .fields = (VMStateField[]) {
> > -        VMSTATE_BOOL(colo_requested, COLOInfo),
> > -        VMSTATE_END_OF_LIST()
> > -    },
> > -};
> > -
> > -void colo_info_init(void)
> > -{
> > -    vmstate_register(NULL, 0, &colo_state, &colo_info);
> > -}
> > -
> > -bool migration_incoming_enable_colo(void)
> > -{
> > -    return colo_info.colo_requested;
> > -}
> > -
> > -void migration_incoming_exit_colo(void)
> > -{
> > -    colo_info.colo_requested = false;
> > -}
> > diff --git a/migration/colo.c b/migration/colo.c
> > index e06640c3d6..c083d3696f 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -152,6 +152,17 @@ static void primary_vm_do_failover(void)
> >      qemu_sem_post(&s->colo_exit_sem);
> >  }
> >
> > +COLOMode get_colo_mode(void)
> > +{
> > +    if (migration_in_colo_state()) {
> > +        return COLO_MODE_PRIMARY;
> > +    } else if (migration_incoming_in_colo_state()) {
> > +        return COLO_MODE_SECONDARY;
> > +    } else {
> > +        return COLO_MODE_UNKNOWN;
> > +    }
> > +}
> > +
> >  void colo_do_failover(MigrationState *s)
> >  {
> >      /* Make sure VM stopped while failover happened. */
> > @@ -745,7 +756,7 @@ out:
> >      if (mis->to_src_file) {
> >          qemu_fclose(mis->to_src_file);
> >      }
> > -    migration_incoming_exit_colo();
> > +    migration_incoming_disable_colo();
> >
> >      return NULL;
> >  }
> > diff --git a/migration/migration.c b/migration/migration.c
> > index ddd0c4b988..8dee7dd309 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -277,6 +277,22 @@ int migrate_send_rp_req_pages(MigrationIncomingState
> *mis, const char *rbname,
> >      return migrate_send_rp_message(mis, msg_type, msglen, bufc);
> >  }
> >
> > +static bool migration_colo_enabled;
> > +bool migration_incoming_colo_enabled(void)
> > +{
> > +    return migration_colo_enabled;
> > +}
> > +
> > +void migration_incoming_disable_colo(void)
> > +{
> > +    migration_colo_enabled = false;
> > +}
> > +
> > +void migration_incoming_enable_colo(void)
> > +{
> > +    migration_colo_enabled = true;
> > +}
> > +
> >  void qemu_start_incoming_migration(const char *uri, Error **errp)
> >  {
> >      const char *p;
> > @@ -388,7 +404,7 @@ static void process_incoming_migration_co(void
> *opaque)
> >      }
> >
> >      /* we get COLO info, and know if we are in COLO mode */
> > -    if (!ret && migration_incoming_enable_colo()) {
> > +    if (!ret && migration_incoming_colo_enabled()) {
> >          /* Make sure all file formats flush their mutable metadata */
> >          bdrv_invalidate_cache_all(&local_err);
> >          if (local_err) {
> > @@ -2431,6 +2447,11 @@ static void *migration_thread(void *opaque)
> >          qemu_savevm_send_postcopy_advise(s->to_dst_file);
> >      }
> >
> > +    if (migrate_colo_enabled()) {
> > +        /* Notify migration destination that we enable COLO */
> > +        qemu_savevm_send_colo_enable(s->to_dst_file);
> > +    }
> > +
> >      qemu_savevm_state_setup(s->to_dst_file);
> >
> >      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index e2be02afe4..c43d220220 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -55,6 +55,8 @@
> >  #include "io/channel-buffer.h"
> >  #include "io/channel-file.h"
> >  #include "sysemu/replay.h"
> > +#include "migration/colo.h"
> > +
> >
> >  #ifndef ETH_P_RARP
> >  #define ETH_P_RARP 0x8035
> > @@ -81,6 +83,9 @@ enum qemu_vm_cmd {
> >                                        were previously sent during
> >                                        precopy but are dirty. */
> >      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this
> stream */
> > +
> > +    MIG_CMD_ENABLE_COLO, /* Enable COLO */
> > +
> >      MIG_CMD_MAX
> >  };
> >
> > @@ -836,6 +841,12 @@ static void qemu_savevm_command_send(QEMUFile *f,
> >      qemu_fflush(f);
> >  }
> >
> > +void qemu_savevm_send_colo_enable(QEMUFile *f)
> > +{
> > +    trace_savevm_send_colo_enable();
> > +    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
> > +}
> > +
> >  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
> >  {
> >      uint32_t buf;
> > @@ -1793,6 +1804,12 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState
> *mis)
> >      return ret;
> >  }
> >
> > +static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> > +{
> > +    migration_incoming_enable_colo();
> > +    return 0;
> > +}
> > +
> >  /*
> >   * Process an incoming 'QEMU_VM_COMMAND'
> >   * 0           just a normal return
> > @@ -1866,6 +1883,9 @@ static int loadvm_process_command(QEMUFile *f)
> >
> >      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> >          return loadvm_postcopy_ram_handle_discard(mis, len);
> > +
> > +    case MIG_CMD_ENABLE_COLO:
> > +        return loadvm_process_enable_colo(mis);
> >      }
> >
> >      return 0;
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index cf4f0d37ca..c6d46b37a2 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -52,6 +52,7 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile
> *f, const char *name,
> >                                             uint16_t len,
> >                                             uint64_t *start_list,
> >                                             uint64_t *length_list);
> > +void qemu_savevm_send_colo_enable(QEMUFile *f);
> >
> >  int qemu_loadvm_state(QEMUFile *f);
> >  void qemu_loadvm_state_cleanup(void);
> > diff --git a/migration/trace-events b/migration/trace-events
> > index d6be74b7a7..9295b4cf40 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -34,6 +34,7 @@ savevm_send_open_return_path(void) ""
> >  savevm_send_ping(uint32_t val) "0x%x"
> >  savevm_send_postcopy_listen(void) ""
> >  savevm_send_postcopy_run(void) ""
> > +savevm_send_colo_enable(void) ""
> >  savevm_state_setup(void) ""
> >  savevm_state_header(void) ""
> >  savevm_state_iterate(void) ""
> > diff --git a/vl.c b/vl.c
> > index 12e31d1aa9..a1576d2045 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4437,8 +4437,6 @@ int main(int argc, char **argv, char **envp)
> >  #endif
> >      }
> >
> > -    colo_info_init();
> > -
> >      if (net_init_clients(&err) < 0) {
> >          error_report_err(err);
> >          exit(1);
> > --
> > 2.17.0
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
