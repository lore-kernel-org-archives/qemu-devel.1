Received: from eggs.gnu.org ([2001:4830:134:3::10]:53577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAiOM-0006B2-4U
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAiOL-0007es-8b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:21:10 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:14146
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gAiOK-0007Yp-VF
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:21:09 -0400
Date: Thu, 11 Oct 2018 17:20:59 -0400
From: Brad Smith <brad@comstyle.com>
Message-ID: <20181011212059.GA44995@humpty.home.comstyle.com>
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
	<CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
	<cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
	<486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
	<6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 11, 2018 at 09:31:23PM +0200, Kamil Rytarowski wrote:
> On 11.10.2018 16:25, Brad Smith wrote:
> > On 10/11/2018 5:41 AM, Kamil Rytarowski wrote:
> > 
> >> On 11.10.2018 11:36, Peter Maydell wrote:
> >>> On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
> >>>> And from FreeBSD...
> >>>>
> >>>> ?????????? MAP_STACK MAP_STACK implies MAP_ANON, and offset of 0.?? The fd
> >>>> argument must be -1 and prot must include at least
> >>>> PROT_READ and PROT_WRITE.
> >>>>
> >>>> This option creates a memory region that grows to at
> >>>> most len bytes in size, starting from the stack top
> >>>> and growing down.?? The stack top is the starting
> >>>> address returned by the call, plus len bytes.?? The
> >>>> bottom of the stack at maximum growth is the starting
> >>>> address returned by the call.
> >>>>
> >>>> Stacks created with MAP_STACK automatically grow.
> >>>> Guards prevent inadvertent use of the regions into
> >>>> which those stacks can grow without requiring mapping
> >>>> the whole stack in advance.
> >>> Hmm. That "automatically growing" part sounds like
> >>> behaviour we definitely do not want for our use case.
> >>> So we're going to need to make this OS-specific :-(
> >>>
> >> I propose to restrict MAP_STACK it to OpenBSD (with a comment in the
> >> code). Once it will be needed by someone else will be able to enable it
> >> for other OSes.
> > 
> > I was going to propose doing something like that but you had replied
> > before I did.
> > What sort of comment did you have in mind?
> > 
> 
> Why do we want it only on OpenBSD and its either unneeded or meaning
> something else on other OSes.
> 
> #ifdef __OpenBSD__
> flags |= MAP_STACK;
> #endif

How about the following?


diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..7814e61114 100644
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
@@ -610,8 +611,15 @@ void *qemu_alloc_stack(size_t *sz)
     /* allocate one extra page for the guard page */
     *sz += pagesz;
 
-    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
-               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#if defined(MAP_STACK) && defined(__OpenBSD__)
+    /* Only enable MAP_STACK on OpenBSD. Other OS's such
+       as Linux/FreeBSD/NetBSD have a flag with the same
+       name but have differing functionality. */
+    flags |= MAP_STACK;
+#endif
+
+    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
     if (ptr == MAP_FAILED) {
         perror("failed to allocate memory for stack");
         abort();
