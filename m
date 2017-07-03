Received: from eggs.gnu.org ([2001:4830:134:3::10]:60002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRySO-0006Dm-At
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRySN-0004pQ-Ij
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:19:52 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dRySN-0004ou-Az
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:19:51 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so231987592wrb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:19:51 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 11:19:29 +0100
Message-ID: <CAFEAcA9CBus3ibcqB7W3vhifoAxthu0bstixtAKQ4TkAW-XODg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] what is the USB 'maxframes' parameter for and what is
 its maximum value?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi; I've been idly looking through our fairly small number of
remaining Coverity issues, and one of them is in hw/usb/hcd-ehci.c:
in ehci_work_bh() we do:
        if (uframes > (ehci->maxframes * 8)) {

but if maxframes is very large then the multiply will overflow
a 32-bit integer. (CID 1375885)

We could shut up Coverity by forcing a 64-bit multiply, but that
doesn't really seem like the right approach -- maxframes is a
user-settable parameter whose default is 128 and values as big
as 2^30 seem like they probably aren't valid. So perhaps we should
handle this by having the device sanity-check the user-provided
value at startup.

Unfortunately there doesn't seem to be any documentation on what
the 'maxframes' property is for or what its valid values are.
Digging through git history this was added in commit 16a2dee6b98
whose commit message briefly says it's the upper limit for how many
frames we process at once, but I'm not familiar enough with
USB to be able to translate that into what the valid range
might be.

thanks
-- PMM
