Received: from eggs.gnu.org ([2001:4830:134:3::10]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHt-0001el-MQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHo-0007kq-RA
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOIHo-0007kI-Mf
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 825097DAC1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:46:15 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 31 May 2018 09:45:58 +0200
Message-Id: <20180531074601.10647-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Avoid retrying on serial_xmit with EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>

EPIPE is not a recoverable error, so retrying on serial_xmit is a waste of CPU
cycles, and can potentially comprosie the Guest OS stability if both the vCPU
and the emulator thread are pinned to the same pCPU, with the first one
actively polling the serial device and barely giving time to the second to make
any actual progress.

Sergio Lopez (3):
  io: Implement QIO_CHANNEL_ERR_BROKEN
  chardev: On QIO_CHANNEL_ERR_BROKEN set errno to EPIPE
  hw/char/serial: Don't retry on serial_xmit if errno == EPIPE

 chardev/char-io.c    | 3 +++
 hw/char/serial.c     | 1 +
 include/io/channel.h | 1 +
 io/channel-file.c    | 3 +++
 4 files changed, 8 insertions(+)

-- 
1.8.3.1
