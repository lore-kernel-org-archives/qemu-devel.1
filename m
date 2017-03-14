Received: from eggs.gnu.org ([2001:4830:134:3::10]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnhEc-0000aW-Iu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnhEX-0007Ey-OM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnhEX-0007EJ-BI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:51:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-7-git-send-email-armbru@redhat.com>
	<4329f1e3-1f8e-7194-3bf6-55ae0d0aae82@redhat.com>
Date: Tue, 14 Mar 2017 08:51:02 +0100
In-Reply-To: <4329f1e3-1f8e-7194-3bf6-55ae0d0aae82@redhat.com> (Eric Blake's
	message of "Mon, 13 Mar 2017 17:46:03 -0500")
Message-ID: <87lgs8pa8p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 06/47] qapi: Have each QAPI schema
 declare its name rule violations
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
>> qapi.py has a hardcoded white-list of type names that may violate the
>> rule on use of upper and lower case.  Add a new pragma directive
>> 'name-case-whitelist', and use it to replace the hard-coded
>> white-list.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/qapi-code-gen.txt                  |  6 ++++++
>>  qapi-schema.json                        | 11 ++++++++++-
>>  scripts/qapi.py                         | 22 ++++++++++------------
>>  tests/qapi-schema/enum-member-case.err  |  2 +-
>>  tests/qapi-schema/enum-member-case.json |  1 +
>>  5 files changed, 28 insertions(+), 14 deletions(-)
>> 
>
>> +++ b/qapi-schema.json
>> @@ -61,7 +61,16 @@
>>          'query-migrate-cache-size',
>>          'query-tpm-models',
>>          'query-tpm-types',
>> -        'ringbuf-read' ] } }
>> +        'ringbuf-read' ],
>> +    'name-case-whitelist': [
>> +        'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
>> +        'CpuInfoMIPS',          # PC, visible through query-cpu
>> +        'CpuInfoTricore',       # PC, visible through query-cpu
>> +        'QapiErrorClass',       # all members, visible through errors
>> +        'UuidInfo',             # UUID, visible through query-uuid
>> +        'X86CPURegister32',     # all members, visible indirectly through qom-get
>> +        'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
>> +    ] } }
>
> Interesting - here you bunch up 2 of the 3 pragmas into one dict, while
> still leaving the third related to documentation in its own dict.
>
> That 'q_obj_CpuInfo-base' is ugly, and I had a patch around previously
> that used a saner name rather than making callers reverse-engineer the
> implicit naming rules.  Related to my work on anonymous bases to flat
> unions, so I'll get to rebase that work and post it on top of yours.
> But not a show-stopper for this patch, where it is just moving the location.

... to a more visible place :)

Regarding flat unions: what I really want is unifying struct and both
kinds of unions into a single object type.  Something like

    { 'object': STRING,        # type name
      '*base': STRING-OR-DICT, # base type
      '*data': DICT,           # common members
      '*tag': STRING,          # tag name, must be in base or common
      '*variant': DICT }       # map tag value -> variant members

Introspection already works that way.

Note no sugar for "simple" unions.  They become syntactically
non-simple.  Feature.

Flat unions become syntactically non-horrible.

>> @@ -311,6 +302,13 @@ class QAPISchemaParser(object):
>>                                     "Pragma returns-whitelist must be"
>>                                     " a list of strings")
>>              returns_whitelist = value
>> +        elif name == 'name-case-whitelist':
>> +            if (not isinstance(value, list)
>> +                    or any([not isinstance(elt, str) for elt in value])):
>> +                raise QAPISemError(info,
>> +                                   "Pragma name-case-whitelist must be"
>> +                                   " a list of strings")
>> +            name_case_whitelist = value
>
> Same comments as before - new error message with no testsuite coverage,
> and no checking for duplicate assignment where last one silently wins;
> but where I'm okay with deferring if you don't want to delay 2.9 for a
> v2 respin.
>
> So if you use it unchanged,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
