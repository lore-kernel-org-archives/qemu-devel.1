Received: from eggs.gnu.org ([2001:4830:134:3::10]:41629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNEGH-0003dI-QT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNEG0-0008H8-89
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNEG0-0008Gf-07
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-4-david@redhat.com>
	<874lcjmue4.fsf@dusky.pond.sub.org>
	<2ba6fbb2-d2cb-a4b3-61f5-385b08f822bd@redhat.com>
Date: Thu, 15 Nov 2018 10:48:09 +0100
In-Reply-To: <2ba6fbb2-d2cb-a4b3-61f5-385b08f822bd@redhat.com> (David
	Hildenbrand's message of "Wed, 14 Nov 2018 20:56:30 +0100")
Message-ID: <87tvkiisdi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 14.11.18 18:38, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> The input visitor has some problems right now, especially
>>> - unsigned type "Range" is used to process signed ranges, resulting in
>>>   inconsistent behavior and ugly/magical code
>>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>>   supported and error messages are misleading
>>> - lists/ranges of int64_t are accepted although no list is parsed and
>>>   we should rather report an error
>>> - lists/ranges are preparsed using int64_t, making it hard to
>>>   implement uint64_t values or uint64_t lists
>>> - types that don't support lists don't bail out
>> 
>> Known weirdness: empty list is invalid (test-string-input-visitor.c
>> demonstates).  Your patch doesn't change that (or else it would update
>> the test).  Should it be changed?
>> 
>
> I don't change the test, so the old behavior still works.
> (empty string -> error)

Understand.  Design question: should it remain an error?  Feel free to
declare the question out of scope for this patch.

>>> So let's rewrite it by getting rid of usage of the type "Range" and
>>> properly supporting lists of int64_t and uint64_t (including ranges of
>>> both types), fixing the above mentioned issues.
>>>
>>> Lists of other types are not supported and will properly report an
>>> error. Virtual walks are now supported.
>>>
>>> Tests have to be fixed up:
>>> - Two BUGs were hardcoded that are fixed now
>>> - The string-input-visitor now actually returns a parsed list and not
>>>   an ordered set.
>>>
>>> While at it, do some smaller style changes (e.g. use g_assert).
>> 
>> Please don't replace assert() by g_assert() in files that consistently
>> use assert() now.
>
> Alright, will use assert() and don't replace. (I thought g_assert() was
> the new fancy thing to do it in QEMU).
>
>> In my opinion, g_assert() is one of the cases where GLib pointlessly
>> reinvents wheels that have been carrying load since forever.
>> 
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  include/qapi/string-input-visitor.h |   3 +-
>>>  qapi/string-input-visitor.c         | 436 +++++++++++++++++-----------
>>>  tests/test-string-input-visitor.c   |  18 +-
>>>  3 files changed, 264 insertions(+), 193 deletions(-)
>>>
>>> diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string-input-visitor.h
>>> index 33551340e3..2c40f7f5a6 100644
>>> --- a/include/qapi/string-input-visitor.h
>>> +++ b/include/qapi/string-input-visitor.h
>>> @@ -19,8 +19,7 @@ typedef struct StringInputVisitor StringInputVisitor;
>>>  
>>>  /*
>>>   * The string input visitor does not implement support for visiting
>>> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>>> - * requires a non-null list argument to visit_start_list().
>>> + * QAPI structs, alternates, null, or arbitrary QTypes.
>> 
>> Preexisting: neglects to spell out the list limitations, i.e. can do
>> only flat lists of integers.  Care do fix that, too?
>
> Added "Only flat lists of integers (int64/uint64) are supported."

Hmm, do lists of narrower integer types also work?  I guess they do: the
narrower visit_type_*int*() call v->type_*int64() via
visit_type_*intN().

Lists of type size are expressly excluded, in parse_type_size() below.
That's okay, we can lift the restriction when it gets in the way.

>>>   */
>>>  Visitor *string_input_visitor_new(const char *str);
>>>  
>>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>>> index dee708d384..16da47409e 100644
>>> --- a/qapi/string-input-visitor.c
>>> +++ b/qapi/string-input-visitor.c
>>> @@ -4,10 +4,10 @@
>>>   * Copyright Red Hat, Inc. 2012-2016
>>>   *
>>>   * Author: Paolo Bonzini <pbonzini@redhat.com>
>>> + *         David Hildenbrand <david@redhat.com>
>>>   *
>>>   * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>>>   * See the COPYING.LIB file in the top-level directory.
>>> - *
>>>   */
>>>  
>>>  #include "qemu/osdep.h"
>>> @@ -18,21 +18,39 @@
>>>  #include "qapi/qmp/qerror.h"
>>>  #include "qapi/qmp/qnull.h"
>>>  #include "qemu/option.h"
>>> -#include "qemu/queue.h"
>>> -#include "qemu/range.h"
>>>  #include "qemu/cutils.h"
>>>  
>>> +typedef enum ListMode {
>>> +    /* no list parsing active / no list expected */
>>> +    LM_NONE,
>>> +    /* we have an unparsed string remaining */
>>> +    LM_UNPARSED,
>>> +    /* we have an unfinished int64 range */
>>> +    LM_INT64_RANGE,
>>> +    /* we have an unfinished uint64 range */
>>> +    LM_UINT64_RANGE,
>>> +    /* we have parsed the string completely and no range is remaining */
>>> +    LM_END,
>>> +} ListMode;
>>> +
>>> +typedef union RangeLimit {
>>> +    int64_t i64;
>>> +    uint64_t u64;
>>> +} RangeLimit;
>>>  
>>>  struct StringInputVisitor
>>>  {
>>>      Visitor visitor;
>>>  
>>> -    GList *ranges;
>>> -    GList *cur_range;
>>> -    int64_t cur;
>>> +    /* Porperties related to list processing */
>> 
>> "Properties"
>> 
>> Suggest
>> 
>>        /* List parsing state */
>
> Yes, will use that.
>
>> 
>>> +    ListMode lm;
>>> +    RangeLimit rangeNext;
>>> +    RangeLimit rangeEnd;
>> 
>> RangeLimit is a good name for rangeEnd, but not so hot for rangeNext.
>> Naming is hard.
>
> Initially I had two unnamed unions to not have to give a name ;)
>
> RangeElement ? Will use that for now.

