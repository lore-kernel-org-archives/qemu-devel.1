Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPD6h-0006eB-2Z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPD6X-0008S1-Pc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPD6X-0008OI-71
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:58:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-7-david@redhat.com>
	<a2262bd0-7b54-c1f0-865b-d53357cce171@redhat.com>
Date: Tue, 20 Nov 2018 21:58:36 +0100
In-Reply-To: <a2262bd0-7b54-c1f0-865b-d53357cce171@redhat.com> (Eric Blake's
	message of "Tue, 20 Nov 2018 11:40:04 -0600")
Message-ID: <87a7m379fn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/9] qapi: Rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

I think the title should be something like

    qapi: Rewrite string-input-visitor's integer and list parsing

because you don't actually rewrite all of it.

Eric Blake <eblake@redhat.com> writes:

> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>> The input visitor has some problems right now, especially
>> - unsigned type "Range" is used to process signed ranges, resulting in
>>    inconsistent behavior and ugly/magical code
>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>    supported and error messages are misleading
>> - lists/ranges of int64_t are accepted although no list is parsed and
>>    we should rather report an error
>> - lists/ranges are preparsed using int64_t, making it hard to
>>    implement uint64_t values or uint64_t lists
>> - types that don't support lists don't bail out
>> - visiting beyond the end of a list is not handled properly
>> - we don't actually parse lists, we parse *sets*: members are sorted,
>>    and duplicates eliminated
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
>>    an ordered set.
>>
>> Please note that no users/callers have to be fixed up. Candiates using
>
> s/Candiates/Candidates/
>
>> visit_type_uint16List() and friends are:
>> - backends/hostmem.c:host_memory_backend_set_host_nodes()
>> -- Code can deal with dupilcates/unsorted lists
>
> s/dupilcates/duplicates/
>
>> - numa.c::query_memdev()
>> -- via object_property_get_uint16List(), the list will still be sorted
>>     and without duplicates (via host_memory_backend_get_host_nodes())
>> - qapi-visit.c::visit_type_Memdev_members()
>> - qapi-visit.c::visit_type_NumaNodeOptions_members()
>> - qapi-visit.c::visit_type_RockerOfDpaGroup_members
>> - qapi-visit.c::visit_type_RxFilterInfo_members()
>> -- Not used with string-input-visitor.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/qapi/string-input-visitor.h |   4 +-
>>   qapi/string-input-visitor.c         | 405 ++++++++++++++++------------
>>   tests/test-string-input-visitor.c   |  18 +-
>>   3 files changed, 234 insertions(+), 193 deletions(-)
>>
>
>>   struct StringInputVisitor
>>   {
>>       Visitor visitor;
>>   -    GList *ranges;
>> -    GList *cur_range;
>> -    int64_t cur;
>> +    /* List parsing state */
>> +    ListMode lm;
>> +    RangeElement rangeNext;
>> +    RangeElement rangeEnd;
>> +    const char *unparsed_string;
>> +    void *list;
>>   +    /* The original string to parse */
>>       const char *string;
>> -    void *list; /* Only needed for sanity checking the caller */
>>   };
>>   
>
> Makes sense.
>
>> @@ -179,88 +106,208 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
>>   static void check_list(Visitor *v, Error **errp)
>>   {
>>       const StringInputVisitor *siv = to_siv(v);
>> -    Range *r;
>> -    GList *cur_range;
>>   -    if (!siv->ranges || !siv->cur_range) {
>> +    switch (siv->lm) {
>> +    case LM_INT64_RANGE:
>> +    case LM_UINT64_RANGE:
>> +    case LM_UNPARSED:
>> +        error_setg(errp, "Fewer list elements expected");
>
> Bike-shedding - I don't know if "Too many list elements supplied"
> would make the error any more legible.

See my review of PATCH RFC 3/6:

    Hmm.  qobject_input_check_list() reports "Only %u list elements expected
    in %s" here.  Looks unintuitive, until you remember how it's normally
    used: to parse user input.  The error gets reported when the parsing
    didn't consume the whole list.  Can only happen with a virtual walk.
    And when it happens, the issue to report is "you provided a longer list
    than I can accept".  qobject_input_check_list() does exactly that.  Your
    message is less clear.

David didn't feel counting elements just for that was worthwhile here,
and I agreed.

>>     static void parse_type_int64(Visitor *v, const char *name,
>> int64_t *obj,
>>                                Error **errp)
>>   {
>>       StringInputVisitor *siv = to_siv(v);
>> -
>> -    if (parse_str(siv, name, errp) < 0) {
>> +    int64_t val;
>> +
>> +    switch (siv->lm) {
>> +    case LM_NONE:
>> +        /* just parse a simple int64, bail out if not completely consumed */
>> +        if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
>> +                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> +                           name ? name : "null", "int64");
>> +            return;
>> +        }
>> +        *obj = val;
>>           return;
>> +    case LM_UNPARSED:
>> +        if (try_parse_int64_list_entry(siv, obj)) {
>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
>> +                       "list of int64 values or ranges");
>
> The error message might be a bit misleading for a range larger than
> 64k, but that's not too bad.
>
>> +            return;
>> +        }
>> +        assert(siv->lm == LM_INT64_RANGE);
>> +        /* fall through */
>> +    case LM_INT64_RANGE:
>> +        /* return the next element in the range */
>> +        assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
>> +        *obj = siv->rangeNext.i64++;
>> +
>> +        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj == INT64_MAX) {
>
> I think our compiler options guarantee that we have sane signed
> wraparound and thus this is a safe comparison on overflow; but if you
> were to swap it so that the *obj == INT64_MAX check is performed
> first, you wouldn't even have to debate about whether undefined C
> semantics are being invoked.
>
>> +            /* end of range, check if there is more to parse */
>> +            siv->lm = siv->unparsed_string[0] ? LM_UNPARSED : LM_END;
>> +        }
>> +        return;
>> +    case LM_END:
>> +        error_setg(errp, "Fewer list elements expected");
>
> Again, bikeshedding if "too many list elements supplied" would make
> any more sense.

Same argument.

>> +static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint64_t *obj)
>> +{
>> +    const char *endptr;
>> +    uint64_t start, end;
>>   -        siv->cur_range = g_list_first(siv->ranges);
>> -        if (!siv->cur_range) {
>> -            goto error;
>> +    /* parse a simple uint64 or range */
>> +    if (qemu_strtou64(siv->unparsed_string, &endptr, 0, &start)) {
>
> Lots of duplication between the signed and unsigned variants.  But I
> don't see any easy way to factor it out into a common helper, as there
> are just too many places where signed vs. unsigned does not easily
> lend itself to common code.

Yes.

>> @@ -330,9 +381,10 @@ static void parse_type_null(Visitor *v, const char *name, QNull **obj,
>>   {
>>       StringInputVisitor *siv = to_siv(v);
>>   +    assert(siv->lm == LM_NONE);
>>       *obj = NULL;
>>   -    if (!siv->string || siv->string[0]) {
>> +    if (siv->string[0]) {
>
> Why did this condition change?

As far as I can tell, siv->string can't ever be null.  Sticking the
change into this patch is perhaps debatable.  I'm okay with it.

> Reviewed-by: Eric Blake <eblake@redhat.com>

With the commit message improved once more:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
