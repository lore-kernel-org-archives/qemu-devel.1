Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4910CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D8D20659
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgyNXbsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIWr-000264-5v
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSIVW-0001YE-PB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSIVL-0002Ct-8p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602588604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STEfBjcmHAB31/rHNu9nB1Y1ZCgfFjr02bdPJi3AY10=;
 b=cgyNXbsE9gGjvX/L7zRjHLviw3N8u7egD4WlXfTB2RphGdc7f8mteWJk0Nk4PEqvgXCNv+
 LitLjFQUx9r3xEcFfVdaglM2UR12ZVmT+Yb3UoDAAKBd2Ca7MeY/vQvtdX4KrikcYcria3
 /ZhFryhqUge+Ey6XgRqbHTXzRL5LPK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-24FZHRGLPjS7A_Uoqkf5AA-1; Tue, 13 Oct 2020 07:29:57 -0400
X-MC-Unique: 24FZHRGLPjS7A_Uoqkf5AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1A7F835B8E;
 Tue, 13 Oct 2020 11:29:55 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0696EF78;
 Tue, 13 Oct 2020 11:29:49 +0000 (UTC)
Date: Tue, 13 Oct 2020 13:29:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
Message-ID: <20201013112948.GA9674@merkur.fritz.box>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <87zh4rzpot.fsf@linaro.org>
 <20201012112506.GC7777@merkur.fritz.box>
 <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
 <20201012124743.GD7777@merkur.fritz.box>
 <87r1q3zdv9.fsf@linaro.org>
 <20201012184919.d4ivnajku6ydewpm@mail.bwidawsk.net>
 <CAP+75-UChQJ_YtUU40ttn=1GwNuYQ7X9xXS+CWg+ZXcLL-jocQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-UChQJ_YtUU40ttn=1GwNuYQ7X9xXS+CWg+ZXcLL-jocQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Ben Widawsky <ben@bwidawsk.net>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.10.2020 um 09:56 hat Philippe Mathieu-Daudé geschrieben:
