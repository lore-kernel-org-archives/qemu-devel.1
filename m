Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F182224D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLECYqKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F182224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k428T-0006ox-HR
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k427l-00067q-3D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k427h-0003rT-VD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596805764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/x3NewQF1PkIbIPzv6xXfbJVLmF6sIYoMK/w9fJud8=;
 b=NLECYqKyVSJLKiNgBymZbvFL3yt1/fGYAVOHvxnRHEv10OHxlmtkqBMIt8jVRlvurQBniS
 cozpAhBwFXB/emredbnFCuaCS27Z9LX5bNtoWKZlCWVD+jvWKjkYwK7hikLpmxqU/7bO82
 JTPttux/gv0F6jJqLhnRkjjgc1BEQDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-0LR1IhxKMhO75Ty1i1z8pw-1; Fri, 07 Aug 2020 09:09:22 -0400
X-MC-Unique: 0LR1IhxKMhO75Ty1i1z8pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8973100A8E7;
 Fri,  7 Aug 2020 13:09:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F0460BE2;
 Fri,  7 Aug 2020 13:09:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 085571132801; Fri,  7 Aug 2020 15:09:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Ways to do per-coroutine properties (was: [PATCH v6 06/12] monitor:
 Make current monitor a per-coroutine property)
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
Date: Fri, 07 Aug 2020 15:09:19 +0200
In-Reply-To: <87sgd15z5w.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 05 Aug 2020 09:28:59 +0200")
Message-ID: <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 09:09:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@gmail.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I called for a discussion of design alternatives, because I dislike the
one I got.  Here we go.

= Context: the "current monitor" =

Output of HMP commands needs to go to the HMP monitor executing the
command.  Trivial in HMP command handlers: the handler function takes a
monitor argument.  Not so trivial in code used both by HMP command
handlers and other users, such as CLI.  In particular, passing the
monitor through multiple layers that don't want to know anything about
monitors to the point that reports an error just so we can make the
error report go where it needs to go would be impractical.  We made
error_report() & friends do the right thing without such help.

To let them do that, we maintain a "current monitor".

    Invariant: while executing a monitor command, thread-local variable
    @cur_mon points to the monitor executing the command.  When the
    thread is not executing a monitor command, @cur_mon is null.

Now error_report() can do the right thing easily: print to @cur_mon if
non-null, else to stderr.

We also use @cur_mon for getting file descriptors stored in the monitor.
Could perhaps do without @cur_mon, but since it's there anyway...

= Problem at hand: "current monitor" for coroutine-enabled commands =

We want to be able to run monitor commands in a coroutine, so they can
yield instead of blocking the main loop.

Simply yielding in a monitor command violates the invariant: we're no
longer executing a monitor command[*], but @cur_mon is still non-null.

This is because the current monitor is no longer a property of the
thread, but a property of the coroutine.  Thread-local variable @cur_mon
doesn't fit the bill anymore.

= Solution 1: A separate map coroutine -> current monitor =

Kevin implemented this, using a hash table.

PRO:

* Stays off the coroutine switch hot path (by staying off coroutine code
  entirely).

CON

* It's a one-off (but at least it's confined to monitor.c)

* It's slow, and uses locks (but that's probably okay for this use; see
  also one-off).

* We get to worry about consistency between coroutines and the hash
  table.

While this looks servicable, I wonder whether we can we come up with
something a bit more elegant.

= Solution 2: Put the map into struct Coroutine =

The hash table can be replaced by putting a @cur_mon member right into
struct Coroutine, together with a setter and a getter function.

PRO

* Stays off the coroutine switch hot path.

CON

* It's a one off.

* HMP bleeds into the coroutine subsystem, which really doesn't want to
  know anything about monitors.

Thanks, but no thanks.

= Solution 3: Put abstract maps into struct Coroutine =

Daniel's proposal: instead of putting a Monitor * member into struct
Coroutine, put an array of void * there, indexed by well-known data
keys.  Initially, there is just one data key, for the current monitor.

This is basically pthread_setspecific(), pthread_getspecific() for
coroutines, with pthread_key_create() dumbed down to a static set of
well-known keys.

PRO

* Stays off the coroutine switch hot path.

* Similar to how thread-local storage works with traditional pthreads.

