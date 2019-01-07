Received: from eggs.gnu.org ([209.51.188.92]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggQJM-0007XW-Eg
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggQJI-0001rL-Nb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:31:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:60444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggQJF-0001oG-43
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:30:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggQJ9-0002Ue-TS
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7B6012E80D4
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 08:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jan 2019 08:16:40 -0000
From: Gerd Hoffmann <1809075@bugs.launchpad.net>
Reply-To: Bug 1809075 <1809075@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154520012723.21082.14347694074023377449.malonedeb@wampee.canonical.com>
Message-Id: <154684900083.4827.10123305490390321592.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809075] Re: Concurrency bug on keyboard events:
 capslock LED messing up keycode streams causes character misses at guest
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is no "capslock LED key event".  0xfa is KBD_REPLY_ACK, and the
device queues it in response to guest port writes.  Yes, the ack can
race with actual key events.  But IMO that isn't a bug in qemu.

Probably the linux kernel just throws away everything until it got the
ack for the port write, and that way the key event gets lost.  On
physical hardware you will not notice because it is next to impossible
to type fast enough to hit the race window.

So, go fix the kernel.

Alternatively fix vncdotool to send uppercase letters properly with
shift key pressed.  Then qemu wouldn't generate capslock key events
(that happens because qemu thinks guest and host capslock state is out
of sync) and the guests's capslock led update request wouldn't get into
the way.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809075

Title:
  Concurrency bug on keyboard events: capslock LED messing up keycode
  streams causes character misses at guest kernel

Status in QEMU:
  Invalid

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
