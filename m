Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dekav-0004V9-RX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dekaq-0007PS-Fk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10133 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dekap-0007Os-W0
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:09:24 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
	<4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
	<cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
	<b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
	<ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b11f4185-df95-5891-f7d3-43c64d9cb3b5@virtuozzo.com>
Date: Mon, 7 Aug 2017 19:09:01 +0300
MIME-Version: 1.0
In-Reply-To: <ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, P J P <ppandit@redhat.com>, mreitz@redhat.com

07.08.2017 18:33, Eric Blake wrote:
> On 08/07/2017 10:13 AM, Eric Blake wrote:
>> On 08/07/2017 07:56 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 07.08.2017 14:52, Eric Blake wrote:
>>>> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Set reply.handle to 0 on error path to prevent normal path of
>>>>> nbd_co_receive_reply.
>> ...and the client is recognizing that the server sent garbage, but then
>> proceeds to handle the packet anyway.  The ideal reaction is that the
>> client should disconnect from the server, rather than handle the packet.
>>   But because it didn't do that, the client is now unable to receive any
>> future messages from the server.  Compare the traces of:
>>
>> followed by a clean disconnect; vs. the buggy server:
>>
>> 29148@1502118384.385133:nbd_opt_go_success Export is good to go
>> 29148@1502118384.385321:nbd_send_request Sending request to server: {
>> .from = 0, .len = 1, .handle = 94152262559840, .flags = 0x0, .type = 0
>> (read) }
>> 29148@1502118396.494643:nbd_receive_reply Got reply: { magic =
>> 0x1446698, .error =  0, handle = 94152262559840 }
>> invalid magic (got 0x1446698)
>> read 1/1 bytes at offset 0
>> 1 bytes, 1 ops; 0:00:12.10 (0.082581 bytes/sec and 0.0826 ops/sec)
>> 29148@1502118396.494746:nbd_send_request Sending request to server: {
>> .from = 0, .len = 0, .handle = 94152262559840, .flags = 0x0, .type = 3
>> (flush) }
>>
>> where the client is now hung.  Thankfully, the client is blocked in an
>> idle loop (not eating CPU), so I don't know if this counts as the
>> ability for a malicious server to cause a denial of service against qemu
>> as an NBD client (in general, being unable to read further data from the
>> server because client internal state is now botched is not that much
>> different from being unable to read further data from the server because
>> the client hung up on the invalid server), unless there is some way to
>> cause qemu to die from an assertion failure rather than just get stuck.
> With just patch 6/17 applied, the client still hangs, but this time with
> a different trace:
>
> 30053@1502119637.604092:nbd_opt_go_success Export is good to go
> 30053@1502119637.604256:nbd_send_request Sending request to server: {
> .from = 0, .len = 1, .handle = 94716063746144, .flags = 0x0, .type = 0
> (read) }
> 30053@1502119649.070156:nbd_receive_reply Got reply: { magic =
> 0x1446698, .error =  0, handle = 94716063746144 }
> invalid magic (got 0x1446698)
> read failed: Input/output error
> 30053@1502119649.070243:nbd_send_request Sending request to server: {
> .from = 0, .len = 0, .handle = 94716063746144, .flags = 0x0, .type = 3
> (flush) }
>
> The client still tried to send a flush request to the server, when it
> should REALLY quit talking to the server at all and just disconnect,
> because the moment the client recognizes that the server has sent
> garbage is the moment that the client can no longer assume that the
> server will react correctly to any further commands.
>
> So I don't think your patch is quite correct, even if you have
> identified a shortfall in our client code.
>
Why do you think so? It just does what it states in commit message.

Patch 17 should fix the case (but I doubt that it can be taken separately).


-- 
Best regards,
Vladimir
