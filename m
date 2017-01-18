Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTnnA-0001Qn-Jp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTnn9-0006zI-Tp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:48:36 -0500
Date: Wed, 18 Jan 2017 18:48:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118104825.GF6199@lemon>
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-14-git-send-email-famz@redhat.com>
	<2acb8480-8e7d-1d47-4f8b-0d9b68c37884@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acb8480-8e7d-1d47-4f8b-0d9b68c37884@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/14] raw-posix: Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

On Fri, 12/02 03:58, Max Reitz wrote:
> On 31.10.2016 16:38, Fam Zheng wrote:
> > This implements open flag sensible image locking for local file
> > and host device protocol.
> > 
> > virtlockd in libvirt locks the first byte, so we start looking at the
> > file bytes from 1.
> > 
> > Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
> > four locking modes by combining two bits (BDRV_O_RDWR and
> > BDRV_O_SHARE_RW), and implemented by taking two locks:
> > 
> > Lock bytes:
> > 
> > * byte 1: I can't allow other processes to write to the image
> > * byte 2: I am writing to the image
> > 
> > Lock modes:
> > 
> > * shared writer (BDRV_O_RDWR | BDRV_O_SHARE_RW): Take shared lock on
> >   byte 2. Test whether byte 1 is locked using an exclusive lock, and
> >   fail if so.
> 
> Testing whether something is locked would be easier by using F_OFD_GETLK
> instead of actually creating an exclusive lock and then releasing it.

My attempt to do this shows it doesn't work: fcntl forces the tested lock type
to read lock for some unknown reason, so it cannot be used to test other shared
lockers.