CON

* Similar to how thread-local storage works with traditional pthreads.

= Solution 4: Fixed coroutine-local storage =

Whereas solution 3 is like traditional pthreads, this solution works
more like __thread does under the hood: we allocate memory for
coroutine-local storage on coroutine creation, maintain a global pointer
on thread switch, and free the memory on destruction.

We can keep the global pointer in struct Coroutine, and have a getter
return it.

If accessing coroutine-local storage ever becomes a performance
bottleneck, we can either open-code the getter, or store the pointer in
thread-local storage (but then we need to update it in the coroutine
switch hot path).  No need to worry about all that now.

Since we don't have compiler and linker support, we have to collect the
coroutine-local variables in a struct manually.

PRO

* Stays off the coroutine switch hot path.

* Access could be made quite fast if need be.

CON

* The struct of coroutine-local variable crosses subsystem boundaries.

= Solution 5: Optional coroutine-specific storage =

When creating a coroutine, you can optionally ask for a certain amount
of coroutine-specific memory.  It's malloced, stored in struct
Coroutine, and freed when on deletion.

A getter returns the coroutine-specific memory.  To actually use it, you
have to know the coroutine's coroutine-specific memory layout.

PRO

* Stays off the coroutine switch hot path.

* Access could be made quite fast if need be.

CON

* Having to know the coroutine's coroutine-specifc memory layout could
  turn out to be impractical for some applications of "property of a
  coroutine".

This is the solution I had in mind from the start.  I have prototype
code that passes basic testing.

= Solution 6: Exploit there is just two coroutines involved =

A simpler solution is possible, but to understand it, you first have to
understand how the threads and coroutines work together.  Let me
recapitulate.

In old QEMU, all monitors run in the main thread's main loop, and
together execute one command after the other.  @cur_mon was a global
variable, to be accessed only by the main thread.

Commit 62aa1d887f "monitor: Fix unsafe sharing of @cur_mon among
threads" (v3.0.0) made @cur_mon thread-local.  "Fix" was a bit of an
overstatement; no unsafe access was known.

The OOB work moved a part of the QMP monitor work from the main loop
into @mon_iothread.  @mon_iothread sends commands to the main thread for
execution, except for commands executed "out-of-band".

This series moves the main thread's QMP command dispatch into coroutine
@qmp_dispatcher_co.  Commands that aren't coroutine-capable get
dispatched to a one-shot bottom half, also in the main thread.

The series modifies the main thread's HMP command dispatch to wrap
execution of each coroutine-capable command in a newly created
coroutine.

We have:

* OOB commands running in @mon_iothread, outside coroutine context

* Coroutine-incapable QMP commands running in the main thread, outside
  coroutine context (detail: in a bottom half)

* Coroutine-incapable HMP commands running in the main thread, outside
  coroutine-incapable context

* Coroutine-capable QMP commands running in the main thread, in
  coroutine @qmp_dispatcher_co

* Coroutine-capable HMP commands runnning in the main thread, in a
  coroutine created just for the command

* At most one non-OOB command is executing at any time.

Let's ignore HMP for now.  Observe:

* As long as there is just one @qmp_dispatcher_co, there is just one
  current monitor for coroutine-capable QMP commands at any time.  It
  can therefore be stored in a simple global variable
  @qmp_dispatcher_co_mon.

* For the coroutine-incapable commands, thread-local variable @cur_mon
  suffices.

* If qemu_coroutine_self() == qmp_dispatcher_co, the current monitor is
  @qmp_dispatcher_co_mon.  Else it's @cur_mon.

To extend this to HMP, we have to make the handle_hmp_command()'s local
variable @co a global one.

PRO:

* Stays off the coroutine switch hot path (by staying off coroutine code
  entirely).

* Simple code.

CON

* It's a one-off (but at least it's confined to monitor.c).

* The argument behind the code is less than simple (see above).

* Should our monitor coroutines multiply, say because we pull off
  executing (some) in-band commands in monitor I/O thread(s), the
  solution falls apart.

I have prototype code that passes basic testing.

Opinions?

I'll post my two prototypes shortly.


[*] In theory, we could yield to a coroutine that is executing another
monitor's monitor command.  In practice, we haven't implemented that.


