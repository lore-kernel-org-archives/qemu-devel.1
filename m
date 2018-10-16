Received: from eggs.gnu.org ([2001:4830:134:3::10]:58420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPHC-0001vx-Qq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPH7-0005IR-RA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:20:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCPH5-0005FW-UR
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 901B8C050E09
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 13:20:38 +0000 (UTC)
Date: Tue, 16 Oct 2018 14:20:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016132035.GF7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <87efcqniza.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Tue, Oct 16, 2018 at 03:01:29PM +0200, Markus Armbruster wrote:
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
> allocations fail.  Anything that overcommits will send you a (commonly
> lethal) signal instead.  Anything that tries handling OOM gracefully,
> and manages to dodge both these bullets somehow, will commonly get it
> wrong and crash.

FWIW, with the cgroups memory controller (with or without containers)
you can be in an environment where there's a memory cap. This can
conceivably cause QEMU to see ENOMEM, while the host OS in general
is operating normally with no swap usage / paging.

That said, no one has ever been able to come up with an algorithm that
reliably predicts the "normal" QEMU peak memory usage. So any time the
cgroups memory cap has been used, it has typically resulted in QEMU
unreasonably aborting in normal operation. This makes it impractical
to try to confine QEMU's memory usage with cgroups IMHO.

> But others are entitled to their opinions as much as I am.  I just want
> to know what our rules are, preferably in the form of a patch to
> HACKING.

I vaguely recall it being said that we should use g_try_new in code
paths that can be triggered from monitor commands that would cause
allocation of "significant" amounts of RAM, for some arbitrary
defintiion of what "significant" means.

eg hotplug a QXL PCI video card with 256 MB of video RAM, you might
use g_try_new() for allocating this 256 MB chunk and return gracefully
on failure, rather than the hotplug op causing QEMU to abort.

The problem with OOM handling is proving that the cleanup paths you
take actually do something sensible / correct, rather than result
in cascading failures due to further OOMs. You're going to need test
cases that exercise the relevant codepaths, and a way to inject OOM
at each individual malloc, or across a sequence of mallocs. This is
extraordinarily expensive to test as it becomes a combinatorial
problem.

We've done such exhaustive malloc failure testing in libvirt before
but it takes such a long time and it is hard to characterize "correct"
output of the test suite. This meant we caught obvious mistakes that
lead to SEGVs for the test, but needed hand inspection to identify
cases where we incorrectly carried on executing with critical data
missing due to the OOM.  It has been a while since I last tried todo
OOM testing of libvirt, so I don't have high confidence in us doing
something sensible. The only thing in our favour is that we've designed
our malloc API replacements so that the pointer to allocated memory is
returned to the caller separately from the success/failure status.
Combined with attribute((return_check)) this let us get compile time
validation that we are actually checking for malloc failures. GLibs
g_try_new API don't allow such compile time checking as they still
overload the pointer with the success/failure status.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
