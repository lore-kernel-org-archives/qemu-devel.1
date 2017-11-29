Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eK1Xs-0004ry-Di
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eK1Xr-0001QU-9N
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:32:56 -0500
Date: Wed, 29 Nov 2017 12:32:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171129123236.GC13499@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171129035502.GD8889@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129035502.GD8889@lemon>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> So in principle, what should we do to make the block layer easy to understand,
> develop with and debug? I think we have opportunities in these aspects:
> 
> - Documentation
> 
>   There is no central developer doc about block layer, especially how all pieces
>   fit together. Having one will make it a lot easier for new contributors to
>   understand better. Of course, we're facing the old problem: the code is
>   moving, maintaining an updated document needs effort.
> 
>   Idea: add ./doc/deve/block.txt?

When I was writing the LUKS block driver one of the bug problems I had was
understanding the internal BlockDriver APIs, as there's almost a complete
lack of any API documentation for them. So I would strongly like to see
inline API documentation in the header files to describe the APIs. eg more
of this:

  commit b461151ff31c7925f271c297e8abed20231ac7d3
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Thu Aug 31 11:54:56 2017 +0100

    block: document semantics of bdrv_co_preadv|pwritev
    

> More thoughts?

Currently the block driver layer has three different ways you can
implement the I/O path. bdrv_aio_{readv,writev},  bdrv_co_{readv,writev}
and bdrv_co_{preadv,pwritev}. This is pretty confusing to people who are
not core block maintainers, and doubtless increases the code complexity
to deal with three different I/O paths.

This is the usual curse of QEMU refactoring - a new framework is introduced
but only a few existing users are updated to use it.  I'd suggest an
aggressive push to convert all block drivers to use the same internal APIs.
Set a deadline for maintainers to convert them, and if missed, drop the
drivers in question.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
