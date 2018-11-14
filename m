Received: from eggs.gnu.org ([2001:4830:134:3::10]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMz8k-0003ZO-50
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMz8c-000351-0o
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:39:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMz8W-0002wJ-Gi
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:39:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-4-david@redhat.com>
Date: Wed, 14 Nov 2018 18:38:43 +0100
In-Reply-To: <20181109110221.10553-4-david@redhat.com> (David Hildenbrand's
	message of "Fri, 9 Nov 2018 12:02:18 +0100")
Message-ID: <874lcjmue4.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> The input visitor has some problems right now, especially
> - unsigned type "Range" is used to process signed ranges, resulting in
>   inconsistent behavior and ugly/magical code
> - uint64_t are parsed like int64_t, so big uint64_t values are not
>   supported and error messages are misleading
> - lists/ranges of int64_t are accepted although no list is parsed and
>   we should rather report an error
> - lists/ranges are preparsed using int64_t, making it hard to
>   implement uint64_t values or uint64_t lists
> - types that don't support lists don't bail out

Known weirdness: empty list is invalid (test-string-input-visitor.c
demonstates).  Your patch doesn't change that (or else it would update
the test).  Should it be changed?

>
> So let's rewrite it by getting rid of usage of the type "Range" and
> properly supporting lists of int64_t and uint64_t (including ranges of
> both types), fixing the above mentioned issues.
>
> Lists of other types are not supported and will properly report an
> error. Virtual walks are now supported.
>
> Tests have to be fixed up:
> - Two BUGs were hardcoded that are fixed now
> - The string-input-visitor now actually returns a parsed list and not
>   an ordered set.
>
> While at it, do some smaller style changes (e.g. use g_assert).

Please don't replace assert() by g_assert() in files that consistently
use assert() now.

