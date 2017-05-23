Received: from eggs.gnu.org ([2001:4830:134:3::10]:33508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD5RM-0007s0-2i
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD5RH-0002TM-84
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:45:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD5RH-0002SH-0F
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:45:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82FD9C059721
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:45:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
	<1495471335-23707-5-git-send-email-armbru@redhat.com>
	<4b996cbf-028a-0f45-e7ba-6b599680fc9a@redhat.com>
Date: Tue, 23 May 2017 10:45:02 +0200
In-Reply-To: <4b996cbf-028a-0f45-e7ba-6b599680fc9a@redhat.com> (Eric Blake's
	message of "Mon, 22 May 2017 13:18:59 -0500")
Message-ID: <8760gshshd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: Reject alternates that can't
 work with keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 05/22/2017 11:42 AM, Markus Armbruster wrote:
>> Alternates are sum types like unions, but use the JSON type on the
>> wire / QType in QObject instead of an explicit tag.  That's why we
>> require alternate members to have distinct QTypes.
>> 
>> The recently introduced keyval_parse() (commit d454dbe) can only
>> produce string scalars.  The qobject_input_visitor_new_keyval() input
>> visitor mostly hides the difference, so code using a QObject input
>> visitor doesn't have to care whether its input was parsed from JSON or
>> KEY=VALUE,...  The difference leaks for alternates, as noted in commit
>> 0ee9ae7: an non-string, non-enum scalar alternate value can't
>
> s/an non/a non/

Will fix.

>> currently be expressed.
>> 
>> In part, this is just our insufficiently sophisticated implementation.
>> Consider alternate type 'GuestFileWhence'.  It has an integer member
>> and a 'QGASeek' member.  The latter is an enumeration with values
>> 'set', 'cur', 'end'.  The meaning of b=set, b=cur, b=end, b=0, b=1 and
>> so forth is perfectly obvious.  However, our current implementation
>> falls apart at run time for b=0, b=1, and so forth.  Fixable, but not
>> today; add a test case and a TODO comment.
>> 
>> Now consider an alternate type with a string and an integer member.
>> What's the meaning of a=42?  Is it the string "42" or the integer 42?
>> Whichever meaning you pick makes the other inexpressible.  This isn't
>> just an implementation problem, it's fundamental.  Our current
>> implementation will pick string.
>> 
>> So far, we haven't needed such alternates.  To make sure we stop and
>> think before we add one that cannot sanely work with keyval_parse(),
>> let's require alternate members to have sufficiently district
>
> s/district/distinct/

Will fix.

>> representation in KEY=VALUE,... syntax:
>> 
>> * A string member clashes with any other scalar member
>> 
>> * An enumeration member clashes with bool members when it has value
>>   'on' or 'off'.
>
> Does case-(in)sensitivity factor in here?

KEY=VALUE,... syntax is case-sensitive.

>                                           Should it also be a problem
> for an enum member with value 'true' or 'false'?

No, because those are spelled "on" and "off" in KEY=VALUE,... syntax.

If we add synonyms there, we'll have to tighten the restrictions here.

>> * An enumeration member clashes with numeric members when it has a
>>   value that starts with '-', '+', '0' or '9'.  This is a rather lazy
>
> s/'0' or '9'/or among '0' to '9'/

Will fix.

>>   approximation of the actual number syntax accepted by the visitor.
>> 
>>   Note that enumeration values starting with '-' and '+' are rejected
>>   elsewhere already, but better safe than sorry.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/scripts/qapi.py
>> @@ -812,11 +812,26 @@ def check_alternate(expr, info):
>>          if not qtype:
>>              raise QAPISemError(info, "Alternate '%s' member '%s' cannot use "
>>                                 "type '%s'" % (name, key, value))
>> -        if qtype in types_seen:
>> +        conflicting = set([qtype])
>> +        if qtype == 'QTYPE_QSTRING':
>> +            enum_expr = enum_types.get(value)
>> +            if enum_expr:
>> +                for v in enum_expr['data']:
>> +                    if v in ['on', 'off']:
>
> what about 'true', 'false'?
>
> Do we care about case insensitive?

See above.

>> +                        conflicting.add('QTYPE_QBOOL')
>> +                    if re.match(r'[-+0-9.]', v): # lazy, could be tightened
>> +                        conflicting.add('QTYPE_QINT')
>> +                        conflicting.add('QTYPE_QFLOAT')
>> +            else:
>> +                conflicting.add('QTYPE_QINT')
>> +                conflicting.add('QTYPE_QFLOAT')
>> +                conflicting.add('QTYPE_QBOOL')
>> +        if conflicting & set(types_seen):
>>              raise QAPISemError(info, "Alternate '%s' member '%s' can't "
>>                                 "be distinguished from member '%s'"
>>                                 % (name, key, types_seen[qtype]))
>> -        types_seen[qtype] = key
>> +        for qt in conflicting:
>> +            types_seen[qt] = key
>>  
>
> Looks good.

Thanks!
