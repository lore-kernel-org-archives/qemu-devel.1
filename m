Received: from eggs.gnu.org ([2001:4830:134:3::10]:38309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSOB-00048O-NK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSO8-00066W-LT
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:01:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpSO8-00066L-Gi
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:01:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-12-armbru@redhat.com>
	<26ff5c67-abfa-bc5d-7c26-3f08ffbdc57b@redhat.com>
	<87k1oyl2y4.fsf@dusky.pond.sub.org>
	<faf9bd30-5d2a-a68f-e6b4-c9dc8c369466@redhat.com>
	<87ftzidcef.fsf@dusky.pond.sub.org>
	<e3606e6f-6880-0647-f6f0-284142e06ab8@redhat.com>
Date: Tue, 14 Aug 2018 08:01:02 +0200
In-Reply-To: <e3606e6f-6880-0647-f6f0-284142e06ab8@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 09:53:00 -0500")
Message-ID: <87eff14hcx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/56] check-qjson: Cover UTF-8 in single
 quoted strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/13/2018 01:11 AM, Markus Armbruster wrote:
>
>>>>> Technically, Unicode ends at U+10FFFF (21 bits). Anything beyond that
>>>>> is not valid Unicode, even if it IS a valid interpretation of UTF-8
>>>>> encoding.
>>>>
>>>> Correct.  Testing how we handle such sequences makes sense all the same.
>>>>
>>>>>>             {
>>>>>> -            "\"\xF7\xBF\xBF\xBF\"",
>>>>>> +            "\xF7\xBF\xBF\xBF",
>>>>>>                 NULL,               /* bug: rejected */
>>>
>>> So, maybe all the more we need to do is remove the comment (as we WANT
>>> to reject these)?
>>
>> Is PATCH 20 doing what you suggest?
>
> Yes, I think you get there in the end, it was more a question of churn
> in the meantime.

Modest churn, I think.  PATCH 09 adds some ten bug: comments that go
away in "[PATCH 21/56] json: Reject invalid UTF-8 sequences" (some might
go a bit later, didn't check).  I put my announcement of intent "[PATCH
20/56] check-qjson: Document we expect invalid UTF-8 to be rejected"
right before its implementation in PATCH 21.  Having PATCH 20 in place
before PATCH 09 would avoid the bug: comment churn, but it would also
separate announcement of intent from implementation.  Seems doubtful to
me.

>>>>>
>>>>> The conversion of the initializer looks sane (well, mechanical).  Ergo:
>>>>>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> Thanks!
>>>
>>> Of course, playing games with the pre-existing comments on
>>> out-of-range behavior is probably better for a separate patch, and you
>>> do have some churn on these tests in later patches. I'll leave it up
>>> to you what to do (or leave put).
>>
