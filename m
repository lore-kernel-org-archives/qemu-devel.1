Received: from eggs.gnu.org ([209.51.188.92]:44529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBEgR-0003fu-Vd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBEdx-0002Nb-Hw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:19:43 -0400
Date: Tue, 2 Apr 2019 10:19:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190402081929.GA5352@localhost.localdomain>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<87bm1pjxz6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm1pjxz6.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, pkrempa@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Am 01.04.2019 um 22:02 hat Markus Armbruster geschrieben:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Let's review our options for 4.0.
> >
> > Please note my analysis is handicapped by incomplete information, in
> > particular on libvirt's needs.
> >
> > Terminology:
> >
> > * "Hard read-write" semantics: open read/write.
> >
> > * "Hard read-only" semantics: open read-only.
> >
> > * "Dynamic read-only" semantics: open read-only, reopen read/write when
> >   a writer attaches, reopen read-only when the last writer detaches.
> >
> > * "Fallback read-only" semantics:. try to open read/write, fall back to
> >   read-only.
> >
> > We have a use case for dynamic read-only: libvirt.  I'm not aware of a
> > use case for fallback read-only.
> >
> > Behavior before 3.1:
> >
> > * read-only=on: hard read-only
> >
> > * read-only=off: hard read-write
> >
> > Behavior in 3.1: new parameter auto-read-only, default off.
> >
> > * read-only=on: hard read-only (no change)
> >
> > * read-only=on,auto-read-only=on: hard read-only (auto-read-only=on
> >   silently ignored)
> >
> > * read-only=off: hard read-write
> >
> > * read-only=off,auto-read-only=on: depends on the driver
> >
> >   - file-posix.c's drivers: fallback read-only
> >   - some other drivers: fallback read-only
> >   - remaining drivers: hard read/write
> >
> > Behavior in 4.0 so far:
> >
> > * read-only=on: hard read-only (no change)
> >
> > * read-only=on,auto-read-only=on: hard read-only (no change)
> >
> > * read-only=off: hard read-write (no change)
> >
> > * read-only=off,auto-read-only=on: depends on the driver
> >
> >   - file-posix.c's drivers: dynamic read-only
> >   - some other drivers: fallback read-only (no change)
> >   - remaining drivers: hard read/write (no change)
> >
> >
> > Option 1: Rename @auto-read-only.
> >
> > Rationale: we released auto-read-only in v3.1 with unproven fallback
> > read-only semantics.  It turned out not to be useful.  Admit the
> > mistake, retract it.  Release our next attempt in 4.0 under a suitable
> > new name with fallback read-only semantics.
> >
> > CON:
> >
> > * Compatibility break.  No-go if there are users.  Users seem quite
> >   unlikely, though.
> >
> > * Still unproven, albeit less so: this time we have some unreleased
> >   (unfinished?) libvirt code.
> >
> > * Semantics are still largely left to drivers, and the schema can't tell
> >   which one does what.  Awkward.
> >
> > * Unless we're fairly confident we won't upgrade drivers from "hard" to
> >   "fallback" to "dynamic", this merely kicks the can down the road:
> >   we'll face the exact same "how can libvirt find out" problem on every
> >   upgrade.
> >
> > PRO:
> >
> > * When libvirt sees the new name, it can rely on file-posix.c's drivers
> >   providing dynamic read-only semantics.
> >
> >
> > Option 2: Add query-qemu-features command, return
> > file-dynamic-auto-read-only #ifdef CONFIG_POSIX.
> >
> > Rationale: we released auto-read-only in v3.1 with unproven fallback
> > read-only semantics.  It turned out not to be useful.  Admit the
> > mistake, and patch it up in 4.0.  Libirt needs to know whether it's
> > patche up, and this is a simple way to tell it.
> >
> > CON:
> >
> > * All of option 1's, except for the compatibility break
> >
> > * Uses query-qemu-features to expose a property of the build.  I
> >   consider that a mistake.
> >
> > PRO
> >
> > * Libvirt can use either query-qmp-schema or query-qemu-features to find
> >   out whether it can can rely on file-posix.c's drivers providing
> >   dynamic read-only semantics.  To make query-qemu-features usable, we
> >   need to promise query-qemu-features never returns false for it.  To
> >   make query-qemu-features usable, we need to promise the value will
> >   remain valid for the remainder of the QEMU run (defeats caching) or
> >   for any future run of the same QEMU binary (enables caching).
> >
> >
> > Option 3: Add @dynamic-read-only to the drivers that provide dynamic
> > read-only, default to value of auto-read-only, promise we'll never add
> > it to drivers that don't.
> >
> > Rationale: give users explicit control over dynamic vs. fallback for all
> > drivers that can provide dynamic.  This makes some sense as an
> > interface, as long as you ignore the fact that no driver implements both
> > dynamic and fallback.  I can't see why a driver couldn't implement both.
> > It also makes dynamic support visible in the schema.
> >
> > Behavior (three bools -> eight cases):
> >
> > * read-only=on: hard read-only (no change)
> >
> >   Shorthand for read-only=on,auto-read-only=off,dynamic-read-only=off
> >
> > * read-only=on,auto-read-only=on: hard read-only (no change)
> >
> >   Shorthand for read-only=on,auto-read-only=on,dynamic-read-only=on
> >
> > * read-only=off: hard read-write (no change)
> >
> >   Shorthand for read-only=off,auto-read-only=off,dynamic-read-only=off
> >
> > * read-only=off,auto-read-only=on:
> >
> >   Shorthand for read-only=off,auto-read-only=on,dynamic-read-only=on
> >
> >   - file-posix.c's drivers: dynamic read-only (no change,
> >     dynamic-read-only=on is the default)
> >   - some other drivers: fallback read-only (no change)
> >   - remaining drivers: hard read/write (no change)
> >
> > * read-only=off,auto-read-only=on,dynamic-read-only=off
> >
> >   - file-posix.c's drivers: error
> >   - all other drivers: N/A
> >
> > * read-only=off,auto-read-only=off,dynamic-read-only=on
> >
> >   - file-posix.c's drivers: error
> >   - all other drivers: N/A
> >
> > * read-only=on,dynamic-read-only=on
> >
> >   Shorthand for read-only=on,auto-read-only=off,dynamic-read-only=on
> >
> >   - file-posix.c's drivers: error
> >   - all other drivers: N/A
> >
> > * read-only=on,auto-read-only=on,dynamic-read-only=off
> >
> >   Shorthand for read-only=on,auto-read-only=on,dynamic-read-only=off
> >
> >   - file-posix.c's drivers: error
> >   - all other drivers: N/A
> >
> > CON:
> >
> > * Two bools (read-only and auto-read-only) to select from three choices
> >   was already ugly.  Three bools (the same plus dynamic-read-only) to
> >   select from four choices is even uglier.
> >
> > * The explicit control is just a facade so far: since only the default
> >   setting is implemented, it doesn't actually control anything.
> >
> > PRO:
> >
> > * When libvirt sees a driver providing a dynamic-read-only parameter, it
> >   knows it can rely on the driver providing dynamic read-only semantics.
> >
> > * Adding dynamic read-only capability to drivers creates no
> >   introspection problems: we simply add dynamic-read-only to their
> >   parameters.
> >
> > Code sketch appended
> 
> Option 4 [Kevin]: Add a dummy option to BlockdevOptionsFile.
> Message-ID: <20190401115410.GB4935@localhost.localdomain>
> 
> A variation of option 3, code is almost identical.  Where option 3 tries
> to evolve what we have into the least bad permanent interface, option 4
> only wants to serve as a stop gap until we get a better solution, such
> as option 5.

