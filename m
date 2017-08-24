Received: from eggs.gnu.org ([2001:4830:134:3::10]:51251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxjh-000747-VD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxje-0001xz-I0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxje-0001xR-6N
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:24:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-3-git-send-email-armbru@redhat.com>
	<04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
	<87y3q8ddbb.fsf@dusky.pond.sub.org>
	<0b31fbbe-1d6e-09d5-6f0d-8f55af18e08f@redhat.com>
Date: Thu, 24 Aug 2017 21:24:05 +0200
In-Reply-To: <0b31fbbe-1d6e-09d5-6f0d-8f55af18e08f@redhat.com> (Eric Blake's
	message of "Thu, 24 Aug 2017 13:56:25 -0500")
Message-ID: <871so0bwh6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/24/2017 01:35 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 08/24/2017 03:45 AM, Markus Armbruster wrote:
>>>> The lookup tables have a sentinel, no need to make callers pass their
>>>> size.
>>>>
>>>> Fun: the header has it in the wrong position.  Good riddance.
>>>>
>
>>>> +++ b/include/qapi/util.h
>>>> @@ -12,7 +12,7 @@
>>>>  #define QAPI_UTIL_H
>>>>  
>>>>  int qapi_enum_parse(const char * const lookup[], const char *buf,
>>>> -                    int max, int def, Error **errp);
>>>> +                    int def, Error **errp);
>>>
>>> I'm not sure what you meant by wrong position; were you thinking that
>>> lookup/max should be immediately adjacent (since max is a property of
>>> the lookup[] parameter), and sticking 'buf' in between the two is what
>>> meant 'max' was in the wrong position?
>> 
>> Compare the declaration above with the definition below:
>> 
>>     diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
>>     index 46eda7d..ee7594f 100644
>>     --- a/qapi/qapi-util.c
>>     +++ b/qapi/qapi-util.c
>>     @@ -16,7 +16,7 @@
>>      #include "qapi/util.h"
>> 
>>      int qapi_enum_parse(const char * const lookup[], const char *buf,
>>     -                    int max, int def, Error **errp)
>>     +                    int def, Error **errp)
>>      {
>>          int i;
>> 
>> Declaration has max before def, definition has it the other way round.
>
> Huh?  On current master (commit 248b2373), the two look like they match
> to me:
>
> $ git grep -A1 qapi_enum_parse'.*const look'
> include/qapi/util.h:int qapi_enum_parse(const char * const lookup[],
> const char *buf,
> include/qapi/util.h-                    int max, int def, Error **errp);
> --
> qapi/qapi-util.c:int qapi_enum_parse(const char * const lookup[], const
> char *buf,
> qapi/qapi-util.c-                    int max, int def, Error **errp)
>
>
>> 
>> Such errors are one reason I prefer to have documentation next to
>> definitions, which are authoritative, rather than declarations, which
>> may or may not match the definition.
>> 
>>> The change itself is reasonable, even if the commit message needs a
>>> tweak to answer my question.
>> 
>> Care to suggest a wording?
>
> At this point, I find the claim to be bogus, so I suggest you delete the
> 'Fun:' paragraph.

Sure.

>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> Thanks!
