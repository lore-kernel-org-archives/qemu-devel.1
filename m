Received: from eggs.gnu.org ([2001:4830:134:3::10]:43070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT2bc-0001CO-7q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT2bY-0005ZA-As
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:57:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dT2bY-0005Yy-4i
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:57:44 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
	<c5b1b1bb-f637-24b7-bdac-0c6c3f310c83@redhat.com>
	<5aafa3cf-4ee1-f198-ce09-5c2d66e643cd@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1caf5855-2119-e48a-329b-a266cc3f41e6@redhat.com>
Date: Thu, 6 Jul 2017 10:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <5aafa3cf-4ee1-f198-ce09-5c2d66e643cd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, den@openvz.org



On 06/07/2017 10:45, Vladimir Sementsov-Ogievskiy wrote:
>>> +do_nbd_trip_read(uint32_t len) "Read %" PRIu32" byte(s)"
>> This one is good.
>=20
> why do you like this and do not like nbd_trip_write_zeros?

I'm not sure I understand: this one is after blk_pread returns.  It
tells you that the socket is about to receive the payload.

For write, nothing special happened since do_nbd_trip_cmd_write.

For write zeroes, nothing special happened since
nbd_co_receive_request_decode_type.

>>
>>> +do_nbd_trip_cmd_write(void) "Request type is WRITE"
>>> +do_nbd_trip_cmd_write_readonly(void) "Server is read-only, return
>>> error"
>> These can be removed.
>=20
> I think the second is informative, isn't it?

Can you instead add a trace point at the beginning of nbd_co_send_reply,
with handle/error/len?  Then you can remove do_nbd_trip_read and
do_nbd_trip_complete, too.

>>> +do_nbd_trip_write(void) "Writing to device"
>> Please add the handle here.
>=20
> handle will be printed in nbd_co_receive_request_decode_type..

You need it in case there are multiple requests in flight.

>>> +do_nbd_trip_cmd_write_zeroes(void) "Request type is WRITE_ZEROES"
>>> +do_nbd_trip_write_zeroes(void) "Writing to device"
>>> +do_nbd_trip_cmd_flush(void) "Request type is FLUSH"
>>> +do_nbd_trip_cmd_trim(void) "Request type is TRIM"
>> Can all be removed.
>=20
> then, remove nbd_trip_write too ?

Write is different because it happens after nbd_read(client->ioc,
req->data, request->len, NULL) has completed.  You can add a tracepoint
to nbd_co_receive_request instead.

Paolo
