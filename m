Received: from eggs.gnu.org ([2001:4830:134:3::10]:47920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gN1HM-0002y7-Uu
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gN1HE-0001Nc-TJ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:56:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gN1H9-0001Id-4z
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:56:37 -0500
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-4-david@redhat.com>
	<874lcjmue4.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2ba6fbb2-d2cb-a4b3-61f5-385b08f822bd@redhat.com>
Date: Wed, 14 Nov 2018 20:56:30 +0100
MIME-Version: 1.0
In-Reply-To: <874lcjmue4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 14.11.18 18:38, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> The input visitor has some problems right now, especially
>> - unsigned type "Range" is used to process signed ranges, resulting in
>>   inconsistent behavior and ugly/magical code
>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>   supported and error messages are misleading
>> - lists/ranges of int64_t are accepted although no list is parsed and
>>   we should rather report an error
>> - lists/ranges are preparsed using int64_t, making it hard to
>>   implement uint64_t values or uint64_t lists
>> - types that don't support lists don't bail out
>=20
> Known weirdness: empty list is invalid (test-string-input-visitor.c
> demonstates).  Your patch doesn't change that (or else it would update
> the test).  Should it be changed?
>=20

I don't change the test, so the old behavior still works.
(empty string -> error)

>>
>> So let's rewrite it by getting rid of usage of the type "Range" and
>> properly supporting lists of int64_t and uint64_t (including ranges of
>> both types), fixing the above mentioned issues.
>>
>> Lists of other types are not supported and will properly report an
>> error. Virtual walks are now supported.
>>
>> Tests have to be fixed up:
>> - Two BUGs were hardcoded that are fixed now
>> - The string-input-visitor now actually returns a parsed list and not
>>   an ordered set.
>>
>> While at it, do some smaller style changes (e.g. use g_assert).
>=20
> Please don't replace assert() by g_assert() in files that consistently
> use assert() now.

Alright, will use assert() and don't replace. (I thought g_assert() was
the new fancy thing to do it in QEMU).

>=20
> In my opinion, g_assert() is one of the cases where GLib pointlessly
> reinvents wheels that have been carrying load since forever.
>=20
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/qapi/string-input-visitor.h |   3 +-
>>  qapi/string-input-visitor.c         | 436 +++++++++++++++++----------=
-
>>  tests/test-string-input-visitor.c   |  18 +-
>>  3 files changed, 264 insertions(+), 193 deletions(-)
>>
>> diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string=
-input-visitor.h
>> index 33551340e3..2c40f7f5a6 100644
>> --- a/include/qapi/string-input-visitor.h
>> +++ b/include/qapi/string-input-visitor.h
>> @@ -19,8 +19,7 @@ typedef struct StringInputVisitor StringInputVisitor=
;
>> =20
>>  /*
>>   * The string input visitor does not implement support for visiting
>> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>> - * requires a non-null list argument to visit_start_list().
>> + * QAPI structs, alternates, null, or arbitrary QTypes.
>=20
> Preexisting: neglects to spell out the list limitations, i.e. can do
> only flat lists of integers.  Care do fix that, too?

Added "Only flat lists of integers (int64/uint64) are supported."

>=20
>>   */
>>  Visitor *string_input_visitor_new(const char *str);
>> =20
>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> index dee708d384..16da47409e 100644
>> --- a/qapi/string-input-visitor.c
>> +++ b/qapi/string-input-visitor.c
>> @@ -4,10 +4,10 @@
>>   * Copyright Red Hat, Inc. 2012-2016
>>   *
>>   * Author: Paolo Bonzini <pbonzini@redhat.com>
>> + *         David Hildenbrand <david@redhat.com>
>>   *
>>   * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>>   * See the COPYING.LIB file in the top-level directory.
>> - *
>>   */
>> =20
>>  #include "qemu/osdep.h"
>> @@ -18,21 +18,39 @@
>>  #include "qapi/qmp/qerror.h"
>>  #include "qapi/qmp/qnull.h"
>>  #include "qemu/option.h"
>> -#include "qemu/queue.h"
>> -#include "qemu/range.h"
>>  #include "qemu/cutils.h"
>> =20
>> +typedef enum ListMode {
>> +    /* no list parsing active / no list expected */
>> +    LM_NONE,
>> +    /* we have an unparsed string remaining */
>> +    LM_UNPARSED,
>> +    /* we have an unfinished int64 range */
>> +    LM_INT64_RANGE,
>> +    /* we have an unfinished uint64 range */
>> +    LM_UINT64_RANGE,
>> +    /* we have parsed the string completely and no range is remaining=
 */
>> +    LM_END,
>> +} ListMode;
>> +
>> +typedef union RangeLimit {
>> +    int64_t i64;
>> +    uint64_t u64;
>> +} RangeLimit;
>> =20
>>  struct StringInputVisitor
>>  {
>>      Visitor visitor;
>> =20
>> -    GList *ranges;
>> -    GList *cur_range;
>> -    int64_t cur;
>> +    /* Porperties related to list processing */
>=20
> "Properties"
>=20
> Suggest
>=20
>        /* List parsing state */

Yes, will use that.

>=20
>> +    ListMode lm;
>> +    RangeLimit rangeNext;
>> +    RangeLimit rangeEnd;
>=20
> RangeLimit is a good name for rangeEnd, but not so hot for rangeNext.
> Naming is hard.

Initially I had two unnamed unions to not have to give a name ;)

