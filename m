Received: from eggs.gnu.org ([2001:4830:134:3::10]:58276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8lnv-00071I-HQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8lns-0002yr-Cj
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:57930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8lns-0002x1-60
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:30:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8lnq-0006LS-Fc
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 11:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 741772E80C9
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 11:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Oct 2017 11:25:03 -0000
From: Geoffrey McRae <1722884@bugs.launchpad.net>
Reply-To: Bug 1722884 <1722884@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150774787109.964.13450141235232669497.malonedeb@chaenomeles.canonical.com>
Message-Id: <150927630377.3780.8211816102555574486.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722884] Re: keyboard input while mouse moving
 triggers mouse failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I believe I am onto the cause of this issue, because the input events
are coming from a multi threaded source (in my instance spice) keyboard
and mouse input share common code paths without any thread interlocking.

Since keyboard input takes priority over mouse, when more mouse events
are being handled it is overwriting and swapping out the data the guest
was expecting with mouse input data.

In short, there is a race condition here.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722884

Title:
  keyboard input while mouse moving triggers mouse failure

Status in QEMU:
  New

Bug description:
  When QEMU is getting a ton of mouse input events if keys are pressed
  on the keyboard the scan code will be corrupted causing erroneous
  behavior. I have confirmed this problem in the latest version in git
  (530049bc1dcc24c1178a29d99ca08b6dd08413e0).

  After the erroneous behavior the operating system issues a keyboard
  reset which prevents the mouse from functioning until the operating
  system is restarted.

  This seems to only occur if the PS2 mouse is being used as the input,
  the tablet input device doesn't exhibit this behavior.

  The same problem was reported here also:
  https://openxt.atlassian.net/browse/OXT-562

  Host  : Debian 9
  CPU   : Ryzen 1700X
  RAM   : 16GB
  Kernel: 4.12.0-0.bpo.2-amd64

  Guest : Windows 10 (KVM)
  RAM   : 8GB (1GB Huge pages)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722884/+subscriptions
