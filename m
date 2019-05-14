Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE9C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2E82085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2E82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZwx-0007lt-J3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:06:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQZv6-0006dy-VS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQZv5-0002Ww-Do
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQZv5-0002WK-5A
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5201158E33;
	Tue, 14 May 2019 16:04:46 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1436410021B5;
	Tue, 14 May 2019 16:04:40 +0000 (UTC)
Date: Tue, 14 May 2019 17:04:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190514160437.GO2753@work-vm>
References: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 14 May 2019 16:04:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Fix use-after-free during
 process exit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Evgeny Yakovlev <wrfsh@yandex-team.ru>, stefanha@redhat.com,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> It fixes heap-use-after-free which was found by clang's ASAN.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.
(cc'ing in Stefan since aio crashes often get to him).


> Control flow of this use-after-free:
> main_thread:
>     * Got SIGTERM and completes main loop
>     * Calls migration_shutdown
>       - migrate_fd_cancel (so, migration_thread begins to complete)
>       - object_unref(OBJECT(current_migration));
> 
> migration_thread:
>     * migration_iteration_finish -> schedule cleanup bh
>     * object_unref(OBJECT(s)); (Now, current_migration is freed)
>     * exits
> 
> main_thread:
>     * Calls vm_shutdown -> drain bdrvs -> main loop
>       -> cleanup_bh -> use after free
> 
> If you want to reproduce, these couple of sleeps will help:
> vl.c:4613:
>      migration_shutdown();
> +    sleep(2);
> migration.c:3269:
> +    sleep(1);
>      trace_migration_thread_after_loop();
>      migration_iteration_finish(s);
> 
> Original output:
> qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown process>)
> =================================================================
> ==31958==ERROR: AddressSanitizer: heap-use-after-free on address 0x61900001d210
>   at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
> READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
>     #0 0x555558a535c9 in migrate_fd_cleanup migration/migration.c:1502:23
>     #1 0x5555594fde0a in aio_bh_call util/async.c:90:5
>     #2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
>     #3 0x555559524783 in aio_poll util/aio-posix.c:725:17
>     #4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wait.c:71:5
>     #5 0x5555573bddf6 in virtio_blk_data_plane_stop
>       hw/block/dataplane/virtio-blk.c:282:5
>     #6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/virtio/virtio-bus.c:246:9
>     #7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/virtio/virtio-pci.c:287:5
>     #8 0x5555589e22bf in virtio_pci_vmstate_change hw/virtio/virtio-pci.c:1072:9
>     #9 0x555557628931 in virtio_vmstate_change hw/virtio/virtio.c:2257:9
>     #10 0x555557c36713 in vm_state_notify vl.c:1605:9
>     #11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
>     #12 0x55555716eeff in vm_shutdown cpus.c:1092:12
>     #13 0x555557c4283e in main vl.c:4617:5
>     #14 0x7fffdfdb482f in __libc_start_main
>       (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
>     #15 0x555556ecb118 in _start (x86_64-softmmu/qemu-system-x86_64+0x1977118)
> 
> 0x61900001d210 is located 144 bytes inside of 952-byte region
>   [0x61900001d180,0x61900001d538)
> freed by thread T6 (live_migration) here:
>     #0 0x555556f76782 in __interceptor_free
>       /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:124:3
>     #1 0x555558d5fa94 in object_finalize qom/object.c:618:9
>     #2 0x555558d57651 in object_unref qom/object.c:1068:9
>     #3 0x555558a55588 in migration_thread migration/migration.c:3272:5
>     #4 0x5555595393f2 in qemu_thread_start util/qemu-thread-posix.c:502:9
>     #5 0x7fffe057f6b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
> 
> previously allocated by thread T0 (qemu-vm-0) here:
>     #0 0x555556f76b03 in __interceptor_malloc
>       /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:146:3
>     #1 0x7ffff6ee37b8 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4f7b8)
>     #2 0x555558d58031 in object_new qom/object.c:640:12
>     #3 0x555558a31f21 in migration_object_init migration/migration.c:139:25
>     #4 0x555557c41398 in main vl.c:4320:5
>     #5 0x7fffdfdb482f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
> 
> Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
>     #0 0x555556f5f0dd in pthread_create
>       /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors.cc:210:3
>     #1 0x555559538cf9 in qemu_thread_create util/qemu-thread-posix.c:539:11
>     #2 0x555558a53304 in migrate_fd_connect migration/migration.c:3332:5
>     #3 0x555558a72bd8 in migration_channel_connect migration/channel.c:92:5
>     #4 0x555558a6ef87 in exec_start_outgoing_migration migration/exec.c:42:5
>     #5 0x555558a4f3c2 in qmp_migrate migration/migration.c:1922:9
>     #6 0x555558bb4f6a in qmp_marshal_migrate qapi/qapi-commands-migration.c:607:5
>     #7 0x555559363738 in do_qmp_dispatch qapi/qmp-dispatch.c:131:5
>     #8 0x555559362a15 in qmp_dispatch qapi/qmp-dispatch.c:174:11
>     #9 0x5555571bac15 in monitor_qmp_dispatch monitor.c:4124:11
>     #10 0x55555719a22d in monitor_qmp_bh_dispatcher monitor.c:4207:9
>     #11 0x5555594fde0a in aio_bh_call util/async.c:90:5
>     #12 0x5555594fe522 in aio_bh_poll util/async.c:118:13
>     #13 0x5555595201e0 in aio_dispatch util/aio-posix.c:460:5
>     #14 0x555559503553 in aio_ctx_dispatch util/async.c:261:5
>     #15 0x7ffff6ede196 in g_main_context_dispatch
>       (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4a196)
> 
> SUMMARY: AddressSanitizer: heap-use-after-free migration/migration.c:1502:23
>   in migrate_fd_cleanup
> Shadow bytes around the buggy address:
>   0x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> =>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable: 00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone: fa
>   Freed heap region: fd
>   Stack left redzone: f1
>   Stack mid redzone: f2
>   Stack right redzone: f3
>   Stack after return: f5
>   Stack use after scope: f8
>   Global redzone: f9
>   Global init order: f6
>   Poisoned by user: f7
>   Container overflow: fc
>   Array cookie: ac
>   Intra object redzone: bb
>   ASan internal: fe
>   Left alloca redzone: ca
>   Right alloca redzone: cb
>   Shadow gap: cc
> ==31958==ABORTING
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  migration/migration.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0..b9848d1030 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1495,10 +1495,8 @@ static void block_cleanup_parameters(MigrationState *s)
>      }
>  }
>  
> -static void migrate_fd_cleanup(void *opaque)
> +static void migrate_fd_cleanup(MigrationState *s)
>  {
> -    MigrationState *s = opaque;
> -
>      qemu_bh_delete(s->cleanup_bh);
>      s->cleanup_bh = NULL;
>  
> @@ -1543,6 +1541,21 @@ static void migrate_fd_cleanup(void *opaque)
>      block_cleanup_parameters(s);
>  }
>  
> +static void migrate_fd_cleanup_schedule(MigrationState *s)
> +{
> +    /* Ref the state for bh, because it may be called when
> +     * there're already no other refs */
> +    object_ref(OBJECT(s));
> +    qemu_bh_schedule(s->cleanup_bh);
> +}
> +
> +static void migrate_fd_cleanup_bh(void *opaque)
> +{
> +    MigrationState *s = opaque;
> +    migrate_fd_cleanup(s);
> +    object_unref(OBJECT(s));
> +}
> +
>  void migrate_set_error(MigrationState *s, const Error *error)
>  {
>      qemu_mutex_lock(&s->error_mutex);
> @@ -3144,7 +3157,7 @@ static void migration_iteration_finish(MigrationState *s)
>          error_report("%s: Unknown ending state %d", __func__, s->state);
>          break;
>      }
> -    qemu_bh_schedule(s->cleanup_bh);
> +    migrate_fd_cleanup_schedule(s);
>      qemu_mutex_unlock_iothread();
>  }
>  
> @@ -3279,7 +3292,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>  
>      s->expected_downtime = s->parameters.downtime_limit;
> -    s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
> +    s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup_bh, s);
>      if (error_in) {
>          migrate_fd_error(s, error_in);
>          migrate_fd_cleanup(s);
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

