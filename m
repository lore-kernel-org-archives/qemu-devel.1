Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f86vx-0002es-6q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f86vt-00051W-U0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:24:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f86vt-00050f-M9
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:24:45 -0400
Date: Mon, 16 Apr 2018 17:24:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416162434.GB12819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<1502467522-32237-3-git-send-email-armbru@redhat.com>
	<df0646df-6e46-4361-010d-aac529177b62@redhat.com>
	<87shgusnp9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87shgusnp9.fsf@dusky.pond.sub.org>
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
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, pbonzini@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, f4bug@amsat.org

On Mon, Aug 14, 2017 at 07:49:54AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 08/11/2017 11:05 AM, Markus Armbruster wrote:
> >> We've wanted -object to support non-scalar properties for a while.
> >> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
> >> authorization API".  Review led to the conclusion that we need to
> >> replace rather than add to QemuOpts.  Initial work towards that goal
> >> has been merged to provide -blockdev (commit 8746709), but there's
> >> substantial work left, mostly due to an bewildering array of
> >> compatibility problems.
> >> 
> >> Even if a full solution is still out of reach, we can have a partial
> >> solution now: accept -object argument in JSON syntax.  This should
> >> unblock development work that needs non-scalar properties with
> >> -object.
> >> 
> >> The implementation is similar to -blockdev, except we use the new
> >> infrastructure only for the new JSON case, and stick to QemuOpts for
> >> the existing KEY=VALUE,... case, to sidestep compatibility problems.
> >> 
> >> If we did this for more options, we'd have to factor out common code.
> >> But for one option, this will do.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  qapi-schema.json | 14 +++++++++++---
> >>  vl.c             | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 62 insertions(+), 3 deletions(-)
> >> 
> >>  static void object_create(bool (*type_predicate)(const char *))
> >>  {
> >> +    ObjectOptionsQueueEntry *e, *next;
> >> +
> >> +    QSIMPLEQ_FOREACH_SAFE(e, &oo_queue, entry, next) {
> >> +        if (!type_predicate(e->oo->qom_type)) {
> >> +            continue;
> >> +        }
> >> +
> >> +        loc_push_restore(&e->loc);
> >> +        qmp_object_add(e->oo->qom_type, e->oo->id,
> >> +                       e->oo->has_props, e->oo->props, &error_fatal);
> >> +        loc_pop(&e->loc);
> >> +
> >> +        QSIMPLEQ_REMOVE(&oo_queue, e, ObjectOptionsQueueEntry, entry);
> >> +        qapi_free_ObjectOptions(e->oo);
> >> +    }
> >> +
> >>      if (qemu_opts_foreach(qemu_find_opts("object"),
> >
> > This handles all JSON forms prior to any QemuOpt forms (within the two
> > priority levels), such that a command line using:
> >
> >  -object type,id=1,oldstyle... -object '{'id':2, 'type':..., newstyle...}'
> >
> > processes the arguments in a different order than
> >
> >  -object type,id=1,oldstyle... -object type,id=2,oldstyle
> >
> > But I don't see that as too bad (ideally, someone using the {} JSON
> > style will use it consistently).
> 
> Yes, that's another restriction: if you need your -object evaluated in a
> certain order, you may have to stick to one of the two syntax variants.
> 
> Aside: there are two sane evaluation orders: (1) strictly left to right,
> and (2) order doesn't matter.  QEMU of course does (3) unpredicable for
> humans without referring back to the source code.

IIUC, to "fix" the ordering problem we need to be able to consider the
ordering of all QEMU args, not just -object.  

The horrible hack with the two stage setup of -object in vl.c is driven by
the fact that some objects are referenced by -device/-chardev args, while
objects are referencing -device/-chardev args etc. This is the big problem
to untangle, and understandable you don't want to tackle that for this
patch. Until we can figure out how to address the big problem, it would be
nice not to introduce yet another ordering though driven off usage of
json vs non-json syntax.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
