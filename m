Received: from eggs.gnu.org ([2001:4830:134:3::10]:59187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xl2-0000FH-MQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xl1-0005eM-UJ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:33:28 -0400
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<fc24ba9e-e325-6478-cb22-bc0a256c6e87@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8c656cc9-9543-5c70-7d78-de02a466319f@redhat.com>
Date: Tue, 9 Oct 2018 15:33:19 -0400
MIME-Version: 1.0
In-Reply-To: <fc24ba9e-e325-6478-cb22-bc0a256c6e87@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 00/10] NBD reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com



On 09/17/2018 11:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> ping
>=20

Is this still pending or did I/we miss a v5?

> 31.07.2018 20:30, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Here is NBD reconnect. Previously, if connection failed all current
>> and future requests will fail. After the series, nbd-client driver
>> will try to reconnect unlimited times. During first @reconnect-delay
>> seconds of reconnecting all requests will wait for the connection,
>> and if it is established requests will be resent. After
>> @reconnect-delay period all requests will be failed (until successful
>> reconnect).
>>
>> v4: - add Eric's r-b to 01.
>> =C2=A0=C2=A0=C2=A0=C2=A0 - drop CONNECTING_INIT mode, don't reconnect =
on _open.
>> =C2=A0=C2=A0=C2=A0=C2=A0 - new api: only one parameter @reconnect-dela=
y
>> =C2=A0=C2=A0=C2=A0=C2=A0 - new interval scheme between reconnect attem=
pts
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 - 2 - 4 - 8 - 16 -=
 16 ... seconds)
>> =C2=A0=C2=A0=C2=A0=C2=A0 - fixes and refactorings in main patch (09), =
including merge with
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old 08 patch
>> =C2=A0=C2=A0=C2=A0=C2=A0
>> v3:
>> 06: fix build error in function 'nbd_co_send_request':
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error: 'i' may be used uninitialized in=
 this function
>>
>> v2 notes:
>> Here is v2 of NBD reconnect, but it is very very different from v1, so=
,
>> forget about v1.
>> The series includes my "NBD reconnect: preliminary refactoring", with
>> changes in 05: leave asserts (Eric).
>>
>> Vladimir Sementsov-Ogievskiy (10):
>> =C2=A0=C2=A0 block/nbd-client: split channel errors from export errors
>> =C2=A0=C2=A0 block/nbd: move connection code from block/nbd to block/n=
bd-client
>> =C2=A0=C2=A0 block/nbd-client: split connection from initialization
>> =C2=A0=C2=A0 block/nbd-client: fix nbd_reply_chunk_iter_receive
>> =C2=A0=C2=A0 block/nbd-client: don't check ioc
>> =C2=A0=C2=A0 block/nbd-client: move from quit to state
>> =C2=A0=C2=A0 block/nbd-client: rename read_reply_co to connection_co
>> =C2=A0=C2=A0 block/nbd: add cmdline and qapi parameter reconnect-delay
>> =C2=A0=C2=A0 block/nbd-client: nbd reconnect
>> =C2=A0=C2=A0 iotests: test nbd reconnect
>>
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 12 +-
>> =C2=A0 block/nbd-client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +-
>> =C2=A0 block/nbd-client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 515
>> +++++++++++++++++++++++++++++++-----------
>> =C2=A0 block/nbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 ++---
>> =C2=A0 tests/qemu-iotests/220=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 67 ++++++
>> =C2=A0 tests/qemu-iotests/220.out=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
>> =C2=A0 tests/qemu-iotests/iotests.py |=C2=A0=C2=A0 4 +
>> =C2=A0 8 files changed, 512 insertions(+), 170 deletions(-)
>> =C2=A0 create mode 100755 tests/qemu-iotests/220
>> =C2=A0 create mode 100644 tests/qemu-iotests/220.out
>>
>=20
>
