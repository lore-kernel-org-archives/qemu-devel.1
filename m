Received: from eggs.gnu.org ([209.51.188.92]:37808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMc1E-0000CN-Tm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMc1D-00013i-K9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:30:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:48596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hMc1D-00013M-Ed
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hMc1C-0000kI-6D
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 17:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E1C92E80C8
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 17:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 May 2019 17:18:43 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1823998 <1823998@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155483243569.8652.5979441352991477638.malonedeb@wampee.canonical.com>
Message-Id: <155690392372.7023.12149440909448128725.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823998] Re: qemu-system-aarch64: support kernels
 bigger than 128MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've submitted a patchset which I think should fix this, but if you
could test that it actually does handle large images correctly that
would be great.

https://patchew.org/QEMU/20190503171347.13747-1-peter.maydell@linaro.org/


** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823998

Title:
  qemu-system-aarch64: support kernels bigger than 128MiB

Status in QEMU:
  In Progress

Bug description:
  Presently QEMU reserves up to 128MiB of space for an arm64 Linux
  kernel, placing the initrd following this, and the dtb following the
  initrd.

  This is not sufficient for some debug configurations of the kernel,
  which can be larger than 128MiB. Depending on the relative size of the
  kernel Image and unpopulated BSS, the dtb (or kernel) will be
  clobbered by the other, resulting in a silent boot failure.

  Since v3.17, the kernel Image header exposes a field called
  image_size, which describes the entire size of the kernel (including
  unpopulated sections such as the BSS) as a 64-bit little-endian value.
  For kernels prior to v3.17, this field is zero. This is documented at:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/arm64/booting.txt?h=3Dv5.0#n68

  It would be great if QEMU could take the image_size field into account
  when placing the initrd and dtb to avoid overlap with the kernel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823998/+subscriptions