> On Mon, Oct 12, 2020 at 8:57 PM Ben Widawsky <ben@bwidawsk.net> wrote:
> >
> > On 20-10-12 16:02:34, Alex Bennée wrote:
> > >
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > >
> > > > Am 12.10.2020 um 13:53 hat Philippe Mathieu-Daudé geschrieben:
> > > >> On 10/12/20 1:25 PM, Kevin Wolf wrote:
> > > >> > Am 12.10.2020 um 12:47 hat Alex Bennée geschrieben:
> > > >> > >
> > > >> > > Markus Armbruster <armbru@redhat.com> writes:
> > > >> > >
> > > >> > > > From: Kevin Wolf <kwolf@redhat.com>
> > > >> > > >
> > > >> > > > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > > >> > > > handlers that declare 'coroutine': true in coroutine context so they
> > > >> > > > can avoid blocking the main loop while doing I/O or waiting for other
> > > >> > > > events.
> > > >> > >
> > > >> > > This subtly changes the replay behaviour leading to a hang in:
> > > >> > >
> > > >> > >    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2…)|✚1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> > > >> > >    Fetching asset from tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> > > >> > >    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
> > > >> > >    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12T11.40-ec11fd2/job.log
> > > >> > >     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt: ERROR: Could not perform graceful shutdown (26.27 s)
> > > >> > >    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> > > >> > >    JOB TIME   : 27.77 s
> > > >> > >
> > > >> > > Looking at the log:
> > > >> > >
> > > >> > >    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.887411] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UTC (1602499231)
> > > >> > >    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.887431] sr_init: No PMIC hook to init smartreflex
> > > >> > >    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.897193] uart-pl011 9000000.pl011: no DMA platform data
> > > >> > >    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.897242] md: Waiting for all devices to be available before autodetect
> > > >> > >    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.897259] md: If you don't use raid, use raid=noautodetect
> > > >> > >    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.897819] md: Autodetecting RAID arrays.
> > > >> > >    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.897832] md: autorun ...
> > > >> > >    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.897842] md: ... autorun DONE.
> > > >> > >    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.897962] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> > > >> > >    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
> > > >> > >    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'timestamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN', 'data': {'guest': True, 'reason': 'guest-reset'}}
> > > >> > >    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu received signal 6; command: "./qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:console -icount shift=1,rr=record,rrfile=/var/tmp/avocado_n00stdrf/avocado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot"
> > > >> >
> > > >> > This looks like a crash (SIGABRT) rather than a hang. Do you have a
> > > >> > stack trace for the crashed process?
> > > >>
> > > >> No crash, exit(0):
> > > >
> > > > Why does the log say "qemu received signal 6" then?
> > > >
> > > >> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> > > >
> > > > Alex has this error in the logs before this commit, so I assume this is
> > > > expected. All of the following is then probably expected, too, because
> > > > it follows directly from this error:
> > > >
> > > >> Please append a correct "root=" boot option; here are the available
> > > >> partitions:
> > > >> Kernel panic - not syncing: VFS: Unable to mount root fs on
> > > >> unknown-block(0,0)
> > > >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #1
> > > >> Hardware name: Generic DT based system
> > > >> [<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0x24)
> > > >> [<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
> > > >> [<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
> > > >> [<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec)
> > > >> [<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0x90)
> > > >> [<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c/0x19c)
> > > >> [<c1101ac4>] (prepare_namespace) from [<c11012e8>]
> > > >> (kernel_init_freeable+0x2c0/0x370)
> > > >> [<c11012e8>] (kernel_init_freeable) from [<c0b63914>]
> > > >> (kernel_init+0x18/0x128)
> > > >> [<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> > > >> Exception stack(0xc790bfb0 to 0xc790bff8)
> > > >> bfa0:                                     00000000 00000000 00000000
> > > >> 00000000
> > > >> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > >> 00000000
> > > >> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > >>
> > > >> -> PSCI call
> > > >>    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
> > > >>       -> SHUTDOWN_CAUSE_GUEST_RESET
> > > >>          -> exit(0)
> > >
> > > Yes - the test is recording the kernel up until the point it gives up.
> > >
> > > > Hm... So you're saying that the test sends a 'quit' QMP command, but
> > > > before it could be processed, the guest causes QEMU to exit, so the test
> > > > will never receive a reply to its request?
> > > >
> > > > If commit 9ce44e2ce2 changes anything about this, it seems to me that it
> > > > would be that more QMP commands are processed during monitor_cleanup()
> > > > because it doesn't just delete the dispatcher BH, but waits until it's
> > > > not busy any more.
> > > >
> > > > Looking at this code again, however, the order in monitor_cleanup() is
> > > > probably wrong. We should first shut down the dispatcher (which may
> > > > still be using Monitor objects) and then destroy the monitors. This
> > > > could possibly explain a crash, but probably not wrong results with a
> > > > successful shutdown.
> > >
> > > I suspect this is a race between QEMU shutting down because the guest
> > > shut it down and the acceptance test trying to shut things down via QMP.
> > > I think the proper fix is either to:
> >
> > I'm not sure my problem is the same, but I do have the same symptom.
> >
> > >
> > >   - s/panic=-1/panic=0/ in the command line (and probably drop --no-reboot)
> > >
> > > which would let the acceptance test cleanly shutdown via QMP.
> >
> > I tried this, which works well on some of the platforms which were failing.
> > -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-1 '
> > +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-0 '
> >
> >      def run_vm(self, kernel_path, kernel_command_line, console_pattern,
> >                 record, shift, args, replay_path):
> > @@ -47,8 +47,8 @@ class ReplayKernel(LinuxKernelTest):
> >                      (shift, mode, replay_path),
> >                      '-kernel', kernel_path,
> >                      '-append', kernel_command_line,
> > -                    '-net', 'none',
> > -                    '-no-reboot')
> > +                    '-net', 'none'
> > +                    )
> >          if args:
> >              vm.add_args(*args)
> >          vm.launch()
> > @@ -154,7 +154,7 @@ class ReplayKernel(LinuxKernelTest):
> >          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> >                                 'console=ttyS0,115200 '
> >                                 'usbcore.nousb '
> > -                               'panic=-1 noreboot')
> > +                               'panic=-0')
> >          console_pattern = 'Boot successful.'
> >
> > >
> > >   - modify the test to declare that qemu will shutdown itself and
> > >     therefor no "quit" needs to be sent
> > >
> > > WDYT?
> 
> Can you send it as a formal patch please? :)