Works for me.

>> 
>>> +    const char *unparsed_string;
>>> +    void *list;
>> 
>> You drop /* Only needed for sanity checking the caller */.
>> Double-checking: is that not true anymore?
>
> I consider such comments bad as they can easily become outdated (and
> IMHO don't help anybody). But I can leave it here, don't really care.

I'm okay with dropping it.

> [...]
>
>>> +        error_setg(errp, "Already processing a list.");
>> 
>> Drop the period, please.  error_setg()'s contract stipulates:
>> 
>>  * The resulting message should be a single phrase, with no newline or
>>  * trailing punctuation.
>> 
>> More of the same below.
>
> All dots dropped :)
>
> [...]
>>>  static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
>>>  {
>>>      StringInputVisitor *siv = to_siv(v);
>>> -    Range *r;
>>> -
>>> -    if (!siv->ranges || !siv->cur_range) {
>>> -        return NULL;
>>> -    }
>>>  
>>> -    r = siv->cur_range->data;
>>> -    if (!r) {
>>> +    switch (siv->lm) {
>>> +    case LM_NONE:
>>> +    case LM_END:
>>> +        /* we have reached the end of the list already or have no list */
>>>          return NULL;
>> 
>> Hmm.  Is there a way to reach case LM_NONE other than a programming
>> error?  If no, we should abort then.  To do so, fold LM_NONE into the
>> default case below.
>
> Alright, all programming errors will be encoded as asserts.

Yes, please.  In my experience, distinguishing between programming
errors and other errors really helps with understanding the code.

>> 
>>> -    }
>>> -
>>> -    if (!range_contains(r, siv->cur)) {
>>> -        siv->cur_range = g_list_next(siv->cur_range);
>>> -        if (!siv->cur_range) {
>>> -            return NULL;
>>> -        }
>>> -        r = siv->cur_range->data;
>>> -        if (!r) {
>>> -            return NULL;
>>> -        }
>>> -        siv->cur = range_lob(r);
>>> +    case LM_INT64_RANGE:
>>> +    case LM_UINT64_RANGE:
>>> +    case LM_UNPARSED:
>>> +        /* we have an unparsed string or something left in a range */
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>> 
>> abort() suffices, and is more consistent with the rest of qapi/.
>
> Right, qapi is special ;)

Sort of.  I like keeping things consistent and simple.  Some parts of
QEMU consistently use plain assert(), some parts consistently use
g_assert(), and some mix them up with abandon.  I'm fighting a rearguard
action against the latter.

> Will use s/g_assert/assert/
> s/g_assert_not_reached/abort/

Thanks!

>> 
>>>      }
>>>  
>>>      tail->next = g_malloc0(size);
>>> @@ -179,88 +109,216 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
>>>  static void check_list(Visitor *v, Error **errp)
>>>  {
>>>      const StringInputVisitor *siv = to_siv(v);
>>> -    Range *r;
>>> -    GList *cur_range;
>>>  
>>> -    if (!siv->ranges || !siv->cur_range) {
>>> +    switch (siv->lm) {
>>> +    case LM_NONE:
>>> +        error_setg(errp, "Not processing a list.");
>> 
>> Same question as for next_list().
>
> abort() it is :) -> default case
>
>> 
>>> +    case LM_INT64_RANGE:
>>> +    case LM_UINT64_RANGE:
>>> +    case LM_UNPARSED:
>>> +        error_setg(errp, "There are elements remaining in the list.");
>> 
>> Hmm.  qobject_input_check_list() reports "Only %u list elements expected
>> in %s" here.  Looks unintuitive, until you remember how it's normally
>> used: to parse user input.  The error gets reported when the parsing
>> didn't consume the whole list.  Can only happen with a virtual walk.
>> And when it happens, the issue to report is "you provided a longer list
>> than I can accept".  qobject_input_check_list() does exactly that.  Your
>> message is less clear.
>
> We don't keep track of element count (and I don't like adding it just to
> print a error message).

The QObject input visitor has more of a need for identifying the
offending part of the input precisely, because it supports nesting.

> What about "Less list elements expected"? That at least matches the
> other error.

Good enough.  I'd say "fewer", though.

>> 
>>>          return;
>>> -    }
>>> -
>>> -    r = siv->cur_range->data;
>>> -    if (!r) {
>>> +    case LM_END:
>>>          return;
>>> +    default:
>>> +        g_assert_not_reached();
>>>      }
>>> -
>>> -    if (!range_contains(r, siv->cur)) {
>>> -        cur_range = g_list_next(siv->cur_range);
>>> -        if (!cur_range) {
>>> -            return;
>>> -        }
>>> -        r = cur_range->data;
>>> -        if (!r) {
>>> -            return;
>>> -        }
>>> -    }
>>> -
>>> -    error_setg(errp, "Range contains too many values");
>>>  }
>>>  
>>>  static void end_list(Visitor *v, void **obj)
>>>  {
>>>      StringInputVisitor *siv = to_siv(v);
>>>  
>>> -    assert(siv->list == obj);
>> 
>> I suspect state LM_NONE is also a programming error here.  If that's
>> correct, let's assert(siv->lm != LM_NONE).
>
> Indeed, added.
>
> [...]
>>> +        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj == INT64_MAX) {
>>> +            /* end of range, check if there is more to parse */
>>> +            if (siv->unparsed_string[0]) {
>>> +                siv->lm = LM_UNPARSED;
>>> +            } else {
>>> +                siv->lm = LM_END;
>>> +            }
>>>          }
>> 
>> Are you sure this is kosher?
>> 
>> if siv->rangeNext.i64 and siv->rangeEnd are both initially INT64_MAX,
>> siv->rangeNext++ wraps around to INT64_MIN.  Except when the compiler
>> exploits undefined behavior.
>
> *obj == INT64_MAX checks exactly that
>
> (it is the old value of siv->rangeNext.i64 before a possible wraparound).

