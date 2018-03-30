Received: from eggs.gnu.org ([2001:4830:134:3::10]:46364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1nos-0004vP-Fw
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 02:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1nor-0005Wp-Qp
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 02:47:26 -0400
Date: Fri, 30 Mar 2018 14:47:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180330064710.GB14869@lemon.usersys.redhat.com>
References: <20180322172053.7343-1-dionbosschieter@gmail.com>
	<20180322173925.GA4079@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322173925.GA4079@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/1] block/file-posix.c: fix not reopened
 lock file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Dion Bosschieter <dionbosschieter@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

On Thu, 03/22 18:39, Kevin Wolf wrote:
> [ Cc: qemu-block ]
> 
> Am 22.03.2018 um 18:20 hat Dion Bosschieter geschrieben:
> > In commit 244a5668106297378391b768e7288eb157616f64 another
> > file descriptor to BDRVRawState is added. When we try to issue the
> > reopen command only s->fd is reopened; lock_fd could still hold an old
> > file descriptor "possibly" pointing to another file.
> > 
> > - change raw_reopen_prepare so it checks use_lock from BDRVRawState and
> > tries to reopen lock_fd accordingly
> > - change raw_reopen_commit so it closes the old lock_fd on use_lock
> > 
> > Signed-off-by: Dion Bosschieter <dionbosschieter@gmail.com>
> 
> bdrv_reopen() is not meant for opening a different file, it is meant to
> change the flags and options of the same file. Do you have a use case
> where you would actually need to switch to a different file?
> 
> As far as I know, lock_fd was specifically introduced _because_ it stays
> the same across reopen, so we don't need a racy release/reacquire pair.
> Fam (CCed) should know more.

I think (I remember we have discussed a bit before) techinically we can do
reopen just well without a separate s->lock_fd.  After all all locks we acquire
are shared lock, so it is possible to handle the lock between old fd and the new
one back and forth freely.

Fam
