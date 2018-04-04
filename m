Received: from eggs.gnu.org ([2001:4830:134:3::10]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3in9-00052Q-BP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3in8-0007DI-Hj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:49:35 -0400
Date: Wed, 4 Apr 2018 21:49:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180404134923.GL12052@lemon.usersys.redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180404132332.GR4467@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404132332.GR4467@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/8] qemu-img convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com

On Wed, 04/04 14:23, Stefan Hajnoczi wrote:
> On Thu, Mar 29, 2018 at 07:09:06PM +0800, Fam Zheng wrote:
> > [Posting a preview RFC for the general idea discussion and internal API review.
> > Libiscsi support is being worked on in the meantime.]
> > 
> > This series introduces block layer API for copy offloading and makes use of it
> > in qemu-img convert.
> > 
> > For now we implemented the operation in local file protocol with
> > copy_file_range(2).  Besides that it's possible to add similar to iscsi, nfs
> > and potentially more.
> > 
> > As far as its usage goes, in addition to qemu-img convert, we can emulate
> > offloading in scsi-disk (EXTENDED COPY), and do similar to drive-mirror.
> > 
> > The new bdrv_co_map_range can also be an alternative way to implement format
> > drivers in the future, once we make block/io.c use it in preadv/pwritev paths.
> 
> I posted concerns about the bdrv_co_map_range() interface.  It would be
> safer to only have a copy_range() interface without exposing how data is
> mapped outside the driver where race conditions can occur and the format
> driver no longer has full control over file layout.

It's a good point, but I couldn't think of a way to implement copy_range between
two format drivers: both of them need to recurse down to their bs->file and what
we eventually want is a copy_file_range() on two fds (or an iscsi equivalent):

    src[qcow2]           ->              dst[raw]
        |                                   |
        v                                   v
    src[file]            ->              dst[file]
        |                                   |
        v                                   v
       fd1               ->                 fd2
                    copy_file_range

Maybe we should add BlockDriver.bdrv_co_map_range_{prepare,commit,abort} and
call them from bdrv_co_copy_range(). This way the code path works pretty much
the same way to .bdrv_co_preadv/pwritev.

Fam
