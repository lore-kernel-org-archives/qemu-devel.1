Received: from eggs.gnu.org ([209.51.188.92]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAwj7-0003QY-Gn
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAwj5-0000U9-GJ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:11:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<20190401115410.GB4935@localhost.localdomain>
Date: Mon, 01 Apr 2019 15:11:36 +0200
In-Reply-To: <20190401115410.GB4935@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 1 Apr 2019 13:54:10 +0200")
Message-ID: <87k1gdyinr.fsf@dusky.pond.sub.org>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 31.03.2019 um 14:56 hat Markus Armbruster geschrieben:
>> Let's review our options for 4.0.
>> 
>> Please note my analysis is handicapped by incomplete information, in
>> particular on libvirt's needs.
>> 
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
>
> The situation is a bit more complex than this:
>
> libvirt requires dynamic read-only for file-posix. It prefers dynamic
> read-only for other drivers, but can live with fallback read-only there.

Aha!

> Only file-posix implements dynamic read-only today. Other drivers
> implement only fallback read-only.
>
> Therefore libvirt has a use case for using fallback read-only for
> non-file-posix drivers.
>
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
>> read-only semantics.  It turned out not to be useful.
>
> It turned out not to be useful for file-posix in the context of libvirt
> with sVirt enabled. That's a different thing than just "not useful".

Right.  It turned out to be insufficient, which is not the same as "not
useful".

>> Admit the mistake, retract it.  Release our next attempt in 4.0 under
>> a suitable new name with fallback read-only semantics.
>
> I'm confused. Do you mean s/fallback/dynamic/?

Messed up prose, sorry.

> file-posix is the only driver than implements dynamic read-only, so this
> is not a suitable replacement for auto-read-only, which is supported by
> many other drivers, too (with fallback read-only semantics, which is
> useful enough for libvirt for those drivers). Removing auto-read-only
> without adding a replacement for all drivers that support it would be a
> regression.

Our next attempt is actually "dynamic read-only with file-posix.c's
drivers, fallback read-only with some other drivers, hard read/write
with the remaining drivers".  All enabled by a single flag.

Documenting this with sufficient precision without making a mess of it
won't be easy.

In my opinion, we did make a mess of it in 3.1: we specified only what
QEMU *may* do, not what it actually does.  Am I confused or was libvirt
expected to rely on actual behavior and not just the specification?

>> CON:
>> 
>> * Compatibility break.  No-go if there are users.  Users seem quite
>>   unlikely, though.
>> 
>> * Still unproven, albeit less so: this time we have some unreleased
>>   (unfinished?) libvirt code.
>
> We had this last time, too. Peter just didn't realise that he hadn't
> sVirt enabled in his development build...

I see.  High pressure is bound to lead to mistakes.

>> * Semantics are still largely left to drivers, and the schema can't tell
>>   which one does what.  Awkward.
>> 
>> * Unless we're fairly confident we won't upgrade drivers from "hard" to
>>   "fallback" to "dynamic", this merely kicks the can down the road:
>>   we'll face the exact same "how can libvirt find out" problem on every
>>   upgrade.
>
> Hm, maybe you meant something different above. Would the new command
> actually be dynamic read-only only for file-posix and fallback read-only
> for everything else?

Yes.

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

"To make query-qmp-schema usable", of course.

>>   need to promise query-qemu-features never returns false for it.  To
>>   make query-qemu-features usable, we need to promise the value will
>>   remain valid for the remainder of the QEMU run (defeats caching) or
>>   for any future run of the same QEMU binary (enables caching).
>
> I don't agree with your assessment here.
>
> query-qmp-schema, as its name says, queries the QMP schema, which
> describes the structure of QMP communication, not generally features of
> the QEMU build.
>
> Features are often related in some way to a QAPI type and clients query
> the schema anyway, so it's convenient to add additional information
> about features there. But it's not the only place where it makes sense.

I've never denied the existence of use cases for query-qemu-features.
I just believe this ain't one :)

> The schema for query-qemu-features should tell you whether this QEMU
> version even knows about a feature like this, i.e. whether it is capable
> of providing this information in a QMP response. Only executing the
> command returns whether the feature is actually supported in this build.
> Inferring the value of a field from its presence in the schema feels
> wrong.

That depends.

If we specify that query-qemu-features never returns false for a certain
feature, there is no need to actually run it to obtain the feature's
value.  If you prefer to run query-qemu-features anyway, go ahead and
run it to your heart's content.  You'll still rely on "never returns
false", because that's the part that tells you for how long the response
remains valid.

If we don't specify "never returns false", we get to specify directly
for how long the response remains valid.

>> Option 3: Add @dynamic-read-only to the drivers that provide dynamic
>> read-only, default to value of auto-read-only, promise we'll never add
>> it to drivers that don't.
>> 
>> Rationale: give users explicit control over dynamic vs. fallback for all
>> drivers that can provide dynamic.  This makes some sense as an
>> interface, as long as you ignore the fact that no driver implements both
>> dynamic and fallback.  I can't see why a driver couldn't implement both.
>> It also makes dynamic support visible in the schema.
>
> Except that we don't even give users more control (the drivers still
> provide what they provide), but we require users to specify that they
> actually expect what the driver provides.

That would be a feature.  Declaring needs explicitly is *good*.

We don't actually require it here because of defaults.

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
> Option 4:
>
> Add a dummy option to BlockdevOptionsFile:
>
>     '*x-auto-read-only-is-dynamic': { 'type': 'null',
>                                       'if': 'defined(CONFIG_POSIX)' }
>
> Specifying it has no effect, so the ridiculous complexity of three bools
> to select from three options is avoided. Its presence in the schema
> indicates that file-posix implements dynamic auto-read-only.
>
> Basically this is features flags in the schema without having proper
> feature flags yet.
>
> Once we add real annotations (hopefully 4.1), this dummy field can be
> removed again.

Exact same patch as for option 3, with the parameter renamed and the
sanity check for non-sensical use dropped.  *Shrug*

Puts more pressure on me to deliver QAPI feature flags sooner rather
than later.  My QAPI pressure control valve has been shedding pressure
for a while, so "bring it on".  I'd advise against holding your breath,
though.

SIGCHLD, back later.
