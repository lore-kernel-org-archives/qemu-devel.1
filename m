Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4047BC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1432F24649
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1432F24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cTX-0005sq-4v
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2cSh-0004YR-KT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2cSg-0002yf-3e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:00:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:53484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2cSf-0002xw-Rw
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:00:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2cSe-00043c-9M
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 15:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 287652E80CB
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 15:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2020 14:49:52 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: mttcg tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Message-Id: <20200214144952.15502-1-alex.bennee@linaro.org>
Subject: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c4fc7b14c103ddeed418b0021f2943da8288d9a2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1863025 <1863025@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200214144952.hG47-ZU9Sr2I7gfLgWBLBe7DhyxZBo2ajDy4vAKW3ec@z>

The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
which is invalidated by a tb_flush before we execute it. This doesn't
affect the other cpu_exec modes as a tb_flush by it's nature can only
occur on a quiescent system. The race was described as:

  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

      C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
          (same TB as B2)

          A3. start_exclusive critical section entered
          A4. do_tb_flush is called, TB memory freed/re-allocated
          A5. end_exclusive exits critical section

  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc reallocates TB from B2

      C4. start_exclusive critical section entered
      C5. cpu_tb_exec executes the TB code that was free in A4

The simplest fix is to widen the exclusive period to include the TB
lookup. As a result we can drop the complication of checking we are in
the exclusive region before we end it.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Yifan <me@yifanlu.com>
Cc: Bug 1863025 <1863025@bugs.launchpad.net>
---
 accel/tcg/cpu-exec.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2560c90eec7..d95c4848a47 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -240,6 +240,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t cf_mask =3D cflags & CF_HASH_MASK;
 =

     if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
+        start_exclusive();
+
         tb =3D tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb =3D=3D NULL) {
             mmap_lock();
@@ -247,8 +249,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
             mmap_unlock();
         }
 =

-        start_exclusive();
-
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus =3D false;
         cc->cpu_exec_enter(cpu);
@@ -271,14 +271,15 @@ void cpu_exec_step_atomic(CPUState *cpu)
         qemu_plugin_disable_mem_helpers(cpu);
     }
 =

-    if (cpu_in_exclusive_context(cpu)) {
-        /* We might longjump out of either the codegen or the
-         * execution, so must make sure we only end the exclusive
-         * region if we started it.
-         */
-        parallel_cpus =3D true;
-        end_exclusive();
-    }
+
+    /*
+     * As we start the exclusive region before codegen we must still
+     * be in the region if we longjump out of either the codegen or
+     * the execution.
+     */
+    g_assert(cpu_in_exclusive_context(cpu));
+    parallel_cpus =3D true;
+    end_exclusive();
 }
 =

 struct tb_desc {
-- =

2.20.1


** Tags added: mttcg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863025

Title:
  Use-after-free after flush in TCG accelerator

Status in QEMU:
  Confirmed

Bug description:
  I believe I found a UAF in TCG that can lead to a guest VM escape. The
  security list informed me "This can not be treated as a security
  issue." and to post it here. I am looking at the 4.2.0 source code.
  The issue requires a race and I will try to describe it in terms of
  three concurrent threads.

  Thread A:

  A1. qemu_tcg_cpu_thread_fn runs work loop
  A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued=
_cpu_work
  A3. start_exclusive critical section entered
  A4. do_tb_flush is called, TB memory freed/re-allocated
  A5. end_exclusive exits critical section

  Thread B:

  B1. qemu_tcg_cpu_thread_fn runs work loop
  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

  Thread C:

  C1. qemu_tcg_cpu_thread_fn runs work loop
  C2. cpu_exec_step_atomic executes
  C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
  C4. start_exclusive critical section entered
  C5. cpu_tb_exec executes the TB code
  C6. end_exclusive exits critical section

  Consider the following sequence of events:
  =C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed)=
 =3D> A5 =3D> B2 =3D>
  =C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB=
 now executing) =3D> C6

  In short, because thread C uses the TB in the critical section, there
  is no guarantee that the pointer has not been "freed" (rather the
  memory is marked as re-usable) and therefore a use-after-free occurs.

  Since the TCG generated code can be in the same memory as the TB data
  structure, it is possible for an attacker to overwrite the UAF pointer
  with code generated from TCG. This can overwrite key pointer values
  and could lead to code execution on the host outside of the TCG
  sandbox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863025/+subscriptions

