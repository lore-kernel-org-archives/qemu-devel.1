Received: from eggs.gnu.org ([2001:4830:134:3::10]:56900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTaJe-0006U4-SD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTaJe-0003OA-06
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:57:30 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-26-vsementsov@virtuozzo.com>
	<87r2xs65a5.fsf@dusky.pond.sub.org> <20170707081305.GA15945@redhat.com>
	<87fue839m5.fsf@dusky.pond.sub.org>
	<5f9bd366-4bf0-6463-3de9-a60afffab7e0@virtuozzo.com>
	<87r2xstkt1.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <66974ef4-b61f-821f-7969-24cfc89b4609@redhat.com>
Date: Fri, 7 Jul 2017 16:57:16 -0400
MIME-Version: 1.0
In-Reply-To: <87r2xstkt1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 25/30] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com



On 07/07/2017 09:53 AM, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 07.07.2017 12:00, Markus Armbruster wrote:
>>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>>
>>>> On Fri, Jul 07, 2017 at 10:05:22AM +0200, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>   block/dirty-bitmap.c         |  5 +++++
>>>>>>   blockdev.c                   | 25 +++++++++++++++++++++++++
>>>>>>   include/block/dirty-bitmap.h |  1 +
>>>>>>   include/qemu/hbitmap.h       |  8 ++++++++
>>>>>>   qapi/block-core.json         | 27 +++++++++++++++++++++++++++
>>>>>>   tests/Makefile.include       |  2 +-
>>>>>>   util/hbitmap.c               | 11 +++++++++++
>>>>>>   7 files changed, 78 insertions(+), 1 deletion(-)
>>>>> [...]
>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>> index 5c42cc7790..6ad8585400 100644
>>>>>> --- a/qapi/block-core.json
>>>>>> +++ b/qapi/block-core.json
>>>>>> @@ -1644,6 +1644,33 @@
>>>>>>     'data': 'BlockDirtyBitmap' }
>>>>>>     ##
>>>>>> +# @BlockDirtyBitmapSha256:
>>>>>> +#
>>>>>> +# SHA256 hash of dirty bitmap data
>>>>>> +#
>>>>>> +# @sha256: ASCII representation of SHA256 bitmap hash
>>>>> Spell it SHA-256, please.  The member name @sha256 can stay.
>>>>>
>>>>> SHA-256 is 256 binary bits.  Please specify how they are represented in
>>>>> ASCII.  It better be base64 (RFC 4648), because we use that elsewhere.
>>>> It is filled later in this patch using qcrypto_hash_digest, so it is just
>>>> a hex string representing the hash, not base64. For the latter you can
>>>> use qcrypto_hash_base64
>>> I got two points:
>>>
>>> 1. Whatever encoding we use, it needs to be documented.
>>>
>>> 2. The fewer binary -> ASCII encodings we use, the better.  We already
>>> use base64.
>>
>>
>> ASCII format for check sum is more common as it is more readable. It
>> is used in the internet to check downloads, it is used by standard
>> utility sha256sum. So, it may be better for the monitor.
>>
>> However, if it is needed, I can make a follow-up patch, it is very
>> easy, just s/qcrypto_hash_digest/qcrypto_hash_base64/ in
>> util/hbitmap.c. iotest 165 - the only user of the feature - doesn't
>> need any changes.
> 
> If the is a standard way to represent SHA-256 in ASCII, use it.
> 
> Whatever you use, document it clearly in the QAPI schema.
> 

I... should we, though? It's a debug interface for testing only,
basically. Couldn't think of a better way to test it, and people
demanded tests.

How's this for documentation:

"The hash will be in an arbitrary format that changes every time you
look away from this specification. Any similarity, real or imagined, to
a canonical SHA-256 ASCII string is purely coincidental."

Basically, I would actually rather go out of my way to obfuscate this
command, not document it...

Maybe that's wrong-headed of me, but I still maintain that it's not
terribly important because I'd rather people never, ever try to use this
in production.
