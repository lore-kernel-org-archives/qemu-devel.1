Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED3C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588A520870
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588A520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bwidawsk.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS30e-0005b8-Dz
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kS2t3-0002o9-66
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:49:33 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:48650
 helo=mail.bwidawsk.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kS2t0-0006NX-Pa
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:49:32 -0400
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
 id 9CDB7122C76; Mon, 12 Oct 2020 11:49:28 -0700 (PDT)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net
 [73.37.61.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by mail.bwidawsk.net (Postfix) with ESMTPSA id 7851C122C73;
 Mon, 12 Oct 2020 11:49:21 -0700 (PDT)
Date: Mon, 12 Oct 2020 11:49:19 -0700
From: Ben Widawsky <ben@bwidawsk.net>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
Message-ID: <20201012184919.d4ivnajku6ydewpm@mail.bwidawsk.net>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <87zh4rzpot.fsf@linaro.org>
 <20201012112506.GC7777@merkur.fritz.box>
 <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
 <20201012124743.GD7777@merkur.fritz.box>
 <87r1q3zdv9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1q3zdv9.fsf@linaro.org>
Received-SPF: none client-ip=107.170.211.233; envelope-from=ben@bwidawsk.net;
 helo=mail.bwidawsk.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 14:49:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.4,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-10-12 16:02:34, Alex Bennée wrote:
> 
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 12.10.2020 um 13:53 hat Philippe Mathieu-Daudé geschrieben:
> >> On 10/12/20 1:25 PM, Kevin Wolf wrote:
> >> > Am 12.10.2020 um 12:47 hat Alex Bennée geschrieben:
> >> > > 
> >> > > Markus Armbruster <armbru@redhat.com> writes:
> >> > > 
> >> > > > From: Kevin Wolf <kwolf@redhat.com>
> >> > > > 
> >> > > > This moves the QMP dispatcher to a coroutine and runs all QMP command
> >> > > > handlers that declare 'coroutine': true in coroutine context so they
> >> > > > can avoid blocking the main loop while doing I/O or waiting for other
> >> > > > events.
> >> > > 
> >> > > This subtly changes the replay behaviour leading to a hang in:
> >> > > 
> >> > >    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2…)|✚1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> >> > >    Fetching asset from tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> >> > >    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
> >> > >    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12T11.40-ec11fd2/job.log
> >> > >     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt: ERROR: Could not perform graceful shutdown (26.27 s)
> >> > >    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> >> > >    JOB TIME   : 27.77 s
> >> > > 
> >> > > Looking at the log:
> >> > > 
> >> > >    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.887411] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UTC (1602499231)
> >> > >    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.887431] sr_init: No PMIC hook to init smartreflex
> >> > >    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.897193] uart-pl011 9000000.pl011: no DMA platform data
> >> > >    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.897242] md: Waiting for all devices to be available before autodetect
> >> > >    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.897259] md: If you don't use raid, use raid=noautodetect
> >> > >    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.897819] md: Autodetecting RAID arrays.
> >> > >    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.897832] md: autorun ...
> >> > >    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.897842] md: ... autorun DONE.
> >> > >    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.897962] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> >> > >    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
> >> > >    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'timestamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN', 'data': {'guest': True, 'reason': 'guest-reset'}}
> >> > >    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu received signal 6; command: "./qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:console -icount shift=1,rr=record,rrfile=/var/tmp/avocado_n00stdrf/avocado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot"
> >> > 
> >> > This looks like a crash (SIGABRT) rather than a hang. Do you have a
> >> > stack trace for the crashed process?
> >> 
> >> No crash, exit(0):
> >
> > Why does the log say "qemu received signal 6" then?
> >
> >> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> >
> > Alex has this error in the logs before this commit, so I assume this is
> > expected. All of the following is then probably expected, too, because
> > it follows directly from this error:
> >
> >> Please append a correct "root=" boot option; here are the available
> >> partitions:
> >> Kernel panic - not syncing: VFS: Unable to mount root fs on
> >> unknown-block(0,0)
> >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #1
> >> Hardware name: Generic DT based system
> >> [<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0x24)
> >> [<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
> >> [<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
> >> [<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec)
> >> [<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0x90)
> >> [<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c/0x19c)
> >> [<c1101ac4>] (prepare_namespace) from [<c11012e8>]
> >> (kernel_init_freeable+0x2c0/0x370)
> >> [<c11012e8>] (kernel_init_freeable) from [<c0b63914>]
> >> (kernel_init+0x18/0x128)
> >> [<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> >> Exception stack(0xc790bfb0 to 0xc790bff8)
> >> bfa0:                                     00000000 00000000 00000000
> >> 00000000
> >> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >> 00000000
> >> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >> 
> >> -> PSCI call
> >>    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
> >>       -> SHUTDOWN_CAUSE_GUEST_RESET
> >>          -> exit(0)
> 
> Yes - the test is recording the kernel up until the point it gives up.
> 
> > Hm... So you're saying that the test sends a 'quit' QMP command, but
> > before it could be processed, the guest causes QEMU to exit, so the test
> > will never receive a reply to its request?
> >
> > If commit 9ce44e2ce2 changes anything about this, it seems to me that it
> > would be that more QMP commands are processed during monitor_cleanup()
> > because it doesn't just delete the dispatcher BH, but waits until it's
> > not busy any more.
> >
> > Looking at this code again, however, the order in monitor_cleanup() is
> > probably wrong. We should first shut down the dispatcher (which may
> > still be using Monitor objects) and then destroy the monitors. This
> > could possibly explain a crash, but probably not wrong results with a
> > successful shutdown.
> 
> I suspect this is a race between QEMU shutting down because the guest
> shut it down and the acceptance test trying to shut things down via QMP.
> I think the proper fix is either to:

I'm not sure my problem is the same, but I do have the same symptom.

> 
>   - s/panic=-1/panic=0/ in the command line (and probably drop --no-reboot)
> 
> which would let the acceptance test cleanly shutdown via QMP.

I tried this, which works well on some of the platforms which were failing.
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-1 '
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-0 '

     def run_vm(self, kernel_path, kernel_command_line, console_pattern,
                record, shift, args, replay_path):
@@ -47,8 +47,8 @@ class ReplayKernel(LinuxKernelTest):
                     (shift, mode, replay_path),
                     '-kernel', kernel_path,
                     '-append', kernel_command_line,
-                    '-net', 'none',
-                    '-no-reboot')
+                    '-net', 'none'
+                    )
         if args:
             vm.add_args(*args)
         vm.launch()
@@ -154,7 +154,7 @@ class ReplayKernel(LinuxKernelTest):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0,115200 '
                                'usbcore.nousb '
-                               'panic=-1 noreboot')
+                               'panic=-0')
         console_pattern = 'Boot successful.'

> 
>   - modify the test to declare that qemu will shutdown itself and
>     therefor no "quit" needs to be sent
> 
> WDYT?
> 
> -- 
> Alex Bennée
> 

