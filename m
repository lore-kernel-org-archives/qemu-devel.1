Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp64O-00018R-8M
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp64L-0006DE-37
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:11:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp64K-0006Cr-U0
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:11:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-12-armbru@redhat.com>
	<26ff5c67-abfa-bc5d-7c26-3f08ffbdc57b@redhat.com>
	<87k1oyl2y4.fsf@dusky.pond.sub.org>
	<faf9bd30-5d2a-a68f-e6b4-c9dc8c369466@redhat.com>
Date: Mon, 13 Aug 2018 08:11:04 +0200
In-Reply-To: <faf9bd30-5d2a-a68f-e6b4-c9dc8c369466@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 09:59:20 -0500")
Message-ID: <87ftzidcef.fsf@dusky.pond.sub.org>
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2018 09:18 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>>>> utf8_string() tests only double quoted strings.  Cover single quoted
>>>> strings, too: store the strings to test without quotes, then wrap them
>>>> in either kind of quote.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    tests/check-qjson.c | 427 ++++++++++++++++++++++----------------------
>>>>    1 file changed, 214 insertions(+), 213 deletions(-)
>>>>
>>>
>>> Pre-existing, but:
>>>
>>>>            /* 2.2.4  4 bytes U+1FFFFF */
>>>
>>> Technically, Unicode ends at U+10FFFF (21 bits). Anything beyond that
>>> is not valid Unicode, even if it IS a valid interpretation of UTF-8
>>> encoding.
>>
>> Correct.  Testing how we handle such sequences makes sense all the same.
>>
>>>>            {
>>>> -            "\"\xF7\xBF\xBF\xBF\"",
>>>> +            "\xF7\xBF\xBF\xBF",
>>>>                NULL,               /* bug: rejected */
>
> So, maybe all the more we need to do is remove the comment (as we WANT
> to reject these)?

Is PATCH 20 doing what you suggest?

>>>
>>> The conversion of the initializer looks sane (well, mechanical).  Ergo:
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Thanks!
>
> Of course, playing games with the pre-existing comments on
> out-of-range behavior is probably better for a separate patch, and you
> do have some churn on these tests in later patches. I'll leave it up
> to you what to do (or leave put).
