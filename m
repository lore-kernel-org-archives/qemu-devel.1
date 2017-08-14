Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dh8GJ-0003dH-Nj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 01:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dh8GG-0008Rl-LQ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 01:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dh8GG-0008RI-CO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 01:50:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<1502467522-32237-3-git-send-email-armbru@redhat.com>
	<df0646df-6e46-4361-010d-aac529177b62@redhat.com>
Date: Mon, 14 Aug 2017 07:49:54 +0200
In-Reply-To: <df0646df-6e46-4361-010d-aac529177b62@redhat.com> (Eric Blake's
	message of "Fri, 11 Aug 2017 12:47:44 -0500")
Message-ID: <87shgusnp9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, f4bug@amsat.org, el13635@mail.ntua.gr

Eric Blake <eblake@redhat.com> writes:

> On 08/11/2017 11:05 AM, Markus Armbruster wrote:
>> We've wanted -object to support non-scalar properties for a while.
>> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
>> authorization API".  Review led to the conclusion that we need to
>> replace rather than add to QemuOpts.  Initial work towards that goal
>> has been merged to provide -blockdev (commit 8746709), but there's
>> substantial work left, mostly due to an bewildering array of
>> compatibility problems.
>> 
>> Even if a full solution is still out of reach, we can have a partial
>> solution now: accept -object argument in JSON syntax.  This should
>> unblock development work that needs non-scalar properties with
>> -object.
>> 
>> The implementation is similar to -blockdev, except we use the new
>> infrastructure only for the new JSON case, and stick to QemuOpts for
>> the existing KEY=VALUE,... case, to sidestep compatibility problems.
>> 
>> If we did this for more options, we'd have to factor out common code.
>> But for one option, this will do.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi-schema.json | 14 +++++++++++---
>>  vl.c             | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+), 3 deletions(-)
>> 
>>  static void object_create(bool (*type_predicate)(const char *))
>>  {
>> +    ObjectOptionsQueueEntry *e, *next;
>> +
>> +    QSIMPLEQ_FOREACH_SAFE(e, &oo_queue, entry, next) {
>> +        if (!type_predicate(e->oo->qom_type)) {
>> +            continue;
>> +        }
>> +
>> +        loc_push_restore(&e->loc);
>> +        qmp_object_add(e->oo->qom_type, e->oo->id,
>> +                       e->oo->has_props, e->oo->props, &error_fatal);
>> +        loc_pop(&e->loc);
>> +
>> +        QSIMPLEQ_REMOVE(&oo_queue, e, ObjectOptionsQueueEntry, entry);
>> +        qapi_free_ObjectOptions(e->oo);
>> +    }
>> +
>>      if (qemu_opts_foreach(qemu_find_opts("object"),
>
> This handles all JSON forms prior to any QemuOpt forms (within the two
> priority levels), such that a command line using:
>
>  -object type,id=1,oldstyle... -object '{'id':2, 'type':..., newstyle...}'
>
> processes the arguments in a different order than
>
>  -object type,id=1,oldstyle... -object type,id=2,oldstyle
>
> But I don't see that as too bad (ideally, someone using the {} JSON
> style will use it consistently).

Yes, that's another restriction: if you need your -object evaluated in a
certain order, you may have to stick to one of the two syntax variants.

Aside: there are two sane evaluation orders: (1) strictly left to right,
and (2) order doesn't matter.  QEMU of course does (3) unpredicable for
humans without referring back to the source code.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