RangeElement ? Will use that for now.

>=20
>> +    const char *unparsed_string;
>> +    void *list;
>=20
> You drop /* Only needed for sanity checking the caller */.
> Double-checking: is that not true anymore?

I consider such comments bad as they can easily become outdated (and
IMHO don't help anybody). But I can leave it here, don't really care.

[...]

>> +        error_setg(errp, "Already processing a list.");
>=20
> Drop the period, please.  error_setg()'s contract stipulates:
>=20
>  * The resulting message should be a single phrase, with no newline or
>  * trailing punctuation.
>=20
> More of the same below.

All dots dropped :)

[...]
>>  static GenericList *next_list(Visitor *v, GenericList *tail, size_t s=
ize)
>>  {
>>      StringInputVisitor *siv =3D to_siv(v);
>> -    Range *r;
>> -
>> -    if (!siv->ranges || !siv->cur_range) {
>> -        return NULL;
>> -    }
>> =20
>> -    r =3D siv->cur_range->data;
>> -    if (!r) {
>> +    switch (siv->lm) {
>> +    case LM_NONE:
>> +    case LM_END:
>> +        /* we have reached the end of the list already or have no lis=
t */
>>          return NULL;
>=20
> Hmm.  Is there a way to reach case LM_NONE other than a programming
> error?  If no, we should abort then.  To do so, fold LM_NONE into the
> default case below.

Alright, all programming errors will be encoded as asserts.

>=20
>> -    }
>> -
>> -    if (!range_contains(r, siv->cur)) {
>> -        siv->cur_range =3D g_list_next(siv->cur_range);
>> -        if (!siv->cur_range) {
>> -            return NULL;
>> -        }
>> -        r =3D siv->cur_range->data;
>> -        if (!r) {
>> -            return NULL;
>> -        }
>> -        siv->cur =3D range_lob(r);
>> +    case LM_INT64_RANGE:
>> +    case LM_UINT64_RANGE:
>> +    case LM_UNPARSED:
>> +        /* we have an unparsed string or something left in a range */
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>=20
> abort() suffices, and is more consistent with the rest of qapi/.

Right, qapi is special ;)

Will use s/g_assert/assert/
s/g_assert_not_reached/abort/

>=20
>>      }
>> =20
>>      tail->next =3D g_malloc0(size);
>> @@ -179,88 +109,216 @@ static GenericList *next_list(Visitor *v, Gener=
icList *tail, size_t size)
>>  static void check_list(Visitor *v, Error **errp)
>>  {
>>      const StringInputVisitor *siv =3D to_siv(v);
>> -    Range *r;
>> -    GList *cur_range;
>> =20
>> -    if (!siv->ranges || !siv->cur_range) {
>> +    switch (siv->lm) {
>> +    case LM_NONE:
>> +        error_setg(errp, "Not processing a list.");
>=20
> Same question as for next_list().

abort() it is :) -> default case

>=20
>> +    case LM_INT64_RANGE:
>> +    case LM_UINT64_RANGE:
>> +    case LM_UNPARSED:
>> +        error_setg(errp, "There are elements remaining in the list.")=
;
>=20
> Hmm.  qobject_input_check_list() reports "Only %u list elements expecte=
d
> in %s" here.  Looks unintuitive, until you remember how it's normally
> used: to parse user input.  The error gets reported when the parsing
> didn't consume the whole list.  Can only happen with a virtual walk.
> And when it happens, the issue to report is "you provided a longer list
> than I can accept".  qobject_input_check_list() does exactly that.  You=
r
> message is less clear.

We don't keep track of element count (and I don't like adding it just to
print a error message).

What about "Less list elements expected"? That at least matches the
other error.

>=20
>>          return;
>> -    }
>> -
>> -    r =3D siv->cur_range->data;
>> -    if (!r) {
>> +    case LM_END:
>>          return;
>> +    default:
>> +        g_assert_not_reached();
>>      }
>> -
>> -    if (!range_contains(r, siv->cur)) {
>> -        cur_range =3D g_list_next(siv->cur_range);
>> -        if (!cur_range) {
>> -            return;
>> -        }
>> -        r =3D cur_range->data;
>> -        if (!r) {
>> -            return;
>> -        }
>> -    }
>> -
>> -    error_setg(errp, "Range contains too many values");
>>  }
>> =20
>>  static void end_list(Visitor *v, void **obj)
>>  {
>>      StringInputVisitor *siv =3D to_siv(v);
>> =20
>> -    assert(siv->list =3D=3D obj);
>=20
> I suspect state LM_NONE is also a programming error here.  If that's
> correct, let's assert(siv->lm !=3D LM_NONE).

Indeed, added.

[...]
>> +        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj =3D=3D INT=
64_MAX) {
>> +            /* end of range, check if there is more to parse */
>> +            if (siv->unparsed_string[0]) {
>> +                siv->lm =3D LM_UNPARSED;
>> +            } else {
>> +                siv->lm =3D LM_END;
>> +            }
>>          }
>=20
> Are you sure this is kosher?
>=20
> if siv->rangeNext.i64 and siv->rangeEnd are both initially INT64_MAX,
> siv->rangeNext++ wraps around to INT64_MIN.  Except when the compiler
> exploits undefined behavior.