I think code-wise, this is actually very different from option 3. We
need to actually process the dynamic-read-only option with option 3, and
I can see things go wrong easily, which is not something to do for -rc2.

Option 4, in contrast, is purely a minimal schema change without
touching any C source file.

> Option 5 [Kevin]: Add feature flags to the QAPI language, use one to say
> "this block driver provides dynamic read-only".
> Message-ID: <20190401140842.GD4935@localhost.localdomain>

More complex than option 4, but the advantage here is that none of the
new code is actually externally visible, so if the implementation turns
out buggy, we can fix it without having to maintain compatibility with
the broken state.

The actually visible change, the query-qmp-schema output, is almost as
minimal as option 4 and can manually be verified.

A bit more invasive than option 4, but I'd consider it still doable for
-rc2 if we decide quickly.

> Option 6 [Peter]: Trigger reopen explicitly via QMP.
> Message-ID: <20190401122054.GA2686@andariel.pipo.sk>
> [Me] This leaves auto-read-only without a use case; deprecate?

We have made some progress there with the new x-blockdev-reopen command.
There are a few things that we know must be addressed before we can
declare it stable, and probably there are more such things that we don't
know of.

x-blockdev-reopen takes the same options as blockdev-add and as such has
a similar complexity. The experience with blockdev-add makes me doubt
that we can mark it stable even for 4.1. So this might be a long-term
solution, but we'd have to do something else for the meantime.

> Given that the libvirt code isn't ready, why do we need this done and
> declared stable in 4.0?  We're going to tag -rc2 tomorrow...

The next libvirt release will be long before the next QEMU release. If
we don't have it in 4.0, enabling -blockdev will have to wait until the
first libvirt release after the QEMU 4.1 release (so maybe September)
and we'll still be stuck with -drive and unable to start deprecating it
until then.

Also, we don't want to give Peter the excuse that the qemu code isn't
ready. ;-)

Kevin
