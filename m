Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A91C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B25220853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Adf0hl3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B25220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYnQ-0002rd-K3
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ad7iXgMKCq4XYnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jkz.bounces.google.com>)
 id 1jjYm3-00015i-Vt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:28 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:54976)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ad7iXgMKCq4XYnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jkz.bounces.google.com>)
 id 1jjYm0-0001VA-Dd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:27 -0400
Received: by mail-yb1-xb49.google.com with SMTP id p22so8734277ybg.21
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Vp4OVl46XRZBSe+oi9pU4mOxTCIGyGyo/JRsd2TSg+Q=;
 b=Adf0hl3VTIFRgGdDeZA2K0o6Fm9yW4o0neP4mUgr1nzYS4LDfOi1wtxiizgedyKp21
 3E9NfBAAiyRKLKn6ypv2b6y8v1PvxSkDpPp8EPa9bTx9lmma9dFcfnlFt0MuH58VbX77
 SPLNiVUM3aGuBTP6Oerant2kzNUJ+MeTn938wfObJuHDSa849lTjFxPe8IOWvszueqM6
 m4jkoYg39wuermUDhKdW6O923i2iahVldV5gmXcrj/4F0lcPSH7HVpgypPLBHpfP/TbH
 fnACzyoKJfcF/Mt2AlT5rfzJKOJCCWY/cG+IBvhK8+isBsheFF78H7jTOnuamWeI12IK
 qPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Vp4OVl46XRZBSe+oi9pU4mOxTCIGyGyo/JRsd2TSg+Q=;
 b=uQDKO4cBn2emmCXfw11yCj5cTlwasqvimufFPOUJwZqJoxpYXHvJNypwTn2pdz7MnB
 u+jJF0JWxOlELRuJ7Vj33VLeJpfBew+dVD9NE0plBDq995Ze6EVt0XkxUDZYiSd6urEO
 v9gGs8SwEN0/CFhQO+YExQAT50TL0MQzDaPHsEGiDokAkhuKUXgMhi8MvsvFsJY4CCg/
 YvIVYjBidnZFrWSksfcck9LVNS4q3SMljA/XfmHYtx1+SDnnNcT8P/Ie65DLEM9lkM4g
 L/a8Bcv0Ga6dcnJQGU5/RnwclcHa2FPpywlNAfHziiyI7CUtpzlhT5Vr5GRH/Ooq87Cg
 /LKQ==
X-Gm-Message-State: AOAM532WJ4s0lv4tfxLwKGro/6mfr2hhECAHj6CNsY0ZCVzU6YpmXpKd
 87xqCgUHkbr+UWNS+PcIpl2ngPd1t0oyxzNWd75xsX3g9Xo+RjUBxMHAsq1xysn1b8yAQ5EzAs/
 pxK8NAa5xOC7t7CLCwXrJgSa5mG2uV0M+HM0wX2ic5C+xhcoXJofe
X-Google-Smtp-Source: ABdhPJxIjZoFRRW6HDdtHlpf7w3REoolueKDU90GZiXKTLrad/KVynm57QPQRb3Og5nyD4BbixqOp20=
X-Received: by 2002:a25:cfcd:: with SMTP id
 f196mr17883823ybg.142.1591926377140; 
 Thu, 11 Jun 2020 18:46:17 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:05 -0700
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Message-Id: <20200612014606.147691-5-jkz@google.com>
Mime-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone options
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ad7iXgMKCq4XYnUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jkz.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The `clone` system call can be used to create new processes that share
attributes with their parents, such as virtual memory, file
system location, file descriptor tables, etc. These can be useful to a
variety of guest programs.

Before this patch, QEMU had support for a limited set of these attributes.
Basically the ones needed for threads, and the options used by fork.
This change adds support for all flag combinations involving CLONE_VM.
In theory, almost all clone options could be supported, but invocations
not using CLONE_VM are likely to run afoul of linux-user's inherently
multi-threaded design.

To add this support, this patch updates the `qemu_clone` helper. An
overview of the mechanism used to support general `clone` options with
CLONE_VM is described below.

This patch also enables by-default the `clone` unit-tests in
tests/tcg/multiarch/linux-test.c, and adds an additional test for duplicate
exit signals, based on a bug found during development.

!! Overview

Adding support for CLONE_VM is tricky. The parent and guest process will
share an address space (similar to threads), so the emulator must
coordinate between the parent and the child. Currently, QEMU relies
heavily on Thread Local Storage (TLS) as part of this coordination
strategy. For threads, this works fine, because libc manages the
thread-local data region used for TLS, when we create new threads using
`pthread_create`. Ideally we could use the same mechanism for
"process-local storage" needed to allow the parent/child processes to
emulate in tandem. Unfortunately TLS is tightly integrated into libc.
The only way to create TLS data regions is via the `pthread_create` API
which also spawns a new thread (rather than a new processes, which is
what we want). Worse still, TLS itself is a complicated arch-specific
feature that is tightly integrated into the rest of libc and the dynamic
linker. Re-implementing TLS support for QEMU would likely require a
special dynamic linker / libc. Alternatively, the popular libcs could be
extended, to allow for users to create TLS regions without creating
threads. Even if major libcs decide to add this support, QEMU will still
need a temporary work around until those libcs are widely deployed. It's
also unclear if libcs will be interested in supporting this case, since
TLS image creation is generally deeply integrated with thread setup.