In my opinion, g_assert() is one of the cases where GLib pointlessly
reinvents wheels that have been carrying load since forever.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/qapi/string-input-visitor.h |   3 +-
>  qapi/string-input-visitor.c         | 436 +++++++++++++++++-----------
>  tests/test-string-input-visitor.c   |  18 +-
>  3 files changed, 264 insertions(+), 193 deletions(-)
>
> diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string-input-visitor.h
> index 33551340e3..2c40f7f5a6 100644
> --- a/include/qapi/string-input-visitor.h
> +++ b/include/qapi/string-input-visitor.h
> @@ -19,8 +19,7 @@ typedef struct StringInputVisitor StringInputVisitor;
>  
>  /*
>   * The string input visitor does not implement support for visiting
> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
> - * requires a non-null list argument to visit_start_list().
> + * QAPI structs, alternates, null, or arbitrary QTypes.

Preexisting: neglects to spell out the list limitations, i.e. can do
only flat lists of integers.  Care do fix that, too?

>   */
>  Visitor *string_input_visitor_new(const char *str);
>  
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index dee708d384..16da47409e 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -4,10 +4,10 @@
>   * Copyright Red Hat, Inc. 2012-2016
>   *
>   * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *         David Hildenbrand <david@redhat.com>
>   *
>   * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>   * See the COPYING.LIB file in the top-level directory.
> - *
>   */
>  
>  #include "qemu/osdep.h"
> @@ -18,21 +18,39 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qnull.h"
>  #include "qemu/option.h"
> -#include "qemu/queue.h"
> -#include "qemu/range.h"
>  #include "qemu/cutils.h"
>  
> +typedef enum ListMode {
> +    /* no list parsing active / no list expected */
> +    LM_NONE,
> +    /* we have an unparsed string remaining */
> +    LM_UNPARSED,
> +    /* we have an unfinished int64 range */
> +    LM_INT64_RANGE,
> +    /* we have an unfinished uint64 range */
> +    LM_UINT64_RANGE,
> +    /* we have parsed the string completely and no range is remaining */
> +    LM_END,
> +} ListMode;
> +
> +typedef union RangeLimit {
> +    int64_t i64;
> +    uint64_t u64;
> +} RangeLimit;
>  
>  struct StringInputVisitor
>  {
>      Visitor visitor;
>  
> -    GList *ranges;
> -    GList *cur_range;
> -    int64_t cur;
> +    /* Porperties related to list processing */

"Properties"

Suggest

       /* List parsing state */

> +    ListMode lm;
> +    RangeLimit rangeNext;
> +    RangeLimit rangeEnd;

RangeLimit is a good name for rangeEnd, but not so hot for rangeNext.
Naming is hard.

> +    const char *unparsed_string;
> +    void *list;

You drop /* Only needed for sanity checking the caller */.
Double-checking: is that not true anymore?

>  
> +    /* the original string to parse */
>      const char *string;
> -    void *list; /* Only needed for sanity checking the caller */
>  };
>  
>  static StringInputVisitor *to_siv(Visitor *v)
> @@ -40,136 +58,48 @@ static StringInputVisitor *to_siv(Visitor *v)
>      return container_of(v, StringInputVisitor, visitor);
>  }
>  
> -static void free_range(void *range, void *dummy)
> -{
> -    g_free(range);
> -}
> -
> -static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
> -{
> -    char *str = (char *) siv->string;
> -    long long start, end;
> -    Range *cur;
> -    char *endptr;
> -
> -    if (siv->ranges) {
> -        return 0;
> -    }
> -
> -    if (!*str) {
> -        return 0;
> -    }
> -
> -    do {
> -        errno = 0;
> -        start = strtoll(str, &endptr, 0);
> -        if (errno == 0 && endptr > str) {
> -            if (*endptr == '\0') {
> -                cur = g_malloc0(sizeof(*cur));
> -                range_set_bounds(cur, start, start);
> -                siv->ranges = range_list_insert(siv->ranges, cur);
> -                cur = NULL;
> -                str = NULL;
> -            } else if (*endptr == '-') {
> -                str = endptr + 1;
> -                errno = 0;
> -                end = strtoll(str, &endptr, 0);
> -                if (errno == 0 && endptr > str && start <= end &&
> -                    (start > INT64_MAX - 65536 ||
> -                     end < start + 65536)) {
> -                    if (*endptr == '\0') {
> -                        cur = g_malloc0(sizeof(*cur));
> -                        range_set_bounds(cur, start, end);
> -                        siv->ranges = range_list_insert(siv->ranges, cur);
> -                        cur = NULL;
> -                        str = NULL;
> -                    } else if (*endptr == ',') {
> -                        str = endptr + 1;
> -                        cur = g_malloc0(sizeof(*cur));
> -                        range_set_bounds(cur, start, end);
> -                        siv->ranges = range_list_insert(siv->ranges, cur);
> -                        cur = NULL;
> -                    } else {
> -                        goto error;
> -                    }
> -                } else {
> -                    goto error;
> -                }
> -            } else if (*endptr == ',') {
> -                str = endptr + 1;
> -                cur = g_malloc0(sizeof(*cur));
> -                range_set_bounds(cur, start, start);
> -                siv->ranges = range_list_insert(siv->ranges, cur);
> -                cur = NULL;
> -            } else {
> -                goto error;
> -            }
> -        } else {
> -            goto error;
> -        }
> -    } while (str);
> -
> -    return 0;
> -error:
> -    g_list_foreach(siv->ranges, free_range, NULL);
> -    g_list_free(siv->ranges);
> -    siv->ranges = NULL;
> -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> -               "an int64 value or range");
> -    return -1;
> -}

Good riddance!

