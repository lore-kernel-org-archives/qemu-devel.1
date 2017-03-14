Received: from eggs.gnu.org ([2001:4830:134:3::10]:55776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cngm6-00022Y-7n
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cngm3-0001LC-3m
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cngm2-0001K2-Rk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-3-git-send-email-armbru@redhat.com>
	<89b4538d-216a-07da-1552-e1bd617a4f84@redhat.com>
Date: Tue, 14 Mar 2017 08:21:34 +0100
In-Reply-To: <89b4538d-216a-07da-1552-e1bd617a4f84@redhat.com> (Eric Blake's
	message of "Mon, 13 Mar 2017 16:00:05 -0500")
Message-ID: <877f3sqq69.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
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
>> Since we added the documentation generator in commit 3313b61, doc
>> comments are mandatory.  That's a very good idea for a schema that
>> needs to be documented, but has proven to be annoying for testing.
>
> As I've found out while rebasing my JSON output visitor as well as
> patches to allow anonymous bases to flat unions.  Thanks, this will help me!
>
>> 
>> Make doc comments optional again, but add a new directive
>> 
>>     { 'pragma': { 'doc-required': true } }
>> 
>> to let a QAPI schema require them.
>
> I like it.  It's extensible to other pragmas, as well; and reading
> ahead, it looks like you did a good job of flagging unknown pragmas.
>
>> 
>> Require documentation in the schemas we actually want documented:
>> qapi-schema.json and qga/qapi-schema.json.
>> 
>> We could probably make qapi2texi.py cope with incomplete
>> documentation, but for now, simply make it refuse to run unless the
>> schema has 'doc-required': true.
>
> I'd rather fail early on our non-documented stuff then risk broken
> corner cases; so I think you made the right decision.

I figure making qapi2texi.py robust wouldn't be hard, but decided not to
try for 2.9.

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/qapi-code-gen.txt             | 40 +++++++++++++++++++++++++-------------
>
>> @@ -277,6 +280,11 @@ class QAPISchemaParser(object):
>>                                         "Value of 'include' must be a string")
>>                  self._include(include, info, os.path.dirname(abs_fname),
>>                                previously_included)
>> +            elif "pragma" in expr:
>> +                if len(expr) != 1:
>> +                    raise QAPISemError(info, "Invalid 'pragma' directive")
>
> You may also want to check that you have an actual dictionary; otherwise...
>
>> +                for name, value in expr['pragma'].iteritems():
>
> calling .iteritems() can lead to some funky python messages. For
> example, tweaking qapi-schema.json to use
>
> { 'pragma': [ { 'doc-required': true } ] }
>
> =>
>
> $ make
>   GEN     qmp-commands.h
> Traceback (most recent call last):
>   File "/home/eblake/qemu/scripts/qapi-commands.py", line 317, in <module>
>     schema = QAPISchema(input_file)
>   File "/home/eblake/qemu/scripts/qapi.py", line 1496, in __init__
>     parser = QAPISchemaParser(open(fname, "r"))
>   File "/home/eblake/qemu/scripts/qapi.py", line 286, in __init__
>     for name, value in expr['pragma'].iteritems():
> AttributeError: 'list' object has no attribute 'iteritems'
> Makefile:431: recipe for target 'qmp-commands.h' failed

You're right.  Need to decide whether to fix it in a respin or on top.

> Not the end of the world, but we've done a nice job elsewhere of
> avoiding cryptic python traces.
>
>> +        global doc_required
>> +        if name == 'doc-required':
>> +            if not isinstance(value, bool):
>> +                raise QAPISemError(info,
>> +                                   "Pragma 'doc-required' must be boolean")
>> +            doc_required = value
>
> No testsuite coverage of this message?

Not yet, i.e. you're right, test coverage is advisable even for exotic
stuff that's expected not to change like pragma.

> If you decide to not bother, or to defer error message(s) cleanup to
> followups (especially since we are running short on time for fixing the
> actual doc regression from going into 2.9), then using this patch as-is
> can have:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

> Of course, if you spin a v2 that actually addresses my concerns, it
> probably will be more involved than something that can trivially keep my
> R-b (in part because you'll probably also want a testsuite addition to
> cover any new error message...).

Possible :)
