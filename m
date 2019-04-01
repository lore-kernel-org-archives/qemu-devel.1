Received: from eggs.gnu.org ([209.51.188.92]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyM0-0004En-8z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyLy-0004S9-FS
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:56:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<20190401122054.GA2686@andariel.pipo.sk>
Date: Mon, 01 Apr 2019 16:55:50 +0200
In-Reply-To: <20190401122054.GA2686@andariel.pipo.sk> (Peter Krempa's message
	of "Mon, 1 Apr 2019 14:20:54 +0200")
Message-ID: <87mul9n5ah.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Sun, Mar 31, 2019 at 14:56:19 +0200, Markus Armbruster wrote:
>> Let's review our options for 4.0.
>> 
>> Please note my analysis is handicapped by incomplete information, in
>> particular on libvirt's needs.
>
> Libvirt's needs are "simple" we need to do block-commit. It has a few
> caveats though. The selinux labels for backing images don't allow write
> operation when starting qemu. When doing block-commit libvirt relabels
> the backing chain prior to using block-commit.

Paraphrasing, to make sure I got you.

Consider the common read/write COW image with a backing image.

Libvirt wants to grant QEMU read/write access to the COW and read-only
access to the backing image.  It does that with SELinux.  QEMU has to
open the backing image read-only (read/write would fail).

But libvirt also wants to do block-commit.  Libvirt first relabels to
grant QEMU read/write access to the backing image, then $something makes
QEMU reopen the backing image read/write, block-commit does its job,
$something makes QEMU reopen the backing image read-only, libvirt
relabels to revoke read/write access.

Correct?

With dynamic read-only, $something is the block commit job (a writer)
attaching and detaching to the backing image node.

> That works with -drive as qemu reopens the files internally, but does
> not work when using -blockdev.

Happy to take your word for it.

> Since we need to keep the images RO until doing  the blockjob there
> needs to be a way when either qemu automagically does what libvirt needs
> even if the image did not have the write permission originally.
>
> auto-read-only was a naive impl when qemu attempted to keep the storage
> access nodes RW. At the point when I was testing it I didn't enable
> s-virt as it's a hassle when you want to run git versions of libvirt and
> qemu and thus didn't see the problem with missing permissions.

Yes, fallback read-only is useless for the scenario above.

Kevin wrote "libvirt requires dynamic read-only for file-posix. It
prefers dynamic read-only for other drivers, but can live with fallback
read-only there."  I'm not sure how it can live with fallback read-only.
Is it because only *files* can labelled with SELinux?

If yes, then my next question is how libvirt makes use of fallback
read-only for non-files.  Can you give me an example?

> The dynamic version attempts to fix that. That is still the automagic
> approach. I don't really mind also doing a hands-on approach where we'd
> need to tell qemu to reopen given nodes.

Aha!  You just corrected my overly narrow idea of the solution space.

> I'm not sure what ends up being less work.

"Less work" is an important consideration.

We may be able to accept some extra work to get a saner interface.
Depends on how much saner and how much extra exactly, and on who needs
to do the work.

>> Terminology:
>> 
>> * "Hard read-write" semantics: open read/write.
>> 
>> * "Hard read-only" semantics: open read-only.
>> 
>> * "Dynamic read-only" semantics: open read-only, reopen read/write when
>>   a writer attaches, reopen read-only when the last writer detaches.
>> 
>> * "Fallback read-only" semantics:. try to open read/write, fall back to
>>   read-only.
>> 
>> We have a use case for dynamic read-only: libvirt.  I'm not aware of a
>> use case for fallback read-only.
>> 
>> Behavior before 3.1:
>> 
>> * read-only=on: hard read-only
>> 
>> * read-only=off: hard read-write
>> 
>> Behavior in 3.1: new parameter auto-read-only, default off.
>> 
>> * read-only=on: hard read-only (no change)
>> 
>> * read-only=on,auto-read-only=on: hard read-only (auto-read-only=on
>>   silently ignored)
>> 
>> * read-only=off: hard read-write
>> 
>> * read-only=off,auto-read-only=on: depends on the driver
>> 
>>   - file-posix.c's drivers: fallback read-only
>>   - some other drivers: fallback read-only
>>   - remaining drivers: hard read/write
>> 
>> Behavior in 4.0 so far:
>> 
>> * read-only=on: hard read-only (no change)
>> 
>> * read-only=on,auto-read-only=on: hard read-only (no change)
>> 
>> * read-only=off: hard read-write (no change)
>> 
>> * read-only=off,auto-read-only=on: depends on the driver
>> 
>>   - file-posix.c's drivers: dynamic read-only
>>   - some other drivers: fallback read-only (no change)
>>   - remaining drivers: hard read/write (no change)
>> 
>> 
>> Option 1: Rename @auto-read-only.
>> 
>> Rationale: we released auto-read-only in v3.1 with unproven fallback
>> read-only semantics.  It turned out not to be useful.  Admit the
>> mistake, retract it.  Release our next attempt in 4.0 under a suitable
>> new name with fallback read-only semantics.
>
> I concur. Nobody probably uses this. Setting up selinux and blockdev is
> not a trivial excercise.

Right.

>> CON:
>> 
>> * Compatibility break.  No-go if there are users.  Users seem quite
>>   unlikely, though.
>> 
>> * Still unproven, albeit less so: this time we have some unreleased
>>   (unfinished?) libvirt code.
>
> unfinished and thus also unreleased.

Noted.

>> 
>> * Semantics are still largely left to drivers, and the schema can't tell
>>   which one does what.  Awkward.
>> 
>> * Unless we're fairly confident we won't upgrade drivers from "hard" to
>>   "fallback" to "dynamic", this merely kicks the can down the road:
>>   we'll face the exact same "how can libvirt find out" problem on every
>>   upgrade.
>> 
>> PRO:
>> 
>> * When libvirt sees the new name, it can rely on file-posix.c's drivers
>>   providing dynamic read-only semantics.
>> 
>> 
>> Option 2: Add query-qemu-features command, return
>> file-dynamic-auto-read-only #ifdef CONFIG_POSIX.
>> 
>> Rationale: we released auto-read-only in v3.1 with unproven fallback
>> read-only semantics.  It turned out not to be useful.  Admit the
>> mistake, and patch it up in 4.0.  Libirt needs to know whether it's
>> patche up, and this is a simple way to tell it.
>> 
>> CON:
>> 
>> * All of option 1's, except for the compatibility break
>> 
>> * Uses query-qemu-features to expose a property of the build.  I
>>   consider that a mistake.
>> 
>> PRO
>> 
>> * Libvirt can use either query-qmp-schema or query-qemu-features to find
>>   out whether it can can rely on file-posix.c's drivers providing
>>   dynamic read-only semantics.  To make query-qemu-features usable, we
>>   need to promise query-qemu-features never returns false for it.  To
>>   make query-qemu-features usable, we need to promise the value will
>>   remain valid for the remainder of the QEMU run (defeats caching) or
>>   for any future run of the same QEMU binary (enables caching).
>> 
>> 
>> Option 3: Add @dynamic-read-only to the drivers that provide dynamic
>> read-only, default to value of auto-read-only, promise we'll never add
>> it to drivers that don't.
>> 
>> Rationale: give users explicit control over dynamic vs. fallback for all
>> drivers that can provide dynamic.  This makes some sense as an
>> interface, as long as you ignore the fact that no driver implements both
>> dynamic and fallback.  I can't see why a driver couldn't implement both.
>> It also makes dynamic support visible in the schema.
>> 
>> Behavior (three bools -> eight cases):
>> 
>> * read-only=on: hard read-only (no change)
>> 
>>   Shorthand for read-only=on,auto-read-only=off,dynamic-read-only=off
>> 
>> * read-only=on,auto-read-only=on: hard read-only (no change)
>> 
>>   Shorthand for read-only=on,auto-read-only=on,dynamic-read-only=on
>> 
>> * read-only=off: hard read-write (no change)
>> 
>>   Shorthand for read-only=off,auto-read-only=off,dynamic-read-only=off
>> 
>> * read-only=off,auto-read-only=on:
>> 
>>   Shorthand for read-only=off,auto-read-only=on,dynamic-read-only=on
>> 
>>   - file-posix.c's drivers: dynamic read-only (no change,
>>     dynamic-read-only=on is the default)
>>   - some other drivers: fallback read-only (no change)
>>   - remaining drivers: hard read/write (no change)
>> 
>> * read-only=off,auto-read-only=on,dynamic-read-only=off
>> 
>>   - file-posix.c's drivers: error
>>   - all other drivers: N/A
>> 
>> * read-only=off,auto-read-only=off,dynamic-read-only=on
>> 
>>   - file-posix.c's drivers: error
>>   - all other drivers: N/A
>> 
>> * read-only=on,dynamic-read-only=on
>> 
>>   Shorthand for read-only=on,auto-read-only=off,dynamic-read-only=on
>> 
>>   - file-posix.c's drivers: error
>>   - all other drivers: N/A
>> 
>> * read-only=on,auto-read-only=on,dynamic-read-only=off
>> 
>>   Shorthand for read-only=on,auto-read-only=on,dynamic-read-only=off
>> 
>>   - file-posix.c's drivers: error
>>   - all other drivers: N/A
>> 
>> CON:
>> 
>> * Two bools (read-only and auto-read-only) to select from three choices
>>   was already ugly.  Three bools (the same plus dynamic-read-only) to
>>   select from four choices is even uglier.
>> 
>> * The explicit control is just a facade so far: since only the default
>>   setting is implemented, it doesn't actually control anything.
>> 
>> PRO:
>> 
>> * When libvirt sees a driver providing a dynamic-read-only parameter, it
>>   knows it can rely on the driver providing dynamic read-only semantics.
>> 
>> * Adding dynamic read-only capability to drivers creates no
>>   introspection problems: we simply add dynamic-read-only to their
>>   parameters.
>
> In the end libvirt does not care that much if the storage is open read
> only or read write. We need the format node or guest frontend to deny
> writes if the disk is declared as read-only. We also need to be able to
> do blockjobs. The requirement is that images may not be accessible in
> R/W mode when qemu is starting but later may become. Then it's expected
> that block-commit will succeed.

Fallback read-only can't help there.

Dynamic read-only should work.  Explicit reopen triggers could also
work.
