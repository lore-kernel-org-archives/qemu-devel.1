Received: from eggs.gnu.org ([2001:4830:134:3::10]:41102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e0MJA-0003YO-73
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e0MJ7-0002d1-2J
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:40:28 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:7705 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e0MJ6-0002YJ-Dh
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:40:24 -0400
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
	<c3c3bfdb-3e8f-5443-3d6c-52ab5a95bc63@virtuozzo.com>
	<3ba450aa-a4ff-0601-5912-896717e3bf65@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <56c874bb-e6e7-b9c3-a376-9a1679238ccb@virtuozzo.com>
Date: Fri, 6 Oct 2017 09:39:56 +0300
MIME-Version: 1.0
In-Reply-To: <3ba450aa-a4ff-0601-5912-896717e3bf65@redhat.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>

05.10.2017 16:37, Eric Blake wrote:
> On 10/05/2017 06:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 21.09.2017 15:18, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> I'm about this:
>>>
>>> "A server SHOULD try to minimize the number of chunks sent in a reply,
>>> but MUST NOT mark a chunk as final if there is still a possibility of
>>> detecting an error before transmission of that chunk completes"
>>>
>>> What do we mean by "possibility"? Formally, such possibility exists
>>> always, so, we'll never mark a chunk as final.
>>>
>> One more question:
>>
>> for |NBD_REPLY_TYPE_ERROR and ||NBD_REPLY_TYPE_ERROR_OFFSET, why do we
>> need message_length field? why not to calc it as chunk.lenght - 4 for
>> ||NBD_REPLY_TYPE_ERROR and chunk.lenght - 12 for
>> ||NBD_REPLY_TYPE_ERROR_OFFSET?
> For consistency.  If _all_ NBD_REPLY_TYPE_ERROR* message have a
> message_length field, then it is easier to write a generic handler that

Oh, I've missed this in the spec, thanks. Of course it make sense.

> knows how to deal with an unknown error, no matter what command the
> error is sent in response to.  Ideally, a server should never send an
> error message that the client is not expecting, but having a robust
> protocol that lets clients deal with bad servers is worth the redundancy
> caused by being consistent, and we are more likely to add additional
> error modes to existing commands than we are to add more success modes.
>
>> For example, with NBD_REPLY_TYPE_OFFSET_DATA variable data length is
>> calculated, not specified separately.
> That's because non-error types don't have the same consistency concerns;
> if we want to introduce a new success response, we'll probably introduce
> it via a new command, rather than as a reply to an existing command.
> Furthermore, while error replies are likely to have a free-form text
> error description, success replies tend to not need it.  The layout of
> the error types is designed to make it easy to grab the free-form error
> message from a known location for display to the user, even if the
> client has no idea what the rest of the error means, as that may be a
> useful debugging aid.
>
>> What is the reason for server to send NBD_REPLY_TYPE_ERROR with
>> message_lenght < chunk.lenght - 4?
> In all likelihood, all well-written servers will never send garbage
> bytes (possible only when setting chunk.length larger than
> message_length + sizeof(documented fields)).  But we wrote the spec to
> be conservative, in case we want to add a later defined field that
> earlier clients will still gracefully ignore, rather than strict
> (allowing inequality, instead of requiring exact lengths, lets a client
> skip over what it considers garbage bytes rather than dropping the
> connection because a too-new server tried to send useful information in
> those bytes).
>


-- 
Best regards,
Vladimir