Please don't "fix" the test case when the problem is a QEMU bug.


I reproduced the bug myself now to fill in the missing information and
this is how it crashes:

(gdb) bt
#0  0x00007fe541cf4bc5 in raise () at /lib64/libc.so.6
#1  0x00007fe541cdd8a4 in abort () at /lib64/libc.so.6
#2  0x000055c24e965327 in error_exit (err=16, msg=0x55c24eead3a0 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:37
#3  0x000055c24e9654c3 in qemu_mutex_destroy (mutex=0x55c25133e0f0) at ../util/qemu-thread-posix.c:70
#4  0x000055c24e7cfaf1 in monitor_data_destroy_qmp (mon=0x55c25133dfd0) at ../monitor/qmp.c:439
#5  0x000055c24e7d23bc in monitor_data_destroy (mon=0x55c25133dfd0) at ../monitor/monitor.c:615
#6  0x000055c24e7d253a in monitor_cleanup () at ../monitor/monitor.c:644
#7  0x000055c24e6cb002 in qemu_cleanup () at ../softmmu/vl.c:4549
#8  0x000055c24e0d259b in main (argc=24, argv=0x7ffff66b0d58, envp=0x7ffff66b0e20) at ../softmmu/main.c:51

The reason is that qemu_mutex_destroy(&mon->qmp_queue_lock) is called
while mon->qmp_queue_lock is still held by the dispatcher coroutine.
This is fixed by correcting the order in monitor_cleanup() as I had
already noticed above.


For the sake of completeness, this is where the dispatcher coroutine has
yielded when the process crashes:

(gdb) l *0x000055c24e7cf3da
0x55c24e7cf3da is in monitor_qmp_dispatcher_co (../monitor/qmp.c:273).
268              * involves an AIO_WAIT_WHILE().
269              */
270             aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
271 ===>        qemu_coroutine_yield();
272
273             mon = req_obj->mon;
274             /* qmp_oob_enabled() might change after "qmp_capabilities" */
275             need_resume = !qmp_oob_enabled(mon) ||
276                 mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
277             qemu_mutex_unlock(&mon->qmp_queue_lock);


Please try the following patch. It fixes the problem for me.

Kevin


diff --git a/monitor/monitor.c b/monitor/monitor.c
index ceffe1a83b..84222cd130 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -632,23 +632,9 @@ void monitor_cleanup(void)
         iothread_stop(mon_iothread);
     }
 
-    /* Flush output buffers and destroy monitors */
-    qemu_mutex_lock(&monitor_lock);
-    monitor_destroyed = true;
-    while (!QTAILQ_EMPTY(&mon_list)) {
-        Monitor *mon = QTAILQ_FIRST(&mon_list);
-        QTAILQ_REMOVE(&mon_list, mon, entry);
-        /* Permit QAPI event emission from character frontend release */
-        qemu_mutex_unlock(&monitor_lock);
-        monitor_flush(mon);
-        monitor_data_destroy(mon);
-        qemu_mutex_lock(&monitor_lock);
-        g_free(mon);
-    }
-    qemu_mutex_unlock(&monitor_lock);
-
     /*
-     * The dispatcher needs to stop before destroying the I/O thread.
+     * The dispatcher needs to stop before destroying the monitor and
+     * the I/O thread.
      *
      * We need to poll both qemu_aio_context and iohandler_ctx to make
      * sure that the dispatcher coroutine keeps making progress and
@@ -665,6 +651,21 @@ void monitor_cleanup(void)
                    (aio_poll(iohandler_get_aio_context(), false),
                     qatomic_mb_read(&qmp_dispatcher_co_busy)));
 
+    /* Flush output buffers and destroy monitors */
+    qemu_mutex_lock(&monitor_lock);
+    monitor_destroyed = true;
+    while (!QTAILQ_EMPTY(&mon_list)) {
+        Monitor *mon = QTAILQ_FIRST(&mon_list);
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+        /* Permit QAPI event emission from character frontend release */
+        qemu_mutex_unlock(&monitor_lock);
+        monitor_flush(mon);
+        monitor_data_destroy(mon);
+        qemu_mutex_lock(&monitor_lock);
+        g_free(mon);
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
     if (mon_iothread) {
         iothread_destroy(mon_iothread);
         mon_iothread = NULL;


