Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAH9q-00078y-2W
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAH9m-0008Rz-3H
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:11:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:44246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAH9l-0008R3-Sk
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:11:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAH9i-000469-8u
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 15:11:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C18C2E806F
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 15:11:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Nov 2017 15:01:45 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1712564 <1712564@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150349266290.16960.17282757508682806782.malonedeb@gac.canonical.com>
Message-Id: <150963490628.9512.6603300950233650651.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1712564] Re: loadvm fails twice in sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 5089e1862fe80b6f23ba4c494e2902cbe3d9d48e

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712564

Title:
  loadvm fails twice in sequence

Status in QEMU:
  Fix Committed

Bug description:
  13:38:23) shorne_: Hello, I was doing some testing with migrations for my=
 OpenRISC SMP patch set, I noticed something that looks like a bug, wonderi=
ng if someone else wants to confirm
  (13:38:47) shorne_: Basically, calling loadvm 2 times causes crash
  (13:38:54) shorne_:    migration/savevm.c:    qemu_event_set(&mis->main_t=
hread_load_event)
  (13:38:54) stefanha: fam: Here is my take at this change: https://paste.d=
ebian.net/982690/
  (13:38:56) shorne_:                             assert(ev->initialized)  =
- fails inside
  (13:39:32) stefanha: quintela davidgiluk: ^
  (13:41:23) ***davidgiluk looks
  (13:41:40) shorne_: c096358e747 util/qemu-thread-posix.c (Fam Zheng      =
        2017-07-04 20:23:25 +0800 397)     assert(ev->initialized);
  (13:41:51) davidgiluk: shorne_: So you're doing a loadvm to load a snapsh=
ot and then again?
  (13:42:02) shorne_: Looks like adding that assert() was done really recen=
tly
  (13:42:41) shorne_: yes, just loadvm 'a' ... then wait a bit longer, load=
vm 'a' again (confirm clocks go back etc)
  (13:42:50) stefanha: fam: While you're having dinner I'll work on turning=
 my script into a qemu-iotests test case that we can merge.
  (13:44:03) gpiccoli [~gpiccoli@0002093a.user.oftc.net] entered the room.
  (13:44:21) davidgiluk: shorne_: Well, it looks like the c09635 assert is =
a sanity check to make sure we didn't do anything stupid, and well.....
  (13:44:57) pm215: migration_incoming_get_current() and migration_incoming=
_state_destroy() seem a bit mismatched
  (13:45:13) davidgiluk: pm215: Yep
  (13:45:46) davidgiluk: pm215: Generally we've thought that an incoming mi=
gration normally only happens once - shorne_'s case is the exception
  (13:46:03) shorne_: pm215: yeah, it looked something like that I just had=
 a few seconds to look at today
  (13:46:03) HariharanTS left the room (quit: Ping timeout: 480 seconds).
  (13:46:03) shorne_ is now known as shorne
  (13:48:05) shorne: davidgiluk: pm215: thanks for having a look.  Unfortun=
ately I need to head off to bed and put kids to sleep
  (13:49:11) davidgiluk: shorne: Sleep well, no nightmares about event dest=
royers....
  (13:49:30) davidgiluk: pm215: Yeh this is fall out from b4b076daf32

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1712564/+subscriptions
