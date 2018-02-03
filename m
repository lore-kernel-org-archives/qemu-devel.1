Received: from eggs.gnu.org ([2001:4830:134:3::10]:59969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtVr-0006wh-6v
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtVq-0000A7-8j
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtVq-00009B-2e
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:49:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-4-armbru@redhat.com>
	<1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
Date: Sat, 03 Feb 2018 09:49:24 +0100
In-Reply-To: <1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 09:59:19 -0600")
Message-ID: <87vafe4fvv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
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

> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>> These classes encapsulate accumulating and writing output.
>> 
>> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
>> rather shallow: most of the output accumulation is not converted.
>> Left for later.
>> 
>> The indentation machinery uses a single global variable indent_level,
>> even though we generally interleave creation of a .c and its .h.  It
>> should become instance variable of QAPIGenC.  Also left for later.
>> 
>> Documentation generation isn't converted, and QAPIGenDoc isn't used.
>> This will change shortly.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi-commands.py   | 27 ++++++-------
>>  scripts/qapi-event.py      | 26 +++++++------
>>  scripts/qapi-introspect.py | 22 ++++++-----
>>  scripts/qapi-types.py      | 26 +++++++------
>>  scripts/qapi-visit.py      | 26 +++++++------
>>  scripts/qapi.py            | 96 ++++++++++++++++++++++++++--------------------
>>  6 files changed, 122 insertions(+), 101 deletions(-)
>> 
>
> A little bit longer due to more structure, but reasonable diffstat in
> that it shows the conversion is fairly straightforward and opens the
> doors for later patches to use the new structures more effectively.
>
>>  
>>  schema = QAPISchema(input_file)
>> -gen = QAPISchemaGenEventVisitor()
>> -schema.visit(gen)
>> -fdef.write(gen.defn)
>> -fdecl.write(gen.decl)
>> +vis = QAPISchemaGenEventVisitor()
>> +schema.visit(vis)
>> +genc.body(vis.defn)
>> +genh.body(vis.decl)
>
> I don't know if it is worth a sentence in the commit message that the
> visitor variable is renamed from 'gen' to 'vis' for less confusion with
> the new class instances 'genc' and 'genh'.

Did the rename give you pause when reviewing?

>> +++ b/scripts/qapi-types.py
>> @@ -180,7 +180,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>>          self.decl = ''
>>          self.defn = ''
>>          self._fwdecl = ''
>> -        self._btin = guardstart('QAPI_TYPES_BUILTIN')
>> +        self._btin = '\n' + guardstart('QAPI_TYPES_BUILTIN')
>
> Tweaks like this means you were paying attention to still producing
> identical generated files; always a good sign.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
