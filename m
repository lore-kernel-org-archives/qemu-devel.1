Received: from eggs.gnu.org ([2001:4830:134:3::10]:46325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZVDl-0002zO-8Y
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZVDh-0000cv-7U
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:20:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:34858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZVDh-0000bv-0L
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:20:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZVDf-0000QF-SJ
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 06:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CAA542E80C8
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 06:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Dec 2018 06:15:27 -0000
From: Gao <1809075@bugs.launchpad.net>
Reply-To: Bug 1809075 <1809075@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154520012723.21082.14347694074023377449.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809075] [NEW] Concurrency bug on keyboard
 events: capslock LED messing up keycode streams causes character misses at
 guest kernel
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

Whenever capslock is pressed on host, both capslock keycode(0x3a 0xba)
and capslock LED keycode(0xfa 0xfa) would be sent to the ps2 keycode
stream.

However, capslock LED is handled by another thread, confirmed by tracing
`ps2_write_keyboard` with gdb. The keycode of casplock LED might divide

For example, I sent AaBb but got ABa. I was using vncdotool, so it
equals sending `capslock a capslock a capslock b capslock b`. In
ps2_queue, I was expecting `3a fa fa ba 1e 9e 3a fa fa ba 1e 9e 3a fa fa
ba 30 b0 3a fa fa ba 30 b0`. But actually once in a while, it might not
receive such streams. In one case I got `3a fa fa ba 1e 9e 3a ba 1e fa
fa 9e 3a ba 30 b0 3a ba 30 b0 fa fa`

In this specific example, `a` was lost because LED keycode 'jumps in' its k=
eycode. Kernel event device receives below streams
```
# /dev/input/event receives    what is sent from ps2_queue
# I use cap_1 to show capslock key down
cap_1   led     caps_0,        # 0x3a 0xfa 0xfa 0xba
a_1     a_0                    # 0x1e 0x9e
caps_1  caps_0                 # 0x3a 0xba
led                            # 0x1e 0xfa 0xfa 0x1e (we lost `a` here)
caps_1  caps_0                 # 0x3a 0xba
b_1     led     b_0            # 0x30 0xfa 0xfa 0xb0 =

caps_1  caps_0                 # 0x3a 0xba
led     b_1     b_0            # 0xfa 0xfa 0x30 0xb0
```

I made sure kernel receives the correct key stream as the qemu ps2_queue
sends using /proc, ftrace and dynamic_debug. I explained the details in
this [post](https://medium.com/@alapha23/quick-peek-into-kernel-land-
keyboard-events-handling-with-ftrace-and-dynamic-debug-24a790056d5a)

So it seems to be a concurrency issue.

A hacky path on my mind is to skip all `0xfa` in ps2_queue. But I'm not
sure if capslock LED is the only stink bug to our ps2 keycode queue as
I've seen other keycodes handled by `ps2_write_keyboard` sent to ps2
queue.

Another solution might be a memory barrier or a lock. Making key down
and key up atomic will prevent another thread modifying the ps2 queue
unwantedly.

What do you think?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809075

Title:
  Concurrency bug on keyboard events: capslock LED messing up keycode
  streams causes character misses at guest kernel

Status in QEMU:
  New

Bug description:
  Whenever capslock is pressed on host, both capslock keycode(0x3a 0xba)
  and capslock LED keycode(0xfa 0xfa) would be sent to the ps2 keycode
  stream.

  However, capslock LED is handled by another thread, confirmed by
  tracing `ps2_write_keyboard` with gdb. The keycode of casplock LED
  might divide

  For example, I sent AaBb but got ABa. I was using vncdotool, so it
  equals sending `capslock a capslock a capslock b capslock b`. In
  ps2_queue, I was expecting `3a fa fa ba 1e 9e 3a fa fa ba 1e 9e 3a fa
  fa ba 30 b0 3a fa fa ba 30 b0`. But actually once in a while, it might
  not receive such streams. In one case I got `3a fa fa ba 1e 9e 3a ba
  1e fa fa 9e 3a ba 30 b0 3a ba 30 b0 fa fa`

  In this specific example, `a` was lost because LED keycode 'jumps in' its=
 keycode. Kernel event device receives below streams
  ```
  # /dev/input/event receives    what is sent from ps2_queue
  # I use cap_1 to show capslock key down
  cap_1   led     caps_0,        # 0x3a 0xfa 0xfa 0xba
  a_1     a_0                    # 0x1e 0x9e
  caps_1  caps_0                 # 0x3a 0xba
  led                            # 0x1e 0xfa 0xfa 0x1e (we lost `a` here)
  caps_1  caps_0                 # 0x3a 0xba
  b_1     led     b_0            # 0x30 0xfa 0xfa 0xb0 =

  caps_1  caps_0                 # 0x3a 0xba
  led     b_1     b_0            # 0xfa 0xfa 0x30 0xb0
  ```

  I made sure kernel receives the correct key stream as the qemu
  ps2_queue sends using /proc, ftrace and dynamic_debug. I explained the
  details in this [post](https://medium.com/@alapha23/quick-peek-into-
  kernel-land-keyboard-events-handling-with-ftrace-and-dynamic-debug-
  24a790056d5a)

  So it seems to be a concurrency issue.

  A hacky path on my mind is to skip all `0xfa` in ps2_queue. But I'm
  not sure if capslock LED is the only stink bug to our ps2 keycode
  queue as I've seen other keycodes handled by `ps2_write_keyboard` sent
  to ps2 queue.

  Another solution might be a memory barrier or a lock. Making key down
  and key up atomic will prevent another thread modifying the ps2 queue
  unwantedly.

  What do you think?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809075/+subscriptions
