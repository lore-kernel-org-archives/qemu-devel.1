Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1chEAe-0005wl-W2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1chEAb-0003Ms-Ra
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1chEAb-0003Ky-Ll
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:36:17 -0500
References: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3f2dd35f-aed2-087e-6ed5-0b1ae47c0ff0@redhat.com>
Date: Fri, 24 Feb 2017 12:36:12 +0100
MIME-Version: 1.0
In-Reply-To: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC QCOW2 compression speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 02/24/17 10:33, Peter Lieven wrote:
> Hi,
> 
> 
> i have been experimenting with deflate compression paramters in the past and found that the values chosen
> 
> in QCOW2 are not that optimal. In fact creation of compressed QCOW2 is very slow.

I agree, I find it slow as well.

> And especially for backups
> 
> compression would be good, but its so slow thats almost infeasible to use.
> 
> 
> The current settings to inflateinit2 are compression level 6 (Z_DEFAULT_COMPRESSION) and windowBits 12.
> 
> Increasing windowBits increases speed and yields better compression. Lowering the compression level increases
> 
> speed, but results in worse compression.
> 
> 
> The issue here is that changing windowBits would (in theory) require a change of the parameters to deflateInit2 in
> 
> decompression which means that this change would make QCOW2 images incompatible.
> 
> 
> As for discussion here is my experiment of compression a Ubuntu1604 installation in ram.
> 
> level 6, windowBits 12   -> 42 seconds, 470MB size
> 
> level 6, windowBits 15   -> 35 seconds, 448MB size
> 
> level 1, windowBits 12   -> 30 seconds, 500MB size
> 
> level 1, windowBits 15   -> 15 seconds, 483MB size
> 
> 
> Strange enough decompression works with unchanged parameters for all files. But the documentation of zlib claims
> 
> it should produce an error if a windowBits 15 stream is deflated with a smaller windowBits parameter.
> 
> 
> What are your thoughts in introducing a switch and/or feature to use alternate settings for inflate?
> 
> If we need to introduce an incompatible feature for the bigger windowBits might it be worth thinking of using
> 
> an alternate compression algorithm like LZ4?

If the compression level was exposed with a command line option (and/or
an environment variable, a la $GZIP), I would welcome it. I have
frequently missed this feature, but I always figured it wouldn't be
important enough to bother block people with it.

Thanks
Laszlo
