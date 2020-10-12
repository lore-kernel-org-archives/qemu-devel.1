Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5532AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB9921BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXDn5+La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB9921BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxJQ-0004LH-L4
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kRxFD-0007WA-Gp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kRxF6-0000VK-N8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTWHdeRtP5xmmHWwlKlm/i9n1cfNpQUBK+FGvm6Sd90=;
 b=BXDn5+LaMwLg+ka/HZWjzsFUWeNBQvGCf6Dsfa85XhyL1sgt1Kj12tnRcIDEeU8kNir7hm
 uRuUaWQyWhHE7OXhLHWhWAnn9o98/ksK46EEcrpKLDlHa2BsRJgiTHxbferOI5Q9Ch9nus
 9D/L5QfNte5y9haE50q2+qmYQ+bEofk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-uQ3aCrqhM02wpvVjX0l7fw-1; Mon, 12 Oct 2020 08:47:53 -0400
X-MC-Unique: uQ3aCrqhM02wpvVjX0l7fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF8C59;
 Mon, 12 Oct 2020 12:47:52 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E94DA5C22B;
 Mon, 12 Oct 2020 12:47:44 +0000 (UTC)
Date: Mon, 12 Oct 2020 14:47:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
Message-ID: <20201012124743.GD7777@merkur.fritz.box>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <87zh4rzpot.fsf@linaro.org>
 <20201012112506.GC7777@merkur.fritz.box>
 <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
MIME-Version: 1.0
In-Reply-To: <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.10.2020 um 13:53 hat Philippe Mathieu-Daudé geschrieben:
> On 10/12/20 1:25 PM, Kevin Wolf wrote:
> > Am 12.10.2020 um 12:47 hat Alex Bennée geschrieben:
> > > 
> > > Markus Armbruster <armbru@redhat.com> writes:
> > > 
> > > > From: Kevin Wolf <kwolf@redhat.com>
> > > > 
> > > > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > > > handlers that declare 'coroutine': true in coroutine context so they
> > > > can avoid blocking the main loop while doing I/O or waiting for other
> > > > events.
> > > 
> > > This subtly changes the replay behaviour leading to a hang in:
> > > 
> > >    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2…)|✚1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> > >    Fetching asset from tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
> > >    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
> > >    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12T11.40-ec11fd2/job.log
> > >     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt: ERROR: Could not perform graceful shutdown (26.27 s)
> > >    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> > >    JOB TIME   : 27.77 s
> > > 
> > > Looking at the log:
> > > 
> > >    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.887411] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UTC (1602499231)
> > >    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.887431] sr_init: No PMIC hook to init smartreflex
> > >    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.897193] uart-pl011 9000000.pl011: no DMA platform data
> > >    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.897242] md: Waiting for all devices to be available before autodetect
> > >    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.897259] md: If you don't use raid, use raid=noautodetect
> > >    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.897819] md: Autodetecting RAID arrays.
> > >    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.897832] md: autorun ...
> > >    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.897842] md: ... autorun DONE.
> > >    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.897962] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> > >    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
> > >    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'timestamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN', 'data': {'guest': True, 'reason': 'guest-reset'}}
> > >    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu received signal 6; command: "./qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:console -icount shift=1,rr=record,rrfile=/var/tmp/avocado_n00stdrf/avocado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot"
> > 
> > This looks like a crash (SIGABRT) rather than a hang. Do you have a
> > stack trace for the crashed process?
> 
> No crash, exit(0):

Why does the log say "qemu received signal 6" then?

> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6

Alex has this error in the logs before this commit, so I assume this is
expected. All of the following is then probably expected, too, because
it follows directly from this error:

