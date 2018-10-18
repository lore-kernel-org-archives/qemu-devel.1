Received: from eggs.gnu.org ([2001:4830:134:3::10]:44808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDC4J-0001Xd-Hk
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDC4I-00088K-6c
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gDC4H-00086A-SW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5F89550CD
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 17:26:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <87efcqniza.fsf@dusky.pond.sub.org>
	<20181016133340.GB2427@work-vm> <87va5zjort.fsf@dusky.pond.sub.org>
	<20181018145406.GE2632@work-vm>
Date: Thu, 18 Oct 2018 19:26:37 +0200
In-Reply-To: <20181018145406.GE2632@work-vm> (David Alan Gilbert's message of
	"Thu, 18 Oct 2018 15:54:06 +0100")
Message-ID: <87zhvbi2sy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>> 
>> > * Markus Armbruster (armbru@redhat.com) wrote:
>> >> We sometimes use g_new() & friends, which abort() on OOM, and sometimes
>> >> g_try_new() & friends, which can fail, and therefore require error
>> >> handling.
>> >> 
>> >> HACKING points out the difference, but is mum on when to use what:
>> >> 
>> >>     3. Low level memory management
>> >> 
>> >>     Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
>> >>     APIs is not allowed in the QEMU codebase. Instead of these routines,
>> >>     use the GLib memory allocation routines g_malloc/g_malloc0/g_new/
>> >>     g_new0/g_realloc/g_free or QEMU's qemu_memalign/qemu_blockalign/qemu_vfree
>> >>     APIs.
>> >> 
>> >>     Please note that g_malloc will exit on allocation failure, so there
>> >>     is no need to test for failure (as you would have to with malloc).
>> >>     Calling g_malloc with a zero size is valid and will return NULL.
>> >> 
>> >>     Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
>> >>     reasons:
>> >> 
>> >>       a. It catches multiplication overflowing size_t;
>> >>       b. It returns T * instead of void *, letting compiler catch more type
>> >>          errors.
>> >> 
>> >>     Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.
>> >> 
>> >>     Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>> >>     qemu_vfree, since breaking this will cause problems on Win32.
>> >> 
>> >> Now, in my personal opinion, handling OOM gracefully is worth the
>> >> (commonly considerable) trouble when you're coding for an Apple II or
>> >> similar.  Anything that pages commonly becomes unusable long before
>> >> allocations fail.
>> >
>> > That's not always my experience; I've seen cases where you suddenly
>> > allocate a load more memory and hit OOM fairly quickly on that hot
>> > process.  Most of the time on the desktop you're right.
>> >
>> >> Anything that overcommits will send you a (commonly
>> >> lethal) signal instead.  Anything that tries handling OOM gracefully,
>> >> and manages to dodge both these bullets somehow, will commonly get it
>> >> wrong and crash.
>> >
>> > If your qemu has maped it's main memory from hugetlbfs or similar pools
>> > then we're looking at the other memory allocations; and that's a bit of
>> > an interesting difference where those other allocations should be a lot
>> > smaller.
>> >
>> >> But others are entitled to their opinions as much as I am.  I just want
>> >> to know what our rules are, preferably in the form of a patch to
>> >> HACKING.
>> >
>> > My rule is to try not to break a happily running VM by some new
>> > activity; I don't worry about it during startup.
>> >
>> > So for example, I don't like it when starting a migration, allocates
>> > some more memory and kills the VM - the user had a happy stable VM
>> > upto that point.  Migration gets the blame at this point.
>> 
>> I don't doubt reliable OOM handling would be nice.  I do doubt it's
>> practical for an application like QEMU.
>
> Well, our use of glib certainly makes it much much harder.
> I just try and make sure anywhere that I'm allocating a non-trivial
> amount of memory (especially anything guest or user controlled) uses
> the _try_ variants.  That should keep a lot of the larger allocations.

Matters only when your g_try_new()s actually fail (which they won't, at
least not reliably), and your error paths actually work (which they
won't unless you test them, no offense).

> However, it scares me that we've got things that can return big chunks
> of JSON for example, and I don't think they're being careful about it.

We got countless allocations small and large (large as in Gigabytes)
that kill QEMU on OOM.  Some of the small allocations add up to
Megabytes (QObjects for JSON work, for example).

Yet the *practical* problem isn't lack of graceful handling when these
allocations fail.  Because they pretty much don't.

The practical problem I see is general confusion on what to do about
OOM.  There's no written guidance.  Vague rules of thumb on when to
handle OOM are floating around.  Code gets copied.  Unsurprisingly, OOM
handling is a haphazard affair.

In this state, whatever OOM handling we have is too unreliable to be
worth much, since it can only help when (1) allocations actually fail
(they generally don't), and (2) the allocation that fails is actually
handled (they generally aren't), and (3) the handling actually works (we
don't test OOM, so it generally doesn't).

For the sake of the argument, let's assume there's a practical way to
run QEMU so that memory allocations actually fail.  We then still need
to find a way to increase the probability for failed allocations to be
actually handled, and the probability for the error handling to actually
work, both to a useful level.  This will require rules on OOM handling,
a strategy to make them stick, a strategy to test OOM, and resources to
implement all that.

Will the benefits be worth the effort?  Arguing about that in the
near-total vacuum we have now is unlikely to be productive.  To ground
the debate at least somewhat, I'd like those of us in favour of OOM
handling to propose a first draft of OOM handling rules.

If we can't do even that, I'll be tempted to shoot down OOM handling in
patches to code I maintain.
