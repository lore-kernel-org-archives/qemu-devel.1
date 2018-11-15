Received: from eggs.gnu.org ([2001:4830:134:3::10]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNMeo-0005r2-JS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNMek-0004ST-P7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNMeh-0004RN-Er
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-6-david@redhat.com>
	<63f61f03-3580-4a27-56a7-54bef6d471a0@redhat.com>
	<f1358106-fc9a-6d9f-29dd-6687459cf219@redhat.com>
Date: Thu, 15 Nov 2018 19:46:10 +0100
In-Reply-To: <f1358106-fc9a-6d9f-29dd-6687459cf219@redhat.com> (David
	Hildenbrand's message of "Thu, 15 Nov 2018 18:32:01 +0100")
Message-ID: <87h8gi9o25.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 5/9] test-string-input-visitor: add more
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 15.11.18 18:13, Eric Blake wrote:
>> On 11/15/18 8:04 AM, David Hildenbrand wrote:
>>> Test that very big/small values are not accepted and that ranges with
>>> only one element work.
>>>
>>> Rename expect4 to expect5, as we will be moving that to a separate ulist
>>> test after the rework.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   tests/test-string-input-visitor.c | 22 ++++++++++++++++++++--
>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>> 
>> I don't see a test for a range that wraps around (such as UINT_MAX-0); 
>> that's worth testing (whether it happens to work or is rejected as 
>> invalid).  Do we require ranges to be ascending, or does 6-5 result in 
>> the sequence 5, 6?  I also recall that our range code imposes a limit on 
>> the maximum elements present in a single range, in order to prevent 
>> denial-of-service attacks where a caller could request 0-INT_MAX to 
>> exhaust resources enumerating everything in the range; does our 
>> testsuite cover those limits?
>>
> Ranges have to be ascending and old code enforced that. New code still
> enforces it. Wrapping ranges are AFAIC also not supported - not
> ascending. I can add a test.

Good.

> The limit is a good point. It is neither in the tests nor in the new
> code. But now we finally have an explanation on the 65000-somewhat
> thingy. I assume that we need such a limit?

Yes, we do.  We don't expect untrusted input here, but typo in the
monitor (say 0--1 parsed as uint64_t 0, UINT_MAX) killing the VM by
eating all memory is not a happy user experience.
