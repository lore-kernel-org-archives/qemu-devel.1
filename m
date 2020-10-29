Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55877C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737CA206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEmYHrY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737CA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDjP-0007oy-9x
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kYDhD-0006Wt-Dr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kYDh9-0004mP-J1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604000085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EuoSGaxcCixwjN/oVloqapMgzHQ0RVwG2XnHR3iKT8=;
 b=bEmYHrY0Pn6X3upHVD8bjKpLbwZ2ZNvO65YVmUw4lnxfv6mmhpbtNkaNTChUaUvay/eXHl
 g/g6vng9ztYKq8KkdiPKHMyDcM5+y2dCUl66JJvtW7kLAFD3B09+DbirzavwUqIOpKadG/
 qS3lJhlIdGg6JIhcNcWSixL8P7ykm5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-hyoWTuCYNAi3XXFQJAociQ-1; Thu, 29 Oct 2020 15:34:41 -0400
X-MC-Unique: hyoWTuCYNAi3XXFQJAociQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 759FE64150;
 Thu, 29 Oct 2020 19:34:40 +0000 (UTC)
Received: from work-vm (ovpn-114-233.ams2.redhat.com [10.36.114.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20B27196FB;
 Thu, 29 Oct 2020 19:34:35 +0000 (UTC)
Date: Thu, 29 Oct 2020 19:34:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com
Subject: Re: recent flakiness (intermittent hangs) of migration-test
Message-ID: <20201029193433.GE3335@work-vm>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
 <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 29 Oct 2020 at 17:41, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > Recently I've seen the 'make check' migration-test developing an
> > > intermittent hang; I've seen this now on aarch32 host several times
> > > and also on s390x host. The symptom is that the test just hangs
> > > with a couple of child qemu processes sitting around doing nothing.
> > > ^Cing out of 'make check' doesn't kill the qemu processes; they
> > > seem to need a 'kill -9'.
> >
> > If you can send us a copy of the ps -eaf of the qemu commandlines
> > in the failing case it would be interesting to see.
> 
> ubuntu    2078 46210  0 13:24 pts/0    00:00:00 bash -o pipefail -c
> echo 'MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_IMG=./qemu-img
> G_TEST_DBUS_DAEMON=/home/ubuntu/qemu/tests/dbus-vmstate-daemon.sh
> QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
> --tap -k' && MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255
> + 1))} QTEST_QEMU_IMG=./qemu-img
> G_TEST_DBUS_DAEMON=/home/ubuntu/qemu/tests/dbus-vmstate-daemon.sh
> QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
> --tap -k < /dev/null | ./scripts/tap-driver.pl
> --test-name="qtest-x86_64/migration-test"
> ubuntu    2079  2078  8 13:24 pts/0    00:07:07
> tests/qtest/migration-test --tap -k
> ubuntu    2080  2078  0 13:24 pts/0    00:00:00 perl
> ./scripts/tap-driver.pl --test-name=qtest-x86_64/migration-test
> ubuntu    3514  2079  6 13:24 pts/0    00:05:56 ./qemu-system-x86_64
> -qtest unix:/tmp/qtest-2079.sock -qtest-log /dev/null -chardev
> socket,path=/tmp/qtest-2079.qmp,id=char0 -mon
> chardev=char0,mode=control -display none -accel kvm -accel tcg -name
> source,debug-threads=on -m 150M -serial
> file:/tmp/migration-test-EOJPDc/src_serial -drive
> file=/tmp/migration-test-EOJPDc/bootsect,format=raw -accel qtest
> ubuntu    3528  2079  0 13:24 pts/0    00:00:00 ./qemu-system-x86_64
> -qtest unix:/tmp/qtest-2079.sock -qtest-log /dev/null -chardev
> socket,path=/tmp/qtest-2079.qmp,id=char0 -mon
> chardev=char0,mode=control -display none -accel kvm -accel tcg -name
> target,debug-threads=on -m 150M -serial
> file:/tmp/migration-test-EOJPDc/dest_serial -incoming
> unix:/tmp/migration-test-EOJPDc/migsocket -drive
> file=/tmp/migration-test-EOJPDc/bootsect,format=raw -accel qtest
>

