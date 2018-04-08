Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56Vh-0007vZ-1f
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56Vg-0006ZX-92
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:21:17 -0400
Date: Sun, 8 Apr 2018 17:21:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180408092101.GB2862@lemon.usersys.redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180404132332.GR4467@stefanha-x1.localdomain>
	<20180404134923.GL12052@lemon.usersys.redhat.com>
	<20180405125509.GJ32222@stefanha-x1.localdomain>
	<f8ca0deb-75b7-b8a5-14fa-ff67fbb559f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ca0deb-75b7-b8a5-14fa-ff67fbb559f7@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 04/06 13:41, Paolo Bonzini wrote:
> On 05/04/2018 14:55, Stefan Hajnoczi wrote:
> > bdrv_copy_file_range() will invoke bdrv_co_copy_file_range_src() on
> > src[qcow2].  The qcow2 block driver will invoke
> > bdrv_co_copy_file_range_src() on src[file].  The file-posix driver will
> > invoke bdrv_co_copy_file_range_dst() on dst[raw].  The raw driver will
> > invoke bdrv_co_copy_file_range_dst() on dst[file], which sees that
> > src_bds (src[file]) is also file-posix and then goes ahead with
> > copy_file_range(2).
> > 
> > In the case where src[qcow2] is on file-posix but dst[raw] is on iSCSI,
> > the iSCSI .bdrv_co_copy_file_range_dst() call fails with -ENOTSUP and
> > the block layer can fall back to a traditional copy operation.
> > 
> > With this approach src[qcow2] could take a lock or keep track of a
> > serializing request struct so that other requests cannot interfere with
> > the operation, and it's done in a natural way since we remain in the
> > qcow2 function until the entire operation completes.  There's no need
> > for bookkeeping structs or callbacks.
> 
> Could there be AB-BA deadlock if the guest attempts a concurrent copy
> from A to B and from B to A?

I don't think bs_src need to hold its locks when calling into bs_dst for mapping
write ranges. So it should be safe.

Fam
