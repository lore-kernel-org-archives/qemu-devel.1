Received: from eggs.gnu.org ([2001:4830:134:3::10]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjelen@redhat.com>) id 1fIv2A-0005Xj-2h
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjelen@redhat.com>) id 1fIv26-0005HK-3V
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjelen@redhat.com>) id 1fIv25-0005GC-Tw
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BBF3BB408
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:55:48 +0000 (UTC)
From: jjelen@redhat.com
Date: Wed, 16 May 2018 13:55:43 +0200
Message-Id: <20180516115544.3897-1-jjelen@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] USB CCID packet handling issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jakub Jelen <jjelen@redhat.com>

From: Jakub Jelen <jjelen@redhat.com>

while working on libcacard, I encountered an issue with USB "packet
fragmentation" (for the lack of better knowledge how to call it) in the
CCID code.

It happens if I try to send exactly 34 B from the virtualized Smart
Card to the guest. These 34 B are packed into 64 B payload on USB
layer, which is the boundary where the "fragmentation" of USB 1.1
packets should happen.

In the guest, the packet is delivered, but not "committed", I see it in
wireshark with 3 seconds delay and with -ENOENT URB status, while pcscd
times out while waiting for this packet.

If I send one byte less or more, the packet(s) go through as expected.

I debugged up to the function, that is handling the data passing to the
USB emulation layer [1].

>From the debug logs, I can see that there is something clearly wrong.
For 63 B message, I can see the following:

usb-ccid: ccid_bulk_in_copy_to_guest: 64/63 req/act to guest (BULK_IN)
usb-ccid: ccid_bulk_in_copy_to_guest: returning short (EREMOTEIO) 63 <
64

But if I bump the length to 64 B, I see one correct message sending the
data and then hundreds of messages like this (assuming until the caller
timer times out):

usb-ccid: ccid_bulk_in_copy_to_guest: 64/64 req/act to guest (BULK_IN)
usb-ccid: ccid_bulk_in_copy_to_guest: returning short (EREMOTEIO) 0 <
64
usb-ccid: ccid_bulk_in_copy_to_guest: returning short (EREMOTEIO) 0 <
64
...

>From the USB specification (8.5.3.2 Variable-length Data Stage), the
following section seems to explain the issue:

>  When all of the data structure is returned to the host, the function
> should indicate that the Data stage is ended by returning a packet
> that is shorter than the MaxPacketSize for thepipe.  If the data
> structure is an exact multiple of wMaxPacketSize for the pipe, the
> function will return a zero-length packet to indicate the end of the
> Data stage.

The code does not have any check for the full packet size and it is not
sending zero-length packet in that case, only NAKs, which means we can
not send data now, the host retries and then comes the timeout.

The attached patch address the issue for me and was already reviewed by
Gerd Hoffmann.

Jakub Jelen (1):
  hw/usb/dev-smartcard-reader: Handle 64 B USB packets

 hw/usb/dev-smartcard-reader.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.14.3
