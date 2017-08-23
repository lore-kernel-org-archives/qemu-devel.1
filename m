Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkVHf-0004Dx-6G
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkVHc-00057L-1A
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:01:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:45663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkVHb-00056m-PD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:01:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkVHZ-0005r1-Cn
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 13:01:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 561E42E861E
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 13:01:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2017 12:51:02 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1712564 <1712564@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150349266290.16960.17282757508682806782.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1712564] [NEW] loadvm fails twice in sequence
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

13:38:23) shorne_: Hello, I was doing some testing with migrations for my O=
penRISC SMP patch set, I noticed something that looks like a bug, wondering=
 if someone else wants to confirm
(13:38:47) shorne_: Basically, calling loadvm 2 times causes crash
(13:38:54) shorne_:    migration/savevm.c:    qemu_event_set(&mis->main_thr=
ead_load_event)
(13:38:54) stefanha: fam: Here is my take at this change: https://paste.deb=
ian.net/982690/
(13:38:56) shorne_:                             assert(ev->initialized)  - =
fails inside
(13:39:32) stefanha: quintela davidgiluk: ^
(13:41:23) ***davidgiluk looks
(13:41:40) shorne_: c096358e747 util/qemu-thread-posix.c (Fam Zheng        =
      2017-07-04 20:23:25 +0800 397)     assert(ev->initialized);
(13:41:51) davidgiluk: shorne_: So you're doing a loadvm to load a snapshot=
 and then again?
(13:42:02) shorne_: Looks like adding that assert() was done really recently
(13:42:41) shorne_: yes, just loadvm 'a' ... then wait a bit longer, loadvm=
 'a' again (confirm clocks go back etc)
(13:42:50) stefanha: fam: While you're having dinner I'll work on turning m=
y script into a qemu-iotests test case that we can merge.
(13:44:03) gpiccoli [~gpiccoli@0002093a.user.oftc.net] entered the room.
(13:44:21) davidgiluk: shorne_: Well, it looks like the c09635 assert is a =
sanity check to make sure we didn't do anything stupid, and well.....
(13:44:57) pm215: migration_incoming_get_current() and migration_incoming_s=
tate_destroy() seem a bit mismatched
(13:45:13) davidgiluk: pm215: Yep
(13:45:46) davidgiluk: pm215: Generally we've thought that an incoming migr=
ation normally only happens once - shorne_'s case is the exception
(13:46:03) shorne_: pm215: yeah, it looked something like that I just had a=
 few seconds to look at today
(13:46:03) HariharanTS left the room (quit: Ping timeout: 480 seconds).
(13:46:03) shorne_ is now known as shorne
(13:48:05) shorne: davidgiluk: pm215: thanks for having a look.  Unfortunat=
ely I need to head off to bed and put kids to sleep
(13:49:11) davidgiluk: shorne: Sleep well, no nightmares about event destro=
yers....
(13:49:30) davidgiluk: pm215: Yeh this is fall out from b4b076daf32

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712564

Title:
  loadvm fails twice in sequence

Status in QEMU:
  New

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
