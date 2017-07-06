Received: from eggs.gnu.org ([2001:4830:134:3::10]:44584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT61O-0005x1-Ob
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT61I-0007vJ-96
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dT61I-0007ud-0e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D02FE4E024
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 12:36:29 +0000 (UTC)
Date: Thu, 6 Jul 2017 20:36:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170706123627.GC13548@lemon.lan>
References: <20170704122325.25634-1-famz@redhat.com>
	<93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, 07/06 07:16, Eric Blake wrote:
> On 07/04/2017 07:23 AM, Fam Zheng wrote:
> > Not all platforms check whether a lock is initialized before used.  In
> > particular Linux seems to be more permissive than OSX.
> > 
> > Check initialization state explicitly in our code to catch such bugs
> > earlier.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  include/qemu/thread-posix.h |  4 ++++
> >  include/qemu/thread-win32.h |  5 +++++
> >  util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
> >  util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
> >  4 files changed, 69 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> > index 09d1e15..e5e3a0f 100644
> > --- a/include/qemu/thread-posix.h
> > +++ b/include/qemu/thread-posix.h
> > @@ -12,10 +12,12 @@ typedef QemuMutex QemuRecMutex;
> >  
> >  struct QemuMutex {
> >      pthread_mutex_t lock;
> > +    bool initialized;
> >  };
> 
> Are we worried about an object living on the stack and inheriting bit
> values that make the object already appear initialized?  Would a magic
> number a little less likely than '1' reduce the risk of inherited stack
> garbage throwing us off?
> 
> Then again, several years ago, the Cygwin project quit using a magic
> number cookie to track if synchronization objects were initialized, as
> it ran into issues where repeated calls to a function that allocates an
> object would cause the second allocation to fail because it saw leftover
> stack contents from the first time through, so even with it's use of
> something a little less likely than a bool '1', it still became a problem.

I don't know the answer to your question about magic number problem, but more
often than not a lock is heap allocated, so I'm not worried.

> 
> 
> > @@ -58,6 +61,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
> >  {
> >      int err;
> >  
> > +    assert(mutex->initialized);
> >      err = pthread_mutex_lock(&mutex->lock);
> >      if (err)
> >          error_exit(err, __func__);
> 
> Are we sure this isn't going to penalize our code speed, by adding a
> conditional on every lock/unlock?

We already have assertions everywhere, and I've never worried about its
computation cost.  Hot paths should try not to contend on locks anyway.

(This patch is already in master, if there is a problem, it will need a follow
up patch.)

Fam