> Please append a correct "root=" boot option; here are the available
> partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #1
> Hardware name: Generic DT based system
> [<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0x24)
> [<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
> [<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
> [<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec)
> [<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0x90)
> [<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c/0x19c)
> [<c1101ac4>] (prepare_namespace) from [<c11012e8>]
> (kernel_init_freeable+0x2c0/0x370)
> [<c11012e8>] (kernel_init_freeable) from [<c0b63914>]
> (kernel_init+0x18/0x128)
> [<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xc790bfb0 to 0xc790bff8)
> bfa0:                                     00000000 00000000 00000000
> 00000000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> -> PSCI call
>    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
>       -> SHUTDOWN_CAUSE_GUEST_RESET
>          -> exit(0)

Hm... So you're saying that the test sends a 'quit' QMP command, but
before it could be processed, the guest causes QEMU to exit, so the test
will never receive a reply to its request?

If commit 9ce44e2ce2 changes anything about this, it seems to me that it
would be that more QMP commands are processed during monitor_cleanup()
because it doesn't just delete the dispatcher BH, but waits until it's
not busy any more.

Looking at this code again, however, the order in monitor_cleanup() is
probably wrong. We should first shut down the dispatcher (which may
still be using Monitor objects) and then destroy the monitors. This
could possibly explain a crash, but probably not wrong results with a
successful shutdown.

Kevin

> > >    2020-10-12 11:40:31,734 stacktrace       L0039 ERROR|
> > >    2020-10-12 11:40:31,734 stacktrace       L0042 ERROR| Reproduced traceback from: /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/core/test.py:767
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR| Traceback (most recent call last):
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 435, in _do_shutdown
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._soft_shutdown(timeout, has_quit)
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 415, in _soft_shutdown
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._qmp.cmd('quit')
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/qmp.py", line 266, in cmd
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     return self.cmd_obj(qmp_cmd)
> > >    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/qmp.py", line 249, in cmd_obj
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     raise QMPConnectError("Unexpected empty reply from server")
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| qemu.qmp.QMPConnectError: Unexpected empty reply from server
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| The above exception was the direct cause of the following exception:
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| Traceback (most recent call last):
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 128, in test_arm_virt
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 71, in run_rr
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     True, shift, args, replay_path)
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 57, in run_vm
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     vm.shutdown()
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 465, in shutdown
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self._do_shutdown(timeout, has_quit)
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 439, in _do_shutdown
> > >    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     from exc
> > >    2020-10-12 11:40:31,737 stacktrace       L0045 ERROR| qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
> > > 
> > > The commit before:
> > > 
> > >    2020-10-12 11:44:02,803 __init__         L0085 DEBUG| [    3.897837] md: ... autorun DONE.
> > >    2020-10-12 11:44:02,806 __init__         L0085 DEBUG| [    3.897958] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> > >    2020-10-12 11:44:02,806 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
> > >    2020-10-12 11:44:02,814 qmp              L0250 DEBUG| <<< {'return': {}}
> > >    2020-10-12 11:44:02,879 replay_kernel    L0059 INFO | finished the recording with log size 237596 bytes
> > >    2020-10-12 11:44:02,879 replay_kernel    L0064 INFO | elapsed time 24.35 sec
> > >    2020-10-12 11:44:02,888 replay_kernel    L0044 INFO | replaying the execution...
> > >    2020-10-12 11:44:02,889 machine          L0362 DEBUG| VM launch command: './qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpihqswp6_/qemu-7747-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpihqswp6_/qemu-7747-console.sock,server,nowait -serial chardev:console
> > >    -icount shift=1,rr=replay,rrfile=/var/tmp/avocado_o3pfy2he/avocado_job_nf30vjqg/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot'
> > >    2020-10-12 11:44:03,001 qmp              L0245 DEBUG| >>> {'execute': 'qmp_capabilities'}
> > >    2020-10-12 11:44:03,172 qmp              L0250 DEBUG| <<< {'return': {}}
> > >    2020-10-12 11:44:04,899 __init__         L0085 DEBUG| [    0.000000] Booting Linux on physical CPU 0x0
> > >    2020-10-12 11:44:04,904 __init__         L0085 DEBUG| [    0.000000] Linux version 4.18.16-300.fc29.armv7hl (mockbuild@buildvm-armv7-06.arm.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun Oct 21 00:56:28 UTC 2018
> [...]
> 


