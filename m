Received: from eggs.gnu.org ([2001:4830:134:3::10]:60566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1df6RI-0000TB-3N
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1df6RE-0005xv-5Y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:00 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1df6RD-0005wc-TL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:28:56 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m85so10047933wma.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 08:28:55 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <3285CAA7-C1B4-4958-86F3-3F8124CAD1B7@daynix.com>
Date: Tue, 8 Aug 2017 18:28:51 +0300
Subject: [Qemu-devel] xhci issues with Logitech,
 Inc. Headset H340 audio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Yan Vugenfirer <yan@daynix.com>

Hi Gerd, qemu-devel

We are trying to use USB host device assignment to propagate
Logitech H340 headset to QEMU guest with virtual XHCI controller
running Windows 10.

For some reason headphone function of the device does not work -
guest OS claims that the device does not complete requests.

We have a bunch of other devices that work, also, the same device =
operates properly when:

1. connected to physical machine running Windows 10,
2. assigned to the same QEMU VM running Ubuntu Linux or Windows 7,
3. assigned to QEMU VM with virtual OHCI controller and Windows 10.

=46rom what we see, the difference between this Logitech device and =
other devices that work
is that it exposes Isochronous Synch Endpoint (see USB audio spec =
3.7.2.2) for headphones function.

Windows traces show (AFAICT, they are pretty cryptic) that the device =
does not properly complete
isochronous IN transfers issued for this endpoint.

The difference between the problematic guest OS (Windows 10) and working
guest OS (Ubuntu Linux) is that Windows 10 driver uses event data TRB =
entries
for completion notification while Linux sets IOC bit in data transfer =
TRB descriptors.
This difference exists for both ISO IN and ISO OUT endpoints of =
headphones function.

On QEMU side it looks like guest sends a bunch of ISO OUT requests with =
data,
1 ISO is request to synch endpoint and then hangs reading MFINDEX =
register repeatedly.

Of course QEMU processes this ISO IN request and issues data transfer =
event
TRB which is visible in sniffer running on the guest side (Wireshark).
QEMU also generates events for all ISO OUT transfers, they are visible =
in
the sniffer as well.

There is a separate parts of logic in XHCI controller code responsible =
for generation
of Event Data Transfer Event TRBs and this code works properly as far as =
we can tell.

Do you have any idea about what could be wrong with this device or =
corresponding XHCI code?
Do you see any additional research directions or places to look into?

Thank you in advance,
Dmitry=
