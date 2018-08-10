Received: from eggs.gnu.org ([2001:4830:134:3::10]:56193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9EI-00032z-Ao
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9EF-0004JZ-5I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:21:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9EE-0004I2-Ua
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:21:27 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-22-armbru@redhat.com>
	<1f889c18-c795-85e3-3ed1-001247403a1d@redhat.com>
	<87y3dejndy.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <226f2f8f-7c7b-c433-9dd7-6d90b5585920@redhat.com>
Date: Fri, 10 Aug 2018 10:21:23 -0500
MIME-Version: 1.0
In-Reply-To: <87y3dejndy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/56] json: Reject invalid UTF-8 sequences
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

On 08/10/2018 09:40 AM, Markus Armbruster wrote:

>>> +            cp = mod_utf8_codepoint(ptr, 6, &end);
>>
>> Why are you hard-coding 6 here, rather than computing min(6,
>> strchr(ptr,0)-ptr)?  If the user passes an invalid sequence at the end
>> of the string, can we end up making mod_utf8_codepoint() read beyond
>> the end of our string?  Would it be better to just always pass the
>> remaining string length (mod_utf8_codepoint() only cares about
>> stopping short of 6 bytes, but never reads beyond there even if you
>> pass a larger number)?
> 
> mod_utf8_codepoint() never reads beyond '\0'.  The second parameter
> exists only so you can further limit reads.  I like to provide that
> capability, because it sometimes saves a silly substring copy.

Okay. Perhaps the comments on mod_utf8_codepoint() could make that more 
clear that the contract is not violated (I didn't spot it without a 
close re-read of the code, prompted by your reply).  But that's possibly 
a separate patch.


>>> +    if (codepoint > 0 && codepoint <= 0x7F) {
>>> +        buf[0] = codepoint & 0x7F;
>>
>> Dead use of binary &. But acceptable for symmetry with the other code
>> branches.
> 
> Exactly as dead as ...
> 

>>> +    buf[0] = 0xF0 | ((codepoint >> 18) & 0x07);
> 
> ... even this one.
> 
> The last one only because is_valid_codepoint() rejects codepoints >
> 0x10FFFFu, which is admittedly a non-local argument.
> 
> I'm debating whether to keep or drop the redundant masking.  Got a
> preference?

No strong preference. A compiler with good range propagation during 
optimization should be able to eliminate the dead mask from the emitted 
assembly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
