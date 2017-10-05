Received: from eggs.gnu.org ([2001:4830:134:3::10]:50475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e03WR-0008C2-RY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e03WQ-0006gR-VS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:36:55 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
	<a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
	<cdec3d7e-04c9-a5e3-d0e7-293e2c7633c8@virtuozzo.com>
	<ca5a605d-e548-5860-1e40-abcac6017683@virtuozzo.com>
	<ad2fa9f3-29b1-c00b-1e51-07604f0b45e0@redhat.com>
	<9c3e29b4-3ec9-4fd7-3d80-122f908d059f@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d54f0fca-6680-cce3-571e-df80a377d48e@redhat.com>
Date: Thu, 5 Oct 2017 12:36:36 +0200
MIME-Version: 1.0
In-Reply-To: <9c3e29b4-3ec9-4fd7-3d80-122f908d059f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 05/10/2017 12:02, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2017 17:06, Paolo Bonzini wrote:
>> On 03/10/2017 15:35, Vladimir Sementsov-Ogievskiy wrote:
>>>>> In the end this probably means that you have a read_chunk_header
>>>>> function and a read_chunk function.=C2=A0 READ has a loop that call=
s
>>>>> read_chunk_header followed by direct reading into the QEMUIOVector,
>>>>> while everyone else calls read_chunk.
>>>> accordingly to spec, we can receive several error reply chunks to an=
y
>>>> request,
>>>> so loop, receiving them should be common for all requests I think
>>> as well as handling error chunks should be common..
>> Yes, reading error chunks should be part of read_chunk_header.
>>
>> Paolo
>=20
> So, you want a loop in READ, and separate loop for other commands? Then
> we will have separate loop for BLOCK_STATUS and for all future commands
> with specific replies?

There should be a separate loop for each command.

The only difference between READ and other commands is that READ
receives directly in QEMUIOVector, while other commands can use a common
function to to receive each structured reply chunk into malloc-ed memory.

Paolo
