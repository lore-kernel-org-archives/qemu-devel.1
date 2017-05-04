Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6BmZ-0007Vf-3D
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6BmU-0000sy-BO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6BmU-0000sW-2i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:06:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
	<87y3udsz3k.fsf@dusky.pond.sub.org>
	<20170503183037.GV3482@thinpad.lan.raisama.net>
Date: Thu, 04 May 2017 10:06:31 +0200
In-Reply-To: <20170503183037.GV3482@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Wed, 3 May 2017 15:30:37 -0300")
Message-ID: <87vaphm4fs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, May 03, 2017 at 06:07:43PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > When parsing alternates from a string, there are some limitations in
>> > what we can do, but it is a valid use case in some situations. We can
>> > support booleans, integer types, and enums.

By the way, the same restrictions apply to the "keyval" variant of the
QObject input visitor.  It's a known problem stated here:

    Message-ID: <8737exuz6u.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00046.html

However, I failed to document it properly in the source.

>> >
>> > This will be used to support 'feature=force' in -cpu options, while
>> > keeping 'feature=on|off|true|false' represented as boolean values.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  qapi/string-input-visitor.c             | 71 ++++++++++++++++++++++----
>> >  tests/test-string-input-visitor.c       | 89 +++++++++++++++++++++++++++++++++
>> >  tests/qapi-schema/qapi-schema-test.json |  8 +++
>> >  3 files changed, 158 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> > index c089491c24..bf8f58748b 100644
>> > --- a/qapi/string-input-visitor.c
>> > +++ b/qapi/string-input-visitor.c
>> > @@ -19,6 +19,7 @@
>> >  #include "qemu/option.h"
>> >  #include "qemu/queue.h"
>> >  #include "qemu/range.h"
>> > +#include "qemu/bitops.h"
>> >  
>> >  
>> >  struct StringInputVisitor
>> > @@ -278,21 +279,34 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
>> >      *obj = val;
>> >  }
>> >  
>> > +static int try_parse_bool(const char *s, bool *result)
>> > +{
>> > +    if (!strcasecmp(s, "on") ||
>> > +        !strcasecmp(s, "yes") ||
>> > +        !strcasecmp(s, "true")) {
>> > +        if (result) {
>> > +            *result = true;
>> > +        }
>> > +        return 0;
>> > +    }
>> > +    if (!strcasecmp(s, "off") ||
>> > +        !strcasecmp(s, "no") ||
>> > +        !strcasecmp(s, "false")) {
>> > +        if (result) {
>> > +            *result = false;
>> > +        }
>> > +        return 0;
>> > +    }
>> > +
>> > +    return -1;
>> > +}
>> > +
>> >  static void parse_type_bool(Visitor *v, const char *name, bool *obj,
>> >                              Error **errp)
>> >  {
>> >      StringInputVisitor *siv = to_siv(v);
>> >  
>> > -    if (!strcasecmp(siv->string, "on") ||
>> > -        !strcasecmp(siv->string, "yes") ||
>> > -        !strcasecmp(siv->string, "true")) {
>> > -        *obj = true;
>> > -        return;
>> > -    }
>> > -    if (!strcasecmp(siv->string, "off") ||
>> > -        !strcasecmp(siv->string, "no") ||
>> > -        !strcasecmp(siv->string, "false")) {
>> > -        *obj = false;
>> > +    if (try_parse_bool(siv->string, obj) == 0) {
>> >          return;
>> >      }
>> >  
>> > @@ -326,6 +340,42 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>> >      *obj = val;
>> >  }
>> >  
>> > +/* Support for alternates on string-input-visitor is limited, because
>> 
>> Please wing both ends of your comments, like this:
>> 
>>    /*
>>     * Comment text
>>     */
>
> Will do.
>
>> 
>> > + * the input string doesn't have any type information.
>> > + *
>> > + * Supported alternate member types:
>> > + * 1) enums
>> > + * 2) integer types
>> 
>> Better add "(but only if there 's no enum member consisting only of
>> digits)".
>
> Oh, I didn't know this was possible.

Special exception in the naming rules prompted by enum QKeyCode.  Quote
qapi-code-gen.txt:

    All names must begin with a letter, and contain only ASCII letters,
    digits, hyphen, and underscore.  There are two exceptions: enum values
    may start with a digit, and names that are downstream extensions (see
    section Downstream extensions) start with underscore.

