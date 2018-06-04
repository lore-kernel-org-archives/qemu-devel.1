Received: from eggs.gnu.org ([2001:4830:134:3::10]:50347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPhNG-0003LA-Ow
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPhND-00083a-LO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:45:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:57986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPhND-00082E-FI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:45:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPhNB-0006Yd-HM
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 04:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6CA422E80C9
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 04:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Jun 2018 04:17:48 -0000
From: Launchpad Bug Tracker <1025244@bugs.launchpad.net>
Reply-To: Bug 1025244 <1025244@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120716123031.26191.29124.malonedeb@chaenomeles.canonical.com>
Message-Id: <152808586849.32120.10910639023960467052.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1025244] Re: qcow2 image increasing disk size
 above the virtual limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu-kvm (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu-kvm (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1025244

Title:
  qcow2 image increasing disk size above the virtual limit

Status in QEMU:
  Expired
Status in qemu-kvm package in Ubuntu:
  Expired

Bug description:
  Using qemu/kvm, qcow2 images, ext4 file systems on both guest and host
   Host and Guest: Ubuntu server 12.04 64bit
  To create an image I did this:

  qemu-img create -f qcow2 -o preallocation=3Dmetadata ubuntu-pdc-vda.img 1=
0737418240 (not sure about the exact bytes, but around this)
  ls -l ubuntu-pdc-vda.img
  fallocate -l theSizeInBytesFromAbove ubuntu-pdc-vda.img

  The problem is that the image is growing progressively and has
  obviously no limit, although I gave it one. The root filesystem's
  image is the same case:

  qemu-img info ubuntu-pdc-vda.img
   image: ubuntu-pdc-vda.img
   file format: qcow2
   virtual size: 10G (10737418240 bytes)
   disk size: 14G
   cluster_size: 65536

  and for confirmation:
   du -sh ubuntu-pdc-vda.img
   15G ubuntu-pdc-vda.img

  I made a test and saw that when I delete something from the guest, the re=
al size of the image is not decreasing (I read it is normal). OK, but when =
I write something again, it doesn't use the freed space, but instead grows =
the image. So for example:
   1. The initial physical size of the image is 1GB.
   2. I copy 1GB of data in the guest. It's physical size becomes 2GB.
   3. I delete this data (1GB). The physical size of the image remains 2GB.
   4. I copy another 1GB of data to the guest.
   5. The physical size of the image becomes 3GB.
   6. And so on with no limit. It doesn't care if the virtual size is less.

  Is this normal - the real/physical size of the image to be larger than
  the virtual limit???

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1025244/+subscriptions