> -
> -static void
> -start_list(Visitor *v, const char *name, GenericList **list, size_t size,
> -           Error **errp)
> +static void start_list(Visitor *v, const char *name, GenericList **list,
> +                       size_t size, Error **errp)
>  {
>      StringInputVisitor *siv = to_siv(v);
>  
> -    /* We don't support visits without a list */
> -    assert(list);
> -    siv->list = list;
> -
> -    if (parse_str(siv, name, errp) < 0) {
> -        *list = NULL;
> +    /* Properly set the state for list processing. */
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Already processing a list.");

Drop the period, please.  error_setg()'s contract stipulates:

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

More of the same below.

>          return;
>      }
> +    siv->list = list;
> +    siv->unparsed_string = siv->string;
>  
> -    siv->cur_range = g_list_first(siv->ranges);
> -    if (siv->cur_range) {
> -        Range *r = siv->cur_range->data;
> -        if (r) {
> -            siv->cur = range_lob(r);
> +    if (!siv->string[0]) {
> +        if (list) {
> +            *list = NULL;
>          }
> -        *list = g_malloc0(size);
> +        siv->lm = LM_END;
>      } else {
> -        *list = NULL;
> +        if (list) {
> +            *list = g_malloc0(size);
> +        }
> +        siv->lm = LM_UNPARSED;
>      }
>  }

Works a bit like qobject_input_start_list() now.  Good.

>  
>  static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
>  {
>      StringInputVisitor *siv = to_siv(v);
> -    Range *r;
> -
> -    if (!siv->ranges || !siv->cur_range) {
> -        return NULL;
> -    }
>  
> -    r = siv->cur_range->data;
> -    if (!r) {
> +    switch (siv->lm) {
> +    case LM_NONE:
> +    case LM_END:
> +        /* we have reached the end of the list already or have no list */
>          return NULL;

Hmm.  Is there a way to reach case LM_NONE other than a programming
error?  If no, we should abort then.  To do so, fold LM_NONE into the
default case below.

> -    }
> -
> -    if (!range_contains(r, siv->cur)) {
> -        siv->cur_range = g_list_next(siv->cur_range);
> -        if (!siv->cur_range) {
> -            return NULL;
> -        }
> -        r = siv->cur_range->data;
> -        if (!r) {
> -            return NULL;
> -        }
> -        siv->cur = range_lob(r);
> +    case LM_INT64_RANGE:
> +    case LM_UINT64_RANGE:
> +    case LM_UNPARSED:
> +        /* we have an unparsed string or something left in a range */
> +        break;
> +    default:
> +        g_assert_not_reached();

abort() suffices, and is more consistent with the rest of qapi/.

>      }
>  
>      tail->next = g_malloc0(size);
> @@ -179,88 +109,216 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
>  static void check_list(Visitor *v, Error **errp)
>  {
>      const StringInputVisitor *siv = to_siv(v);
> -    Range *r;
> -    GList *cur_range;
>  
> -    if (!siv->ranges || !siv->cur_range) {
> +    switch (siv->lm) {
> +    case LM_NONE:
> +        error_setg(errp, "Not processing a list.");

Same question as for next_list().

> +    case LM_INT64_RANGE:
> +    case LM_UINT64_RANGE:
> +    case LM_UNPARSED:
> +        error_setg(errp, "There are elements remaining in the list.");

Hmm.  qobject_input_check_list() reports "Only %u list elements expected
in %s" here.  Looks unintuitive, until you remember how it's normally
used: to parse user input.  The error gets reported when the parsing
didn't consume the whole list.  Can only happen with a virtual walk.
And when it happens, the issue to report is "you provided a longer list
than I can accept".  qobject_input_check_list() does exactly that.  Your
message is less clear.

>          return;
> -    }
> -
> -    r = siv->cur_range->data;
> -    if (!r) {
> +    case LM_END:
>          return;
> +    default:
> +        g_assert_not_reached();
>      }
> -
> -    if (!range_contains(r, siv->cur)) {
> -        cur_range = g_list_next(siv->cur_range);
> -        if (!cur_range) {
> -            return;
> -        }
> -        r = cur_range->data;
> -        if (!r) {
> -            return;
> -        }
> -    }
> -
> -    error_setg(errp, "Range contains too many values");
>  }
>  
>  static void end_list(Visitor *v, void **obj)
>  {
>      StringInputVisitor *siv = to_siv(v);
>  
> -    assert(siv->list == obj);

I suspect state LM_NONE is also a programming error here.  If that's
correct, let's assert(siv->lm != LM_NONE).

> +    g_assert(siv->list == obj);
> +    siv->list = NULL;
> +    siv->unparsed_string = NULL;
> +    siv->lm = LM_NONE;
>  }
>  
> -static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
> -                             Error **errp)
> +static int try_parse_int64_list_entry(StringInputVisitor *siv, int64_t *obj)
>  {
> -    StringInputVisitor *siv = to_siv(v);
> +    const char *endptr;
> +    int64_t start, end;
>  
> -    if (parse_str(siv, name, errp) < 0) {
> -        return;
> +    if (qemu_strtoi64(siv->unparsed_string, &endptr, 0, &start)) {
> +        return -EINVAL;
>      }
>  
> -    if (!siv->ranges) {
> -        goto error;
> +    switch (endptr[0]) {
> +    case '\0':
> +        siv->lm = LM_END;
> +        break;
> +    case ',':
> +        siv->unparsed_string = endptr + 1;
> +        break;
> +    case '-':
> +        /* parse the end of the range */
> +        if (qemu_strtoi64(endptr + 1, &endptr, 0, &end)) {
> +            return -EINVAL;
> +        }
> +        /* we require at least two elements in a range */
> +        if (start >= end) {
> +            return -EINVAL;
> +        }
> +        switch (endptr[0]) {
> +        case '\0':
> +            siv->unparsed_string = endptr;
> +            break;
> +        case ',':
> +            siv->unparsed_string = endptr + 1;
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +        /* we have a proper range */
> +        siv->lm = LM_INT64_RANGE;
> +        siv->rangeNext.i64 = start + 1;
> +        siv->rangeEnd.i64 = end;
> +        break;
> +    default:
> +        return -EINVAL;
>      }
>  
> -    if (!siv->cur_range) {
> -        Range *r;
> +    *obj = start;
> +    return 0;
> +}
>  
> -        siv->cur_range = g_list_first(siv->ranges);
> -        if (!siv->cur_range) {
> -            goto error;
> +static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
> +                             Error **errp)
> +{
> +    StringInputVisitor *siv = to_siv(v);
> +    int64_t val;
> +
> +    switch (siv->lm) {
> +    case LM_NONE:
> +        /* just parse a simple int64, bail out if not completely consumed */
> +        if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
> +                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                           name ? name : "null", "int64");
> +            return;
>          }
> -
> -        r = siv->cur_range->data;
> -        if (!r) {
> -            goto error;
> +        *obj = val;
> +        return;
> +    case LM_INT64_RANGE:
> +        /* return the next element in the range */
> +        g_assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
> +        *obj = siv->rangeNext.i64++;
> +
> +        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj == INT64_MAX) {
> +            /* end of range, check if there is more to parse */
> +            if (siv->unparsed_string[0]) {
> +                siv->lm = LM_UNPARSED;
> +            } else {
> +                siv->lm = LM_END;
> +            }
>          }

Are you sure this is kosher?

if siv->rangeNext.i64 and siv->rangeEnd are both initially INT64_MAX,
siv->rangeNext++ wraps around to INT64_MIN.  Except when the compiler
exploits undefined behavior.

You could try something like

           g_assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
           *obj = siv->rangeNext.i64;

           if (siv->rangeNext.i64 == siv->rangeEnd.i64) {
               /* end of range, check if there is more to parse */
               if (siv->unparsed_string[0]) {
                   siv->lm = LM_UNPARSED;
               } else {
                   siv->lm = LM_END;
               }
           } else {
               siv->rangeNext.i64++;
           }

Another alternative might be to iterate in uint64_t (and dispense with
union RangeLimit), then convert to int64_t.

> +        return;
> +    case LM_UNPARSED:
> +        if (try_parse_int64_list_entry(siv, obj)) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +                       "list of int64 values or ranges");
> +        }

I figure I'd make try_parse_int64_list_entry() just parse, and on
success fall through to case LM_INT64_RANGE.  But your solution works,
too.

> +        return;
> +    case LM_END:
> +        error_setg(errp, "No more elements in the list.");

This is the buddy of check_list() case LM_UNPARSED etc.  There, input
provides more list members than we expect.  Here, input provides less.
Again, the error is less clear than the one the QObject input visitor
reports: "Parameter '%s' is missing".

Same for the unsigned copy below.

> +        return;
> +    default:
> +        error_setg(errp, "Lists don't support mixed types.");

Is this a programming error?

Same for the unsigned copy below.

> +        return;
> +    }
> +}
> +
> +static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint64_t *obj)
> +{
> +    const char *endptr;
> +    uint64_t start, end;
>  
> -        siv->cur = range_lob(r);
> +    /* parse a simple uint64 or range */
> +    if (qemu_strtou64(siv->unparsed_string, &endptr, 0, &start)) {
> +        return -EINVAL;
>      }
>  
> -    *obj = siv->cur;
> -    siv->cur++;
> -    return;
> +    switch (endptr[0]) {
> +    case '\0':
> +        siv->lm = LM_END;
> +        break;
> +    case ',':
> +        siv->unparsed_string = endptr + 1;
> +        break;
> +    case '-':
> +        /* parse the end of the range */
> +        if (qemu_strtou64(endptr + 1, &endptr, 0, &end)) {
> +            return -EINVAL;
> +        }
> +        /* we require at least two elements in a range */
> +        if (start >= end) {
> +            return -EINVAL;
> +        }
> +        switch (endptr[0]) {
> +        case '\0':
> +            siv->unparsed_string = endptr;
> +            break;
> +        case ',':
> +            siv->unparsed_string = endptr + 1;
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +        /* we have a proper range */
> +        siv->lm = LM_UINT64_RANGE;
> +        siv->rangeNext.u64 = start + 1;
> +        siv->rangeEnd.u64 = end;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
>  
> -error:
> -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> -               "an int64 value or range");
> +    *obj = start;
> +    return 0;
>  }
>  
>  static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
>                                Error **errp)
>  {
> -    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
> -    int64_t i;
> -    Error *err = NULL;
> -    parse_type_int64(v, name, &i, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    } else {
> -        *obj = i;
> +    StringInputVisitor *siv = to_siv(v);
> +    uint64_t val;
> +
> +    switch (siv->lm) {
> +    case LM_NONE:
> +        /* just parse a simple uint64, bail out if not completely consumed */
> +        if (qemu_strtou64(siv->string, NULL, 0, &val)) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +                       "uint64");
> +            return;
> +        }
> +        *obj = val;
> +        return;
> +    case LM_UINT64_RANGE:
> +        /* return the next element in the range */
> +        g_assert(siv->rangeNext.u64 <= siv->rangeEnd.u64);
> +        *obj = siv->rangeNext.u64++;
> +
> +        if (siv->rangeNext.u64 > siv->rangeEnd.u64 || *obj == UINT64_MAX) {
> +            /* end of range, check if there is more to parse */
> +            if (siv->unparsed_string[0]) {
> +                siv->lm = LM_UNPARSED;
> +            } else {
> +                siv->lm = LM_END;
> +            }
> +        }

Unsigned wraps around fine.  But when you fix the signed code, you
should probably keep this unsigned code as similar as practical.

> +        return;
> +    case LM_UNPARSED:
> +        if (try_parse_uint64_list_entry(siv, obj)) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +                       "list of uint64 values or ranges");
> +        }
> +        return;
> +    case LM_END:
> +        error_setg(errp, "No more elements in the list.");
> +        return;
> +    default:
> +        error_setg(errp, "Lists don't support mixed types.");
> +        return;
>      }
>  }
>  
> @@ -271,6 +329,11 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
>      Error *err = NULL;
>      uint64_t val;
>  
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Lists not supported for type \"size\"");
> +        return;
> +    }
> +