>> > + * 3) booleans (but only if the there's no enum variant
>> 
>> Make that "(but only if there's no enum member".
>
> Will do.
>
>
>> 
>> > + *    containing "on", "off", "true", or "false" as members)
>> 
>> Begs the question what happens when you violate these restrictions.
>
> Right now, we don't detect those cases and behavior is undefined.
> I think it will be a good idea to give start_alternate() enough
> information to detect those cases (by adding a 'const char *const
> enum_table[]' parameter).

Alternate types that won't work with the string input visitor can be
detected at compile time (by qapi.py), but not their actual use.  Pity.

Do we actually use alternates that violate the restrictions?  If not, we
could simply restrict alternates so they work with *all* visitors.  If
we ever run into an actual need for alternates that don't, we'll be no
worse off than now.

Let's review existing alternates outside tests:

* Qcow2OverlapChecks: struct + enum
* BlockdevRef: struct + str
* GuestFileWhence: int + enum (all enum members start with a letter)

Restricting alternates looks practical to me.  Eric, what do you think?

>> > + *
>> > + * UNSUPPORTED alternate member types:
>> > + * 1) strings
>> > + * 2) complex types
>> > + */
>> 
>> This comment explains the visitor's restrictions for alternate types.
>> It does not explain how the function works.  The proper place for
>> explaining the visitor's restriction is the comment in
>> string-input-visitor.h, which you need to update anyway, because right
>> now it claims visiting alternates isn't implemented.
>
> Right. I will take a look.
>
>> 
>> > +static void start_alternate(Visitor *v, const char *name,
>> > +                            GenericAlternate **obj, size_t size,
>> > +                            unsigned long supported_qtypes, Error **errp)
>> > +{
>> > +    StringInputVisitor *siv = to_siv(v);
>> > +    QType t = QTYPE_QSTRING;
>> 
>> We usually call such variables @type or @qtype.
>
> I will change it.
>
>> 
>> QTYPE_QSTRING means enum here.  Worth a comment, I think.
>
> I will update it.
>
>> 
>> > +
>> > +    if (supported_qtypes & BIT(QTYPE_QBOOL)) {
>> > +        if (try_parse_bool(siv->string, NULL) == 0) {
>> > +            t = QTYPE_QBOOL;
>> > +        }
>> > +    }
>> > +
>> > +    if (supported_qtypes & BIT(QTYPE_QINT)) {
>> > +        if (parse_str(siv, name, NULL) == 0) {
>> 
>> parse_str() alters *siv.  Why is that harmless?
>
> I remember concluding it was harmless, but I don't remember the
> details.
>
> I will probably drop support for integers in the next version,
> and let whoever needs integer member support on alternates fix
> parse_str().

Any idea that lets me avoid looking at parse_str() is tempting.

If we choose to have alternates that can work only with some visitors,
then restricting this visitor in its own special ways seems quite
tolerable.

But if we restrict alternates to the ones that can work with all
visitors, it would be nice if all visitors that can do alternates at all
can do all alternates.  Mind, "nice", not "must have to get patches
accepted".

>> Aside: parse_str() is basically horrible, but that's not your fault.
>
> That's an understatement. :)
>
>> 
>> > +            t = QTYPE_QINT;
>> > +        }
>> > +    }
>> > +
>> > +    *obj = g_malloc0(size);
>> > +    (*obj)->type = t;
>> > +}
>> > +
>> >  static void string_input_free(Visitor *v)
>> >  {
>> >      StringInputVisitor *siv = to_siv(v);
>> > @@ -353,6 +403,7 @@ Visitor *string_input_visitor_new(const char *str)
>> >      v->visitor.next_list = next_list;
>> >      v->visitor.check_list = check_list;
>> >      v->visitor.end_list = end_list;
>> > +    v->visitor.start_alternate = start_alternate;
>> >      v->visitor.free = string_input_free;
>> >  
>> >      v->string = str;
>> > diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
>> > index 79313a7f7a..1e867d62c9 100644
>> > --- a/tests/test-string-input-visitor.c
>> > +++ b/tests/test-string-input-visitor.c
>> > @@ -290,6 +290,91 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
>> >      }
>> >  }
>> >  
>> > +static void test_visitor_in_alt_bool_enum(TestInputVisitorData *data,
>> > +                                 const void *unused)
>> 
>> Indentation's off.
>
> Will fix it.
>
>> 
>> > +{
>> > +    Error *err = NULL;
>> > +    Visitor *v;
>> > +    AltBoolEnum *be = NULL;
>> > +
>> > +    v = visitor_input_test_init(data, "true");
>> > +    visit_type_AltBoolEnum(v, NULL, &be, &err);
>> > +    g_assert(!err);
>> 
>> What's wrong with &error_abort?  More of the same below.
>
> Most test cases in test-string-input-visitor.c use
> g_asserto(!err) instead of error_abort.
>
> I prefer the former, because I read &error_abort as "if this
> causes an error, something is wrong with the caller [the test
> code itself]", and g_assert(!err) as "if this assert is
> triggered, the test code detected a bug".

Better not read them that way, because you'll misread a couple of
hundred instances in tests/ that don't make this distinction.

> Also, if that function call returns an error, I want to know
> which line on which test case failed. &error_abort would hide
> that information.

Point taken.  On the flip side, with &error_abort you immediately see
this is a negative test.

This file already uses both, so I'm not going to force you pick the one
I prefer.

[...]
