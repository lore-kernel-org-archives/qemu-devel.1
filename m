Received: from eggs.gnu.org ([209.51.188.92]:58591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOB-000512-PM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNO4-0003lG-Rx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNO4-0003kY-IK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:12 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:47 +0000
Message-Id: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/9] Dealing with Null devices in
 usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, darren.kenny@oracle.com

This series is in response to feedback from Gerd Hoffman (below) on 
<1548859022-3969-1-git-send-email-liam.merwick@oracle.com>

Instead of checking if usb_ep_get() returns NULL, ensure it never is passed
a NULL device.

===

The usb device emulation (hw/usb/dev-*.c) never ever calls usb_ep_get()
with dev == NULL.  There are some places in usb host adapter emulation
(hw/usb/hcd-*) which might do this.  uhci for example has this ...

	[ ... ]
        USBDevice *dev = uhci_find_device(s, (td->token >> 8) & 0x7f);
        USBEndpoint *ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);

        if (ep == NULL) {
	[ ... ]

... and uhci_find_device can return NULL.

So, I'd suggest to check all usb_ep_get() callers, fix them if needed,
then remove the 'if (dev== NULL)' check in usb_ep_get() and add the
assert() instead.

===

Passes QEMU 'make check' and kvm-unit-tests


Liam Merwick (9):
  usb: rearrange usb_ep_get()
  xhci: add asserts to help with static code analysis
  xhci: check device is not NULL before calling usb_ep_get()
  ehci: check device is not NULL before calling usb_ep_get()
  ohci: check device is not NULL before calling usb_ep_get()
  uhci: check device is not NULL before calling usb_ep_get()
  usb: check device is not NULL before calling usb_ep_get()
  usb: add device checks before redirector calls to usb_ep_get()
  usb: remove unnecessary NULL device check from usb_ep_get()

 hw/usb/core.c     | 6 ++----
 hw/usb/hcd-ehci.c | 7 +++++--
 hw/usb/hcd-musb.c | 8 ++++----
 hw/usb/hcd-ohci.c | 8 ++++++++
 hw/usb/hcd-uhci.c | 8 +++++---
 hw/usb/hcd-xhci.c | 6 ++++--
 hw/usb/redirect.c | 3 ++-
 7 files changed, 30 insertions(+), 16 deletions(-)

-- 
1.8.3.1
