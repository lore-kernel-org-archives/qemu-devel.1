Received: from eggs.gnu.org ([2001:4830:134:3::10]:60490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNEUC-00046z-BK
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNEU8-0006hW-A9
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:30:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fNEU8-0006h9-1i
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:30:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<1502467522-32237-3-git-send-email-armbru@redhat.com>
	<df0646df-6e46-4361-010d-aac529177b62@redhat.com>
	<87shgusnp9.fsf@dusky.pond.sub.org>
	<20180416162434.GB12819@redhat.com>
Date: Mon, 28 May 2018 11:30:33 +0200
In-Reply-To: <20180416162434.GB12819@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Mon, 16 Apr 2018 17:24:34 +0100")
Message-ID: <87vab8nn46.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: kwolf@redhat.com, el13635@mail.ntua.gr, f4bug@amsat.org, qemu-devel@nongnu.org, pbonzini@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 14, 2017 at 07:49:54AM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>> > On 08/11/2017 11:05 AM, Markus Armbruster wrote:
>> >> We've wanted -object to support non-scalar properties for a while.
>> >> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
>> >> authorization API".  Review led to the conclusion that we need to
>> >> replace rather than add to QemuOpts.  Initial work towards that goal
>> >> has been merged to provide -blockdev (commit 8746709), but there's
>> >> substantial work left, mostly due to an bewildering array of
>> >> compatibility problems.
>> >>=20
>> >> Even if a full solution is still out of reach, we can have a partial
>> >> solution now: accept -object argument in JSON syntax.  This should
>> >> unblock development work that needs non-scalar properties with
>> >> -object.
>> >>=20
>> >> The implementation is similar to -blockdev, except we use the new
>> >> infrastructure only for the new JSON case, and stick to QemuOpts for
>> >> the existing KEY=3DVALUE,... case, to sidestep compatibility problems.
>> >>=20
>> >> If we did this for more options, we'd have to factor out common code.
>> >> But for one option, this will do.
>> >>=20
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >> ---
>> >>  qapi-schema.json | 14 +++++++++++---
>> >>  vl.c             | 51 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>> >>  2 files changed, 62 insertions(+), 3 deletions(-)
>> >>=20
>> >>  static void object_create(bool (*type_predicate)(const char *))
>> >>  {
>> >> +    ObjectOptionsQueueEntry *e, *next;
>> >> +
>> >> +    QSIMPLEQ_FOREACH_SAFE(e, &oo_queue, entry, next) {
>> >> +        if (!type_predicate(e->oo->qom_type)) {
>> >> +            continue;
>> >> +        }
>> >> +
>> >> +        loc_push_restore(&e->loc);
>> >> +        qmp_object_add(e->oo->qom_type, e->oo->id,
>> >> +                       e->oo->has_props, e->oo->props, &error_fatal);
>> >> +        loc_pop(&e->loc);
>> >> +
>> >> +        QSIMPLEQ_REMOVE(&oo_queue, e, ObjectOptionsQueueEntry, entry=
);
>> >> +        qapi_free_ObjectOptions(e->oo);
>> >> +    }
>> >> +
>> >>      if (qemu_opts_foreach(qemu_find_opts("object"),
>> >
>> > This handles all JSON forms prior to any QemuOpt forms (within the two
>> > priority levels), such that a command line using:
>> >
>> >  -object type,id=3D1,oldstyle... -object '{'id':2, 'type':..., newstyl=
e...}'
>> >
>> > processes the arguments in a different order than
>> >
>> >  -object type,id=3D1,oldstyle... -object type,id=3D2,oldstyle
>> >
>> > But I don't see that as too bad (ideally, someone using the {} JSON
>> > style will use it consistently).
>>=20
>> Yes, that's another restriction: if you need your -object evaluated in a
>> certain order, you may have to stick to one of the two syntax variants.
>>=20
>> Aside: there are two sane evaluation orders: (1) strictly left to right,
>> and (2) order doesn't matter.  QEMU of course does (3) unpredicable for
>> humans without referring back to the source code.
>
> IIUC, to "fix" the ordering problem we need to be able to consider the
> ordering of all QEMU args, not just -object.=20=20

Yes.

> The horrible hack with the two stage setup of -object in vl.c is driven by
> the fact that some objects are referenced by -device/-chardev args, while
> objects are referencing -device/-chardev args etc. This is the big problem
> to untangle, and understandable you don't want to tackle that for this
> patch. Until we can figure out how to address the big problem, it would be
> nice not to introduce yet another ordering though driven off usage of
> json vs non-json syntax.

I proposed the patch as a quick hack to unblock development.  We then
decided we had nothing worthwhile to unblock at the time.

You now want it as a stop gap so certain features don't have to wait
until I crack the more general command line expressiveness problem.  I
agree we should reconsider what warts and restrictions are acceptable
for this different, more serious purpose.

I doubt the reordering wart and its accompanying "don't mix dotted keys
with JSON if you need evaluation in order" restriction is inacceptable.
However, avoiding the reordering wart might be easier than debating it,
so let me look into that first.
