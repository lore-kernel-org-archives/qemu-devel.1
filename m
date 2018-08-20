Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friig-0001ey-A7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1friic-00065B-BN
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:51:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1friic-000651-7G
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:51:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-53-armbru@redhat.com>
	<fa470eb3-cc13-1ab3-b0d5-19343bc3b038@redhat.com>
Date: Mon, 20 Aug 2018 13:51:29 +0200
In-Reply-To: <fa470eb3-cc13-1ab3-b0d5-19343bc3b038@redhat.com> (Eric Blake's
	message of "Fri, 17 Aug 2018 11:07:35 -0500")
Message-ID: <87k1olqmri.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 52/60] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
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

> On 08/17/2018 10:05 AM, Markus Armbruster wrote:
>> Bonus: static json_lexer[] loses its unused elements.  It shrinks from
>> 8KiB to 4.75KiB for me.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>
>>           ['a' ... 'z'] = IN_KEYWORD,
>> -        [' '] = IN_WHITESPACE,
>> -        ['\t'] = IN_WHITESPACE,
>> -        ['\r'] = IN_WHITESPACE,
>> -        ['\n'] = IN_WHITESPACE,
>> +        [' '] = IN_START,
>> +        ['\t'] = IN_START,
>> +        ['\r'] = IN_START,
>> +        ['\n'] = IN_START,
>>       },
>>       [IN_START_INTERPOL]['%'] = IN_INTERPOL,
>> +    [IN_START_INTERPOL][' '] = IN_START_INTERPOL,
>> +    [IN_START_INTERPOL]['\t'] = IN_START_INTERPOL,
>> +    [IN_START_INTERPOL]['\r'] = IN_START_INTERPOL,
>> +    [IN_START_INTERPOL]['\n'] = IN_START_INTERPOL,
>
> Hmm, if we did this:
>
> [IN_START_INTERPOL] {
>   ['%'] = IN_INTERPOL,
>   ['\t'] = IN_START_INTERPOL,
> ...
> }
>
> for similarity with all our other constructs, will gcc remember that
> we've already initialized other members not listed in the clause
> before, or will it mistakenly re-0-initialize the array members not
> mentioned?

Fails make check.

(gdb) p json_lexer[IN_START_INTERPOL]
$1 = "\000\000\000\000\000\000\000\000\000\016\016\000\000\016", '\000' <repeats 18 times>, "\016\000\000\000\000\035", '\000' <repeats 217 times>
(gdb) p json_lexer[IN_START]
$2 = "\000\000\000\000\000\000\000\000\000\r\r\000\000\r", '\000' <repeats 18 times>, "\r\000\020\000\000\000\000\022\000\000\000\000\006\033\000\000\023\032\032\032\032\032\032\032\032\032\005", '\000' <repeats 32 times>, "\003\000\004\000\000\000", '\034' <repeats 26 times>, "\001\000\002", '\000' <repeats 129 times>