By the time you check *obj == INT64_MAX, you already executed
siv->rangeNext++ with undefined behavior.

But wait... your code is fine because we compile with -fwrapv.

> BTW I added a test case for exactly that as I had the BUG you described
> in the code ;)
>
> [...]
>>> +        return;
>>> +    case LM_UNPARSED:
>>> +        if (try_parse_int64_list_entry(siv, obj)) {
>>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
>>> +                       "list of int64 values or ranges");
>>> +        }
>> 
>> I figure I'd make try_parse_int64_list_entry() just parse, and on
>> success fall through to case LM_INT64_RANGE.  But your solution works,
>> too.
>
> Then we would have to represent even single values as ranges, which is
> something I'd like to avoid.

Your artistic license applies.

>>> +        return;
>>> +    case LM_END:
>>> +        error_setg(errp, "No more elements in the list.");
>> 
>> This is the buddy of check_list() case LM_UNPARSED etc.  There, input
>> provides more list members than we expect.  Here, input provides less.
>> Again, the error is less clear than the one the QObject input visitor
>> reports: "Parameter '%s' is missing".
>> 
>> Same for the unsigned copy below.
>
> Will also use "Less list elements expected".

Good enough.  I'd say "fewer", though.

> "Parameter '%s' is missing" does not really apply to list elements
> without a name. We can discuss when I resend.

