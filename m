Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB632C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C51820880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C51820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3pF-0001rY-Nc
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:47:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nZ-0000rH-Dj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nX-0007uN-Nm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG3nV-0007av-Sp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 001AFC060209;
	Mon, 15 Apr 2019 15:45:10 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14ADE608C2;
	Mon, 15 Apr 2019 15:45:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 16:45:00 +0100
Message-Id: <20190415154503.6758-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 15 Apr 2019 15:45:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request handling
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415154500.QvxGbmshhx1uqG-diCA7BhIZ3_mJZ2uZ8rgyNyINJMQ@z>

Two previous attempts to fix this due to GCC 9 highlighting
unaligned data access. My attempt:

  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html

And a previous one:

  https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html

There are a number of bugs in the USB MTP usb_mtp_write_metadata
method handling the filename character set conversion.

The 2nd patch in this series is a security flaw fix since the
code was not correctly validating guest provided data length.

I've been unable to figure out how to exercise the codepath that
calls usb_mtp_write_metadata. At a guess, it looks like something
that should be called when writing to a file from a guest, but the
GNOME GVFS MTP driver doesn't provide write support. Using the
command line MTP tools "mtp-sendfile" command results in an
protocol error

    # mtp-sendfile foo eek.txt
    libmtp version: 1.1.14

    Device 0 (VID=3D46f4 and PID=3D0004) is UNKNOWN in libmtp v1.1.14.
    Please report this VID/PID and the device model to the libmtp develop=
ment team
    PTP_ERROR_IO: failed to open session, trying again after resetting US=
B interface
    LIBMTP libusb: Attempt to reset device
    Sending foo to eek.txt
    type: , 44
    Sending file...

    Error sending file.
    Error 2: PTP Layer error 02ff: send_file_object_info(): Could not sen=
d object info.
    Error 2: Error 02ff: PTP I/O Error
    ERROR: Could not close session!

And QEMU tracing show unexpected requests

    26582@1555340076151600935 usb_mtp_command dev 4, code 0x9803, trans 0=
x18, args 0x11, 0xdc04, 0x0, 0x0, 0x0
    26582@1555340076151619955 usb_mtp_xfer dev 4, ep 2, 20/20
    26582@1555340076154138556 usb_mtp_data_in dev 4, trans 0x18, len 8
    26582@1555340076154150689 usb_mtp_xfer dev 4, ep 1, 20/512
    26582@1555340076156654311 usb_mtp_success dev 4, trans 0x18, args 0x0=
, 0x0
    26582@1555340076156667764 usb_mtp_xfer dev 4, ep 1, 12/512
    26582@1555340076159215930 usb_mtp_command dev 4, code 0x100c, trans 0=
x19, args 0x10001, 0xc, 0x0, 0x0, 0x0
    26582@1555340076159229610 usb_mtp_xfer dev 4, ep 2, 20/20
    26582@1555340076164166196 usb_mtp_stall dev 4, reason: awaiting data-=
out
    26582@1555340076167156367 usb_mtp_stall dev 4, reason: transaction in=
flight
    26582@1555340076170108336 usb_mtp_stall dev 4, reason: unknown contro=
l request
    26582@1555340076172606798 usb_mtp_stall dev 4, reason: unknown contro=
l request

Perhaps a Windows guest can exercise this, but I don't have a modern
Windows install with MTP support.

Thus this series is merely compile tested.

Daniel P. Berrang=C3=A9 (3):
  usb-mtp: fix string length for filename when writing metadata
  usb-mtp: fix bounds check for guest provided filename
  usb-mtp: fix alignment of access of ObjectInfo filename field

 hw/usb/dev-mtp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--=20
2.20.1


