Received: from eggs.gnu.org ([2001:4830:134:3::10]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cef9i-0000W8-3h
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cef9h-0004bH-6k
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:48:46 -0500
Date: Fri, 17 Feb 2017 09:48:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170217094830.GA4941@work-vm>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
	<20170217084951.GA5338@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217084951.GA5338@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, quintela@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 17.02.2017 um 09:06 hat Pankaj Gupta geschrieben:
> >  To maintain consistency at all the places use qemu_madvise wrapper
> >  inplace of madvise call.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 
> Juan/Dave, if one of you can give an Acked-by, I can take this through
> my tree.

NACK

That's wrong; qemu_madvise can end up going through posix_madvise and
using POSIX_MADV_DONTNEED, it has different semantics to the madvise(MADV_DONTNEED)
and we need the semantics of madvise - i.e. it's guaranteed to throw
away the pages, where as posix_madvise *may* throw away the pages if
the kernel feels like it.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
