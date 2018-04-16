Received: from eggs.gnu.org ([2001:4830:134:3::10]:41193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f870P-0004oW-89
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f870M-0008PM-JV
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:29:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f870M-0008On-Cv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:29:22 -0400
Date: Mon, 16 Apr 2018 17:29:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416162919.GC12819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<1502467522-32237-3-git-send-email-armbru@redhat.com>
	<df0646df-6e46-4361-010d-aac529177b62@redhat.com>
	<20170814094433.GD8506@redhat.com>
	<87lgmme6ji.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgmme6ji.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com

On Mon, Aug 14, 2017 at 01:24:17PM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > On Fri, Aug 11, 2017 at 12:47:44PM -0500, Eric Blake wrote:
> >> On 08/11/2017 11:05 AM, Markus Armbruster wrote:
> >> > We've wanted -object to support non-scalar properties for a while.
> >> > Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
> >> > authorization API".  Review led to the conclusion that we need to
> >> > replace rather than add to QemuOpts.  Initial work towards that goal
> >> > has been merged to provide -blockdev (commit 8746709), but there's
> >> > substantial work left, mostly due to an bewildering array of
> >> > compatibility problems.
> >> > 
> >> > Even if a full solution is still out of reach, we can have a partial
> >> > solution now: accept -object argument in JSON syntax.  This should
> >> > unblock development work that needs non-scalar properties with
> >> > -object.
> >> > 
> >> > The implementation is similar to -blockdev, except we use the new
> >> > infrastructure only for the new JSON case, and stick to QemuOpts for
> >> > the existing KEY=VALUE,... case, to sidestep compatibility problems.
> >> > 
> >> > If we did this for more options, we'd have to factor out common code.
> >> > But for one option, this will do.
> >> > 
> >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> > ---
> >> >  qapi-schema.json | 14 +++++++++++---
> >> >  vl.c             | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 62 insertions(+), 3 deletions(-)
> >> > 
> >> >  static void object_create(bool (*type_predicate)(const char *))
> >> >  {
> >> > +    ObjectOptionsQueueEntry *e, *next;
> >> > +
> >> > +    QSIMPLEQ_FOREACH_SAFE(e, &oo_queue, entry, next) {
> >> > +        if (!type_predicate(e->oo->qom_type)) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        loc_push_restore(&e->loc);
> >> > +        qmp_object_add(e->oo->qom_type, e->oo->id,
> >> > +                       e->oo->has_props, e->oo->props, &error_fatal);
> >> > +        loc_pop(&e->loc);
> >> > +
> >> > +        QSIMPLEQ_REMOVE(&oo_queue, e, ObjectOptionsQueueEntry, entry);
> >> > +        qapi_free_ObjectOptions(e->oo);
> >> > +    }
> >> > +
> >> >      if (qemu_opts_foreach(qemu_find_opts("object"),
> >> 
> >> This handles all JSON forms prior to any QemuOpt forms (within the two
> >> priority levels), such that a command line using:
> >> 
> >>  -object type,id=1,oldstyle... -object '{'id':2, 'type':..., newstyle...}'
> >> 
> >> processes the arguments in a different order than
> >> 
> >>  -object type,id=1,oldstyle... -object type,id=2,oldstyle
> >> 
> >> But I don't see that as too bad (ideally, someone using the {} JSON
> >> style will use it consistently).
> >
> > I don't really like such a constraint - the ordering of object
> > creation is already complex with some objets created at a different
> > point in startup to other objects. Adding yet another constraint
> > feels like it is painting ourselves into a corner wrt future changes.
> 
> The full solution will evaluate -object left to right.
> 
> This partial solution doesn't, but it's not meant for use in anger, just
> for unblocking development work.  Can add scary warnings to deter
> premature use.
> 
> > In particular I think it is quite possible to use the dotted
> > form primarily, and only use JSON for the immediate scenario
> > where non-JSON form won't work - I expect that's how we would
> > use it in libvirt - I don't see libvirt changing 100% to JSON
> > based objects
> 
> You need the JSON form anyway for QMP, and for the cases where dotted
> keys break down.  Doing both just for the command line requires code to
> do dotted keys (which may already exist), and code to decide whether it
> can be used (which probably doesn't exist, yet).
> 
> Wouldn't this add complexity?  For what benefit exactly?

Surprisingly, it appears we do actually have code that generates the
JSON syntax for (probably) all uses of -object today. In fact we are
actually generating JSON and then converting it to dotted syntax in
most cases, which I didn't realize when writing the above.

We'll have to keep support for dotted syntax around a while for old
QEMU versions, but it looks like we could reasonably easily switch
to JSON syntax for all -object usage at the same time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
