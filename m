Received: from eggs.gnu.org ([2001:4830:134:3::10]:51593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpsiA-0003Ba-Dm
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpsi6-0007xO-GU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpsi6-0007wn-8f
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23C4280099
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 09:02:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
	<9fe40ce91ada6dfdade83f32940f420e8b373db2.1504696921.git.mprivozn@redhat.com>
	<6ac4f80c-3e80-297b-a4d6-2f4ae0b70d66@redhat.com>
	<87zia7rb6h.fsf@dusky.pond.sub.org>
	<cd13f335-e1ae-b340-61e5-06a7bc78881f@redhat.com>
Date: Thu, 07 Sep 2017 11:02:47 +0200
In-Reply-To: <cd13f335-e1ae-b340-61e5-06a7bc78881f@redhat.com> (Michal
	Privoznik's message of "Thu, 7 Sep 2017 09:56:24 +0200")
Message-ID: <87k21aj2yw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Michal Privoznik <mprivozn@redhat.com> writes:

> On 09/06/2017 07:25 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 09/06/2017 06:24 AM, Michal Privoznik wrote:
>>>> We already have enum that enumerates all the action that a
>>>
>>> s/action/actions/
>>>
>>>> watchdog can take when hitting its timeout: WatchdogAction.
>>>> Use that instead of inventing our own.
>>>>
>>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>>> ---
>>>
>>>> @@ -77,27 +77,16 @@ int select_watchdog(const char *p)
>>>>  
>>>>  int select_watchdog_action(const char *p)
>>>>  {
>>>> -    if (strcasecmp(p, "reset") == 0)
>>>> -        watchdog_action = WDT_RESET;
>>>
>>> The old code was case-insensitive,
>>>
>>>> +    action = qapi_enum_parse(&WatchdogAction_lookup, p, -1, NULL);
>>>
>>> the new code is not.  Do we care?  (I don't, but we could be breaking
>>> someone's control flow).  Should qapi_enum_parse be taught to be
>>> case-insensitive?  Or perhaps we answer related questions first: Do we
>>> have any QAPI enums that have values differing only in case? Do we
>>> prevent such QAPI definitions, to give us the potential of making the
>>> parsing insensitive?
>> 
>> Case-sensitive everywhere is fine.  Case-insensitive everywhere also
>> fine, just not my personal preference.  What's not fine is "guess
>> whether this part of the interface is case-sensitive or not".
>> 
>> QMP is case-sensitive.  Let's keep it that way.
>> 
>> The -watchdog-action option has a case-insensitive argument.  The
>> obvious way to remain misfeature-^Wbackwards compatible is converting
>> the argument to lower case before handing it off to qapi_enum_parse.  I
>> doubt it matters, but just doing it is less work than debating how far
>> exactly we want to bend over backwards.
>> 
>> g_ascii_strdown() should do.  It only converts ASCII characters, but
>> anything else is going to fail in qapi_enum_parse() anyway.
>> 
>
> On the other hand, the documentation enumerates the accepted values in
> lowercase. So one can argue that upper- or mixed-case is just a misuse
> of a bug in the code.

I quite agree, but...

>                       But getting the code in is more important to me so
> I'll do the strdown() conversion and sent yet another version.

... like you, I have to pick my battles.  A respin adding the stupid
case conversion seems safer for both of us than risking a debate on how
far we need to go for backward compatibility.
