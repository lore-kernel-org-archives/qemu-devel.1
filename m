Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5639C3A5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07F523407
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07F523407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Dyo-0001IU-Ka
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 08:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1i2Dy6-0000tS-1N
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1i2Dy4-0005NC-L5
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:19:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34846)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>)
 id 1i2Dy1-0005Kz-AT; Mon, 26 Aug 2019 08:19:25 -0400
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id D2EC654006A;
 Mon, 26 Aug 2019 15:19:22 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 26 Aug 2019 15:19:22 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, pavel.dovgaluk@ispras.ru
In-Reply-To: <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
 <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
Message-ID: <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
X-Sender: dovgaluk@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
Content-Transfer-Encoding: quoted-printable
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
Cc: Qemu-devel <qemu-devel-bounces+importer=patchew.org@nongnu.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch breaks the execution recording.
While vCPU tries to lock replay mutex in main while loop,
vga causes dirty memory sync and do_run_on_cpu call.
This call waits for vCPU to process the work queue.

Pavel Dovgalyuk

Paolo Bonzini =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-08-20 09:59:
> There is a race between TCG and accesses to the dirty log:
>=20
>       vCPU thread                  reader thread
>       -----------------------      -----------------------
>       TLB check -> slow path
>         notdirty_mem_write
>           write to RAM
>           set dirty flag
>                                    clear dirty flag
>       TLB check -> fast path
>                                    read memory
>         write to RAM
>=20
> Fortunately, in order to fix it, no change is required to the
> vCPU thread.  However, the reader thread must delay the read after
> the vCPU thread has finished the write.  This can be approximated
> conservatively by run_on_cpu, which waits for the end of the current
> translation block.
>=20
> A similar technique is used by KVM, which has to do a synchronous TLB
> flush after doing a test-and-clear of the dirty-page flags.
>=20
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c                | 31 +++++++++++++++++++++++++++++++
>  include/exec/memory.h | 12 ++++++++++++
>  memory.c              | 10 +++++++++-
>  migration/ram.c       |  1 +
>  4 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/exec.c b/exec.c
> index 3e78de3..ae68f72 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -198,6 +198,7 @@ typedef struct subpage_t {
>=20
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> +static void tcg_log_global_after_sync(MemoryListener *listener);
>  static void tcg_commit(MemoryListener *listener);
>=20
>  static MemoryRegion io_mem_watch;
> @@ -906,6 +907,7 @@ void cpu_address_space_init(CPUState *cpu, int=20
> asidx,
>      newas->cpu =3D cpu;
>      newas->as =3D as;
>      if (tcg_enabled()) {
> +        newas->tcg_as_listener.log_global_after_sync =3D
> tcg_log_global_after_sync;
>          newas->tcg_as_listener.commit =3D tcg_commit;
>          memory_listener_register(&newas->tcg_as_listener, as);
>      }
> @@ -3143,6 +3145,35 @@ void=20
> address_space_dispatch_free(AddressSpaceDispatch *d)
>      g_free(d);
>  }
>=20
> +static void do_nothing(CPUState *cpu, run_on_cpu_data d)
> +{
> +}
> +
> +static void tcg_log_global_after_sync(MemoryListener *listener)
> +{while (1) {
         qemu_mutex_unlock_iothread();
         replay_mutex_lock();
         qemu_mutex_lock_i
> +    CPUAddressSpace *cpuas;
> +
> +    /* Wait for the CPU to end the current TB.  This avoids the=20
> following
> +     * incorrect race:
> +     *
> +     *      vCPU                         migration
> +     *      ----------------------       -------------------------
> +     *      TLB check -> slow path
> +     *        notdirty_mem_write
> +     *          write to RAM
> +     *          mark dirty
> +     *                                   clear dirty flag
> +     *      TLB check -> fast path
> +     *                                   read memory
> +     *        write to RAM
> +     *
> +     * by pushing the migration thread's memory read after the vCPU=20
> thread has
> +     * written the memory.
> +     */
> +    cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener)=
;
> +    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
> +}
> +
>  static void tcg_commit(MemoryListener *listener)
>  {
>      CPUAddressSpace *cpuas;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb0961d..b6bcf31 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -419,6 +419,7 @@ struct MemoryListener {
>      void (*log_clear)(MemoryListener *listener, MemoryRegionSection=20
> *section);
>      void (*log_global_start)(MemoryListener *listener);
>      void (*log_global_stop)(MemoryListener *listener);
> +    void (*log_global_after_sync)(MemoryListener *listener);
>      void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection=20
> *section,
>                          bool match_data, uint64_t data, EventNotifier=20
> *e);
>      void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection=20
> *section,
> @@ -1682,6 +1683,17 @@ MemoryRegionSection=20
> memory_region_find(MemoryRegion *mr,
>  void memory_global_dirty_log_sync(void);
>=20
>  /**
> + * memory_global_dirty_log_sync: synchronize the dirty log for all=20
> memory
> + *
> + * Synchronizes the vCPUs with a thread that is reading the dirty=20
> bitmap.
> + * This function must be called after the dirty log bitmap is cleared,=
=20
> and
> + * before dirty guest memory pages are read.  If you are using
> + * #DirtyBitmapSnapshot, memory_region_snapshot_and_clear_dirty()=20
> takes
> + * care of doing this.
> + */
> +void memory_global_after_dirty_log_sync(void);
> +
> +/**
>   * memory_region_transaction_begin: Start a transaction.
>   *
>   * During a transaction, changes will be accumulated and made visible
> diff --git a/memory.c b/memory.c
> index e42d63a..edd0c13 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2127,9 +2127,12 @@ DirtyBitmapSnapshot
> *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
>                                                              hwaddr=20
> size,
>                                                              unsigned=20
> client)
>  {
> +    DirtyBitmapSnapshot *snapshot;
>      assert(mr->ram_block);
>      memory_region_sync_dirty_bitmap(mr);
> -    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr,
> size, client);
> +    snapshot =3D cpu_physical_memory_snapshot_and_clear_dirty(mr, addr=
,
> size, client);
> +    memory_global_after_dirty_log_sync();
> +    return snapshot;
>  }
>=20
>  bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
> DirtyBitmapSnapshot *snap,
> @@ -2620,6 +2623,11 @@ void memory_global_dirty_log_sync(void)
>      memory_region_sync_dirty_bitmap(NULL);
>  }
>=20
> +void memory_global_after_dirty_log_sync(void)
> +{
> +    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
> +}
> +
>  static VMChangeStateEntry *vmstate_change;
>=20
>  void memory_global_dirty_log_start(void)
> diff --git a/migration/ram.c b/migration/ram.c
> index 889148d..4e3a6ae 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1847,6 +1847,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
>=20
> +    memory_global_after_dirty_log_sync();
>      trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
>=20
>      end_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);


