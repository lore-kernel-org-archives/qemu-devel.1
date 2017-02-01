Received: from eggs.gnu.org ([2001:4830:134:3::10]:35572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYqmM-0008Ej-QG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYqmL-0002X7-Dn
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:00:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-8-git-send-email-armbru@redhat.com>
	<894b7bb8-768b-de12-cb48-7c9d52333bbe@redhat.com>
	<87efzjcn2p.fsf@dusky.pond.sub.org>
	<13043bdb-4fd7-6e1a-308a-605b46272788@redhat.com>
Date: Wed, 01 Feb 2017 10:00:23 +0100
In-Reply-To: <13043bdb-4fd7-6e1a-308a-605b46272788@redhat.com> (John Snow's
	message of "Tue, 31 Jan 2017 10:37:15 -0500")
Message-ID: <87zii6guag.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] blockdev: Make
 orphaned -drive fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

John Snow <jsnow@redhat.com> writes:

> On 01/31/2017 09:37 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 01/26/2017 10:09 AM, Markus Armbruster wrote:
>>>> Block backends defined with "-drive if=T" with T other than "none" are
>>>> meant to be picked up by machine initialization code: a suitable
>>>> frontend gets created and wired up automatically.
>>>>
>>>> If machine initialization code doesn't comply, the block backend
>>>> remains unused.  This triggers a warning since commit a66c9dc, v2.2.0.
>>>> Drives created by default are excempted; use -nodefaults to get rid of
>>>> them.
>>>>
>>>> Turn this warning into an error.
>>>>
>>>
>>> "Exempted," oddly enough.
>>> </eblake>
>> 
>> Thanks!
>> 
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  blockdev.c                | 14 +++++++-------
>>>>  include/sysemu/blockdev.h |  2 +-
>>>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/blockdev.c b/blockdev.c
>>>> index a597a66..ec9c114 100644
>>>> --- a/blockdev.c
>>>> +++ b/blockdev.c
>>>> @@ -227,28 +227,28 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit)
>>>>      return NULL;
>>>>  }
>>>>  
>>>> -bool drive_check_orphaned(void)
>>>> +void drive_check_orphaned(void)
>>>>  {
>>>>      BlockBackend *blk;
>>>>      DriveInfo *dinfo;
>>>>      Location loc;
>>>> -    bool rs = false;
>>>> +    bool orphans = false;
>>>>  
>>>>      for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>>>>          dinfo = blk_legacy_dinfo(blk);
>>>> -        /* If dinfo->bdrv->dev is NULL, it has no device attached. */
>>>> -        /* Unless this is a default drive, this may be an oversight. */
>>>>          if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
>>>>              dinfo->type != IF_NONE) {
>>>>              loc_push_none(&loc);
>>>>              qemu_opts_loc_restore(dinfo->opts);
>>>> -            error_report("warning: machine type does not support this drive");
>>>> +            error_report("machine type does not support this drive");
>>>>              loc_pop(&loc);
>>>> -            rs = true;
>>>> +            orphans = true;
>>>>          }
>>>>      }
>>>>  
>>>> -    return rs;
>>>> +    if (orphans) {
>>>> +        exit(1);
>>>> +    }
>>>
>>> Hardcore. Why not just return a status code and allow vl.c to exit? It
>>> only has the one caller. (Unless you added more and I didn't read
>>> because I'm lazy.)
>>>
>>> You could even add an Error **arg if you wanted to; but vl.c has exits
>>> all over the dang place, so maybe that's not really interesting.
>> 
>> My excuse it that checking for orphans makes sense only during initial
>> startup, and there, exit(1) on error is what we do.  Doing it right away
>> is simplest.
>> 
>> I'm fine with leaving the exit() to the caller.  I would prefer to leave
>> the printing to the caller as well then.

Returning an Error makes reporting all offending -drive too bothersome
to be worthwhile.  We'd report just the first one then.  Pity.

>> Anyone else got a preference?
>> 
>
> I guess my preference here was just simply to keep the exit() out of
> blockdev.c to discourage code-by-example naughtiness in the future.

Understand.  Of course, the error handling rules are a good deal more
complex than "don't exit()".

During initial startup, including command line processing, we exit() on
error.  This is generally wrong elsewhere.  exit() right away saves us
the error-prone busy-work of propagating errors and cleaning up along
the way.  Half-hearted error handling like "I don't dare to exit(), so I
propagate, but I can't be bothered to clean up, because I know we'll
exit()" is the worst, in my opinion.

For reporting errors during startup, error_report() is appropriate.
fprintf() is bad, because it leads to inferior error messages (no
location, no timestamp).

In HMP commands, error_report() is appopriate.  monitor_printf() works,
but is bad style, because it makes errors less obvious in the code.

In code that's used for both by HMP and startup, error_report() is fine,
but you can't exit().

When error_report() is appropriate, calling it right away saves us the
propagating.  Occasionally permits better error messages, because it's
less of a straitjacket.

In QMP commands, you need to error_setg().  error_report(),
monitor_printf, fprintf() and so forth are all wrong.

In code that doesn't (want to) know in what context (startup, HMP, QMP,
other) it is used, you generally need to error_setg().  However, there
are situations where that is plainly impossible, e.g. in a callback for
a guest device register access.  error_report() may be the best you can
do there.  abort() or its fancy cousin hw_error() is still used in many
places.

My point is: when the context is clear, what to do is fairly obvious.
Sadly, we tend to mix code meant for different contexts willy-nilly,
which can make the context needlessly hard to see.

One way to deal with that is to minimize relying on context.  Minimizing
assumptions is good.  Complicating / boiler-plating the code is bad.
Tradeoff.

When a function could conceivably be useful in different contexts,
keeping it unaware of the context can be worth the boilerplate, even
when it's currently used only in one context.

But when it's clearly useful in just one context, I tend to balk.

drive_check_orphaned() makes sense only during startup.  Not relying on
that isn't so bad, because there's nothing to clean up.  Would be easier
to decide if it was bad ;)

> As many as I can keep or cram into vl.c, the better, I think?

Only 142 out of 1000+ exit() are in vl.c.  You got work to do!

> Well, that's my story.
>
> --js
