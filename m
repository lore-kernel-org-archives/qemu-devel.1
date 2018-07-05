Received: from eggs.gnu.org ([2001:4830:134:3::10]:35216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fb3Xs-0002ue-5L
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fb3Xo-0006FZ-Ul
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fb3Xo-0006AT-O5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3738D75192
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 12:39:31 +0000 (UTC)
Date: Thu, 5 Jul 2018 13:39:29 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180705123929.GB16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com, berrange@redhat.com, jferlan@redhat.com

I was doing a bit of investigation around how different hypervisors
handle the VM Generation ID feature.  QEMU's behaviour seems quite
strange, I wonder if this is a bug or expected?

(1) I booted a Windows 2016 VM with:

  qemu-system-x86_64 -M pc,accel=kvm -m 2G -hda w2k16-mincore.img \
      -device vmgenid,guid=01020304-0506-0708-090a-0b0c0d0e0f00,id=vmgenid0

(2) Inside the guest I used the VMGENID.EXE program from:

  https://bugzilla.redhat.com/show_bug.cgi?id=1598350#c3
  https://docs.microsoft.com/en-gb/windows/desktop/HyperV_v2/virtual-machine-generation-identifier

Note this is self-compiled using mingw64-g++ (not using Visual Studio
which I don't have available), but I don't believe that could have
caused the problem.

(3) The program prints:

  VmCounterValue: 708050601020304:f0e0d0c0b0a09

To make it easier to see, this is the same number but zero-extended:

  VmCounterValue: 07 08 05 06 01 02 03 04 : 00 0f 0e 0d 0c 0b 0a 09
                  \________ LOW ________/   \_______ HIGH _______/
                            WORD                     WORD

As you can see it looks like there is no clear relationship between
the order of the bytes in the guid= parameter and the order that they
are seen by Windows.

BTW if you want to try to reproduce this you will need to use
Windows 2012 R2 or above.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
