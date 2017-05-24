Received: from eggs.gnu.org ([2001:4830:134:3::10]:54703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dDW6k-0004Fe-7s
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dDW6f-0007aa-8W
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dDW6e-0007a5-Uz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4F27C059723
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:13:39 +0000 (UTC)
Date: Wed, 24 May 2017 10:13:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170524131337.GH32274@thinpad.lan.raisama.net>
References: <20170520020914.14562-1-ehabkost@redhat.com>
	<87o9uj64ro.fsf@dusky.pond.sub.org>
	<20170523143443.GE32274@thinpad.lan.raisama.net>
	<87zie2pi5f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zie2pi5f.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 0/3] qmp: Return extra information on
 qom-list-types
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

On Wed, May 24, 2017 at 02:13:16PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, May 23, 2017 at 04:12:43PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > This series adds 'abstract' and 'parent-types' fields to the
> >> > output of qom-list-types.
> >> 
> >> Peeking at PATCH 3, it looks like 'parent-types' is the transitive
> >> closure of the single direct parent type (TypeImpl member parent_type).
> >> Do we need information on interfaces as well?
> >
> > I think we should, but it is more complex so I plan to do in a
> > separate patch.
> 
> Okay.
> 
> >> > For reference, below are the sizes of the output of
> >> > "qom-list-types abstract=true" on qemu-system-x86_64, before and
> >> > after applying the patches:
> >> >
> >> > * before: 11724 bytes
> >> > * with 'abstract' field: 20119 bytes
> >> > * with 'abstract' and 'parent-types': 44383 bytes
> >> 
> >> Obvious ways to save space:
> >> 
> >> * Make 'abstract' optional, default to false, present only when
> >>   necessary (79 out of 456 times right now)
> >
> > Good idea.
> >
> >> 
> >> * Pare down 'parent-types' to *direct* parent types.  The indirect ones
> >>   are redundant.
> >
> > On the one hand, I assume clients don't care if a given type is a
> > direct parent or indirect parent, and including only the direct
> > parent type will require them to make extra queries.
> 
> Given the direct parents, computing their transitive closure is trivial.
> So a single query should suffice.

If you have the full list, yes.  I was thinking of something like
asking "does type FOO is a (direct or indirect) child of BAR?".

"qom-list-types implements=FOO" wouldn't suffice.

"qom-list-types implements=BAR" would be enough, but it would
also return all subtypes of BAR.

However, I think this example is not very realistic.  libvirt,
for example, does query everything about QEMU capabilities only
once, and then cache it.  Even if a client doesn't cache it, the
size of "qom-list-types implements=BAR" should be reasonable.

> 
> > On the other hand, if the client wants to save a few queries it
> > can use the "implements" argument, already? Not sure.
> >
> >> 
> >> A less obvious way:
> >> 
> >> * 'parent-types' defines a relation with adjacency lists.  If the
> >>   relation is tree-shaped, we can send the tree instead, i.e. a tree of
> >>   device names rather than list of (device name, adjacency list).  New
> >>   command unless we're willing to break qom-list-types.
> >> 
> >> > I'm not sure if extending qom-list-types with this info is the
> >> > right way to go, or if we should keep qom-list-types as-is and
> >> > add a new "query-qom-type" QMP command to query info on one QOM
> >> > type at a time.
> >> 
> >> Might lead to more traffic rather than less.  Depends on what
> >> information the client needs to query.
> >
> > I think queries that return all available QOM types are likely to
> > (should?) be cached by clients.
> 
> Perhaps libvirt developers can help us here.

The only usage of qom-list-types I found in libvirt has no
command arguments, and is called by code that checks for cached
information first.

> 
> >                                  I believe the size will stay
> > acceptable if we implement the two suggestions above.
> 
> Please do.

-- 
Eduardo
