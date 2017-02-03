Received: from eggs.gnu.org ([2001:4830:134:3::10]:49011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdickens@grammatech.com>) id 1cZiTa-0002NC-CI
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdickens@grammatech.com>) id 1cZiTW-0007Cr-DO
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:20:50 -0500
Received: from placid1.grammatech.com ([98.159.213.246]:44888
	helo=placid.grammatech.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdickens@grammatech.com>)
	id 1cZiTW-0007Cm-8I
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:20:46 -0500
Received: from placid.grammatech.com (placid1 [192.168.219.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by placid.grammatech.com (Postfix) with ESMTPS id DBF0FB20A5
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 13:20:44 -0500 (EST)
Received: from [10.233.218.30] (barracuda.grammatech.com [192.168.219.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by placid.grammatech.com (Postfix) with ESMTPSA id D0443B2086
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 13:20:44 -0500 (EST)
From: Jason Dickens <jdickens@grammatech.com>
Message-ID: <c327fa49-67c4-5e01-29f8-cbe9c883e157@grammatech.com>
Date: Fri, 3 Feb 2017 13:20:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU + OVMF, bootable linux image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am trying to create a raw Linux image that is bootable by QEMU using 
the OVMF firmware image.

Basically, I have used a standard Ubuntu ISO  and a empty raw image. 
Executing qemu-system-x86_64 with the ISO as CD and the other image as a 
hardrive I have been able to install Ubuntu on the image, no problem.

However, when trying to boot the created image I simply get the UEFI shell?

I've noticed the following:

1. The ISO image which boots with OVMF in UEFI just fine has the 
following format (from fdisk):

Disk ubuntu-14.04.3-desktop-amd64.iso: 1006 MiB, 1054867456 bytes, 
2060288 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6a6216fc

Device                           Boot   Start     End Sectors Size Id Type
ubuntu-14.04.3-desktop-amd64.iso1  *        0 2060287 2060288 1006M  0 
Empty
ubuntu-14.04.3-desktop-amd64.iso2     2038760 2043303 4544 2.2M ef EFI 
(FAT-12/16/32)

2. The image created by the linux install has the following(from fdisk):

Disk ovmf_test_image: 10 GiB, 10737418240 bytes, 20971520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 36240C48-C008-4619-BE31-26D271000490

Device              Start      End  Sectors  Size Type
ovmf_test_image1     2048  1050623  1048576  512M EFI System
ovmf_test_image2  1050624 12584959 11534336  5.5G Linux filesystem
ovmf_test_image3 12584960 20969471  8384512    4G Linux swap


Can someone help me understand the format requirements to boot using 
OVMF in UEFI mode? Clearly these two images are dramatically different. 
However, I would expect #2 to be the more modern method and more likely 
to work? As for QEMU command I use literally the same command switching 
only between the file names to get the different results it looks 
something like this:

qemu-system-x86_64 -drive file=ovmf_test_image,format=raw -m 4G 
--bios.bin -net none

Thanks,

Jason
