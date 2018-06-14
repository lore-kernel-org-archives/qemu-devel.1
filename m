Received: from eggs.gnu.org ([2001:4830:134:3::10]:33255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTaSM-0006cW-5L
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTaSI-0005Uc-Si
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:11:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTaSI-0005Tn-LC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:10:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTaSG-0004ZI-Nt
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 22:10:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A14F52E80CB
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 22:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 21:49:52 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <152901299218.26180.4350929355102129416.malone@soybean.canonical.com>
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

I believe I have distilled entire process to few repeatable steps that
can be fully reproduced on my Mac. The binary source files - - boot.bin
and lzloader.elf - were created on my Linux VM running in VirtualBox on
same Mac but I do not think it matters as the execution completely
happens on Mac.

The steps executed on my mac:
1. dd if=3Dboot.bin of=3Dimage.img > /dev/null 2>&1
2. dd if=3Dlzloader.elf of=3Dimage.img conv=3Dnotrunc seek=3D128 > /dev/nul=
l 2>&1
3. qemu-img convert image.img -O qcow2 image.qemu
4. qemu-img convert image.qemu -O qcow2 image2.qemu

The end result:
ll image*
-rw-r--r--  1 *** *** 6684672 Jun 14 17:17 image.img
-rw-r--r--  1 *** *** 7012352 Jun 14 17:40 image.qemu
-rw-r--r--  1 *** ***  196616 Jun 14 17:40 image2.qemu

The result of regular compare:
qemu-img compare image.qemu image2.qemu
Images are identical.

The result of strict compare:
qemu-img compare -s image.qemu image2.qemu
Strict mode: Offset 0 block status mismatch!

Images are clearly different.

The same 4 steps executed on my Linux VM behave correctly - image.qemu
is TRULY identical with image2.qemu.

Qemu-img on my Mac:
qemu-img --version
qemu-img version 2.12.0
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Details about Mac and OSX version:
Model Name:	MacBook Pro
  Model Identifier:	MacBookPro13,3
  Processor Name:	Intel Core i7
  Processor Speed:	2.7 GHz
  Number of Processors:	1
  Total Number of Cores:	4
  L2 Cache (per Core):	256 KB
  L3 Cache:	8 MB
  Memory:	16 GB

Mac filesystem:
Mount Point:	/
  File System:	APFS
  Writable:	Yes
  Ignore Ownership:	No
  BSD Name:	disk1s1
  Physical Drive:
  Device Name:	APPLE SSD SM0512L
  Media Name:	AppleAPFSMedia
  Medium Type:	SSD
  Protocol:	PCI-Express
  Internal:	Yes
  Partition Map Type:	Unknown

I am also attaching both source files and images for examination.

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