In this patch, I've employed an alternative approach: spawning a thread
an "stealing" its TLS image for use in the child process. This approach
leaves a dangling thread while the TLS image is in use, but by design
that thread will not become schedulable until after the TLS data is no
longer in-use by the child (as described in a moment). Therefore, it
should cause relatively minimal overhead. When considered in the larger
context, this seems like a reasonable tradeoff.

A major complication of this approach knowing when it is safe to clean up
the stack, and TLS image, used by a child process. When a child is
created with `CLONE_VM` its stack, and TLS data, need to remain valid
until that child has either exited, or successfully called `execve` (on
`execve` the child is given a new VMM by the kernel). One approach would
be to use `waitid(WNOWAIT)` (the `WNOWAIT` allows the guest to reap the
child). The problem is that the `wait` family of calls only waits for
termination. The pattern of `clone() ... execve()` for long running
child processes is pretty common. If we waited for child processes to
exit, it's likely we would end up using substantially more memory, and
keep the suspended TLS thread around much longer than necessary.
Instead, in this patch, I've used an "trampoline" process. The real
parent first clones a trampoline, the trampoline then clones the
ultimate child using the `CLONE_VFORK` option. `CLONE_VFORK` suspends
the trampoline process until the child has exited, or called `execve`.
Once the trampoline is re-scheduled, we know it is safe to clean up
after the child. This creates one more suspended process, but typically,
the trampoline only exists for a short period of time.

!! CLONE_VM setup, step by step

1. First, the suspended thread whose TLS we will use is created using
   `pthread_create`. The thread fetches and returns it's "TLS pointer"
   (an arch-specific value given to the kernel) to the parent. It then
   blocks on a lock to prevent its TLS data from being cleaned up.
   Ultimately the lock will be unlocked by the trampoline once the child
   exits.
2. Once the TLS thread has fetched the TLS pointer, it notifies the real
   parent thread, which calls `clone()` to create the trampoline
   process. For ease of implementation, the TLS image is set for the
   trampoline process during this step. This allows the trampoline to
   use functions that require TLS if needed (e.g., printf). TLS location
   is inherited when a new child is spawned, so this TLS data will
   automatically be inherited by the child.
3. Once the trampoline has been spawned, it registers itself as a
   "hidden" process with the signal subsystem. This prevents the exit
   signal from the trampoline from ever being forwarded to the guest.
   This is needed due to the way that Linux sets the exit signal for the
   ultimate child when `CLONE_PARENT` is set. See the source for
   details.
4. Once setup is complete, the trampoline spawns the final child with
   the original clone flags, plus `CLONE_PARENT`, so the child is
   correctly parented to the kernel task on which the guest invoked
   `clone`. Without this, kernel features like PDEATHSIG, and
   subreapers, would not work properly. As previously discussed, the
   trampoline also supplies `CLONE_VFORK` so that it is suspended until
   the child can be cleaned up.
5. Once the child is spawned, it signals the original parent thread that
   it is running. At this point, the trampoline process is suspended
   (due to CLONE_VFORK).
6. Finally, the call to `qemu_clone` in the parent is finished, the
   child begins executing the given callback function in the new child
   process.

!! Cleaning up

Clean up itself is a multi-step process. Once the child exits, or is
killed by a signal (cleanup is the same in both cases), the trampoline
process becomes schedulable. When the trampoline is scheduled, it frees
the child stack, and unblocks the suspended TLS thread. This cleans up
the child resources, but not the stack used by the trampoline itself. It
is possible for a process to clean up its own stack, but it is tricky,
and architecture-specific. Instead we leverage the TLS manager thread to
clean up the trampoline stack. When the trampoline is cloned (in step 2
above), we additionally set the `CHILD_SETTID` and `CHILD_CLEARTID`
flags. The target location for the SET/CLEAR TID is set to a special field
known by the TLS manager. Then, when the TLS manager thread is unsuspended,
it performs an additional `FUTEX_WAIT` on this location. That blocks the
TLS manager thread until the trampoline has fully exited, then the TLS
manager thread frees the trampoline process's stack, before exiting
itself.

!! Shortcomings of this patch

* It's complicated.
* It doesn't support any clone options when CLONE_VM is omitted.
* It doesn't properly clean up the CPU queue when the child process
  terminates, or calls execve().
* RCU unregistration is done in the trampoline process (in clone.c), but
  registration happens in syscall.c This should be made more explicit.
* The TLS image, and trampoline stack are not cleaned up if the parent
  calls `execve` or `exit_group` before the child does. This is because
  those cleanup tasks are handled by the TLS manager thread. The TLS
  manager thread is in the same thread group as the parent, so it will
  be terminated if the parent exits or calls `execve`.

!! Alternatives considered

