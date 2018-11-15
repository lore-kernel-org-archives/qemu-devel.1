Received: from eggs.gnu.org ([2001:4830:134:3::10]:37041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPhz-0002z3-TS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPhu-0000HX-HQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gNPht-0000Eo-6z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B85D43001E72
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 22:01:45 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 15 Nov 2018 17:01:30 -0500
Message-Id: <20181115220132.6531-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

For larger files, not only do we keep reallocating to increase the mtp buffer
size, the write also happens in one go. This does two things:

Write to file upto a certain data size we have received so far and second,
reuse the buffer again instead of reallocating to a larger buffer size.

Tested with different file sizes on a Linux guest.

Bandan Das (2):
  usb-mtp: Reallocate buffer in multiples of MTP_WRITE_BUF_SZ
  usb-mtp: breakup MTP write into smaller chunks

 hw/usb/dev-mtp.c | 153 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 54 deletions(-)

-- 
2.14.4
