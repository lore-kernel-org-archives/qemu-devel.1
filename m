Received: from eggs.gnu.org ([2001:4830:134:3::10]:55782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gL3Al-0001AN-JG
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gL3Ak-00019I-Gk
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:33:51 -0500
Date: Fri, 9 Nov 2018 10:33:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181109093316.GA4635@dhcp-200-186.str.redhat.com>
References: <20181105205641.17862-1-v.mayatskih@gmail.com>
	<20181105205641.17862-2-v.mayatskih@gmail.com>
	<d96db69e-1276-b4d5-e8a1-e9cdf8bda567@oracle.com>
	<20181108114640-mutt-send-email-mst@kernel.org>
	<1b0590da-68a2-cc52-bfe8-cb6e59eb43ec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0590da-68a2-cc52-bfe8-cb6e59eb43ec@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/1 V2] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Vitaly Mayatskikh <v.mayatskih@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>

Am 09.11.2018 um 02:48 hat Dongli Zhang geschrieben:
> 
> 
> On 11/09/2018 12:47 AM, Michael S. Tsirkin wrote:
> > On Thu, Nov 08, 2018 at 10:09:00PM +0800, Dongli Zhang wrote:
> >> It looks the kernel space vhost-blk can only process raw image.
> >>
> >> How about to verify that only raw image is used in the drive command line when
> >> vhost-blk-pci is paired with it?
> >>
> >> Otherwise, vhost-blk-pci might be working with qcow2 image without any warning
> >> on qemu side.
> >>
> >> Dongli Zhang
> > 
> > raw being raw can you really verify that?
> 
> I meant to verify the property 'format=' of '-drive', e.g., to check if
> BlockBackend->root->bs->drv->format_name is raw?

I don't like string comparisons for this, but at least check for "file"
and "host_device" then, because "raw" is a format driver that can be
used above any protocol driver, not just for local files.

Though rather than comparing strings, I'd check bs->drv == &bdrv_file.

> We allow the user to erroneously give a qcow2 file with 'format=raw'.
> However, if 'format=qcow2' is set explicitly, vhots-blk-pci would exit
> with error as only raw is supported in kernel space.

Please note that the QEMU block layer offers various options even for
file-posix images, and silently ignoring them is probably not very nice.
So just checking the driver is not enough, you also need to check that
no feature is enabled that vhost can't provide.

At first sight, this includes at least detect-zeroes, copy-on-read and
cache.no-flush. There may be more, but this just needs some work to find
all of them. More interesting question: How will we make sure that the
list is updated when we add new options?

Is it actually a good idea to use the block layer at all for this, or
would just taking a filename string be a better idea for this device?
Of course, if you want to do automatic switchover as Stefan suggested,
havin a block node is required and we need to figure out the exact
conditions when we can switch and a way to keep them updated when we
change things.

Kevin