* Non-standard libc extension to allow creating TLS images independent
  of threads. This would allow us to just `clone` the child directly
  instead of this complicated maneuver. Though we probably would still
  need the cleanup logic. For libcs, TLS image allocation is tightly
  connected to thread stack allocation, which is also arch-specific. I
  do not have enough experience with libc development to know if
  maintainers of any popular libcs would be open to supporting such an
  API. Additionally, since it will probably take years before a libc
  fix would be widely deployed, we need an interim solution anyways.
* Non-standard, Linux-only, libc extension to allow us to specify the
  CLONE_* flags used by `pthread_create`. The processes we are creating
  are basically threads in a different thread group. If we could alter
  the flags used, this whole processes could become a `pthread_create.`
  The problem with this approach is that I don't know what requirements
  pthreads has on threads to ensure they function properly. I suspect
  that pthreads relies on CHILD_CLEARTID+FUTEX_WAKE to cleanup detached
  thread state. Since we don't control the child exit reason (Linux only
  handles CHILD_CLEARTID on normal, non-signal process termination), we
  probably can't use this same tracking mechanism.
* Other mechanisms for detecting child exit so cleanup can happen
  besides CLONE_VFORK:
  * waitid(WNOWAIT): This can only detect exit, not execve.
  * file descriptors with close on exec set: This cannot detect children
    cloned with CLONE_FILES.
  * System V semaphore adjustments: Cannot detect children cloned with
    CLONE_SYSVSEM.
  * CLONE_CHILD_CLEARTID + FUTEX_WAIT: Cannot detect abnormally
    terminated children.
* Doing the child clone directly in the TLS manager thread: This saves the
  need for the trampoline process, but it causes the child process to be
  parented to the wrong kernel task (the TLS thread instead of the Main
  thread) breaking things like PDEATHSIG.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/clone.c               | 415 ++++++++++++++++++++++++++++++-
 linux-user/qemu.h                |  17 ++
 linux-user/signal.c              |  49 ++++
 linux-user/syscall.c             |  69 +++--
 tests/tcg/multiarch/linux-test.c |  67 ++++-
 5 files changed, 592 insertions(+), 25 deletions(-)

diff --git a/linux-user/clone.c b/linux-user/clone.c
index f02ae8c464..3f7344cf9e 100644
--- a/linux-user/clone.c
+++ b/linux-user/clone.c
@@ -12,6 +12,12 @@
 #include <stdbool.h>
 #include <assert.h>
 