*obj =3D=3D INT64_MAX checks exactly that

(it is the old value of siv->rangeNext.i64 before a possible wraparound).

BTW I added a test case for exactly that as I had the BUG you described
in the code ;)

[...]
>> +        return;
>> +    case LM_UNPARSED:
>> +        if (try_parse_int64_list_entry(siv, obj)) {
>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? nam=
e : "null",
>> +                       "list of int64 values or ranges");
>> +        }
>=20
> I figure I'd make try_parse_int64_list_entry() just parse, and on
> success fall through to case LM_INT64_RANGE.  But your solution works,
> too.

Then we would have to represent even single values as ranges, which is
something I'd like to avoid.

>=20
>> +        return;
>> +    case LM_END:
>> +        error_setg(errp, "No more elements in the list.");
>=20
> This is the buddy of check_list() case LM_UNPARSED etc.  There, input
> provides more list members than we expect.  Here, input provides less.
> Again, the error is less clear than the one the QObject input visitor
> reports: "Parameter '%s' is missing".
>=20
> Same for the unsigned copy below.

Will also use "Less list elements expected".

"Parameter '%s' is missing" does not really apply to list elements
without a name. We can discuss when I resend.

>=20
>> +        return;
>> +    default:
>> +        error_setg(errp, "Lists don't support mixed types.");
>=20
> Is this a programming error?
>=20
> Same for the unsigned copy below.

