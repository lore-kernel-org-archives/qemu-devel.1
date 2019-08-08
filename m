Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DFC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723822173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvoYNSr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723822173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveiN-0000pP-Lu
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvehn-0000Nv-Lu
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvehm-0001Wu-Ad
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:27:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvehm-0001Wc-2S
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:27:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so94160887wrf.11
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7ifbAcQ+KaC/pBtCQncXmg3xRiLT7aw+NxetxtXedJk=;
 b=VvoYNSr3Yyx4DY9ZHStfC2DzfggFt77NkgWZ4n2l7KJswn2oehBFYnicPbaDprunL6
 ZSgoQIoSkgdGVH/hsJ3fF0f2uS1D96At88zoCZnR8qHawYJyWL7J0VaNr1LHQYo7dye7
 s+hcpGrOQ8SFST26xqVVXYDLkUic3kLCZDXZMHvR4l5sqRteB6smxmMWiLZLdvTSVat1
 Ogca4tkwQhvh2KdqGfIcTmayjjr5a4zoa8CpNgLkb8pHInX2dywYPPAx1hgptrXygzqw
 /bnUHzQP0GqIiXSVrWko6+aM63T7GKvuoOqz+cjuUf/+tP41jHpiHf2Vx14RP2aAoKqO
 Q4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7ifbAcQ+KaC/pBtCQncXmg3xRiLT7aw+NxetxtXedJk=;
 b=g8luSmgd2VaQ7Orgn/eoWzZlktXpuNPvPmyvOwe0k4BSeWUcOQ8yzQlzfDm/Q1h2Bg
 xIS29FCr558Laq9Pqr+ffszM5/4S6a2zCEw0TOrBf/LL2PnUXI444GiG74C1SLMUoE3y
 2wEncZkzep81VOWc0aJ/CcQACdVvP3yUmdH63WzUDmDO9s0aHAAJ32sLbGj3SJ1KrNpf
 ugAFIfJYdE580IdEuXPsY3AR8ALI+fIkRvv6lyJEoJP/3vodTNnRgWV+KRKT/ePpQkK7
 EKPNyhaTzVaUH1MDLUxVhpU2CdTH8CMf8MPh9XRxGeXZKOK7EETOHCF4yRrY88NsgNbe
 n3Jg==
X-Gm-Message-State: APjAAAXtOI7XG3R2DGXRcGzzi1+j+pgUc7aGFwfEFu3o9+F36oAycRSI
 KyyRkjBJ/kN1PxZlTUv+BbZ2gg==
X-Google-Smtp-Source: APXvYqx8dDeKAf7KQEI9XzmQ3L2FclPeE6eh+U/rAH8cHzHziibXiQdk+a59QiIZFerb58L707GxpA==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr6436304wrj.9.1565256447968;
 Thu, 08 Aug 2019 02:27:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z2sm6723258wrt.17.2019.08.08.02.27.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 02:27:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D60201FF87;
 Thu,  8 Aug 2019 10:27:26 +0100 (BST)
