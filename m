Received: from eggs.gnu.org ([2001:4830:134:3::10]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crIuK-00088i-Ll
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crIuH-0007Jv-J5
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:41:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:38414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1crIuH-0007Ji-CX
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:41:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1crIuF-0001ld-ET
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:41:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BAFD2E80C1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:41:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2017 06:29:50 -0000
From: Brendan Shanks <brendan@bslabs.net>
Reply-To: Bug 1675108 <1675108@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
Message-Id: <20170324062950.30507.96974.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1675108] Re: Cocoa UI always crashes on startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Tested on 10.12.3, it doesn't crash immediately (like before) but
crashes reliably once I send some keyboard input to qemu:

$ i386-softmmu/qemu-system-i386 =

**
ERROR:/Users/pip/no_backup/qemu/translate-common.c:34:tcg_handle_interrupt:=
 assertion failed: (qemu_mutex_iothread_locked())
Abort trap: 6


Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
0   libsystem_kernel.dylib        	0x00007fffa746edd6 __pthread_kill + 10
1   libsystem_pthread.dylib       	0x00007fffa755a787 pthread_kill + 90
2   libsystem_c.dylib             	0x00007fffa73d4420 abort + 129
3   libglib-2.0.0.dylib           	0x00000001076aec86 g_assertion_message +=
 388
4   libglib-2.0.0.dylib           	0x00000001076aece4 g_assertion_message_e=
xpr + 94
5   qemu-system-i386              	0x00000001066bb1ec tcg_handle_interrupt =
+ 156 (translate-common.c:50)
6   qemu-system-i386              	0x0000000106740dfc pic_irq_request + 156=
 (pc.c:187)
7   qemu-system-i386              	0x000000010673e5e4 gsi_handler + 36 (pc.=
c:115)
8   qemu-system-i386              	0x000000010685e97a kbd_update_kbd_irq + =
138 (pckbd.c:180)
9   qemu-system-i386              	0x000000010694164a qemu_input_event_send=
_impl + 938 (input.c:328)
10  qemu-system-i386              	0x000000010694188f qemu_input_event_send=
_key + 239 (input.c:359)
11  qemu-system-i386              	0x0000000106946a00 cocoa_refresh + 272 (=
cocoa.m:1402)
12  qemu-system-i386              	0x000000010693f6a8 gui_update + 104 (con=
sole.c:1603)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1675108

Title:
  Cocoa UI always crashes on startup

Status in QEMU:
  New

Bug description:
  Commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5 ("ui/console: ensure
  graphic updates don't race with TCG vCPUs") causes the graphic update
  to run on a non-main thread, which Cocoa is not happy with. It crashes
  immediately after startup.

  $ i386-softmmu/qemu-system-i386 =

  2017-03-22 10:09:25.113 qemu-system-i386[15968:9538245] *** Terminating a=
pp due to uncaught exception 'NSInternalInconsistencyException', reason: 'n=
extEventMatchingMask should only be called from the Main Thread!'
  *** First throw call stack:
  (
  	0   CoreFoundation                      0x00007fff91e72e7b __exceptionPr=
eprocess + 171
  	1   libobjc.A.dylib                     0x00007fffa6a5ccad objc_exceptio=
n_throw + 48
  	2   AppKit                              0x00007fff900953fd -[NSApplicati=
on(NSEvent) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 4471
  	3   qemu-system-i386                    0x0000000104f75a49 cocoa_refresh=
 + 233
  	4   qemu-system-i386                    0x0000000104e0312c process_queue=
d_cpu_work + 140
  	5   qemu-system-i386                    0x0000000104d1a73c qemu_tcg_rr_c=
pu_thread_fn + 284
  	6   libsystem_pthread.dylib             0x00007fffa7557aab _pthread_body=
 + 180
  	7   libsystem_pthread.dylib             0x00007fffa75579f7 _pthread_body=
 + 0
  	8   libsystem_pthread.dylib             0x00007fffa75571fd thread_start =
+ 13
  )
  libc++abi.dylib: terminating with uncaught exception of type NSException
  Abort trap: 6

  System: macOS 10.12.3, Xcode 8.2.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1675108/+subscriptions
