Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTEy-0007Y6-Ms
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTEu-0007G4-PT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:12:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPTEs-0007BV-R7
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:12:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-7-david@redhat.com>
	<a2262bd0-7b54-c1f0-865b-d53357cce171@redhat.com>
	<87a7m379fn.fsf@dusky.pond.sub.org>
	<3021bc1d-d802-96ad-fd30-8dc78f5af3c8@redhat.com>
Date: Wed, 21 Nov 2018 15:12:16 +0100
In-Reply-To: <3021bc1d-d802-96ad-fd30-8dc78f5af3c8@redhat.com> (David
	Hildenbrand's message of "Wed, 21 Nov 2018 11:53:57 +0100")
Message-ID: <871s7e4j0f.fsf@dusky.pond.sub.org>
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
To: David Hildenbrand <david@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 20.11.18 21:58, Markus Armbruster wrote:
>> I think the title should be something like
>> 
>>     qapi: Rewrite string-input-visitor's integer and list parsing
>> 
>> because you don't actually rewrite all of it.
>> 
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>>>> The input visitor has some problems right now, especially
>>>> - unsigned type "Range" is used to process signed ranges, resulting in
>>>>    inconsistent behavior and ugly/magical code
>>>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>>>    supported and error messages are misleading
>>>> - lists/ranges of int64_t are accepted although no list is parsed and
>>>>    we should rather report an error
>>>> - lists/ranges are preparsed using int64_t, making it hard to
>>>>    implement uint64_t values or uint64_t lists
>>>> - types that don't support lists don't bail out
>>>> - visiting beyond the end of a list is not handled properly
>>>> - we don't actually parse lists, we parse *sets*: members are sorted,
>>>>    and duplicates eliminated
>>>>
>>>> So let's rewrite it by getting rid of usage of the type "Range" and
>>>> properly supporting lists of int64_t and uint64_t (including ranges of
>>>> both types), fixing the above mentioned issues.
>>>>
>>>> Lists of other types are not supported and will properly report an
>>>> error. Virtual walks are now supported.
>>>>
>>>> Tests have to be fixed up:
>>>> - Two BUGs were hardcoded that are fixed now
>>>> - The string-input-visitor now actually returns a parsed list and not
>>>>    an ordered set.
>>>>
>>>> Please note that no users/callers have to be fixed up. Candiates using
>>>
>>> s/Candiates/Candidates/
>>>
>>>> visit_type_uint16List() and friends are:
>>>> - backends/hostmem.c:host_memory_backend_set_host_nodes()
>>>> -- Code can deal with dupilcates/unsorted lists
>>>
>>> s/dupilcates/duplicates/
>
> Thanks, both fixed.
>
>> 
>>>> @@ -330,9 +381,10 @@ static void parse_type_null(Visitor *v, const char *name, QNull **obj,
>>>>   {
>>>>       StringInputVisitor *siv = to_siv(v);
>>>>   +    assert(siv->lm == LM_NONE);
>>>>       *obj = NULL;
>>>>   -    if (!siv->string || siv->string[0]) {
>>>> +    if (siv->string[0]) {
>>>
>>> Why did this condition change?
>> 
>> As far as I can tell, siv->string can't ever be null.  Sticking the
>> change into this patch is perhaps debatable.  I'm okay with it.
>
> Yes, we have an assertion when creating the visitor. Do you want me to
> pull this into a separate patch?

I'm okay with it as is.  Up to you.

> (It made sense under the old patch subject ;) )

It did :)

>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> With the commit message improved once more:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> 
> Thanks!
