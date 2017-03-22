Received: from eggs.gnu.org ([2001:4830:134:3::10]:48597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqkAu-00018l-Qr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqkAq-0005HH-US
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:36370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqkAq-0005Fo-J8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqkAo-0007HN-Fa
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:35:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4786A2E80EB
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:35:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Mar 2017 17:26:21 -0000
From: Brendan Shanks <brendan@bslabs.net>
Reply-To: Bug 1675108 <1675108@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5 ("ui/console: ensure
graphic updates don't race with TCG vCPUs") causes the graphic update to
run on a non-main thread, which Cocoa is not happy with. It crashes
immediately after startup.

$ i386-softmmu/qemu-system-i386 =

2017-03-22 10:09:25.113 qemu-system-i386[15968:9538245] *** Terminating app=
 due to uncaught exception 'NSInternalInconsistencyException', reason: 'nex=
tEventMatchingMask should only be called from the Main Thread!'
*** First throw call stack:
(
	0   CoreFoundation                      0x00007fff91e72e7b __exceptionPrep=
rocess + 171
	1   libobjc.A.dylib                     0x00007fffa6a5ccad objc_exception_=
throw + 48
	2   AppKit                              0x00007fff900953fd -[NSApplication=
(NSEvent) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 4471
	3   qemu-system-i386                    0x0000000104f75a49 cocoa_refresh +=
 233
	4   qemu-system-i386                    0x0000000104e0312c process_queued_=
cpu_work + 140
	5   qemu-system-i386                    0x0000000104d1a73c qemu_tcg_rr_cpu=
_thread_fn + 284
	6   libsystem_pthread.dylib             0x00007fffa7557aab _pthread_body +=
 180
	7   libsystem_pthread.dylib             0x00007fffa75579f7 _pthread_body +=
 0
	8   libsystem_pthread.dylib             0x00007fffa75571fd thread_start + =
13
)
libc++abi.dylib: terminating with uncaught exception of type NSException
Abort trap: 6

System: macOS 10.12.3, Xcode 8.2.1

** Affects: qemu
     Importance: Undecided
         Status: New

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
