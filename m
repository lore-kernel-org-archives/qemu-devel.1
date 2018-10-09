Received: from eggs.gnu.org ([2001:4830:134:3::10]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1g9srB-0006JX-EY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1g9sr7-0003hs-DV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:19:27 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:13401
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1g9sr5-0003eF-CH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:19:23 -0400
Date: Tue, 9 Oct 2018 10:19:13 -0400
From: Brad Smith <brad@comstyle.com>
Message-ID: <20181009141912.GA76167@humpty.home.comstyle.com>
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 09, 2018 at 03:52:30PM +0200, Kamil Rytarowski wrote:
> On 07.10.2018 17:37, Brad Smith wrote:
> > Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
> > 
> > Added to -current and will be in our soon to be 6.4 release.
> > 
> > MAP_STACK      Indicate that the mapping is used as a stack.  This
> >                flag must be used in combination with MAP_ANON and
> >                MAP_PRIVATE.
> > 
> > Implement MAP_STACK option for mmap().  Synchronous faults (pagefault and
> > syscall) confirm the stack register points at MAP_STACK memory, otherwise
> > SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are modified
> > to create a MAP_STACK sub-region which satisfies alignment requirements.
> > Observe that MAP_STACK can only be set/cleared by mmap(), which zeroes the
> > contents of the region -- there is no mprotect() equivalent operation, so
> > there is no MAP_STACK-adding gadget.
> > 
> > 
> > Signed-off-by: Brad Smith <brad@comstyle.com>
> > 
> > 
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index fbd0dc8c57..51e9a012c2 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
> >      *sz += pagesz;
> >  
> >      ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
> > -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +               MAP_PRIVATE | MAP_ANONYMOUS
> > +#ifdef MAP_STACK
> > +               | MAP_STACK
> > +#endif
> > +               , -1, 0);
> >      if (ptr == MAP_FAILED) {
> >          perror("failed to allocate memory for stack");
> >          abort();
> > 
> 
> Can we handle it differently, storing MAP_* flags in a variable:
> 
> int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> #ifdef MAP_STACK
> flags |= MAP_STACK;
> #endif
> 
> ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
> 
> This way it will look nicer as we won't ifdef the middle of a function call.

How about the following?


diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..f8ee349c9c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -596,6 +596,7 @@ pid_t qemu_fork(Error **errp)
 void *qemu_alloc_stack(size_t *sz)
 {
     void *ptr, *guardpage;
+    int flags;
 #ifdef CONFIG_DEBUG_STACK_USAGE
     void *ptr2;
 #endif
@@ -610,8 +611,12 @@ void *qemu_alloc_stack(size_t *sz)
     /* allocate one extra page for the guard page */
     *sz += pagesz;
 
-    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
-               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#ifdef MAP_STACK
+    flags |= MAP_STACK;
+#endif
+
+    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
     if (ptr == MAP_FAILED) {
         perror("failed to allocate memory for stack");
         abort();