The QObject input visitor uses the list index as name, see
full_name_nth().  I'm *not* suggesting you implement that for the string
input visitor.

>> 
>>> +        return;
>>> +    default:
>>> +        error_setg(errp, "Lists don't support mixed types.");
>> 
>> Is this a programming error?
>> 
>> Same for the unsigned copy below.
>
> abort() it is.
>
> [...]
>>> +
>>> +        if (siv->rangeNext.u64 > siv->rangeEnd.u64 || *obj == UINT64_MAX) {
>>> +            /* end of range, check if there is more to parse */
>>> +            if (siv->unparsed_string[0]) {
>>> +                siv->lm = LM_UNPARSED;
>>> +            } else {
>>> +                siv->lm = LM_END;
>>> +            }
>>> +        }
>> 
>> Unsigned wraps around fine.  But when you fix the signed code, you
>> should probably keep this unsigned code as similar as practical.
>
> Again, *obj == UINT64_MAX checks this.
>
>> 
>>> +        return;
>>> +    case LM_UNPARSED:
>>> +        if (try_parse_uint64_list_entry(siv, obj)) {
>>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
>>> +                       "list of uint64 values or ranges");
>>> +        }
>>> +        return;
>>> +    case LM_END:
>>> +        error_setg(errp, "No more elements in the list.");
>>> +        return;
>>> +    default:
>>> +        error_setg(errp, "Lists don't support mixed types.");
>>> +        return;
>>>      }
>>>  }
>>>  
>>> @@ -271,6 +329,11 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
>>>      Error *err = NULL;
>>>      uint64_t val;
>>>  
>>> +    if (siv->lm != LM_NONE) {
>>> +        error_setg(errp, "Lists not supported for type \"size\"");
>>> +        return;
>>> +    }
>>> +
>> 
>> Programming error?  More of the same below.
>
> assert() it is.
>
> [...]
>>>      visit_type_uint64List(v, NULL, &res, &error_abort);
>>>      tail = res;
>>>      for (i = 0; i < n; i++) {
>>> @@ -117,10 +107,10 @@ static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
>>>  static void test_visitor_in_intList(TestInputVisitorData *data,
>>>                                      const void *unused)
>>>  {
>>> -    /* Note: the visitor *sorts* ranges *unsigned* */
>>> -    int64_t expect1[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
>>> +    int64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5,
>> 
>> Please wrap this line a bit earlier.
>
> Will do.
>
>> 
>>> +                          6, 7, 8 };
>>>      int64_t expect2[] = { 32767, -32768, -32767 };
>>> -    int64_t expect3[] = { INT64_MAX, INT64_MIN };
>>> +    int64_t expect3[] = { INT64_MIN, INT64_MAX };
>> 
>> Did you mean to change this line?
>> 
>
> Yes, we don't sort the list anymore.

D'oh!

>>>      uint64_t expect4[] = { UINT64_MAX };
>>>      Error *err = NULL;
>>>      int64List *res = NULL;
>>> @@ -189,7 +179,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>>>      visit_type_int64(v, NULL, &tail->value, &err);
>>>      g_assert_cmpint(tail->value, ==, 0);
>>>      visit_type_int64(v, NULL, &val, &err);
>>> -    g_assert_cmpint(val, ==, 1); /* BUG */
>>> +    error_free_or_abort(&err);
>> 
>> Which of the problems listed in commit message is this?
>
> I guess the not mentioned "visiting beyond the end of a list is not
> handled properly" bug (most probably due to old range handling). Will
> add it to the description,

Thanks!

>> 
>>>      visit_check_list(v, &error_abort);
>>>      visit_end_list(v, (void **)&res);
>> 
>> Please don't let my review comments discourage you!  This is so much
>> better than the code we have now, and feels pretty close to ready.
>> Thanks a lot!
>> 
>
> I appreciate people reviewing my code :) So don't worry, I'll do
> requested changes and resend, then we'll see what we are still missing.
>
> BTW: I'll add support for single-element ranges (1-1) as the previous
> code seemed to accepted that.

Good idea.
