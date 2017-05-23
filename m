Received: from eggs.gnu.org ([2001:4830:134:3::10]:59396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dDJQc-0002iS-Bt
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dDJQX-0008Er-LY
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:41:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:42529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dDJQX-0008Ed-Dz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:41:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dDJQU-0003KR-R4
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 23:41:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CB7F42E8088
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 23:41:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 May 2017 23:32:27 -0000
From: Robert Mustacchi <1693050@bugs.launchpad.net>
Reply-To: Bug 1693050 <1693050@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149558234717.18218.15801621819682136328.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1693050] [NEW] xhci HCIVERSION register read
 emulation incorrectly handled
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

We had an illumos user trying to run illumos in QEMU 2.9.0 with the
qemu-xhci device enabled. Note, that while this was discovered against
QEMU 2.9.0, from my current read of the HEAD, it is still present. The
illumos bug at https://www.illumos.org/issues/8173 has additional
information on how the user invoked qemu. While investigating the
problem we found that the illumos driver was reading a version of 0x0000
when reading the HCIVERSION register from qemu.

In the illumos driver we're performing a 16-bit read of the version
register at offset 0x2. From looking around at other OSes, while Linux
performs a 4 byte read at offset 0x0 and masks out the version, others
that care about the version are doing a two byte read, though not all
actually act on the version and some just discard the information.

The user who hit this was able to enable tracing (note the tracing file
is attached to the illumos bug linked previously) and we hit the
unimplemented register read with offset 0x2 at
http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
xhci.c;hb=3DHEAD#l2960. The xhci register specifies today that its allowed
for users to do 1-4 byte reads; however, that it implements only four
byte reads in its implementation
(http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
xhci.c;hb=3DHEAD#l3333). Hence why when we read the HCIVERSION register at
offset 0x2, it isn't handled in xhci_cap_read() which then returns
zeros.

>From digging into this, I think that we're coming into
memory_region_dispatch_read() and then memory_region_dispatch_read1().
However, I don't see anything in either the general memory region logic
or in the xhci_cap_read() function that would deal with adjusting the
offset that we're reading at and then masking it off again. While the
access_with_adjusted_size() attempts to deal with this, it never adjusts
the hardware address that's passed in to be a multiple of the
implementation defined offset that I can see. I suspect that the FIXME
at line 582
(http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dmemory.c;hb=3DHEAD#l582) an=
d the
implementation in the xhci code is the crux of the problem.

For the time being we're working around this in the illumos driver, but
I wanted to point this out such that it might be helpful for other
systems which are assuming that they can do the two byte read like on
hardware.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693050

Title:
  xhci HCIVERSION register read emulation incorrectly handled

Status in QEMU:
  New

Bug description:
  We had an illumos user trying to run illumos in QEMU 2.9.0 with the
  qemu-xhci device enabled. Note, that while this was discovered against
  QEMU 2.9.0, from my current read of the HEAD, it is still present. The
  illumos bug at https://www.illumos.org/issues/8173 has additional
  information on how the user invoked qemu. While investigating the
  problem we found that the illumos driver was reading a version of
  0x0000 when reading the HCIVERSION register from qemu.

  In the illumos driver we're performing a 16-bit read of the version
  register at offset 0x2. From looking around at other OSes, while Linux
  performs a 4 byte read at offset 0x0 and masks out the version, others
  that care about the version are doing a two byte read, though not all
  actually act on the version and some just discard the information.

  The user who hit this was able to enable tracing (note the tracing
  file is attached to the illumos bug linked previously) and we hit the
  unimplemented register read with offset 0x2 at
  http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l2960. The xhci register specifies today that its
  allowed for users to do 1-4 byte reads; however, that it implements
  only four byte reads in its implementation
  (http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l3333). Hence why when we read the HCIVERSION register
  at offset 0x2, it isn't handled in xhci_cap_read() which then returns
  zeros.

  From digging into this, I think that we're coming into
  memory_region_dispatch_read() and then memory_region_dispatch_read1().
  However, I don't see anything in either the general memory region
  logic or in the xhci_cap_read() function that would deal with
  adjusting the offset that we're reading at and then masking it off
  again. While the access_with_adjusted_size() attempts to deal with
  this, it never adjusts the hardware address that's passed in to be a
  multiple of the implementation defined offset that I can see. I
  suspect that the FIXME at line 582
  (http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dmemory.c;hb=3DHEAD#l582) =
and
  the implementation in the xhci code is the crux of the problem.

  For the time being we're working around this in the illumos driver,
  but I wanted to point this out such that it might be helpful for other
  systems which are assuming that they can do the two byte read like on
  hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693050/+subscriptions