OK, so x86-64 tcg,

> 
> > > Sorry for the low-information-density bug report, but I don't really
> > > have time at the moment to debug failures in merge build test runs
> > > because the queue of stuff still to merge is enormous...
> >
> > If you get a moment to breath then a backtrace of the migration-test
> > process itself would be useful to see where it's hanging.
> 
> Here you go:
> 
> 
> Thread 2 (Thread 0x3ff9bcff910 (LWP 2081)):
> #0  syscall () at ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
> #1  0x000002aa35e353cc in qemu_futex_wait (val=<optimized out>,
> f=<optimized out>)
>     at /home/ubuntu/qemu/include/qemu/futex.h:29
> #2  qemu_event_wait (ev=ev@entry=0x2aa35e69388 <rcu_call_ready_event>)
> at ../../util/qemu-thread-posix.c:460
> #3  0x000002aa35e37a8c in call_rcu_thread (opaque=opaque@entry=0x0) at
> ../../util/rcu.c:258
> #4  0x000002aa35e34512 in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #5  0x000003ff9bf87aa8 in start_thread (arg=0x3ff9bcff910) at
> pthread_create.c:463
> #6  0x000003ff9be7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 1 (Thread 0x3ff9c378750 (LWP 2079)):
> #0  0x000003ff9be44040 in __GI___nanosleep
> (requested_time=requested_time@entry=0x3ffe49fe4b8,
> remaining=remaining@entry=0x0)
>     at ../sysdeps/unix/sysv/linux/nanosleep.c:28
> #1  0x000003ff9be72d7c in usleep (useconds=useconds@entry=1000) at
> ../sysdeps/posix/usleep.c:32
> #2  0x000002aa35e1074e in wait_for_migration_status (who=<optimized
> out>, goal=<optimized out>, ungoals=0x0)
>     at ../../tests/qtest/migration-helpers.c:157
> #3  0x000002aa35e0ecd2 in migrate_postcopy_complete
> (from=0x2aa371feb00, to=0x2aa372092e0)
>     at ../../tests/qtest/migration-test.c:746
> #4  0x000002aa35e0f31a in test_postcopy_recovery () at
> ../../tests/qtest/migration-test.c:830

Ah, postcopy-recovery, one for Peter Xu.

> #5  0x000003ff9c17c604 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0

On s390x host.

Dave

