Received: from eggs.gnu.org ([2001:4830:134:3::10]:48248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Nx-0004X9-Mw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Nt-00078R-Pc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3Nt-00078D-HV
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:30:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-27-git-send-email-armbru@redhat.com>
	<c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com>
Date: Wed, 15 Mar 2017 08:30:10 +0100
In-Reply-To: <c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 14:29:01 -0500")
Message-ID: <8737efro8t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 26/47] qapi2texi: Generate
 reference to base type members
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
>> The generated documentation doesn't mention object type members
>> inherited from a base type.  Fix that.
>> 
>> Example change (qemu-qmp-ref.txt):
>> 
>>   -- Struct: VncServerInfo
>> 
>>       The network connection information for server
>> 
>>       Members:
>>       'auth' (optional)
>> 	   authentication method used for the plain (non-websocket) VNC
>> 	   server
>> +     The members of 'VncBasicInfo'
>> 
>
> Again, will be more useful later in the series when you add hyperlinking.
>
>>       Since: 2.1
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi2texi.py | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
>> index 993b652..7083d0c 100755
>> --- a/scripts/qapi2texi.py
>> +++ b/scripts/qapi2texi.py
>> @@ -143,7 +143,7 @@ def texi_member(member):
>>          ' (optional)' if member.optional else '')
>>  
>>  
>> -def texi_members(doc, what, member_func):
>> +def texi_members(doc, what, base, member_func):
>>      """Format the table of members"""
>>      items = ''
>>      for section in doc.args.itervalues():
>> @@ -152,6 +152,8 @@ def texi_members(doc, what, member_func):
>>          else:
>>              desc = 'Not documented'
>>          items += member_func(section.member) + texi_format(desc) + '\n'
>> +    if base:
>> +        items += '@item The members of @code{%s}\n' % base.doc_type()
>
> Will this still work for implicit bases?
>
>>  
>> @@ -205,11 +207,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>>              typ = 'Flat Union'
>>          else:
>>              typ = 'Simple Union'
>> +        if base and base.is_implicit():
>> +            base = None
>
> Hmm - you just ignore those, such as the anonymous base in CpuInfo.  On
> the other hand, CpuInfo documents its base fields explicitly.  Are we at
> risk of double-documenting a base member, both explicitly and via its
> named base type?

Actually no.

Doc comments should document exactly the members defined locally.  This
includes members of anonymous bases, but not members of named bases.  If
you try to document members of named basses, you get your wrist slapped.
For example, if I do

    diff --git a/qapi-schema.json b/qapi-schema.json
    index 1d7b1cd..4214e97 100644
    --- a/qapi-schema.json
    +++ b/qapi-schema.json
    @@ -1549,6 +1549,7 @@
     #
     # @auth: authentication method used for
     #        the plain (non-websocket) VNC server
    +# @family: address family
     #
     # Since: 2.1
     ##

I get

    qemu/qapi-schema.json:1545: The following documented members are not in the declaration: family

> At any rate, this patch is an incremental improvement, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
