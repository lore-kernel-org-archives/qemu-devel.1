Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23895C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBE2208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE2208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8J0y-0003IT-1t
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1i8Izm-0002qJ-Ii
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1i8Izk-0003mc-Uq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:54:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39436)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1i8Izk-0003lJ-Iq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:54:20 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 23C24540093;
 Thu, 12 Sep 2019 09:54:17 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'dovgaluk'" <dovgaluk@ispras.ru>, "'Paolo Bonzini'" <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
 <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
 <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
In-Reply-To: <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
Date: Thu, 12 Sep 2019 09:54:09 +0300
Message-ID: <000901d56936$e10a0b60$a31e2220$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVcCH31g+aJ4sKCSmK582z5Q9amcwNLk57Q
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PULL 15/36] memory: fix race between TCG and
 accesses to dirty bitmap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.


Pavel Dovgalyuk

> -----Original Message-----
> From: dovgaluk [mailto:dovgaluk@ispras.ru]
> Sent: Monday, August 26, 2019 3:19 PM
> To: Paolo Bonzini; pavel.dovgaluk@ispras.ru
> Cc: qemu-devel@nongnu.org; Qemu-devel
> Subject: Re: [Qemu-devel] [PULL 15/36] memory: fix race between TCG =
and accesses to dirty
> bitmap
>=20
> This patch breaks the execution recording.
> While vCPU tries to lock replay mutex in main while loop,
> vga causes dirty memory sync and do_run_on_cpu call.
> This call waits for vCPU to process the work queue.
>=20
> Pavel Dovgalyuk
>=20
> Paolo Bonzini =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-08-20 09:59:
> > There is a race between TCG and accesses to the dirty log:
> >
> >       vCPU thread                  reader thread
> >       -----------------------      -----------------------
> >       TLB check -> slow path
> >         notdirty_mem_write
> >           write to RAM
> >           set dirty flag
> >                                    clear dirty flag
> >       TLB check -> fast path
> >                                    read memory
> >         write to RAM
> >
> > Fortunately, in order to fix it, no change is required to the
> > vCPU thread.  However, the reader thread must delay the read after
> > the vCPU thread has finished the write.  This can be approximated
> > conservatively by run_on_cpu, which waits for the end of the current
> > translation block.
> >
> > A similar technique is used by KVM, which has to do a synchronous =
TLB
> > flush after doing a test-and-clear of the dirty-page flags.
> >
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  exec.c                | 31 +++++++++++++++++++++++++++++++
> >  include/exec/memory.h | 12 ++++++++++++
> >  memory.c              | 10 +++++++++-
> >  migration/ram.c       |  1 +
> >  4 files changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/exec.c b/exec.c
> > index 3e78de3..ae68f72 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -198,6 +198,7 @@ typedef struct subpage_t {
> >
> >  static void io_mem_init(void);
> >  static void memory_map_init(void);
> > +static void tcg_log_global_after_sync(MemoryListener *listener);
> >  static void tcg_commit(MemoryListener *listener);
> >
> >  static MemoryRegion io_mem_watch;
> > @@ -906,6 +907,7 @@ void cpu_address_space_init(CPUState *cpu, int
> > asidx,
> >      newas->cpu =3D cpu;
> >      newas->as =3D as;
> >      if (tcg_enabled()) {
> > +        newas->tcg_as_listener.log_global_after_sync =3D
> > tcg_log_global_after_sync;
> >          newas->tcg_as_listener.commit =3D tcg_commit;
> >          memory_listener_register(&newas->tcg_as_listener, as);
> >      }
> > @@ -3143,6 +3145,35 @@ void
> > address_space_dispatch_free(AddressSpaceDispatch *d)
> >      g_free(d);
> >  }
> >
> > +static void do_nothing(CPUState *cpu, run_on_cpu_data d)
> > +{
> > +}
> > +
> > +static void tcg_log_global_after_sync(MemoryListener *listener)
> > +{while (1) {
>          qemu_mutex_unlock_iothread();
>          replay_mutex_lock();
>          qemu_mutex_lock_i
> > +    CPUAddressSpace *cpuas;
> > +
> > +    /* Wait for the CPU to end the current TB.  This avoids the
> > following
> > +     * incorrect race:
> > +     *
> > +     *      vCPU                         migration
> > +     *      ----------------------       -------------------------
> > +     *      TLB check -> slow path
> > +     *        notdirty_mem_write
> > +     *          write to RAM
> > +     *          mark dirty
> > +     *                                   clear dirty flag
> > +     *      TLB check -> fast path
> > +     *                                   read memory
> > +     *        write to RAM
> > +     *
> > +     * by pushing the migration thread's memory read after the vCPU
> > thread has
> > +     * written the memory.
> > +     */
> > +    cpuas =3D container_of(listener, CPUAddressSpace, =
tcg_as_listener);
> > +    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
> > +}
> > +
> >  static void tcg_commit(MemoryListener *listener)
> >  {
> >      CPUAddressSpace *cpuas;
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index bb0961d..b6bcf31 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -419,6 +419,7 @@ struct MemoryListener {
> >      void (*log_clear)(MemoryListener *listener, MemoryRegionSection
> > *section);
> >      void (*log_global_start)(MemoryListener *listener);
> >      void (*log_global_stop)(MemoryListener *listener);
> > +    void (*log_global_after_sync)(MemoryListener *listener);
> >      void (*eventfd_add)(MemoryListener *listener, =
MemoryRegionSection
> > *section,
> >                          bool match_data, uint64_t data, =
EventNotifier
> > *e);
> >      void (*eventfd_del)(MemoryListener *listener, =
MemoryRegionSection
> > *section,
> > @@ -1682,6 +1683,17 @@ MemoryRegionSection
> > memory_region_find(MemoryRegion *mr,
> >  void memory_global_dirty_log_sync(void);
> >
> >  /**
> > + * memory_global_dirty_log_sync: synchronize the dirty log for all
> > memory
> > + *
> > + * Synchronizes the vCPUs with a thread that is reading the dirty
> > bitmap.
> > + * This function must be called after the dirty log bitmap is =
cleared,
> > and
> > + * before dirty guest memory pages are read.  If you are using
> > + * #DirtyBitmapSnapshot, memory_region_snapshot_and_clear_dirty()
> > takes
> > + * care of doing this.
> > + */
> > +void memory_global_after_dirty_log_sync(void);
> > +
> > +/**
> >   * memory_region_transaction_begin: Start a transaction.
> >   *
> >   * During a transaction, changes will be accumulated and made =
visible
> > diff --git a/memory.c b/memory.c
> > index e42d63a..edd0c13 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -2127,9 +2127,12 @@ DirtyBitmapSnapshot
> > *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
> >                                                              hwaddr
> > size,
> >                                                              =
unsigned
> > client)
> >  {
> > +    DirtyBitmapSnapshot *snapshot;
> >      assert(mr->ram_block);
> >      memory_region_sync_dirty_bitmap(mr);
> > -    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr,
> > size, client);
> > +    snapshot =3D cpu_physical_memory_snapshot_and_clear_dirty(mr, =
addr,
> > size, client);
> > +    memory_global_after_dirty_log_sync();
> > +    return snapshot;
> >  }
> >
> >  bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
> > DirtyBitmapSnapshot *snap,
> > @@ -2620,6 +2623,11 @@ void memory_global_dirty_log_sync(void)
> >      memory_region_sync_dirty_bitmap(NULL);
> >  }
> >
> > +void memory_global_after_dirty_log_sync(void)
> > +{
> > +    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
> > +}
> > +
> >  static VMChangeStateEntry *vmstate_change;
> >
> >  void memory_global_dirty_log_start(void)
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 889148d..4e3a6ae 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1847,6 +1847,7 @@ static void migration_bitmap_sync(RAMState =
*rs)
> >      rcu_read_unlock();
> >      qemu_mutex_unlock(&rs->bitmap_mutex);
> >
> > +    memory_global_after_dirty_log_sync();
> >      trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
> >
> >      end_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);