> #6  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #7  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #8  0x000003ff9c17c540 in ?? () from /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #9  0x000003ff9c17c7e6 in g_test_run_suite () from
> /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #10 0x000003ff9c17c820 in g_test_run () from
> /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #11 0x000002aa35e0ce7c in main (argc=<optimized out>, argv=<optimized
> out>) at ../../tests/qtest/migration-test.c:1511
> 
> Here's qemu process 3514:
> Thread 5 (Thread 0x3ff4affd910 (LWP 3628)):
> #0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
> out>, expected=0, futex_word=0x2aa26cd74dc)
>     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> #1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
> mutex=0x2aa26cd7488, cond=0x2aa26cd74b0)
>     at pthread_cond_wait.c:502
> #2  0x000003ff94c8d936 in __pthread_cond_wait
> (cond=cond@entry=0x2aa26cd74b0, mutex=mutex@entry=0x2aa26cd7488)
>     at pthread_cond_wait.c:655
> #3  0x000002aa2497072c in qemu_sem_wait (sem=sem@entry=0x2aa26cd7488)
> at ../../util/qemu-thread-posix.c:328
> #4  0x000002aa244f4a02 in postcopy_pause (s=0x2aa26cd7000) at
> ../../migration/migration.c:3192
> #5  0x000002aa244f4a02 in migration_detect_error (s=0x2aa26cd7000) at
> ../../migration/migration.c:3255
> #6  0x000002aa244f4a02 in migration_thread
> (opaque=opaque@entry=0x2aa26cd7000) at
> ../../migration/migration.c:3564
> #7  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #8  0x000003ff94c87aa8 in start_thread (arg=0x3ff4affd910) at
> pthread_create.c:463
> #9  0x000003ff94b7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 4 (Thread 0x3ff68adb910 (LWP 3522)):
> #0  0x000003ff94c8d936 in futex_wait_cancelable (private=<optimized
> out>, expected=0, futex_word=0x2aa26dd2d58)
>     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> #1  0x000003ff94c8d936 in __pthread_cond_wait_common (abstime=0x0,
> mutex=0x2aa2525d870 <qemu_global_mutex>, cond=0x2aa26dd2d30) at
> pthread_cond_wait.c:502
> #2  0x000003ff94c8d936 in __pthread_cond_wait
> (cond=cond@entry=0x2aa26dd2d30, mutex=mutex@entry=0x2aa2525d870
> <qemu_global_mutex>) at pthread_cond_wait.c:655
> #3  0x000002aa24970196 in qemu_cond_wait_impl (cond=0x2aa26dd2d30,
> mutex=0x2aa2525d870 <qemu_global_mutex>, file=0x2aa24a8d162
> "../../softmmu/cpus.c", line=<optimized out>) at
> ../../util/qemu-thread-posix.c:174
> #4  0x000002aa2467cbe0 in qemu_wait_io_event
> (cpu=cpu@entry=0x2aa26da31e0) at ../../softmmu/cpus.c:411
> #5  0x000002aa24760976 in tcg_cpu_thread_fn
> (arg=arg@entry=0x2aa26da31e0) at ../../accel/tcg/tcg-cpus.c:455
> #6  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #7  0x000003ff94c87aa8 in start_thread (arg=0x3ff68adb910) at
> pthread_create.c:463
> #8  0x000003ff94b7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 3 (Thread 0x3ff693cd910 (LWP 3521)):
> #0  0x000003ff94b6f5c0 in __GI___poll (fds=0x3ff64007700, nfds=3,
> timeout=<optimized out>)
>     at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x000003ff96fd250c in  () at /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #2  0x000003ff96fd2990 in g_main_loop_run () at
> /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #3  0x000002aa247b76e4 in iothread_run
> (opaque=opaque@entry=0x2aa26a47a30) at ../../iothread.c:80
> #4  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #5  0x000003ff94c87aa8 in start_thread (arg=0x3ff693cd910) at
> pthread_create.c:463
> #6  0x000003ff94b7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 2 (Thread 0x3ff879b7910 (LWP 3520)):
> #0  0x000003ff94b75a62 in syscall () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
> #1  0x000002aa249708f4 in qemu_futex_wait (val=<optimized out>,
> f=<optimized out>)
>     at /home/ubuntu/qemu/include/qemu/futex.h:29
> #2  0x000002aa249708f4 in qemu_event_wait (ev=ev@entry=0x2aa2527dbf8
> <rcu_call_ready_event>)
>     at ../../util/qemu-thread-posix.c:460
> #3  0x000002aa2497b57c in call_rcu_thread (opaque=opaque@entry=0x0) at
> ../../util/rcu.c:258
> #4  0x000002aa2496fa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #5  0x000003ff94c87aa8 in start_thread (arg=0x3ff879b7910) at
> pthread_create.c:463
> #6  0x000003ff94b7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 1 (Thread 0x3ff977b8450 (LWP 3514)):
> #0  0x000003ff94b6f712 in __GI_ppoll (fds=0x2aa2755ecd0, nfds=6,
> timeout=<optimized out>,
>     timeout@entry=0x3ffec7fe4c8, sigmask=sigmask@entry=0x0) at
> ../sysdeps/unix/sysv/linux/ppoll.c:39
> #1  0x000002aa24961c9c in ppoll (__ss=0x0, __timeout=0x3ffec7fe4c8,
> __nfds=<optimized out>, __fds=<optimized out>)
>     at /usr/include/s390x-linux-gnu/bits/poll2.h:77
> #2  0x000002aa24961c9c in qemu_poll_ns (fds=<optimized out>,
> nfds=<optimized out>, timeout=timeout@entry=1000000000)
>     at ../../util/qemu-timer.c:349
> #3  0x000002aa2497bb88 in os_host_main_loop_wait (timeout=1000000000)
> at ../../util/main-loop.c:239
> #4  0x000002aa2497bb88 in main_loop_wait
> (nonblocking=nonblocking@entry=0) at ../../util/main-loop.c:520
> #5  0x000002aa2475aaf0 in qemu_main_loop () at ../../softmmu/vl.c:1678
> #6  0x000002aa243ee178 in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>) at ../../softmmu/main.c:50
> 
> And here's 3528:
> Thread 6 (Thread 0x3ff6ccfd910 (LWP 3841)):
> #0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
> out>, expected=0, futex_word=0x2aa387a6aac)
>     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> #1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
> mutex=0x2aa387a6a58, cond=0x2aa387a6a80)
>     at pthread_cond_wait.c:502
> #2  0x000003ffb1b8d936 in __pthread_cond_wait
> (cond=cond@entry=0x2aa387a6a80, mutex=mutex@entry=0x2aa387a6a58)
>     at pthread_cond_wait.c:655
> #3  0x000002aa36bf072c in qemu_sem_wait (sem=sem@entry=0x2aa387a6a58)
> at ../../util/qemu-thread-posix.c:328
> #4  0x000002aa366c369a in postcopy_pause_incoming (mis=<optimized
> out>) at ../../migration/savevm.c:2541
> #5  0x000002aa366c369a in qemu_loadvm_state_main
> (f=f@entry=0x2aa38897930, mis=mis@entry=0x2aa387a6820)
>     at ../../migration/savevm.c:2615
> #6  0x000002aa366c44fa in postcopy_ram_listen_thread
> (opaque=opaque@entry=0x0) at ../../migration/savevm.c:1830
> #7  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #8  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6ccfd910) at
> pthread_create.c:463
> #9  0x000003ffb1a7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 5 (Thread 0x3ff6d4fe910 (LWP 3840)):
> #0  0x000003ffb1b8d936 in futex_wait_cancelable (private=<optimized
> out>, expected=0, futex_word=0x2aa387a6b0c)
>     at ../sysdeps/unix/sysv/linux/futex-internal.h:88
> #1  0x000003ffb1b8d936 in __pthread_cond_wait_common (abstime=0x0,
> mutex=0x2aa387a6ab8, cond=0x2aa387a6ae0)
>     at pthread_cond_wait.c:502
> #2  0x000003ffb1b8d936 in __pthread_cond_wait
> (cond=cond@entry=0x2aa387a6ae0, mutex=mutex@entry=0x2aa387a6ab8)
>     at pthread_cond_wait.c:655
> #3  0x000002aa36bf072c in qemu_sem_wait (sem=0x2aa387a6ab8,
> sem@entry=<error reading variable: value has been optimized out>)
>     at ../../util/qemu-thread-posix.c:328
> #4  0x000002aa3685282c in postcopy_pause_fault_thread (mis=<optimized
> out>) at ../../migration/postcopy-ram.c:841
> #5  0x000002aa3685282c in postcopy_ram_fault_thread
> (opaque=opaque@entry=0x2aa387a6820) at
> ../../migration/postcopy-ram.c:905
> #6  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #7  0x000003ffb1b87aa8 in start_thread (arg=0x3ff6d4fe910) at
> pthread_create.c:463
> #8  0x000003ffb1a7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 4 (Thread 0x3ff859db910 (LWP 3536)):
> #0  0x000002aa369854ec in load_memop (op=MO_8, haddr=0x3ff6fa61000) at
> ../../accel/tcg/cputlb.c:1794
> #1  0x000002aa369854ec in load_helper (full_load=<optimized out>,
> code_read=false, op=MO_8, retaddr=4396002632260, oi=<optimized out>,
> addr=18223104, env=0x2aa38879a90) at ../../accel/tcg/cputlb.c:1914
> #2  0x000002aa369854ec in full_ldub_mmu (env=0x2aa38879a90,
> addr=18223104, oi=<optimized out>, retaddr=4396002632260)
>     at ../../accel/tcg/cputlb.c:1930
> #3  0x000003ff862ce304 in code_gen_buffer ()
> #4  0x000002aa3693ab62 in cpu_tb_exec (itb=<optimized out>,
> cpu=<optimized out>) at ../../accel/tcg/cpu-exec.c:178
> #5  0x000002aa3693ab62 in cpu_loop_exec_tb (tb_exit=<synthetic
> pointer>, last_tb=<synthetic pointer>, tb=<optimized out>,
> cpu=<optimized out>) at ../../accel/tcg/cpu-exec.c:658
> #6  0x000002aa3693ab62 in cpu_exec (cpu=<optimized out>) at
> ../../accel/tcg/cpu-exec.c:771
> #7  0x000002aa0000000c in  ()
> 
> Thread 3 (Thread 0x3ff862cd910 (LWP 3535)):
> #0  0x000003ffb1a6f5c0 in __GI___poll (fds=0x3ff78007700, nfds=3,
> timeout=<optimized out>)
>     at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x000003ffb3ed250c in  () at /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #2  0x000003ffb3ed2990 in g_main_loop_run () at
> /usr/lib/s390x-linux-gnu/libglib-2.0.so.0
> #3  0x000002aa36a376e4 in iothread_run
> (opaque=opaque@entry=0x2aa38515a30) at ../../iothread.c:80
> #4  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #5  0x000003ffb1b87aa8 in start_thread (arg=0x3ff862cd910) at
> pthread_create.c:463
> #6  0x000003ffb1a7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 2 (Thread 0x3ffa48b7910 (LWP 3533)):
> #0  0x000003ffb1a75a62 in syscall () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:53
> #1  0x000002aa36bf08f4 in qemu_futex_wait (val=<optimized out>,
> f=<optimized out>)
>     at /home/ubuntu/qemu/include/qemu/futex.h:29
> #2  0x000002aa36bf08f4 in qemu_event_wait (ev=ev@entry=0x2aa374fdbf0
> <rcu_gp_event>) at ../../util/qemu-thread-posix.c:460
> #3  0x000002aa36bfb190 in wait_for_readers () at ../../util/rcu.c:135
> #4  0x000002aa36bfb190 in synchronize_rcu () at ../../util/rcu.c:171
> #5  0x000002aa36bfb5b2 in call_rcu_thread (opaque=opaque@entry=0x0) at
> ../../util/rcu.c:265
> #6  0x000002aa36befa3a in qemu_thread_start (args=<optimized out>) at
> ../../util/qemu-thread-posix.c:521
> #7  0x000003ffb1b87aa8 in start_thread (arg=0x3ffa48b7910) at
> pthread_create.c:463
> #8  0x000003ffb1a7a896 in thread_start () at
> ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:65
> 
> Thread 1 (Thread 0x3ffb46b8450 (LWP 3528)):
> #0  0x000003ffb1a6f712 in __GI_ppoll (fds=0x2aa39312cb0, nfds=6,
> timeout=<optimized out>,
>     timeout@entry=0x3ffe76feb78, sigmask=sigmask@entry=0x0) at
> ../sysdeps/unix/sysv/linux/ppoll.c:39
> #1  0x000002aa36be1c9c in ppoll (__ss=0x0, __timeout=0x3ffe76feb78,
> __nfds=<optimized out>, __fds=<optimized out>)
>     at /usr/include/s390x-linux-gnu/bits/poll2.h:77
> #2  0x000002aa36be1c9c in qemu_poll_ns (fds=<optimized out>,
> nfds=<optimized out>, timeout=timeout@entry=54858292)
>     at ../../util/qemu-timer.c:349
> #3  0x000002aa36bfbb88 in os_host_main_loop_wait (timeout=54858292) at
> ../../util/main-loop.c:239
> #4  0x000002aa36bfbb88 in main_loop_wait
> (nonblocking=nonblocking@entry=0) at ../../util/main-loop.c:520
> #5  0x000002aa369daaf0 in qemu_main_loop () at ../../softmmu/vl.c:1678
> #6  0x000002aa3666e178 in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>) at ../../softmmu/main.c:50
> 
> 
> thanks
> -- PMM
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