abort() it is.

[...]
>> +
>> +        if (siv->rangeNext.u64 > siv->rangeEnd.u64 || *obj =3D=3D UIN=
T64_MAX) {
>> +            /* end of range, check if there is more to parse */
>> +            if (siv->unparsed_string[0]) {
>> +                siv->lm =3D LM_UNPARSED;
>> +            } else {
>> +                siv->lm =3D LM_END;
>> +            }
>> +        }
>=20
> Unsigned wraps around fine.  But when you fix the signed code, you
> should probably keep this unsigned code as similar as practical.

Again, *obj =3D=3D UINT64_MAX checks this.

>=20
>> +        return;
>> +    case LM_UNPARSED:
>> +        if (try_parse_uint64_list_entry(siv, obj)) {
>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? nam=
e : "null",
>> +                       "list of uint64 values or ranges");
>> +        }
>> +        return;
>> +    case LM_END:
>> +        error_setg(errp, "No more elements in the list.");
>> +        return;
>> +    default:
>> +        error_setg(errp, "Lists don't support mixed types.");
>> +        return;
>>      }
>>  }
>> =20
>> @@ -271,6 +329,11 @@ static void parse_type_size(Visitor *v, const cha=
r *name, uint64_t *obj,
>>      Error *err =3D NULL;
>>      uint64_t val;
>> =20
>> +    if (siv->lm !=3D LM_NONE) {
>> +        error_setg(errp, "Lists not supported for type \"size\"");
>> +        return;
>> +    }
>> +
>=20
> Programming error?  More of the same below.

assert() it is.

[...]
>>      visit_type_uint64List(v, NULL, &res, &error_abort);
>>      tail =3D res;
>>      for (i =3D 0; i < n; i++) {
>> @@ -117,10 +107,10 @@ static void check_ulist(Visitor *v, uint64_t *ex=
pected, size_t n)
>>  static void test_visitor_in_intList(TestInputVisitorData *data,
>>                                      const void *unused)
>>  {
>> -    /* Note: the visitor *sorts* ranges *unsigned* */
>> -    int64_t expect1[] =3D { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
>> +    int64_t expect1[] =3D { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2=
, 3, 4, 5,
>=20
> Please wrap this line a bit earlier.

Will do.

>=20
>> +                          6, 7, 8 };
>>      int64_t expect2[] =3D { 32767, -32768, -32767 };
>> -    int64_t expect3[] =3D { INT64_MAX, INT64_MIN };
>> +    int64_t expect3[] =3D { INT64_MIN, INT64_MAX };
>=20
> Did you mean to change this line?
>=20

Yes, we don't sort the list anymore.

>>      uint64_t expect4[] =3D { UINT64_MAX };
>>      Error *err =3D NULL;
>>      int64List *res =3D NULL;
>> @@ -189,7 +179,7 @@ static void test_visitor_in_intList(TestInputVisit=
orData *data,
>>      visit_type_int64(v, NULL, &tail->value, &err);
>>      g_assert_cmpint(tail->value, =3D=3D, 0);
>>      visit_type_int64(v, NULL, &val, &err);
>> -    g_assert_cmpint(val, =3D=3D, 1); /* BUG */
>> +    error_free_or_abort(&err);
>=20
> Which of the problems listed in commit message is this?

I guess the not mentioned "visiting beyond the end of a list is not
handled properly" bug (most probably due to old range handling). Will
add it to the description,

>=20
>>      visit_check_list(v, &error_abort);
>>      visit_end_list(v, (void **)&res);
>=20
> Please don't let my review comments discourage you!  This is so much
> better than the code we have now, and feels pretty close to ready.
> Thanks a lot!
>=20

I appreciate people reviewing my code :) So don't worry, I'll do
requested changes and resend, then we'll see what we are still missing.

BTW: I'll add support for single-element ranges (1-1) as the previous
code seemed to accepted that.

--=20

Thanks,

David / dhildenb
