Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fWD16-00018R-QV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fWD14-0007Xu-13
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:45:44 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:44897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fWD13-0007XS-Jj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:45:41 -0400
Received: by mail-wr0-x235.google.com with SMTP id p12-v6so3576464wrn.11
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:45:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619190047.GO2368@work-vm>
References: <20180514165424.12884-1-zhangckid@gmail.com>
	<20180514165424.12884-13-zhangckid@gmail.com>
	<20180515185603.GF2749@work-vm>
	<CAK3tnv+ir0fcjLr5Af-tn7LHpyrXsCWC_wu4-K277_GbUOPscQ@mail.gmail.com>
	<20180619190047.GO2368@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 22 Jun 2018 11:45:39 +0800
Message-ID: <CAK3tnvJC6W3eomO5oM=-A79sZFcLd_t7LAk4DjXFhFgg8aBT5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V7 RESEND 12/17] savevm: split the process
 of different stages for loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Wed, Jun 20, 2018 at 3:00 AM, Dr. David Alan Gilbert <dgilbert@redhat.com
> wrote:

> * Zhang Chen (zhangckid@gmail.com) wrote:
> > On Wed, May 16, 2018 at 2:56 AM, Dr. David Alan Gilbert <
> dgilbert@redhat.com
> > > wrote:
> >
> > > * Zhang Chen (zhangckid@gmail.com) wrote:
> > > > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > >
> > > > There are several stages during loadvm/savevm process. In different
> > > stage,
> > > > migration incoming processes different types of sections.
> > > > We want to control these stages more accuracy, it will benefit COLO
> > > > performance, we don't have to save type of QEMU_VM_SECTION_START
> > > > sections everytime while do checkpoint, besides, we want to separate
> > > > the process of saving/loading memory and devices state.
> > > >
> > > > So we add three new helper functions: qemu_load_device_state() and
> > > > qemu_savevm_live_state() to achieve different process during
> migration.
> > > >
> > > > Besides, we make qemu_loadvm_state_main() and
> qemu_save_device_state()
> > > > public, and simplify the codes of qemu_save_device_state() by
> calling the
> > > > wrapper qemu_savevm_state_header().
> > > >
> > > > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  migration/colo.c   | 36 ++++++++++++++++++++++++++++--------
> > > >  migration/savevm.c | 35 ++++++++++++++++++++++++++++-------
> > > >  migration/savevm.h |  4 ++++
> > > >  3 files changed, 60 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/migration/colo.c b/migration/colo.c
> > > > index cdff0a2490..5b055f79f1 100644
> > > > --- a/migration/colo.c
> > > > +++ b/migration/colo.c
> > > > @@ -30,6 +30,7 @@
> > > >  #include "block/block.h"
> > > >  #include "qapi/qapi-events-migration.h"
> > > >  #include "qapi/qmp/qerror.h"
> > > > +#include "sysemu/cpus.h"
> > > >
> > > >  static bool vmstate_loading;
> > > >  static Notifier packets_compare_notifier;
> > > > @@ -414,23 +415,30 @@ static int colo_do_checkpoint_transaction
> (MigrationState
> > > *s,
> > > >
> > > >      /* Disable block migration */
> > > >      migrate_set_block_enabled(false, &local_err);
> > > > -    qemu_savevm_state_header(fb);
> > > > -    qemu_savevm_state_setup(fb);
> > > >      qemu_mutex_lock_iothread();
> > > >      replication_do_checkpoint_all(&local_err);
> > > >      if (local_err) {
> > > >          qemu_mutex_unlock_iothread();
> > > >          goto out;
> > > >      }
> > > > -    qemu_savevm_state_complete_precopy(fb, false, false);
> > > > -    qemu_mutex_unlock_iothread();
> > > > -
> > > > -    qemu_fflush(fb);
> > > >
> > > >      colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND,
> > > &local_err);
> > > >      if (local_err) {
> > > >          goto out;
> > > >      }
> > > > +    /*
> > > > +     * Only save VM's live state, which not including device state.
> > > > +     * TODO: We may need a timeout mechanism to prevent COLO process
> > > > +     * to be blocked here.
> > > > +     */
> > >
> > > I guess that's the downside to transmitting it directly than into the
> > > buffer;
> > > Peter Xu's OOB command system would let you kill the connection - and
> > > that's something I think COLO should use.
> > > Still the change saves you having that huge outgoing buffer on the
> > > source side and lets you start sending the checkpoint sooner, which
> > > means the pause time should be smaller.
> > >
> >
> > Yes, you are right.
> > But I think this is a performance optimization, this series focus on
> > enabling.
> > I will do this job in the future.
> >
> >
> > >
> > > > +    qemu_savevm_live_state(s->to_dst_file);
> > >
> > > Does this actually need to be inside of the qemu_mutex_lock_iothread?
> > > I'm pretty sure the device_state needs to be, but I'm not sure the
> > > live_state needs to.
> > >
> >
> > I have checked the codes, qemu_savevm_live_state needn't inside of the
> > qemu_mutex_lock_iothread,
> > I will move the it out the lock area in next version.
> >
> >
> >
> > >
> > > > +    /* Note: device state is saved into buffer */
> > > > +    ret = qemu_save_device_state(fb);
> > > > +
> > > > +    qemu_mutex_unlock_iothread();
> > > > +
> > > > +    qemu_fflush(fb);
> > > > +
> > > >      /*
> > > >       * We need the size of the VMstate data in Secondary side,
> > > >       * With which we can decide how much data should be read.
> > > > @@ -643,6 +651,7 @@ void *colo_process_incoming_thread(void *opaque)
> > > >      uint64_t total_size;
> > > >      uint64_t value;
> > > >      Error *local_err = NULL;
> > > > +    int ret;
> > > >
> > > >      qemu_sem_init(&mis->colo_incoming_sem, 0);
> > > >
> > > > @@ -715,6 +724,16 @@ void *colo_process_incoming_thread(void
> *opaque)
> > > >              goto out;
> > > >          }
> > > >
> > > > +        qemu_mutex_lock_iothread();
> > > > +        cpu_synchronize_all_pre_loadvm();
> > > > +        ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> > > > +        qemu_mutex_unlock_iothread();
> > > > +
> > > > +        if (ret < 0) {
> > > > +            error_report("Load VM's live state (ram) error");
> > > > +            goto out;
> > > > +        }
> > > > +
> > > >          value = colo_receive_message_value(mis->from_src_file,
> > > >                                   COLO_MESSAGE_VMSTATE_SIZE,
> &local_err);
> > > >          if (local_err) {
> > > > @@ -748,8 +767,9 @@ void *colo_process_incoming_thread(void *opaque)
> > > >          qemu_mutex_lock_iothread();
> > > >          qemu_system_reset(SHUTDOWN_CAUSE_NONE);
> > >
> > > Is the reset safe? Are you sure it doesn't change the ram you've just
> > > loaded?
> > >
> >
> > Yes, It is safe. In my test the secondary node running well.
>
> The fact it's working doesn't mean it's safe; it just means you've
> not hit a problem!  A qemu_system_reset calls a 'reset' on all of the
> devices, nd calls cpu_synchronize_all_states() - I'd worry that any of
> those might touch RAM.
>

In the migration/savevm.c   load_snapshot() do the same job like here, have
any difference?
And I have tested running COLO without the reset, looks like it works well
too in short test.


>
> > >
> > > >          vmstate_loading = true;
> > > > -        if (qemu_loadvm_state(fb) < 0) {
> > > > -            error_report("COLO: loadvm failed");
> > > > +        ret = qemu_load_device_state(fb);
> > > > +        if (ret < 0) {
> > > > +            error_report("COLO: load device state failed");
> > > >              qemu_mutex_unlock_iothread();
> > > >              goto out;
> > > >          }
> > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > index ec0bff09ce..0f61239429 100644
> > > > --- a/migration/savevm.c
> > > > +++ b/migration/savevm.c
> > > > @@ -1332,13 +1332,20 @@ done:
> > > >      return ret;
> > > >  }
> > > >
> > > > -static int qemu_save_device_state(QEMUFile *f)
> > > > +void qemu_savevm_live_state(QEMUFile *f)
> > > >  {
> > > > -    SaveStateEntry *se;
> > > > +    /* save QEMU_VM_SECTION_END section */
> > > > +    qemu_savevm_state_complete_precopy(f, true, false);
> > > > +    qemu_put_byte(f, QEMU_VM_EOF);
> > > > +}
> > > >
> > > > -    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
> > > > -    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> > > > +int qemu_save_device_state(QEMUFile *f)
> > > > +{
> > > > +    SaveStateEntry *se;
> > > >
> > > > +    if (!migration_in_colo_state()) {
> > > > +        qemu_savevm_state_header(f);
> > > > +    }
> > > >      cpu_synchronize_all_states();
> > >
> > > So this changes qemu_save_device_state to use savevm_state_header
> > > which feels reasonable, but that includes the 'configuration'
> > > section;  do we want that?  Is that OK for Xen's use in
> > > qmp_xen_save_devices_state?
> > >
> >
> > If I understand correctly, COLO Xen don't use qemu migration codes do
> this
> > job currently,
> > COLO Xen have an independent COLO frame do same job(use Xen migration
> > codes),
> > So I think it is OK for Xen.
>
> It's important not to break non-COLO Xen though; so you need to check
> with the Xen people that a change that impacts
> qmp_xen_save_devices_state is OK.
>

Yes, I think the quick way is remove the  "qmp_xen_save_devices_state"
related codes to keep the interface for Xen.
I will do this job in next version.

Thanks
Zhang Chen


>
> Dave
>
> >
> >
> > Thanks your review and continued support.
> > Zhang Chen
> >
> >
> > >
> > > >      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > > > @@ -1394,8 +1401,6 @@ enum LoadVMExitCodes {
> > > >      LOADVM_QUIT     =  1,
> > > >  };
> > > >
> > > > -static int qemu_loadvm_state_main(QEMUFile *f,
> MigrationIncomingState
> > > *mis);
> > > > -
> > > >  /* ------ incoming postcopy messages ------ */
> > > >  /* 'advise' arrives before any transfers just to tell us that a
> postcopy
> > > >   * *might* happen - it might be skipped if precopy transferred
> > > everything
> > > > @@ -2075,7 +2080,7 @@ void qemu_loadvm_state_cleanup(void)
> > > >      }
> > > >  }
> > > >
> > > > -static int qemu_loadvm_state_main(QEMUFile *f,
> MigrationIncomingState
> > > *mis)
> > > > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState
> *mis)
> > > >  {
> > > >      uint8_t section_type;
> > > >      int ret = 0;
> > > > @@ -2229,6 +2234,22 @@ int qemu_loadvm_state(QEMUFile *f)
> > > >      return ret;
> > > >  }
> > > >
> > > > +int qemu_load_device_state(QEMUFile *f)
> > > > +{
> > > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > +    int ret;
> > > > +
> > > > +    /* Load QEMU_VM_SECTION_FULL section */
> > > > +    ret = qemu_loadvm_state_main(f, mis);
> > > > +    if (ret < 0) {
> > > > +        error_report("Failed to load device state: %d", ret);
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    cpu_synchronize_all_post_init();
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  int save_snapshot(const char *name, Error **errp)
> > > >  {
> > > >      BlockDriverState *bs, *bs1;
> > > > diff --git a/migration/savevm.h b/migration/savevm.h
> > > > index c6d46b37a2..cf7935dd68 100644
> > > > --- a/migration/savevm.h
> > > > +++ b/migration/savevm.h
> > > > @@ -53,8 +53,12 @@ void qemu_savevm_send_postcopy_ram_
> discard(QEMUFile
> > > *f, const char *name,
> > > >                                             uint64_t *start_list,
> > > >                                             uint64_t *length_list);
> > > >  void qemu_savevm_send_colo_enable(QEMUFile *f);
> > > > +void qemu_savevm_live_state(QEMUFile *f);
> > > > +int qemu_save_device_state(QEMUFile *f);
> > > >
> > > >  int qemu_loadvm_state(QEMUFile *f);
> > > >  void qemu_loadvm_state_cleanup(void);
> > > > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState
> *mis);
> > > > +int qemu_load_device_state(QEMUFile *f);
> > > >
> > > >  #endif
> > > > --
> > > > 2.17.0
> > >
> > > Dave
> > >
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