References: <20190729214717.6616-1-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190729214717.6616-1-pbonzini@redhat.com>
Date: Thu, 08 Aug 2019 10:27:26 +0100
Message-ID: <875zn8hurl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH untested for-4.2] memory: fix race between
 TCG and accesses to dirty bitmap
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
Cc: peter.maydell@linaro.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> The race is as follows:
>
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
>
> and the second write is missed by the reader.
>
> Fortunately, in order to fix it, no change is required to the
> vCPU thread.  However, the reader thread must delay the read after
> the vCPU thread has finished the write.  This can be approximated
> conservatively by run_on_cpu, which waits for the end of the current
> translation block.
>
> A similar technique is used by KVM, which has to do a synchronous TLB
> flush after doing a test-and-clear of the dirty-page flags.
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>         I tested this some time ago, and enough has changed that I don't
>         really trust those old results.  Nevertheless, I am throwing out
>         the patch so that it is not forgotten.
>
>  exec.c                | 31 +++++++++++++++++++++++++++++++
>  include/exec/memory.h | 12 ++++++++++++
>  memory.c              | 10 +++++++++-
>  migration/ram.c       |  1 +
>  4 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/exec.c b/exec.c
> index 3e78de3b8f..ae68f72da4 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -198,6 +198,7 @@ typedef struct subpage_t {
>
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> +static void tcg_log_global_after_sync(MemoryListener *listener);
>  static void tcg_commit(MemoryListener *listener);
>
>  static MemoryRegion io_mem_watch;
> @@ -906,6 +907,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      newas->cpu =3D cpu;
>      newas->as =3D as;
>      if (tcg_enabled()) {
> +        newas->tcg_as_listener.log_global_after_sync =3D tcg_log_global_=
after_sync;
>          newas->tcg_as_listener.commit =3D tcg_commit;
>          memory_listener_register(&newas->tcg_as_listener, as);
>      }
> @@ -3143,6 +3145,35 @@ void address_space_dispatch_free(AddressSpaceDispa=
tch *d)
>      g_free(d);
>  }
>
> +static void do_nothing(CPUState *cpu, run_on_cpu_data d)
> +{
> +}
> +
> +static void tcg_log_global_after_sync(MemoryListener *listener)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    /* Wait for the CPU to end the current TB.  This avoids the following
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
> +     * by pushing the migration thread's memory read after the vCPU thre=
ad has
> +     * written the memory.
> +     */
> +    cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener);
> +    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
> +}
> +
>  static void tcg_commit(MemoryListener *listener)
>  {
>      CPUAddressSpace *cpuas;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb0961ddb9..b6bcf31b0a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -419,6 +419,7 @@ struct MemoryListener {
>      void (*log_clear)(MemoryListener *listener, MemoryRegionSection *sec=
tion);
>      void (*log_global_start)(MemoryListener *listener);
>      void (*log_global_stop)(MemoryListener *listener);
> +    void (*log_global_after_sync)(MemoryListener *listener);
>      void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *s=
ection,
>                          bool match_data, uint64_t data, EventNotifier *e=
);
>      void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *s=
ection,
> @@ -1681,6 +1682,17 @@ MemoryRegionSection memory_region_find(MemoryRegio=
n *mr,
>   */
>  void memory_global_dirty_log_sync(void);
>
> +/**
> + * memory_global_dirty_log_sync: synchronize the dirty log for all memory
> + *
> + * Synchronizes the vCPUs with a thread that is reading the dirty bitmap.
> + * This function must be called after the dirty log bitmap is cleared, a=
nd
> + * before dirty guest memory pages are read.  If you are using
> + * #DirtyBitmapSnapshot, memory_region_snapshot_and_clear_dirty() takes
> + * care of doing this.
> + */
> +void memory_global_after_dirty_log_sync(void);
> +
>  /**
>   * memory_region_transaction_begin: Start a transaction.
>   *
> diff --git a/memory.c b/memory.c
> index e42d63a3a0..edd0c13c38 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2127,9 +2127,12 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_cl=
ear_dirty(MemoryRegion *mr,
>                                                              hwaddr size,
>                                                              unsigned cli=
ent)
>  {
> +    DirtyBitmapSnapshot *snapshot;
>      assert(mr->ram_block);
>      memory_region_sync_dirty_bitmap(mr);
> -    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, =
client);
> +    snapshot =3D cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, =
size, client);
> +    memory_global_after_dirty_log_sync();
> +    return snapshot;
>  }
>
>  bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnaps=
hot *snap,
> @@ -2620,6 +2623,11 @@ void memory_global_dirty_log_sync(void)
>      memory_region_sync_dirty_bitmap(NULL);
>  }
>
> +void memory_global_after_dirty_log_sync(void)
> +{
> +    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
> +}
> +
>  static VMChangeStateEntry *vmstate_change;
>
>  void memory_global_dirty_log_start(void)
> diff --git a/migration/ram.c b/migration/ram.c
> index 2b0774c2bf..b9d6a3921d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1801,6 +1801,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
>
> +    memory_global_after_dirty_log_sync();
>      trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
>
>      end_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);


--
Alex Benn=C3=A9e

