Received: from eggs.gnu.org ([2001:4830:134:3::10]:51933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW3GM-0002Rm-B8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW3GI-0005yl-Bc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:20:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:39470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fW3GI-0005yK-5c
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:20:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fW3GG-0008Vx-9N
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F29242E80CC
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:20:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Jun 2018 17:11:27 -0000
From: John Snow <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <152960108766.26563.15291996422240489526.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My hunch is that we're handling zero regions incorrectly and we might be
skipping data regions we ought to be copying.

...I'm looking at the `image2.qemu` file you've uploaded and it's empty!
we didn't copy *anything* from your source file.

Try converting with '-S 0` to disable sparse protection and see if that
might help.

  '-S' indicates the consecutive number of bytes (defaults to 4k) that must
       contain only zeros for qemu-img to create a sparse image during
       conversion. If the number of bytes is 0, the source will not be scan=
ned for
       unallocated or zero sectors, and the destination image will always be
       fully allocated

If that helps, I'd take a look at img_convert in qemu-img.c ...

convert_iteration_sectors looks relevant, it appears to help us know
which sectors to copy when called by convert_co_do_copy.

Tracing around "convert_co_read" in the same function might also help us
to know which portions of the image we're even deciding to read; and we
could probably track backwards from there to figure out which
condition(s) are disqualifying us if we're deciding not to copy data.

My current hunch is that bdrv_block_status[_above] is returning
something wrong when backed by APFS.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