Programming error?  More of the same below.

>      parse_option_size(name, siv->string, &val, &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -285,6 +348,11 @@ static void parse_type_bool(Visitor *v, const char *name, bool *obj,
>  {
>      StringInputVisitor *siv = to_siv(v);
>  
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Lists not supported for type \"boolean\"");
> +        return;
> +    }
> +
>      if (!strcasecmp(siv->string, "on") ||
>          !strcasecmp(siv->string, "yes") ||
>          !strcasecmp(siv->string, "true")) {
> @@ -307,6 +375,11 @@ static void parse_type_str(Visitor *v, const char *name, char **obj,
>  {
>      StringInputVisitor *siv = to_siv(v);
>  
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Lists not supported for type \"string\"");
> +        return;
> +    }
> +
>      *obj = g_strdup(siv->string);
>  }
>  
> @@ -316,6 +389,11 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>      StringInputVisitor *siv = to_siv(v);
>      double val;
>  
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Lists not supported for type \"number\"");
> +        return;
> +    }
> +
>      if (qemu_strtod(siv->string, NULL, &val)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "number");
> @@ -332,7 +410,12 @@ static void parse_type_null(Visitor *v, const char *name, QNull **obj,
>  
>      *obj = NULL;
>  
> -    if (!siv->string || siv->string[0]) {
> +    if (siv->lm != LM_NONE) {
> +        error_setg(errp, "Lists not supported for type \"null\"");
> +        return;
> +    }
> +
> +    if (siv->string[0]) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "null");
>          return;
> @@ -345,8 +428,6 @@ static void string_input_free(Visitor *v)
>  {
>      StringInputVisitor *siv = to_siv(v);
>  
> -    g_list_foreach(siv->ranges, free_range, NULL);
> -    g_list_free(siv->ranges);
>      g_free(siv);
>  }
>  
> @@ -354,7 +435,7 @@ Visitor *string_input_visitor_new(const char *str)
>  {
>      StringInputVisitor *v;
>  
> -    assert(str);
> +    g_assert(str);
>      v = g_malloc0(sizeof(*v));
>  
>      v->visitor.type = VISITOR_INPUT;
> @@ -372,5 +453,6 @@ Visitor *string_input_visitor_new(const char *str)
>      v->visitor.free = string_input_free;
>  
>      v->string = str;
> +    v->lm = LM_NONE;
>      return &v->visitor;
>  }
> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
> index 88e0e1aa9a..0a4152f79d 100644
> --- a/tests/test-string-input-visitor.c
> +++ b/tests/test-string-input-visitor.c
> @@ -92,16 +92,6 @@ static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
>      uint64List *tail;
>      int i;
>  
> -    /* BUG: unsigned numbers above INT64_MAX don't work */
> -    for (i = 0; i < n; i++) {
> -        if (expected[i] > INT64_MAX) {
> -            Error *err = NULL;
> -            visit_type_uint64List(v, NULL, &res, &err);
> -            error_free_or_abort(&err);
> -            return;
> -        }
> -    }
> -
>      visit_type_uint64List(v, NULL, &res, &error_abort);
>      tail = res;
>      for (i = 0; i < n; i++) {
> @@ -117,10 +107,10 @@ static void check_ulist(Visitor *v, uint64_t *expected, size_t n)
>  static void test_visitor_in_intList(TestInputVisitorData *data,
>                                      const void *unused)
>  {
> -    /* Note: the visitor *sorts* ranges *unsigned* */
> -    int64_t expect1[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
> +    int64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5,

Please wrap this line a bit earlier.

> +                          6, 7, 8 };
>      int64_t expect2[] = { 32767, -32768, -32767 };
> -    int64_t expect3[] = { INT64_MAX, INT64_MIN };
> +    int64_t expect3[] = { INT64_MIN, INT64_MAX };

Did you mean to change this line?

>      uint64_t expect4[] = { UINT64_MAX };
>      Error *err = NULL;
>      int64List *res = NULL;
> @@ -189,7 +179,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>      visit_type_int64(v, NULL, &tail->value, &err);
>      g_assert_cmpint(tail->value, ==, 0);
>      visit_type_int64(v, NULL, &val, &err);
> -    g_assert_cmpint(val, ==, 1); /* BUG */
> +    error_free_or_abort(&err);

Which of the problems listed in commit message is this?

>      visit_check_list(v, &error_abort);
>      visit_end_list(v, (void **)&res);

Please don't let my review comments discourage you!  This is so much
better than the code we have now, and feels pretty close to ready.
Thanks a lot!
