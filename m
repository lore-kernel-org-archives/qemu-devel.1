Received: from eggs.gnu.org ([209.51.188.92]:44181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1guhZu-0006gr-4y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1guhZt-0002sh-DQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1guhZs-0002qO-Vg
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id z84so3278440wmg.4
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 09:47:08 -0800 (PST)
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Fri, 15 Feb 2019 18:46:58 +0100
Message-Id: <20190215174659.4007-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/1] Allow TAP to unnegotiate virtio-net
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Vincenzo Maffione <v.maffione@gmail.com>

Hi,
  I was doing experiments with a custom paravirtualized net device,
and I ran into a limitation of the TAP backend. I see from the kernel
code that it is not possible to set the TAP virtio-net header
length to something different from 10 or 12, which means that it
is not possible to set it to 0. That's fine.
The QEMU implementation of the TAP backend already supports
the case where virtio-net header is set to 10 or 12 in kernel,
but the emulated/paravirtualized net device is not using that:
the TAP backend will just strip/prepend a zeroed header in this case
(e.g., see the if statement in tap_receive_iov()).
However, the tap_using_vnet_hdr() has an assert() that prevents
this situation to happen, and I don't understand why. Maybe it
is a leftover? I tried to remove the assert and by doing that
my paravirtualized device was able to stop using the virtio-net
header.

Vincenzo Maffione (1):
  net: tap: allow net frontends to un-negotiate virtio-net header

 net/tap.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.20.1
