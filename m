Received: from eggs.gnu.org ([2001:4830:134:3::10]:45613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvPOQ-0006a8-H9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvPON-0002j5-De
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:57:26 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:12550 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dvPON-0002hD-1V
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:57:23 -0400
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
	<cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9a3ce498-040d-5d8f-41d0-a2a649771528@virtuozzo.com>
Date: Fri, 22 Sep 2017 17:57:07 +0300
MIME-Version: 1.0
In-Reply-To: <cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

21.09.2017 16:55, Eric Blake wrote:
> [updating CC to point to the correct new NBD list]
>
> On 09/21/2017 07:18 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> I'm about this:
>>
>> "A server SHOULD try to minimize the number of chunks sent in a reply,
>> but MUST NOT mark a chunk as final if there is still a possibility of
>> detecting an error before transmission of that chunk completes"
>>
>> What do we mean by "possibility"? Formally, such possibility exists
>> always, so, we'll never mark a chunk as final.
> Here's what is envisioned.  It is fairly easy to write a server that
> receives an NBD_CMD_READ, issues the header reply, and only then
> dispatches the I/O to collect the data from the file system to send
> after the header.  But if you encounter EIO (or other problem) while
> reading from the file system, you're stuck if you've already sent the
> header.  In this scenario, if you mark the header being as final, you
> are unable to report the EIO (it is one of the flaws with non-structured
> reads that makes the spec say that if you detect an error after sending
> the header, you have no choice but to terminate the connection).
>
> An alternative server implementation would buffer the header, perform
> the I/O to collect data from the file system, and only when it is all
> present in memory, it finally sends the reply to the client.  In this
> scenario, since you wait until all data is buffered, you know up front
> whether an error occurred while collecting the I/O, and can therefore
> send the data as the final packet right away (whether error or success).
>   However, it potentially requires more memory to buffer requests like
> this, compared to the server that sends information piecemeal as soon as
> it obtains data.
>
> The intent is not to detect errors in sending the data over the wire,
> but in detecting errors in reading the data from the underlying storage
> (or however else the data to be read is being collected).  A chunk must
> not be marked final unless you can guarantee that there will be no
> further errors in collecting data for the reply.
>
> If you have suggestions for improving the NBD spec wording, feel free to
> propose a doc patch.
>

Thanks, now I understand.. However I don't have good idea of wording..


Another thing: server can send several error and success chunks on 
CMD_READ..

The obvious behavior of client is to fail the whole read if it received 
one error chunk.
And, actually, client is not interesting in all following chunks for 
this request. I think
we need some additional negotiation flag for this, which says that error 
chunk
must be final.

May be we need also a method (command) to cancel one of inflight 
requests, but it
is not so important.


-- 
Best regards,
Vladimir
