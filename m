Received: from eggs.gnu.org ([209.51.188.92]:36445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyul-0005DS-08
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyuj-0006WE-NI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:31:58 -0400
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
	<87k1gdyinr.fsf@dusky.pond.sub.org>
	<20190401140842.GD4935@localhost.localdomain>
Date: Mon, 01 Apr 2019 17:31:49 +0200
In-Reply-To: <20190401140842.GD4935@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 1 Apr 2019 16:08:42 +0200")
Message-ID: <87tvfhlp22.fsf@dusky.pond.sub.org>
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
Cc: pkrempa@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 01.04.2019 um 15:11 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Option 4:
>> >
>> > Add a dummy option to BlockdevOptionsFile:
>> >
>> >     '*x-auto-read-only-is-dynamic': { 'type': 'null',
>> >                                       'if': 'defined(CONFIG_POSIX)' }
>> >
>> > Specifying it has no effect, so the ridiculous complexity of three bools
>> > to select from three options is avoided. Its presence in the schema
>> > indicates that file-posix implements dynamic auto-read-only.
>> >
>> > Basically this is features flags in the schema without having proper
>> > feature flags yet.
>> >
>> > Once we add real annotations (hopefully 4.1), this dummy field can be
>> > removed again.
>> 
>> Exact same patch as for option 3, with the parameter renamed and the
>> sanity check for non-sensical use dropped.  *Shrug*
>> 
>> Puts more pressure on me to deliver QAPI feature flags sooner rather
>> than later.  My QAPI pressure control valve has been shedding pressure
>> for a while, so "bring it on".  I'd advise against holding your breath,
>> though.
>
> Okay, let's stop beating around the bush.
>
> Nobody has told me so explicitly during this discussion, but implicitly
> I understand that everyone seems to think doing annotations in the
> schema is what we really want to have.

I think it would make a useful addition to QAPI.

I don't think it's the ideal solution to the problem at hand.  But the
problem at hand may not have ideal solutions.

We put @auto-read-only in 3.1 unproven.  As specified, it gives QEMU
wide latitude to open read-only instead of read-write, and to reopen.
It doesn't *require* QEMU to do anything in particular.

3.1's implementation conforms to this specification (it would be hard
not to).

Libvirt needs more than is specified (it would be hard not to), and more
than is implemented in 3.1.

We changed the implementation in 4.0 to give libvirt what it needs (to
the best of our knowledge).  This implementation still conforms to the
specification (again, hard not to).

Libvirt needs to know whether it's dealing with a 3.1 implementation or
a 4.0 implementation.  A feature bit in the schema can expose this
cleanly in introspection.

But it's still an awful interface, to be frank.  Let's try to write a
doc comment for it.

# @read-only:     whether the block device should be read-only (default: false).
#                 Note that some block drivers support only read-only access,
#                 either generally or in certain configurations. In this case,
#                 the default value does not work and the option must be
#                 specified explicitly.
# @auto-read-only: if true and @read-only is false, QEMU may automatically
#                  decide not to open the image read-write as requested, but
#                  fall back to read-only instead (and switch between the modes
#                  later), e.g. depending on whether the image file is writable
#                  or whether a writing user is attached to the node.
#                  If the variant part corresponding to @driver carries
#                  feature flag dynamic-auto-read-only, then QEMU will
#                  always open the image read-only, reopen it read/write
#                  when the first writing user attaches to the node, and
#                  reopen it read-only when the last writing user
#                  detaches from the node.
#                  (default: false, since 3.1)

This still underspecifies fallback read-only.  If libvirt wants to rely
on it, we'll get to tighten up that part.

Behavior is governed by three separate entities: feature flag
@dynamic-read-only, members @read-only and @auto-read-only.  Bonus: the
feature flag lives somewhere else.  Where it'll also need documentation.

Now compare to this hypothetical interface: @read-only can be true,
false, "dynamic" (some drivers only) or "fallback (some drivers only,
assuming we even need it).

To make introspection show the values the driver accepts, @read-only has
to move from BlockdevOptions into the BlockdevOptionsFoo.  In some of
them, it remains bool, in BlockdevOptionsFile it becomes an alternate of
bool and an enum with the single value "dynamic", and so forth.

Perhaps this implementing this would be too onerous.

> Instead of continuing to argue which option to get around it is the
> least ugly one - how bad is the following attempt at just implementing
> what we really want?
>
> Only for structs for now, but that's all we need at the moment. Should
> be easy to extend during the 4.1 cycle (or whenever we need something
> else).
>
> Note that even if there are bugs in it, they are not user-visible and
> can just be fixed in 4.1. Currently, a diff between old and new
> query-qmp-schema output looks sane - just the added 'features' list
> where we want it.

I'll try to review the patch later today.
