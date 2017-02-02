Received: from eggs.gnu.org ([2001:4830:134:3::10]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cZJqq-0004yj-Tj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cZJqm-0004Jg-HQ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:12 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephane.chazelas@gmail.com>)
	id 1cZJqm-0004J6-73
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:08 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so4958960wmi.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:03:07 -0800 (PST)
Date: Thu, 2 Feb 2017 16:03:04 +0000
From: Stephane Chazelas <stephane.chazelas@gmail.com>
Message-ID: <20170202160304.GB24699@chaz.gmail.com>
References: <20170202123045.GA24714@chaz.gmail.com>
	<8ec657d7-3f46-1caa-9961-7127b0d99e12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec657d7-3f46-1caa-9961-7127b0d99e12@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org

2017-02-02 16:23:53 +0100, Laszlo Ersek:
[...]
> You didn't mention what qcow2 features you use -- vmstate, snapshots,
> backing files (chains of them), compression?
> 
> Since commit 2928abce6d1d only modifies "block/qcow2.c", you could
> switch / convert the images to "raw". "raw" still benefits from sparse
> files (which ZFS-on-Linux apparently supports). Sparse files (i.e., the
> disk space savings) are the most important feature to me at least.
[...]

Thanks for the feedback.

Sorry for not mentioning it in the first place, but I do need
the vmstate and snapshots (even non-linear snapshots which means
even ZFS zvol snapshots as done by Proxmox VE are not an option
either, neither is vmdk)


I hadn't tested before now, but what I observe with raw
devices and discard=on,detect-zeroes=unmap (and the virtio-scsi
interface), is that upon those "synced writes of zeroes" into
allocated data, qemu does some

[pid 10535] fallocate(14, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 136314880, 4096) = 0

into the disk image.

(and no lseek(SEEK_DATA/SEEK_HOLE))

which I don't see when using qcow2 images.

If the qcow2 interface was updated to do the same (punch holes
regardless instead of checking if the data is allocated
beforehand), that would also solve my problem (anything that
avoid those lseek()s being called).

Another thing I've not mentioned clearly is the versions of qemu
I have been testing with: 2.7, 2.7.1 (those two on Proxmox VE
4.4 (based on Debian jessie)) and 2.8.0 (the latter for
verification on a Debian unstable system, not with zfs).

-- 
Stephane