+/* arch-specifc includes needed to fetch the TLS base offset. */
+#if defined(__x86_64__)
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+#endif
+
 static const unsigned long NEW_STACK_SIZE = 0x40000UL;
 
 /*
@@ -62,6 +68,397 @@ static void completion_finish(struct completion *c)
     pthread_mutex_unlock(&c->mu);
 }
 
+struct tls_manager {
+    void *tls_ptr;
+    /* fetched is completed once tls_ptr has been set by the thread. */
+    struct completion fetched;
+    /*
+     * spawned is completed by the user once the managed_tid
+     * has been spawned.
+     */
+    struct completion spawned;
+    /*
+     * TID of the child whose memory is cleaned up upon death. This memory
+     * location is used as part of a futex op, and is cleared by the kernel
+     * since we specify CHILD_CLEARTID.
+     */
+    int managed_tid;
+    /*
+     * The value to be `free`'d up once the janitor is ready to clean up the
+     * TLS section, and the managed tid has exited.
+     */
+    void *cleanup;
+};
+
+/*
+ * tls_ptr fetches the TLS "pointer" for the current thread. This pointer
+ * should be whatever platform-specific address is used to represent the TLS
+ * base address.
+ */
+static void *tls_ptr()
+{
+    void *ptr;
+#if defined(__x86_64__)
+    /*
+     * On x86_64, the TLS base is stored in the `fs` segment register, we can
+     * fetch it with `ARCH_GET_FS`:
+     */
+    (void)syscall(SYS_arch_prctl, ARCH_GET_FS, (unsigned long) &ptr);
+#else
+    ptr = NULL;
+#endif
+    return ptr;
+}
+
+/*
+ * clone_vm_supported returns true if clone_vm() is supported on this
+ * platform.
+ */
+static bool clone_vm_supported()
+{
+#if defined(__x86_64__)
+    return true;
+#else
+    return false;
+#endif
+}
+
+static void *tls_manager_thread(void *arg)
+{
+    struct tls_manager *mgr = (struct tls_manager *) arg;
+    int child_tid, ret;
+
+    /*
+     * NOTE: Do not use an TLS in this thread until after the `spawned`
+     * completion is finished. We need to preserve the pristine state of
+     * the TLS image for this thread, so it can be re-used in a separate
+     * process.
+     */
+    mgr->tls_ptr = tls_ptr();
+
+    /* Notify tls_new that we finished fetching the TLS ptr. */
+    completion_finish(&mgr->fetched);
+
+    /*
+     * Wait for the user of our TLS to tell us the child using our TLS has
+     * been spawned.
+     */
+    completion_await(&mgr->spawned);
+
+    child_tid = atomic_fetch_or(&mgr->managed_tid, 0);
+    /*
+     * Check if the child has already terminated by this point. If not, wait
+     * for the child to exit. As long as the trampoline is not killed by
+     * a signal, the kernel guarantees that the memory at &mgr->managed_tid
+     * will be cleared, and a FUTEX_WAKE at that address will triggered.
+     */
+    if (child_tid != 0) {
+        ret = syscall(SYS_futex, &mgr->managed_tid, FUTEX_WAIT,
+                      child_tid, NULL, NULL, 0);
+        assert(ret == 0 && "clone manager futex should always succeed");
+    }
+
+    free(mgr->cleanup);
+    g_free(mgr);
+
+    return NULL;
+}
+
+static struct tls_manager *tls_manager_new()
+{
+    struct tls_manager *mgr = g_new0(struct tls_manager, 1);
+    sigset_t block, oldmask;
+
+    sigfillset(&block);
+    if (sigprocmask(SIG_BLOCK, &block, &oldmask) != 0) {
+        return NULL;
+    }
+
+    completion_init(&mgr->fetched);
+    completion_init(&mgr->spawned);
+
+    pthread_attr_t attr;
+    pthread_attr_init(&attr);
+    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+    pthread_t unused;
+    if (pthread_create(&unused, &attr, tls_manager_thread, (void *) mgr)) {
+        pthread_attr_destroy(&attr);
+        g_free(mgr);
+        return NULL;
+    }
+    pthread_attr_destroy(&attr);
+    completion_await(&mgr->fetched);
+
+    if (sigprocmask(SIG_SETMASK, &oldmask, NULL) != 0) {
+        /* Let the thread exit, and cleanup itself. */
+        completion_finish(&mgr->spawned);
+        return NULL;
+    }
+
+    /* Once we finish awaiting, the tls_ptr will be usable. */
+    return mgr;
+}
+
+struct stack {
+    /* Buffer is the "base" of the stack buffer. */
+    void *buffer;
+    /* Top is the "start" of the stack (since stack addresses "grow down"). */
+    void *top;
+};
+
+struct info {
+    /* Stacks used for the trampoline and child process. */
+    struct {
+        struct stack trampoline;
+        struct stack process;
+    } stack;
+    struct completion child_ready;
+    /* `clone` flags for the process the user asked us to make. */
+    int flags;
+    sigset_t orig_mask;
+    /*
+     * Function to run in the ultimate child process, and payload to pass as
+     * the argument.
+     */
+    int (*clone_f)(void *);
+    void *payload;
+    /*
+     * Result of calling `clone` for the child clone. Will be set to
+     * `-errno` if an error occurs.
+     */
+    int result;
+};
+
+static bool stack_new(struct stack *stack)
+{
+    /*
+     * TODO: put a guard page at the bottom of the stack, so we don't
+     * accidentally roll off the end.
+     */
+    if (posix_memalign(&stack->buffer, 16, NEW_STACK_SIZE)) {
+        return false;
+    }
+    memset(stack->buffer, 0, NEW_STACK_SIZE);
+    stack->top = stack->buffer + NEW_STACK_SIZE;
+    return true;
+}
+
+static int clone_child(void *raw_info)
+{
+    struct info *info = (struct info *) raw_info;
+    int (*clone_f)(void *) = info->clone_f;
+    void *payload = info->payload;
+    if (!(info->flags & CLONE_VFORK)) {
+        /*
+         * If CLONE_VFORK is NOT set, then the trampoline has stalled (it
+         * forces VFORK), but the actual clone should return immediately. In
+         * this case, this thread needs to notify the parent that the new
+         * process is running. If CLONE_VFORK IS set, the trampoline will
+         * notify the parent once the normal kernel vfork completes.
+         */
+        completion_finish(&info->child_ready);
+    }
+    if (sigprocmask(SIG_SETMASK, &info->orig_mask, NULL) != 0) {
+        perror("failed to restore signal mask in cloned child");
+        _exit(1);
+    }
+    return clone_f(payload);
+}
+
+static int clone_trampoline(void *raw_info)
+{
+    struct info *info = (struct info *) raw_info;
+    int flags;
+
+    struct stack process_stack = info->stack.process;
+    int orig_flags = info->flags;
+
+    if (orig_flags & CSIGNAL) {
+        /*
+         * It should be safe to call here, since we know signals are blocked
+         * for this process.
+         */
+        hide_current_process_exit_signal();
+    }
+
+    /*
+     * Force CLONE_PARENT, so that we don't accidentally become a child of the
+     * trampoline thread. This kernel task should either be a child of the
+     * trampoline's parent (if CLONE_PARENT is not in info->flags), or a child
+     * of the calling process's parent (if CLONE_PARENT IS in info->flags).
+     * That is to say, our parent should always be the correct parent for the
+     * child task.
+     *
+     * Force CLONE_VFORK so that we know when the child is no longer holding
+     * a reference to this process's virtual memory. CLONE_VFORK just suspends
+     * this task until the child execs or exits, it should not affect how the
+     * child process is created in any way. This is the only generic way I'm
+     * aware of to observe *any* exit or exec. Including "abnormal" exits like
+     * exits via signals.
+     *
+     * Force CLONE_CHILD_SETTID, since we want to track the CHILD TID in the
+     * `info` structure. Capturing the child via `clone` call directly is
+     * slightly nicer than making a syscall in the child. Since we know we're
+     * doing a CLONE_VM here, we can use CLONE_CHILD_SETTID, to guarantee that
+     * the kernel must set the child TID before the child is run. The child
+     * TID should be visibile to the parent, since both parent and child share
+     * and address space. If the clone fails, we overwrite `info->result`
+     * anyways with the error code.
+     */
+    flags = orig_flags | CLONE_PARENT | CLONE_VFORK | CLONE_CHILD_SETTID;
+    if (clone(clone_child, info->stack.process.top, flags,
+              (void *) info, NULL, NULL, &info->result) < 0) {
+        info->result = -errno;
+        completion_finish(&info->child_ready);
+        return 0;
+    }
+
+    /*
+     * Clean up the child process stack, since we know the child can no longer
+     * reference it.
+     */
+    free(process_stack.buffer);
+
+    /*
+     * We know the process we created was CLONE_VFORK, so it registered with
+     * the RCU. We share a TLS image with the process, so we can unregister
+     * it from the RCU. Since the TLS image will be valid for at least our
+     * lifetime, it should be OK to leave the child processes RCU entry in
+     * the queue between when the child execve or exits, and the OS returns
+     * here from our vfork.
+     */
+    rcu_unregister_thread();
+
+    /*
+     * If we're doing a real vfork here, we need to notify the parent that the
+     * vfork has happened.
+     */
+    if (orig_flags & CLONE_VFORK) {
+        completion_finish(&info->child_ready);
+    }
+
+    return 0;
+}
+
+static int clone_vm(int flags, int (*callback)(void *), void *payload)
+{
+    struct info info;
+    sigset_t sigmask;
+    int ret;
+
+    assert(flags & CLONE_VM && "CLONE_VM flag must be set");
+
+    memset(&info, 0, sizeof(info));
+    info.clone_f = callback;
+    info.payload = payload;
+    info.flags = flags;
+
+    /*
+     * Set up the stacks for the child processes needed to execute the clone.
+     */
+    if (!stack_new(&info.stack.trampoline)) {
+        return -1;
+    }
+    if (!stack_new(&info.stack.process)) {
+        free(info.stack.trampoline.buffer);
+        return -1;
+    }
+
+    /*
+     * tls_manager_new grants us it's ownership of the reference to the
+     * TLS manager, so we "leak" the data pointer, instead of using _get()
+     */
+    struct tls_manager *mgr = tls_manager_new();
+    if (mgr == NULL) {
+        free(info.stack.trampoline.buffer);
+        free(info.stack.process.buffer);
+        return -1;
+    }
+
+    /* Manager cleans up the trampoline stack once the trampoline exits. */
+    mgr->cleanup = info.stack.trampoline.buffer;
+
+    /*
+     * Flags used by the trampoline in the 2-phase clone setup for children
+     * cloned with CLONE_VM. We want the trampoline to be essentially identical
+     * to its parent. This improves the performance of cloning the trampoline,
+     * and guarantees that the real flags are implemented correctly.
+     *
+     * CLONE_CHILD_SETTID: Make the kernel set the managed_tid for the TLS
+     * manager.
+     *
+     * CLONE_CHILD_CLEARTID: Make the kernel clear the managed_tid, and
+     * trigger a FUTEX_WAKE (received by the TLS manager), so the TLS manager
+     * knows when to cleanup the trampoline stack.
+     *
+     * CLONE_SETTLS: To set the trampoline TLS based on the tls manager.
+     */
+    static const int base_trampoline_flags = (
+        CLONE_FILES | CLONE_FS | CLONE_IO | CLONE_PTRACE |
+        CLONE_SIGHAND | CLONE_SYSVSEM | CLONE_VM
+    ) | CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID | CLONE_SETTLS;
+
+    int trampoline_flags = base_trampoline_flags;
+
+    /*
+     * To get the process hierarchy right, we set the trampoline
+     * CLONE_PARENT/CLONE_THREAD flag to match the child
+     * CLONE_PARENT/CLONE_THREAD. So add those flags if specified by the child.
+     */
+    trampoline_flags |= (flags & CLONE_PARENT) ? CLONE_PARENT : 0;
+    trampoline_flags |= (flags & CLONE_THREAD) ? CLONE_THREAD : 0;
+
+    /*
+     * When using CLONE_PARENT, linux always sets the exit_signal for the task
+     * to the exit_signal of the parent process. For our purposes, the
+     * trampoline process. exit_signal has special significance for calls like
+     * `wait`, so it needs to be set correctly. We add the signal part of the
+     * user flags here so the ultimate child gets the right signal.
+     *
+     * This has the unfortunate side-effect of sending the parent two exit
+     * signals. One when the true child exits, and one when the trampoline
+     * exits. To work-around this we have to capture the exit signal from the
+     * trampoline and supress it.
+     */
+    trampoline_flags |= (flags & CSIGNAL);
+
+    sigfillset(&sigmask);
+    if (sigprocmask(SIG_BLOCK, &sigmask, &info.orig_mask) != 0) {
+        free(info.stack.trampoline.buffer);
+        free(info.stack.process.buffer);
+        completion_finish(&mgr->spawned);
+        return -1;
+    }
+
+    if (clone(clone_trampoline,
+              info.stack.trampoline.top, trampoline_flags, &info,
+              NULL, mgr->tls_ptr, &mgr->managed_tid) < 0) {
+        free(info.stack.trampoline.buffer);
+        free(info.stack.process.buffer);
+        completion_finish(&mgr->spawned);
+        return -1;
+    }
+
+    completion_await(&info.child_ready);
+    completion_finish(&mgr->spawned);
+
+    ret = sigprocmask(SIG_SETMASK, &info.orig_mask, NULL);
+    /*
+     * If our final sigproc mask doesn't work, we're pretty screwed. We may
+     * have started the final child now, and there's no going back. If this
+     * ever happens, just crash.
+     */
+    assert(!ret && "sigprocmask after clone needs to succeed");
+
+    /* If we have an error result, then set errno as needed. */
+    if (info.result < 0) {
+        errno = -info.result;
+        return -1;
+    }
+    return info.result;
+}
+
 struct clone_thread_info {
     struct completion running;
     int tid;
@@ -120,6 +517,17 @@ int qemu_clone(int flags, int (*callback)(void *), void *payload)
 {
     int ret;
 
+    /*
+     * Backwards Compatibility: Remove once all target platforms support
+     * clone_vm. Previously, we implemented vfork() via a fork() call,
+     * preserve that behavior instead of failing.
+     */
+    if (!clone_vm_supported()) {
+        if (flags & CLONE_VFORK) {
+            flags &= ~(CLONE_VFORK | CLONE_VM);
+        }
+    }
+
     if (clone_flags_are_thread(flags)) {
         /*
          * The new process uses the same flags as pthread_create, so we can
@@ -146,7 +554,12 @@ int qemu_clone(int flags, int (*callback)(void *), void *payload)
         return ret;
     }
 
-    /* !fork && !thread */
+    if (clone_vm_supported() && (flags & CLONE_VM)) {
+        return clone_vm(flags, callback, payload);
+    }
+
+    /* !fork && !thread && !CLONE_VM. This form is unsupported. */
+
     errno = EINVAL;
     return -1;
 }
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 54bf4f47be..e29912466c 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -94,6 +94,7 @@ struct vm86_saved_state {
 
 struct emulated_sigtable {
     int pending; /* true if signal is pending */
+    pid_t exit_pid; /* non-zero host pid, if a process is exiting. */
     target_siginfo_t info;
 };
 
@@ -183,6 +184,15 @@ typedef struct TaskState {
      * least TARGET_NSIG entries
      */
     struct target_sigaction *sigact_tbl;
+
+    /*
+     * Set to true if the process asssociated with this task state was cloned.
+     * This is needed to disambiguate cloned processes from threads. If
+     * CLONE_VM is used, a pthread_exit(..) will free the stack/TLS of the
+     * trampoline thread, and the trampoline will be unable to conduct its
+     * cleanup.
+     */
+    bool is_cloned;
 } __attribute__((aligned(16))) TaskState;
 
 extern char *exec_path;
@@ -442,6 +452,13 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp);
 int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
 abi_long do_swapcontext(CPUArchState *env, abi_ulong uold_ctx,
                         abi_ulong unew_ctx, abi_long ctx_size);
+
+/*
+ * Register the current process as a "hidden" process. Exit signals generated
+ * by this process should not be delivered to the guest.
+ */
+void hide_current_process_exit_signal(void);
+
 /**
  * block_signals: block all signals while handling this guest syscall
  *
diff --git a/linux-user/signal.c b/linux-user/signal.c
index dc98def6d1..a7f0612b64 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -36,6 +36,21 @@ typedef struct target_sigaction sigact_table[TARGET_NSIG];
 static void host_signal_handler(int host_signum, siginfo_t *info,
                                 void *puc);
 
+/*
+ * This table, initilized in signal_init, is used to track "hidden" processes
+ * for which exit signals should not be delivered. The PIDs of the processes
+ * hidden processes are stored as keys. Values are always set to NULL.
+ *
+ * Note: Process IDs stored in this table may "leak" (i.e., never be removed
+ * from the table) if the guest blocks (SIG_IGN) the exit signal for the child
+ * it spawned. There is a small risk, that this PID could later be reused
+ * by an alternate child process, and the child exit would be hidden. This is
+ * an unusual case that is unlikely to happen, but it is possible.
+ */
+static GHashTable *hidden_processes;
+
+/* this lock guards access to the `hidden_processes` table. */
+static pthread_mutex_t hidden_processes_lock = PTHREAD_MUTEX_INITIALIZER;
 
 /*
  * System includes define _NSIG as SIGRTMAX + 1,
@@ -564,6 +579,9 @@ void signal_init(void)
     /* initialize signal conversion tables */
     signal_table_init();
 
+    /* initialize the hidden process table. */
+    hidden_processes = g_hash_table_new(g_direct_hash, g_direct_equal);
+
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
 
@@ -749,6 +767,10 @@ static void host_signal_handler(int host_signum, siginfo_t *info,
     k = &ts->sigtab[sig - 1];
     k->info = tinfo;
     k->pending = sig;
+    k->exit_pid = 0;
+    if (info->si_code & (CLD_DUMPED | CLD_KILLED | CLD_EXITED)) {
+        k->exit_pid = info->si_pid;
+    }
     ts->signal_pending = 1;
 
     /* Block host signals until target signal handler entered. We
@@ -930,6 +952,17 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     return ret;
 }
 
+void hide_current_process_exit_signal(void)
+{
+    pid_t pid = getpid();
+
+    pthread_mutex_lock(&hidden_processes_lock);
+
+    (void)g_hash_table_insert(hidden_processes, GINT_TO_POINTER(pid), NULL);
+
+    pthread_mutex_unlock(&hidden_processes_lock);
+}
+
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
                                   struct emulated_sigtable *k)
 {
@@ -944,6 +977,22 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     /* dequeue signal */
     k->pending = 0;
 
+    if (k->exit_pid) {
+        pthread_mutex_lock(&hidden_processes_lock);
+        /*
+         * If the exit signal is for a hidden PID, then just drop it, and
+         * remove the hidden process from the list, since we know it has
+         * exited.
+         */
+        if (g_hash_table_contains(hidden_processes,
+                                  GINT_TO_POINTER(k->exit_pid))) {
+            g_hash_table_remove(hidden_processes, GINT_TO_POINTER(k->exit_pid));
+            pthread_mutex_unlock(&hidden_processes_lock);
+            return;
+        }
+        pthread_mutex_unlock(&hidden_processes_lock);
+    }
+
     sig = gdb_handlesig(cpu, sig);
     if (!sig) {
         sa = NULL;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 838caf9c98..20cf5d5464 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -139,10 +139,9 @@
 
 /* These flags are ignored:
  * CLONE_DETACHED is now ignored by the kernel;
- * CLONE_IO is just an optimisation hint to the I/O scheduler
  */
 #define CLONE_IGNORED_FLAGS                     \
-    (CLONE_DETACHED | CLONE_IO)
+    (CLONE_DETACHED)
 
 /* Flags for fork which we can implement within QEMU itself */
 #define CLONE_EMULATED_FLAGS               \
@@ -5978,14 +5977,31 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
     }
     proc_flags = (proc_flags & ~CSIGNAL) | host_sig;
 
-    /* Emulate vfork() with fork() */
-    if (proc_flags & CLONE_VFORK) {
-        proc_flags &= ~(CLONE_VFORK | CLONE_VM);
+
+    if (!clone_flags_are_fork(proc_flags) && !(flags & CLONE_VM)) {
+        /*
+         * If the user is doing a non-CLONE_VM clone, which cannot be emulated
+         * with fork, we can't guarantee that we can emulate this correctly.
+         * It should work OK as long as there are no threads in parent process,
+         * so we hide it behind a flag if the user knows what they're doing.
+         */
+        qemu_log_mask(LOG_UNIMP,
+                      "Refusing non-fork/thread clone without CLONE_VM.");
+        return -TARGET_EINVAL;
     }
 
-    if (!clone_flags_are_fork(proc_flags) &&
-        !clone_flags_are_thread(proc_flags)) {
-        qemu_log_mask(LOG_UNIMP, "unsupported clone flags");
+    if ((flags & CLONE_FILES) && !(flags & CLONE_VM)) {
+        /*
+         * This flag combination is currently unsupported. QEMU needs to update
+         * the fd_trans_table as new file descriptors are opened. This is easy
+         * when CLONE_VM is set, because the fd_trans_table is shared between
+         * the parent and child. Without CLONE_VM the fd_trans_table will need
+         * to be share specially using shared memory mappings, or a
+         * consistentcy protocol between the child and the parent.
+         *
+         * For now, just return EINVAL in this case.
+         */
+        qemu_log_mask(LOG_UNIMP, "CLONE_FILES only supported with CLONE_VM");
         return -TARGET_EINVAL;
     }
 
@@ -6042,6 +6058,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts->sigact_tbl = sigact_table_clone(parent_ts->sigact_tbl);
     }
 
+    if (!clone_flags_are_thread(proc_flags)) {
+        ts->is_cloned = true;
+    }
+
     if (flags & CLONE_CHILD_CLEARTID) {
         ts->child_tidptr = child_tidptr;
     }
@@ -6063,10 +6083,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         tb_flush(cpu);
     }
 
-    if (proc_flags & CLONE_VM) {
-        info.child.register_thread = true;
-        info.child.signal_setup = true;
-    }
+    info.child.signal_setup = (flags & CLONE_VM) && !(flags & CLONE_VFORK);
+    info.child.register_thread = !!(flags & CLONE_VM);
 
     /*
      * It is not safe to deliver signals until the child has finished
@@ -6078,7 +6096,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 
     ret = get_errno(qemu_clone(proc_flags, clone_run, (void *) &info));
 
-    if (ret >= 0 && (proc_flags & CLONE_VM)) {
+    if (ret >= 0 && (flags & CLONE_VM) && !(flags & CLONE_VFORK)) {
         /*
          * Wait for the child to finish setup if the child is running in the
          * same VM.
@@ -6092,7 +6110,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
     pthread_cond_destroy(&info.cond);
     pthread_mutex_destroy(&info.mutex);
 
-    if (ret >= 0 && !(proc_flags & CLONE_VM)) {
+    if (ret >= 0 && !(flags & CLONE_VM)) {
         /*
          * If !CLONE_VM, then we need to set parent_tidptr, since the child
          * won't set it for us. Should always be safe to set it here anyways.
@@ -7662,6 +7680,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     switch(num) {
     case TARGET_NR_exit:
     {
+        bool do_pthread_exit = false;
         /* In old applications this may be used to implement _exit(2).
            However in threaded applictions it is used for thread termination,
            and _exit_group is used for application termination.
@@ -7692,10 +7711,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                           NULL, NULL, 0);
             }
 
+            /*
+             * Need this multi-step process so we can free ts before calling
+             * pthread_exit.
+             */
+            if (!ts->is_cloned) {
+                do_pthread_exit = true;
+            }
+
             thread_cpu = NULL;
             g_free(ts);
-            rcu_unregister_thread();
-            pthread_exit(NULL);
+            if (do_pthread_exit) {
+                rcu_unregister_thread();
+                pthread_exit(NULL);
+            }
         }
 
         pthread_mutex_unlock(&clone_lock);
@@ -9700,6 +9729,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef __NR_exit_group
         /* new thread calls */
     case TARGET_NR_exit_group: {
+        /*
+         * TODO: We need to clean up CPUs (like is done for exit(2))
+         * for all threads in this process when exit_group is called, at least
+         * for tasks that have been cloned. Could also be done in
+         * clone_trampoline/tls_mgr. Since this cleanup is non-trival (need to
+         * coordinate it across threads. Right now it seems to be fine without
+         * the cleanup, so just leaving a note.
+         */
         preexit_cleanup(cpu_env, arg1);
         return get_errno(exit_group(arg1));
     }
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 8a7c15cd31..a7723556c2 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -407,14 +407,13 @@ static void test_clone(void)
 
     stack1 = malloc(STACK_SIZE);
     pid1 = chk_error(clone(thread1_func, stack1 + STACK_SIZE,
-                           CLONE_VM | CLONE_FS | CLONE_FILES |
-                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
+                           CLONE_VM | SIGCHLD,
                             "hello1"));
 
     stack2 = malloc(STACK_SIZE);
     pid2 = chk_error(clone(thread2_func, stack2 + STACK_SIZE,
                            CLONE_VM | CLONE_FS | CLONE_FILES |
-                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
+                           CLONE_SIGHAND | CLONE_SYSVSEM | SIGCHLD,
                            "hello2"));
 
     wait_for_child(pid1);
@@ -517,6 +516,61 @@ static void test_shm(void)
     chk_error(shmdt(ptr));
 }
 
+static volatile sig_atomic_t test_clone_signal_count_handler_calls;
+
+static void test_clone_signal_count_handler(int sig)
+{
+    test_clone_signal_count_handler_calls++;
+}
+
+/* A clone function that does nothing and exits successfully. */
+static int successful_func(void *arg __attribute__((unused)))
+{
+    return 0;
+}
+
+/*
+ * With our clone implementation it's possible that we could generate too many
+ * child exit signals. Make sure only the single expected child-exit signal is
+ * generated.
+ */
+static void test_clone_signal_count(void)
+{
+    uint8_t *child_stack;
+    struct sigaction prev, test;
+    int status;
+    pid_t pid;
+
+    memset(&test, 0, sizeof(test));
+    test.sa_handler = test_clone_signal_count_handler;
+    test.sa_flags = SA_RESTART;
+
+    /* Use real-time signals, so every signal event gets delivered. */
+    chk_error(sigaction(SIGRTMIN, &test, &prev));
+
+    child_stack = malloc(STACK_SIZE);
+    pid = chk_error(clone(
+        successful_func,
+        child_stack + STACK_SIZE,
+        CLONE_VM | SIGRTMIN,
+        NULL
+    ));
+
+    /*
+     * Need to use __WCLONE here because we are not using SIGCHLD as the
+     * exit_signal. By default linux only waits for children spawned with
+     * SIGCHLD.
+     */
+    chk_error(waitpid(pid, &status, __WCLONE));
+
+    chk_error(sigaction(SIGRTMIN, &prev, NULL));
+
+    if (test_clone_signal_count_handler_calls != 1) {
+        error("expected to receive exactly 1 signal, received %d signals",
+              test_clone_signal_count_handler_calls);
+    }
+}
+
 int main(int argc, char **argv)
 {
     test_file();
@@ -524,11 +578,8 @@ int main(int argc, char **argv)
     test_fork();
     test_time();
     test_socket();
-
-    if (argc > 1) {
-        printf("test_clone still considered buggy\n");
-        test_clone();
-    }
+    test_clone();
+    test_clone_signal_count();
 
     test_signal();
     test_shm();
-- 
2.27.0.290.gba653c62da-goog


