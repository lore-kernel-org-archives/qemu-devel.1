Received: from eggs.gnu.org ([2001:4830:134:3::10]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e0N9x-0001hm-5r
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e0N9u-0007v0-2Q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:35:01 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23737 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e0N9t-0007sC-Kf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:34:57 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
	<a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
	<cdec3d7e-04c9-a5e3-d0e7-293e2c7633c8@virtuozzo.com>
	<ca5a605d-e548-5860-1e40-abcac6017683@virtuozzo.com>
	<ad2fa9f3-29b1-c00b-1e51-07604f0b45e0@redhat.com>
	<9c3e29b4-3ec9-4fd7-3d80-122f908d059f@virtuozzo.com>
	<d54f0fca-6680-cce3-571e-df80a377d48e@redhat.com>
	<8f9f485a-b3b0-f14a-20ed-86578a96644e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f0100e4f-648a-e2d4-efcd-9549b62b35b1@virtuozzo.com>
Date: Fri, 6 Oct 2017 10:34:50 +0300
MIME-Version: 1.0
In-Reply-To: <8f9f485a-b3b0-f14a-20ed-86578a96644e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 8/8] nbd: Minimal structured
 read for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

06.10.2017 01:12, Eric Blake wrote:
> On 10/05/2017 05:36 AM, Paolo Bonzini wrote:
>> On 05/10/2017 12:02, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.10.2017 17:06, Paolo Bonzini wrote:
>>>> On 03/10/2017 15:35, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> In the end this probably means that you have a read_chunk_header
>>>>>>> function and a read_chunk function.=C2=A0 READ has a loop that ca=
lls
>>>>>>> read_chunk_header followed by direct reading into the QEMUIOVecto=
r,
>>>>>>> while everyone else calls read_chunk.
>>>>>> accordingly to spec, we can receive several error reply chunks to =
any
>>>>>> request,
>>>>>> so loop, receiving them should be common for all requests I think
>>>>> as well as handling error chunks should be common..
>>>> Yes, reading error chunks should be part of read_chunk_header.
>>>>
>>>> Paolo
>>> So, you want a loop in READ, and separate loop for other commands? Th=
en
>>> we will have separate loop for BLOCK_STATUS and for all future comman=
ds
>>> with specific replies?
>> There should be a separate loop for each command.
>>
>> The only difference between READ and other commands is that READ
>> receives directly in QEMUIOVector, while other commands can use a comm=
on
>> function to to receive each structured reply chunk into malloc-ed memo=
ry.
> To make sure we're on the same page, here's how I see it.  At a high
> level, we have:
>
> Each command calls nbd_co_send_request once, then calls
> nbd_co_receive_reply in a loop until there is an indication of the last
> packet.  nbd_co_receive_reply waits for data to come from the server,
> and parses the header.
>
> If the packet is unrecognized, report failure and request a quit
> (negative return value)
>
> If it is old-style:
> - if the command is read, and we did not negotiate structured read, the=
n
> we also read the payload into qiov
> - if the command is read, but we negotiated structured read, the server
> is buggy, so report the bug and request a quit
> - for all other commands, there is no payload, return success or failur=
e
> to the caller based on the header payload
> - at any rate, the reply to the caller is that this is the final packet=
,
> and there is no payload returned (so we return negative or 1, but never=
 0)
>
> Otherwise, it is new-style:
> - if we did not negotiate structured reply, the server is buggy, so
> report the bug and request a quit (negative return)
> - if the chunk is an error, we process the entire packet and report the
> error; if we have any commands that care about the error details, we
> could return the error in a malloc'd discriminated union, but we can
> probably get by without that. If callers don't care about details, but
> the error chunk is not final, it may be easier to just store the fact
> that an error occurred and return 0 to tell the caller to keep looping,
> and return the negative value later when the final chunk is finally rec=
eived
> - if the chunk is NBD_REPLY_TYPE_NONE, there is no payload, and this
> should be the final chunk, so the return to the caller can be the same
> as for old-style (return 1 if we had no earlier error packets, or the
> saved negative value corresponding to the first error received)
> - if the command is read, we can read the payload into qiov (saves
> malloc'ing space for the reply only to copy it into the qiov), so we

but here you said "This is putting a LOT of smarts directly into the=20
receive routine"

> don't have to return any data
> - for any other command, we malloc space for the non-error payload, and
> then it is up to the command's loop to process the payload
>
> so the signature can be something like:
>
> int nbd_co_receive_reply(NBDClientSession *s, QEMUIOVector *qiov,
>                           void **payload)
>
> where it returns -errno on failure, 0 if the command is not complete,
> and 1 if the command is done.  READ passes qiov, which is fully
> populated when the function returns 1; all other commands pass NULL.
> Commands pass NULL for payload if they don't expect a payload return
> (this includes READ); but a command that expects a payload
> (BLOCK_STATUS) passes a pointer in payload and gets malloc'd space
> stored there if return is 0 or 1.
>
> Does that sound like we're on the right design track?
>


--=20
Best regards,
Vladimir
