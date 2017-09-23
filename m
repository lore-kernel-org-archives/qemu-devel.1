Received: from eggs.gnu.org ([2001:4830:134:3::10]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dviBL-0008Rf-0P
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 07:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dviBH-0003Ms-V8
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 07:01:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5332 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dviBH-0003MH-DZ
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 07:01:07 -0400
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
	<cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
	<9a3ce498-040d-5d8f-41d0-a2a649771528@virtuozzo.com>
	<866e71c0-5d94-d9a2-d00b-3dd43319a1f8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <33e1c27b-96b2-8051-e3b2-1929a1ce6a04@virtuozzo.com>
Date: Sat, 23 Sep 2017 14:00:51 +0300
MIME-Version: 1.0
In-Reply-To: <866e71c0-5d94-d9a2-d00b-3dd43319a1f8@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nbd structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, nbd@other.debian.org

22.09.2017 23:36, Eric Blake wrote:
> On 09/22/2017 09:57 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>> If you have suggestions for improving the NBD spec wording, feel free to
>>> propose a doc patch.
>>>
>> Thanks, now I understand.. However I don't have good idea of wording..
>>
>>
>> Another thing: server can send several error and success chunks on
>> CMD_READ..
> Yes, and that is intentional. A server that spawns sub-tasks to read
> portions of the request to various parallel workers, and then sends
> those responses back to the client as sub-tasks finish, can indeed send
> multiple errors before sending the final chunk complete message.
>
>> The obvious behavior of client is to fail the whole read if it received
>> one error chunk.
> Yes, the read has failed if the client sees at least one error chunk.
> The read is not successful unless there are no error chunks, and the
> server has sent chunks describing every portion of the request (the
> server is not allowed to send chunks that overlap, nor to send a
> successful chunk after sending an error for the same offset, nor to send
> a success message if it has not covered the entire request - but IS
> allowed to send multiple error chunks).
>
>> And, actually, client is not interesting in all following chunks for
>> this request.
> Perhaps not, but the client is not in control of how much the server
> sends, so it must gracefully deal with the remaining traffic from the
> server while waiting for the server to finally send the last chunk.
>
>> I think
>> we need some additional negotiation flag for this, which says that error
>> chunk
>> must be final.
> Why? It adds complexity, for no real reason.  (Read errors are not
> common, so it is okay if dealing with read errors requires more network
> traffic than normal).

Hmm, when writing error handling, it may seem that the program is 
processing errors
almost all the time). Ok, really they are not common, so it doesn't 
really matter.

>
>> May be we need also a method (command) to cancel one of inflight
>> requests, but it
>> is not so important.
> Again, that would add complexity that may be really hard to justify (we
> want to be able to implement stateless servers; a server that has to
> parse a second message from a client requesting to abort an in-flight
> command has to track state).  So I don't think it is worth it.
>

-- 
Best regards,
Vladimir
