Received: from eggs.gnu.org ([209.51.188.92]:56704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hB30y-0007pG-EP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hB30x-0000NM-3j
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:54:40 -0400
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
Date: Mon, 01 Apr 2019 21:54:12 +0200
In-Reply-To: <20190401140842.GD4935@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 1 Apr 2019 16:08:42 +0200")
Message-ID: <87k1gdjycb.fsf@dusky.pond.sub.org>
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
>
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

[Patch snipped...]

Caveat emptor: at this time of day, I'm perfectly capable of missing the
obvious.  Assuming I don't: for once, something doesn't turn out six
times as hard as anticipated.

Missing:

* Test coverage: two negative tests for the two errors, positive
  coverage in qapi-schema-test.json

* Update to introspect.json (without this, qmp-cmd-test fails, and with
  qapi-schema-test.json updated, test /visitor/input/qapi-introspect
  will fail, too),

* Update a few tests/qapi-schema/*.err

* Update docs/devel/qapi-code-gen.txt

* A general idea how to document feature flags

* Depending on that, perhaps an update to the documentation generator
  scripts/qapi/doc.py

* A rough idea on where else feature flags need to go
