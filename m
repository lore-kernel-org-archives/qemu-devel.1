Received: from eggs.gnu.org ([2001:4830:134:3::10]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1AyW-0000WH-DA
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1AyR-0004ba-HE
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:46:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e1AyR-0004b7-AH
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 08:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6709C4E4D0
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 12:46:25 +0000 (UTC)
Date: Sun, 8 Oct 2017 20:46:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171008124614.GA7792@pxdev.xzpeter.org>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922101652.GF9243@stefanha-x1.localdomain>
	<87h8vh1nar.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8vh1nar.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 02, 2017 at 07:18:04PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > On Fri, Sep 22, 2017 at 04:56:10PM +0800, Peter Xu wrote:
> >> IOThread is a general framework that contains IO loop environment and a
> >> real thread behind.  It's also good to be used internally inside qemu.
> >> Provide some helpers for it to create iothreads to be used internally.
> >> 
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  include/sysemu/iothread.h |  8 ++++++++
> >>  iothread.c                | 21 +++++++++++++++++++++
> >>  2 files changed, 29 insertions(+)
> >> 
> >> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> >> index d2985b3..b07663f 100644
> >> --- a/include/sysemu/iothread.h
> >> +++ b/include/sysemu/iothread.h
> >> @@ -46,4 +46,12 @@ AioContext *iothread_get_aio_context(IOThread *iothread);
> >>  void iothread_stop_all(void);
> >>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >>  
> >> +/*
> >> + * Helpers used to allocate iothreads for internal use.  These
> >> + * iothreads will not be seen by monitor clients when query using
> >> + * "query-iothreads".
> >> + */
> >> +IOThread *iothread_create(const char *id, Error **errp);
> >> +void iothread_destroy(IOThread *iothread);
> >> +
> >>  #endif /* IOTHREAD_H */
> >> diff --git a/iothread.c b/iothread.c
> >> index 44c8944..74e400c 100644
> >> --- a/iothread.c
> >> +++ b/iothread.c
> >> @@ -354,3 +354,24 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
> >>  
> >>      return iothread->worker_context;
> >>  }
> >> +
> >> +static Object *iothread_get_internal_parent(void)
> >> +{
> >> +    return container_get(object_get_root(), "/internal-iothreads");
> >> +}
> >
> > Markus, please advise on the following QMP API design issue.
> 
> Sorry for the slow response.  Is my advice still needed, or are you
> good?

I see that the patches are in master now (latest version, not this
one), and the consensus should be that internally used iothreads won't
affect results of query-iothreads.  So I think we are good now.  Thanks,

-- 
Peter Xu
