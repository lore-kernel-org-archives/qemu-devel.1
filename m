Received: from eggs.gnu.org ([2001:4830:134:3::10]:59015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpD6u-0007lR-0Z
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpD6t-0000lL-7D
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:42:16 -0400
Date: Mon, 13 Aug 2018 15:42:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813134206.GF4323@localhost.localdomain>
References: <20180813023958.5352-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813023958.5352-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Skip effectiveless OFD lock
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 13.08.2018 um 04:39 hat Fam Zheng geschrieben:
> If we know we've already locked the bytes, don't do it again; similarly
> don't unlock a byte if we haven't locked it. This doesn't change the
> behavior, but fixes a corner case explained below.
> 
> Libvirt had an error handling bug that an image can get its (ownership,
> file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behind
> QEMU. Specifically, an image in use by Libvirt VM has:
> 
>     $ ls -lhZ b.img
>     -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 b.img
> 
> Trying to attach it a second time won't work because of image locking.
> And after the error, it becomes:
> 
>     $ ls -lhZ b.img
>     -rw-r--r--. root root system_u:object_r:virt_image_t:s0 b.img
> 
> Then, we won't be able to do OFD lock operations with the existing fd.
> In other words, the code such as in blk_detach_dev:
> 
>     blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);
> 
> can abort() QEMU, out of environmental changes.
> 
> This patch is an easy fix to this and the change is regardlessly
> reasonable, so do it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
