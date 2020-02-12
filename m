Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF5C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C26F20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C26F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yifanlu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23nQ-000232-J8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j20DX-0001aT-Nc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j20DV-0003Qw-Jf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:10:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:44714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j20DV-0003Pi-Dy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:10:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j20DT-0004tR-VS
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 22:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E4A902E8042
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 22:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 22:01:07 -0000
From: Yifan <me@yifanlu.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: Yifan (yifanlu)
Message-Id: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Subject: [Bug 1863025] [NEW] Use-after-free after flush in TCG accelerator
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9484060313346fba58f007d3cdcf5834e322216c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Wed, 12 Feb 2020 20:59:15 -0500
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

Public bug reported:

I believe I found a UAF in TCG that can lead to a guest VM escape. The
security list informed me "This can not be treated as a security issue."
and to post it here. I am looking at the 4.2.0 source code. The issue
requires a race and I will try to describe it in terms of three
concurrent threads.

Thread A:

A1. qemu_tcg_cpu_thread_fn runs work loop
A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued_c=
pu_work
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
=C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed) =
=3D> A5 =3D> B2 =3D>
=C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB n=
ow executing) =3D> C6

In short, because thread C uses the TB in the critical section, there is
no guarantee that the pointer has not been "freed" (rather the memory is
marked as re-usable) and therefore a use-after-free occurs.

Since the TCG generated code can be in the same memory as the TB data
structure, it is possible for an attacker to overwrite the UAF pointer
with code generated from TCG. This can overwrite key pointer values and
could lead to code execution on the host outside of the TCG sandbox.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

- I believe I found a UAF in TCG that can lead to a guest VM escape. The se=
curity =

- list informed me "This can not be treated as a security issue." and to po=
st it =

- here. I am looking at the 4.2.0 source code. The issue requires a race an=
d I =

- will try to describe it in terms of three concurrent threads.
- =

- I am looking =

- at the 4.2.0 source code. The issue requires a race and I will try to des=
cribe =

- it in terms of three concurrent threads.
+ I believe I found a UAF in TCG that can lead to a guest VM escape. The
+ security list informed me "This can not be treated as a security issue."
+ and to post it here. I am looking at the 4.2.0 source code. The issue
+ requires a race and I will try to describe it in terms of three
+ concurrent threads.
  =

  Thread A:
  =

  A1. qemu_tcg_cpu_thread_fn runs work loop
  A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued=
_cpu_work
  A3. start_exclusive critical section entered
  A4. do_tb_flush is called, TB memory freed/re-allocated
  A5. end_exclusive exits critical section
  =

  Thread B:
  =

  B1. qemu_tcg_cpu_thread_fn runs work loop
  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB
  =

  Thread C:
  =

  C1. qemu_tcg_cpu_thread_fn runs work loop
  C2. cpu_exec_step_atomic executes
  C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
  C4. start_exclusive critical section entered
  C5. cpu_tb_exec executes the TB code
  C6. end_exclusive exits critical section
  =

  Consider the following sequence of events:
-   B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed) =3D> A5 =
=3D> B2 =3D> =

-   B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB now execu=
ting) =3D> C6
+ =C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed)=
 =3D> A5 =3D> B2 =3D>
+ =C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB=
 now executing) =3D> C6
  =

- In short, because thread C uses the TB in the critical section, there is =
no =

- guarantee that the pointer has not been "freed" (rather the memory is mar=
ked as =

- re-usable) and therefore a use-after-free occurs.
+ In short, because thread C uses the TB in the critical section, there is
+ no guarantee that the pointer has not been "freed" (rather the memory is
+ marked as re-usable) and therefore a use-after-free occurs.
  =

- Since the TCG generated code can be in the same memory as the TB data str=
ucture,
- it is possible for an attacker to overwrite the UAF pointer with code gen=
erated
- from TCG. This can overwrite key pointer values and could lead to code =

- execution on the host outside of the TCG sandbox.
+ Since the TCG generated code can be in the same memory as the TB data
+ structure, it is possible for an attacker to overwrite the UAF pointer
+ with code generated from TCG. This can overwrite key pointer values and
+ could lead to code execution on the host outside of the TCG sandbox.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863025

Title:
  Use-after-free after flush in TCG accelerator

Status in QEMU:
  New

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

