Received: from eggs.gnu.org ([2001:4830:134:3::10]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnh4R-0006f0-S8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnh4N-00047X-00
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnh4M-000476-O6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:40:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-6-git-send-email-armbru@redhat.com>
	<27b4a5aa-fa4e-ad49-c51a-cc5b49c58525@redhat.com>
Date: Tue, 14 Mar 2017 08:40:26 +0100
In-Reply-To: <27b4a5aa-fa4e-ad49-c51a-cc5b49c58525@redhat.com> (Eric Blake's
	message of "Mon, 13 Mar 2017 17:41:44 -0500")
Message-ID: <87tw6wpaqd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 05/47] qapi: Have each QAPI schema
 declare its returns white-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> qapi.py has a hardcoded white-list of command names that may violate
>> the rules on permitted return types.  Add a new pragma directive
>> 'returns-whitelist', and use it to replace the hard-coded white-list.
>
> So now the list is per-client, rather than global. Nice idea!
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qapi-schema.json
>> @@ -51,6 +51,18 @@
>>  
>>  { 'pragma': { 'doc-required': true } }
>>  
>> +# Whitelists to permit QAPI rule violations; think twice before you
>> +# add to them!
>> +{ 'pragma': {
>> +    # Commands allowed to return a non-dictionary:
>> +    'returns-whitelist': [
>> +        'human-monitor-command',
>> +        'qom-get',
>> +        'query-migrate-cache-size',
>> +        'query-tpm-models',
>> +        'query-tpm-types',
>> +        'ringbuf-read' ] } }
>> +
>
> If I'm understanding the code right, we could have also written this all
> as one pragma with a larger dict instead of two pragmas with one-element
> dicts:
>
> { 'pragma': { 'doc-required': true,
>               'returns-whitelist': [ ... ] } }

Yes.  Separating them let me make the comment stand out more.

> But see below about another potential for rewriting that I thought of
> before reading your full patch [1]...
>
>> @@ -317,12 +298,19 @@ class QAPISchemaParser(object):
>>          self.docs.extend(exprs_include.docs)
>>  
>>      def _pragma(self, name, value, info):
>> -        global doc_required
>> +        global doc_required, returns_whitelist
>>          if name == 'doc-required':
>>              if not isinstance(value, bool):
>>                  raise QAPISemError(info,
>>                                     "Pragma 'doc-required' must be boolean")
>>              doc_required = value
>> +        elif name == 'returns-whitelist':
>> +            if (not isinstance(value, list)
>> +                    or any([not isinstance(elt, str) for elt in value])):
>> +                raise QAPISemError(info,
>> +                                   "Pragma returns-whitelist must be"
>> +                                   " a list of strings")
>
> Again, a new error message with no testsuite coverage.

Okay.

    $ git-ls-files tests/qapi-schema/ | grep -c 'json$'
    157

What's half a dozen more...

>> +            returns_whitelist = value
>
> [1] Hmm, this precludes the converse direction of specifying things.
> You cannot usefully list the whitelist pragma more than once, because
> only the last one wins.  Why would we want to allow it to be more than
> once? because we could do:
>
> { 'pragma': 'returns-whitelist': [ 'human-monitor-command' ] }
> { 'pragma': 'returns-whitelist': [ 'qom-get' ] }
>
> and then spread out the uses of the pragma to be closer to the
> violations, rather than bunched up front.
>
> Or maybe you want to consider rejecting a second whitelist, instead of
> silently losing the first one, if you want to force that all violations
> are bunched up front into a single pragma.

Where to put the pragma is a question of style.  As is, the patch
supports only "put them first", because we actually use the white-list
in a later pass, where only the last pragma value is visible.  To fix
that, we'd have to compute *current* pragma values throughout that later
pass.

As long as we don't, accepting only one whitelist is better than
silently ignoring all but the last.

Computing current pragma values shouldn't be hard, but I'm not sure it's
worthwhile.

> But that's food for thought - I'm leaving it up to you if you want to
> spin a v2 (making non-trivial changes based on my comments), or leave
> improvements (like any testsuite additions) for a followup patch.  If
> you use this patch as-is, you can add:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
