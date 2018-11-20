Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPCpk-0005aS-Ud
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPCpg-0002qN-QT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPCpg-0002pc-KN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:16 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-3-david@redhat.com>
	<7d8d4e4f-bb70-5047-4e37-ed3672c89e02@redhat.com>
	<87va4r7aou.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64d0f403-2dd3-2841-b346-7634f37cf5b8@redhat.com>
Date: Tue, 20 Nov 2018 14:41:12 -0600
MIME-Version: 1.0
In-Reply-To: <87va4r7aou.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/9] cutils: Fix qemu_strtosz() &
 friends to reject non-finite sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11/20/18 2:31 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>>> qemu_strtosz() & friends reject NaNs, but happily accept inifities.
>>
>> s/inifities/infinities/
>>
>>> They shouldn't. Fix that.
>>>
>>> The fix makes use of qemu_strtod_finite(). To avoid ugly casts,
>>> change the @end parameter of qemu_strtosz() & friends from char **
>>> to const char **.
>>>
>>> Also, add two test cases, testing that "inf" and "NaN" are properly
>>> rejected.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    include/qemu/cutils.h |  6 +++---
>>>    monitor.c             |  2 +-
>>>    tests/test-cutils.c   | 24 +++++++++++++++++-------
>>>    util/cutils.c         | 16 +++++++---------
>>>    4 files changed, 28 insertions(+), 20 deletions(-)
>>>
>>
>>> +++ b/util/cutils.c
>>> @@ -206,20 +206,18 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>>>     * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
>>
>> Pre-existing, but since you're touching this area: the second 'Return'
>> is unusual capitalization for being mid-sentence.  You could even
>> s/Return/of/
> 
> "of"?

"or" (ouch - wrong time for my fingers to be slipping on the keyboard)


>> It's some hairy code to think about, but I can't find anything wrong
>> with it.  Typo fixes are minor, so
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Thanks for your analysis, Eric.
> 
> With the typo fixes:

Including the fix of my attempt at a typo fix :)

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
