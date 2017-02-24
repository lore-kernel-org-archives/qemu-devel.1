Received: from eggs.gnu.org ([2001:4830:134:3::10]:51764)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1chCFw-0005Ow-PC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1chCFs-0007rX-RO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:33:40 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:46716 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1chCFs-0007qd-Ie
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:33:36 -0500
From: Peter Lieven <pl@kamp.de>
Message-ID: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
Date: Fri, 24 Feb 2017 10:33:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] RFC QCOW2 compression speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi,


i have been experimenting with deflate compression paramters in the past and found that the values chosen

in QCOW2 are not that optimal. In fact creation of compressed QCOW2 is very slow. And especially for backups

compression would be good, but its so slow thats almost infeasible to use.


The current settings to inflateinit2 are compression level 6 (Z_DEFAULT_COMPRESSION) and windowBits 12.

Increasing windowBits increases speed and yields better compression. Lowering the compression level increases

speed, but results in worse compression.


The issue here is that changing windowBits would (in theory) require a change of the parameters to deflateInit2 in

decompression which means that this change would make QCOW2 images incompatible.


As for discussion here is my experiment of compression a Ubuntu1604 installation in ram.

level 6, windowBits 12   -> 42 seconds, 470MB size

level 6, windowBits 15   -> 35 seconds, 448MB size

level 1, windowBits 12   -> 30 seconds, 500MB size

level 1, windowBits 15   -> 15 seconds, 483MB size


Strange enough decompression works with unchanged parameters for all files. But the documentation of zlib claims

it should produce an error if a windowBits 15 stream is deflated with a smaller windowBits parameter.


What are your thoughts in introducing a switch and/or feature to use alternate settings for inflate?

If we need to introduce an incompatible feature for the bigger windowBits might it be worth thinking of using

an alternate compression algorithm like LZ4?


Thanks,

Peter
