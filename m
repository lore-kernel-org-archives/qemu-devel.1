Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8390C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FE32083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FE32083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yifanlu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2l3p-0007es-Uf
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2l2w-0007Da-Ts
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2l2v-0008Oi-HA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:10:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:44404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2l2v-0008N7-Ba
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:10:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2l2t-0000rv-NF
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 00:10:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AD8E72E80C3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 00:10:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Feb 2020 00:01:17 -0000
From: Yifan <me@yifanlu.com>
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
X-Launchpad-Bug-Modifier: Yifan (yifanlu)
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Message-Id:
 <CAP4MwtfP_+pxb96WQ4coe187A4e2HasXqTXsobTn1UH+8RFK8Q@mail.gmail.com>
Subject: [Bug 1863025] Re: [PATCH] accel/tcg: fix race in cpu_exec_step_atomic
 (bug 1863025)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 478c8d9d708a41d4133581151e079b7f6ea1c0a3
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
Message-ID: <20200215000117._6nTivmr-oRkkKEvJAQ5KuNxDxzzHAAYGHT-WpQ6ccs@z>

What race are you thinking of in my patch? The obvious race I can
think of is benign:

Case 1:
A: does TB flush
B: read tb_flush_count
A: increment tb_flush_count
A: end_exclusive
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (increment seen)
B: retries

Case 2:
B: read tb_flush_count
A: does TB flush
A: increment tb_flush_count
A: end_exclusive
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (increment seen)
B: retries

Case 3:
A: does TB flush
A: increment tb_flush_count
A: end_exclusive
B: read tb_flush_count
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (no increment seen)
B: proceeds

Case 1 is the expected case. Case 2, we thought TB was stale but it
wasn't so we get it again with tb_lookup__cpu_state with minimal extra
overhead.

Case 3 seems to be bad because we could read tb_flush_count and find
it already incremented. But if so that means thread A is at the end of
do_tb_flush and the lookup tables are already cleared and the TCG
context is already reset. So it should be safe for thread B to call
tb_lookup__cpu_state or tb_gen_code.

Yifan

On Fri, Feb 14, 2020 at 3:31 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/14/20 6:49 AM, Alex Benn=C3=A9e wrote:
> > The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
> > which is invalidated by a tb_flush before we execute it. This doesn't
> > affect the other cpu_exec modes as a tb_flush by it's nature can only
> > occur on a quiescent system. The race was described as:
> >
> >   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
> >   B3. tcg_tb_alloc obtains a new TB
> >
> >       C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
> >           (same TB as B2)
> >
> >           A3. start_exclusive critical section entered
> >           A4. do_tb_flush is called, TB memory freed/re-allocated
> >           A5. end_exclusive exits critical section
> >
> >   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
> >   B3. tcg_tb_alloc reallocates TB from B2
> >
> >       C4. start_exclusive critical section entered
> >       C5. cpu_tb_exec executes the TB code that was free in A4
> >
> > The simplest fix is to widen the exclusive period to include the TB
> > lookup. As a result we can drop the complication of checking we are in
> > the exclusive region before we end it.
>
> I'm not 100% keen on having the tb_gen_code within the exclusive region. =
 It
> implies a much larger delay on (at least) the first execution of the atom=
ic
> operation.
>
> But I suppose until recently we had a global lock around code generation,=
 and
> this is only slightly worse.  Plus, it has the advantage of being dead si=
mple,
> and without the races vs tb_ctx.tb_flush_count that exist in Yifan's patc=
h.
>
> Applied to tcg-next.
>
>
> r~

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

