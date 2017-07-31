Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc885-0000nb-0T
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc881-0000yA-Tv
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:40:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:33983)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc881-0000xe-D0
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:40:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <93cb052b-78fb-6934-fd35-1d2805090d2a@msgid.tls.msk.ru>
Date: Mon, 31 Jul 2017 13:40:48 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] xhci: guard xhci_kick_epctx against recursive calls
 for 2.8?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

After applying commit 96d87bdda3919bb16f754b3d3fd1227e1f38f13c:

Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Thu Feb 2 12:36:12 2017 +0100

    xhci: guard xhci_kick_epctx against recursive calls

    Track xhci_kick_epctx processing being active in a variable.  Check the
    variable before calling xhci_kick_epctx from xhci_kick_ep.  Add an
    assert to make sure we don't call recursively into xhci_kick_epctx.

    Cc: 1653384@bugs.launchpad.net
    Fixes: 94b037f2a451b3dc855f9f2c346e5049a361bd55
    Reported-by: Fabian Lesniak <fabian@lesniak-it.de>
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Message-id: 1486035372-3621-1-git-send-email-kraxel@redhat.com
    Message-id: 1485790607-31399-5-git-send-email-kraxel@redhat.com

to 2.8, to fix the CVE-2017-9375 in 2.8, it starts to fail at
startup with the assertion failure introduced in this commit:

 hw/usb/hcd-xhci.c:2169: xhci_kick_epctx: Assertion `!epctx->kick_active' failed.

The commit itself looks sane, but might be there were other
fixes before this one, on top of 2.8, required for it to
functioning properly?  I'm not sure I understand the xhci
machinery right.

Gerd, can you shed some light on this please?

Thank you!

/mjt
