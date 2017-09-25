Received: from eggs.gnu.org ([2001:4830:134:3::10]:47105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwMPO-000567-1M
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwMPK-0008Bp-Uu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwMPK-0008Ap-OB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:58:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 810B32F944D
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 05:58:17 +0000 (UTC)
Date: Mon, 25 Sep 2017 13:58:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170925055812.GB398@lemon.lan>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-4-git-send-email-peterx@redhat.com>
	<20170922130922.GF32000@lemon>
	<20170925052330.GC19505@pxdev.xzpeter.org>
	<20170925053002.GA398@lemon.lan>
	<20170925055034.GD19505@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925055034.GD19505@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] iothread: delay the context release to
 finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 09/25 13:50, Peter Xu wrote:
> On Mon, Sep 25, 2017 at 01:30:02PM +0800, Fam Zheng wrote:
> > On Mon, 09/25 13:23, Peter Xu wrote:
> > > On Fri, Sep 22, 2017 at 09:09:22PM +0800, Fam Zheng wrote:
> > > > On Fri, 09/22 16:56, Peter Xu wrote:
> > > > > When gcontext is used with iothread, the context will be destroyed
> > > > > during iothread_stop().  That's not good since sometimes we would like
> > > > > to keep the resources until iothread is destroyed, but we may want to
> > > > > stop the thread before that point.
> > > > 
> > > > Would be nice if you can also mention the glib bug that "required" this in the
> > > > commit message.
> > > 
> > > I can add it, but I am not sure it's very closely related (and I'm
> > > afraid that may confuse more people).  Say, even without that bug, I
> > > would still think it not a good idea to free the context in the loop,
> > > especially considering that we have the finalize function there.  Thanks,
> > 
> > It's interesting to know if or not your future change will break without this
> > patch, this is especially useful for backport.
> 
> I haven't tried to run with iothread and without this patch, but I
> think it should fail, so this patch should be needed.
> 
> The point is that we should not destroy the context before explicitly
> calling remove_fd_in_watch() if the context is running chardevs.
> Without this patch, this rule does not satisfy.  And IIUC this rule
> comes from the glib bug.
> 
> Anyway, I'll mention it in commit message to clarify.

OK, thanks for the explanations! My r-b still stands with the amended commit
log.

Fam
