Received: from eggs.gnu.org ([2001:4830:134:3::10]:45323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cY8ex-0000MP-3p
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cY8eu-0003R2-1a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 04:54:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cY8et-0003OU-RO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 04:53:59 -0500
Date: Mon, 30 Jan 2017 10:53:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170130095356.GA3463@noname.redhat.com>
References: <1485362572-7246-1-git-send-email-den@openvz.org>
	<1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
	<1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add missed BDRV_O_NOCACHE when
 block device is opened without file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Am 25.01.2017 um 20:44 hat Denis V. Lunev geschrieben:
> This is what I have exactly started from:
> http://ftp.redhat.com/pub/redhat/linux/enterprise/7Server/en/RHEV/SRPMS/qemu-kvm-rhev-2.6.0-27.el7.src.rpm
> 
> This package starts VM well for the above mentioned configuration:
> 
>     <disk type='file' device='cdrom'>
>       <driver name='qemu' type='raw' cache='none' io='native'/>
>       <target dev='sdb' bus='scsi'/>
>       <readonly/>
>     </disk>
> 
> but the problem comes later at 'change' moment. It reports
> 
> 'Details: internal error: unable to execute QEMU command 'change':
> aio=native was specified, but it requires cache.direct=on, which
> was not specified.)'
> 
> 
> Thus partial solution implemented by the RedHat is really
> partial and does not work at the second stage. I have started from

That's a downstream problem that is probably worth fixing, but of course
not with an upstream patch. Can you create a Bugzilla for this and
assign it to Max, John or me? (Putting the rest of us into the CC list)

> the problem for me is that each clone() call is costly and counts. That
> is why we are trying to avoid it whenever possible. That is why 'native'
> mode is MUCH better. Also it would be very nice not to use cached
> IO, which is very good for memory overcommit situations.
> 
> Here I am fighting not with the performance, which does not make
> any real sense, but with a memory footprint.

This makes sense generally, but for empty CD-ROMs, no I/O request is
ever made, so neither Linux AIO nor the thread pool is used.

You only get a specific cache/aio mode once you actually insert a block
driver node to the virtual device.

> > Second, all this patch does is revert some changes done by commit
> > 91a097e7478940483e76d52217f05bc05b98d5a5, which was very deliberate.
> >
> > Third, you may then be asking for the recommended way to put an
> > aio=native medium into a CD-ROM drive. Good thing you ask, because we
> > have a way that we want to recommend but can't because it's still
> > considered experimental:
> >
> > The BDS is added using blockdev-add, with all of the appropriate caching
> > and aio options. Then it's inserted into the drive using the
> > x-blockdev-insert-medium command, and the drive is closed using
> > blockdev-close-tray.
> the problem, again, is that with x-blockdev-insert-medium I can not
> deal with block driver options, or may be I am missing something.

The thing that you insert with x-blockdev-insert-medium is a block
driver node that you presumably created with blockdev-add, so you did
have a chance to specify whichever options you want.

Kevin
