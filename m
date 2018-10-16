Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCPTp-0007qH-CH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCPTl-00026g-5D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gCPTk-00024g-SP
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 277A730E4EB3
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 13:33:44 +0000 (UTC)
Date: Tue, 16 Oct 2018 14:33:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181016133340.GB2427@work-vm>
References: <87efcqniza.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efcqniza.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> We sometimes use g_new() & friends, which abort() on OOM, and sometimes
> g_try_new() & friends, which can fail, and therefore require error
> handling.
> 
> HACKING points out the difference, but is mum on when to use what:
> 
>     3. Low level memory management
> 
>     Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
>     APIs is not allowed in the QEMU codebase. Instead of these routines,
>     use the GLib memory allocation routines g_malloc/g_malloc0/g_new/
>     g_new0/g_realloc/g_free or QEMU's qemu_memalign/qemu_blockalign/qemu_vfree
>     APIs.
> 
>     Please note that g_malloc will exit on allocation failure, so there
>     is no need to test for failure (as you would have to with malloc).
>     Calling g_malloc with a zero size is valid and will return NULL.
> 
>     Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
>     reasons:
> 
>       a. It catches multiplication overflowing size_t;
>       b. It returns T * instead of void *, letting compiler catch more type
>          errors.
> 
>     Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.
> 
>     Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>     qemu_vfree, since breaking this will cause problems on Win32.
> 
> Now, in my personal opinion, handling OOM gracefully is worth the
> (commonly considerable) trouble when you're coding for an Apple II or
> similar.  Anything that pages commonly becomes unusable long before
> allocations fail.

That's not always my experience; I've seen cases where you suddenly
allocate a load more memory and hit OOM fairly quickly on that hot
process.  Most of the time on the desktop you're right.

> Anything that overcommits will send you a (commonly
> lethal) signal instead.  Anything that tries handling OOM gracefully,
> and manages to dodge both these bullets somehow, will commonly get it
> wrong and crash.

If your qemu has maped it's main memory from hugetlbfs or similar pools
then we're looking at the other memory allocations; and that's a bit of
an interesting difference where those other allocations should be a lot
smaller.

> But others are entitled to their opinions as much as I am.  I just want
> to know what our rules are, preferably in the form of a patch to
> HACKING.

My rule is to try not to break a happily running VM by some new
activity; I don't worry about it during startup.

So for example, I don't like it when starting a migration, allocates
some more memory and kills the VM - the user had a happy stable VM
upto that point.  Migration gets the blame at this point.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
