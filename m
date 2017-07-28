Received: from eggs.gnu.org ([2001:4830:134:3::10]:42101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db3s3-0001l1-C1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db3s1-0008Bi-Oj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:55:55 -0400
Date: Fri, 28 Jul 2017 13:55:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728115538.GC3983@localhost.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, Jeff Cody <jcody@redhat.com>, armbru@redhat.com

Am 28.07.2017 um 00:09 hat John Snow geschrieben:
> On 07/26/2017 02:23 PM, Manos Pitsidianakis wrote:
> > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> > > > This proposal follows a discussion we had with Kevin and Stefan
> > > > on filter
> > > > node management.
> > > > 
> > > > With block filter drivers arises a need to configure filter
> > > > nodes on runtime
> > > > with QMP on live graphs. A problem with doing live graph
> > > > modifications is
> > > > that some block jobs modify the graph when they are done and
> > > > don't operate
> > > > under any synchronisation, resulting in a race condition if we
> > > > try to insert
> > > > a filter node in the place of an existing edge.
> > > 
> > > But maybe you are thinking about higher level race conditions between
> > > QMP commands.  Can you give an example of the race?
> > 
> > Exactly, synchronisation between the QMP/user actions. Here's an
> > example, correct me if I'm wrong:
> > 
> > User issues a block-commit to this tree to commit A onto B:
> >     BB -> A -> B
> > 
> > This inserts the dummy mirror node at the top since this is a mirror job
> > (active commit)
> >     BB -> dummy -> A -> B
> > 
> > User wants to add a filter node F below the BB. First we create the node:
> >     BB -> dummy -> A -> B
> >        F /
> > 
> > Commit finishes before we do block-insert-node, dummy and A is removed
> > from the BB's chain, mirror_exit calls bdrv_replace_node()
> > 
> >     BB ------------> B
> >                 F -> /
> > 
> > Now inserting F under BB will error since dummy does not exist any more.

So the basic scenario is the one from the last section of the STR block
meeting notes:

http://lists.gnu.org/archive/html/qemu-block/2016-12/msg00045.html

At the time, this scenario seemed to make sense, but in fact, as your
explanation show, it's not a real problem. The theory that inserting the
filter would bring the mirror_top node back is false because removing
the mirror_top node updates _all_ of its parents (including the new
throttling node) rather than just the BB to point to the BDS below.

However, whether block-insert-node actually fails depends on how you
address the edge(s) on which you want to insert a filter node. We would
only get an error if you specify it as "insert filter above this node".
However, this is not a way to unambiguously reference a single edge, you
could only update _all_ incoming edges for a node at once. Therefore I
don't think this is a good way to do things.

An unambiguous way to identify a single edge is the name of the parent
node (usually a node-name, but possibly a BB name - they share a single
namespace, so having one QMP argument for both could be enough) and of
the child (as in BdrvChild), e.g. "insert as new child=backing of
node=myimage",

This way, the example scenario would actually just work.

> Exactly how much of a problem is this? You, the user, have instructed QEMU
> to do two conflicting things:
> 
> (1) Squash A down into B, and
> (2) Insert a filter above A
> 
> Shame on you for deleting the node you were trying to reference, no? And as
> an added bonus, QEMU will even error out on your command instead of trying
> to do something and getting it wrong.
> 
> Is this a problem?

I don't think these two actions can reasonably be considered
conflicting, adding a filter on top doesn't influence the commit
operation at all.

We used to just forbid everything while doing block jobs, but these
operations are block jobs because they are long-running, and just
forbidding everything for a long time isn't very helpful. There is no
reason why a user shouldn't be able to take a snapshot while they are
creating a backup, etc.

As I said above, filter nodes automagically going away at some point
without an explicit user command isn't necessarily a problem, but I
also don't feel very comfortable with it. It certainly feels like an
easy way to introduce bugs. Things should become much easier to manage
when all graph modifications are explicit.

I'm surprised that you seem to be opposed to an explicit job-delete now
as we already discussed this before and it would solve several problems:

* Block job completion issues only an event. If the management tools
  reconnects, it has no way to get the same information with a query-*
  command. If jobs stay around until job-delete, this is not a problem.

* Completion is usually rather complicated with all of the graph changes
  and involves operations that can fail, but we don't have a way to
  actually report errors to the user. job-delete could do that.

* And finally the management problem we're discussing here. Yes, if I
  want to snapshot below a mirror node and the mirror goes away
  immediately before I send the command, libvirt will just get an error
  and can process all events and update its graph view and then retry
  with another node name.

  Though even if it's possible, do you really believe this will be fun
  to implement for management tools and help to avoid bugs? Or will
  people even remember to properly implement this?

On the other hand, the downsides of job-delete:

* Er... Haven't heard of any yet. Maybe inconvenient for human users?
  But they shouldn't be using QMP anyway.

> > The proposal doesn't guard against the following:
> > User issues a block-commit to this tree to commit B onto C:
> >     BB -> A -> B -> C
> > 
> > The dummy node (commit's top bs is A):
> >     BB -> A -> dummy -> B -> C
> > 
> > blockdev-add of a filter we wish to eventually be between A and C:
> >     BB -> A -> dummy -> B -> C
> >              F/
> > 
> > if commit finishes before we issue block-insert-node (commit_complete()
> > calls bdrv_set_backing_hd() which only touches A)
> >     BB -> A --------------> C
> >            F -> dummy -> B /
> >     resulting in error when issuing block-insert-node,
> 
> Because "B" and "dummy" have already actually been deleted, I assume. (The
> diagram is confusing.)

Why would there be a graph change at all before job-delete?

> > else if we set the job to manual-delete and insert F:
> >     BB -> A -> F -> dummy -> B -> C
> > deleting the job will result in F being lost since the job's top bs
> > wasn't updated.
> 
> Seems like a fairly good reason not to pursue this avenue then, yes?

That's an implementation problem of the commit job. That it requires
knowledge about the graph above the commit_top node is just completely
wrong. The current implementation works for the trivial case, but not
for much more. You don't even have to add filters dynamically for it to
break.

A future correct commit job would just replace the commit_top node by
base when it completes.

I have patches to implement this change, but unfortunately they revealed
some bugs between bdrv_reopen() and op blockers, so they aren't ready
yet to be posted.

> I think I agree with Stefan's concerns that this is more of a
> temporary workaround for the benefit of jobs, but that there may well
> be other reasons (especially in the future) where graph manipulations
> may occur invisibly to the user.

We should do our best to avoid this. Implicit graph changes only make
libvirt's life hard. I agree that we'll have many more graph changes in
the future, but let's keep them as explicit as possible.

> Do you have any use cases for failure here that don't involve the user
> themselves asking for two conflicting things? That is, QEMU doing some graph
> reorganization without the user's knowledge coupled with the user asking for
> a new filter node?
> 
> Are there any failures that result in anything more dangerous or bad than a
> "404: node not found" style error where we simply reject the premise of what
> the user was attempting to accomplish?

"404: node not found" is already very bad if you want management tools
to be able to cope with it.

Kevin
