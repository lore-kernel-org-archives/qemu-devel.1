Received: from eggs.gnu.org ([2001:4830:134:3::10]:35718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fufbr-0007ce-KA
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fufVO-00070W-Vl
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fufVO-0006z8-OR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:02:06 -0400
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-6-armbru@redhat.com>
	<2f5517a3-bb02-c7e7-cebc-315fbf8bd89b@redhat.com>
	<87d0u3qf30.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4556c609-2b90-43be-7456-4239eb116a55@redhat.com>
Date: Tue, 28 Aug 2018 10:01:56 -0500
MIME-Version: 1.0
In-Reply-To: <87d0u3qf30.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] json: Eliminate lexer state IN_ERROR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/27/2018 11:40 PM, Markus Armbruster wrote:

>>>    typedef enum json_token_type {
>>> -    JSON_MIN = 100,
>>> -    JSON_LCURLY = JSON_MIN,
>>> +    JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
>>> +    /* Gap for lexer states */
>>> +    JSON_LCURLY = 100,
>>> +    JSON_MIN = JSON_LCURLY,
>>
>> In an earlier version of this type of cleanup, you swapped the IN_ and
>> JSON_ values and eliminated the gap, to make the overall table more
>> compact (no storage wasted on any of the states in the gap between the
>> two).
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01178.html
>>
>> Is it still worth trying to minimize the gap between the two
>> sequences, even if you now no longer swap them in order?
> 
> You caught me :)
> 
> Eliminating the gap actually enlarges the table.

Rather, switching the order enlarges the table.

>  I first got confused,
> then measured the size change backwards to confirm my confused ideas.
> When I looked at the patch again, I realized my mistake, and silently
> dropped this part of the change.

The size of the table is determined by the fact that we must initialize 
entry 0 (whether we spell it IN_ERROR or JSON_ERROR), then pay attention 
to the largest value assigned.  Re-reading json_lexer[], you are only 
initializing IN_* states, and not JSON_* states; swapping JSON_* to come 
first enlarged the table because you now have a bunch of additional rows 
in the table that are all 0-initialized to JSON_ERROR transitions.

So at the end of the day, leaving IN_* to be first, and putting JSON_* 
second, makes sense.

The question remains, then, if a fixed-size gap (by making JSON_MIN be 
exactly 100) is any smarter than a contiguous layout (by making JSON_MIN 
be IN_START_INTERP + 1).  I can't see any strong reason for preferring 
one form over the other, so keeping the gap doesn't hurt.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
