Received: from eggs.gnu.org ([2001:4830:134:3::10]:53217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqJc0-0008Eq-09
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqJbx-0003cz-5r
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:50:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqJbx-0003cp-1A
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:50:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-22-armbru@redhat.com>
	<1f889c18-c795-85e3-3ed1-001247403a1d@redhat.com>
	<87y3dejndy.fsf@dusky.pond.sub.org>
	<226f2f8f-7c7b-c433-9dd7-6d90b5585920@redhat.com>
Date: Thu, 16 Aug 2018 16:50:49 +0200
In-Reply-To: <226f2f8f-7c7b-c433-9dd7-6d90b5585920@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 10:21:23 -0500")
Message-ID: <87bma29xh2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 21/56] json: Reject invalid UTF-8 sequences
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

> On 08/10/2018 09:40 AM, Markus Armbruster wrote:
>
>>>> +            cp = mod_utf8_codepoint(ptr, 6, &end);
>>>
>>> Why are you hard-coding 6 here, rather than computing min(6,
>>> strchr(ptr,0)-ptr)?  If the user passes an invalid sequence at the end
>>> of the string, can we end up making mod_utf8_codepoint() read beyond
>>> the end of our string?  Would it be better to just always pass the
>>> remaining string length (mod_utf8_codepoint() only cares about
>>> stopping short of 6 bytes, but never reads beyond there even if you
>>> pass a larger number)?
>>
>> mod_utf8_codepoint() never reads beyond '\0'.  The second parameter
>> exists only so you can further limit reads.  I like to provide that
>> capability, because it sometimes saves a silly substring copy.
>
> Okay. Perhaps the comments on mod_utf8_codepoint() could make that
> more clear that the contract is not violated (I didn't spot it without
> a close re-read of the code, prompted by your reply).  But that's
> possibly a separate patch.

Well, the contract says @s is a string, and that means no access beyond
the terminating null character is permitted.  Perhaps too subtle.  My
contracts often are.

[...]
