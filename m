Received: from eggs.gnu.org ([2001:4830:134:3::10]:35870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faLds-0006Oq-JA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faLdr-0007Oe-KW
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:46:52 -0400
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e56d4b22-dfe3-f127-679f-a5609f78d8db@virtuozzo.com>
Date: Tue, 3 Jul 2018 16:46:39 +0300
MIME-Version: 1.0
In-Reply-To: <20180609153217.19683-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 00/11] NBD reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

Hi all.

before v4 realization, I'd like to discuss some questions.

Our proposal for v4 is the following:

1. don't reconnect on nbd_open. So, on open we do only one connect=20
attempt, and if it fails, open fails.
2. don't configure timeout between attempts. instead do the following:
 =C2=A0=C2=A0=C2=A0 1s timeout, then 2s, then 4, 8, 16, and then always 16 =
until success
3. configure only time, after disconnect, during which requests are=20
paused (and after this time, if not connected, they will return EIO). Or=20
not configure it for now, make a default of 5 minutes.

Any ideas?


09.06.2018 18:32, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>
> Here is NBD reconnect.
> The feature realized inside nbd-client driver and works as follows:
>
> There are two parameters: reconnect-attempts and reconnect-timeout.
> So, we will try to reconnect in case of initial connection failed or
> in case of connection lost. All current and new io operations will wait
> until we make reconnect-attempts tries to reconnect. After this, all
> requests will fail with EIO, but we will continue trying to reconnect.
>
> v3:
> 06: fix build error in function 'nbd_co_send_request':
>       error: 'i' may be used uninitialized in this function
>
> v2 notes:
> Here is v2 of NBD reconnect, but it is very very different from v1, so,
> forget about v1.
> The series includes my "NBD reconnect: preliminary refactoring", with
> changes in 05: leave asserts (Eric).
>
> Vladimir Sementsov-Ogievskiy (11):
>    block/nbd-client: split channel errors from export errors
>    block/nbd: move connection code from block/nbd to block/nbd-client
>    block/nbd-client: split connection from initialization
>    block/nbd-client: fix nbd_reply_chunk_iter_receive
>    block/nbd-client: don't check ioc
>    block/nbd-client: move from quit to state
>    block/nbd-client: rename read_reply_co to connection_co
>    block/nbd-client: move connecting to connection_co
>    block/nbd: add cmdline and qapi parameters for nbd reconnect
>    block/nbd-client: nbd reconnect
>    iotests: test nbd reconnect
>
>   qapi/block-core.json          |  12 +-
>   block/nbd-client.h            |  23 ++-
>   block/nbd-client.c            | 429 ++++++++++++++++++++++++++++++-----=
-------
>   block/nbd.c                   |  61 +++---
>   tests/qemu-iotests/220        |  68 +++++++
>   tests/qemu-iotests/220.out    |   7 +
>   tests/qemu-iotests/group      |   1 +
>   tests/qemu-iotests/iotests.py |   4 +
>   8 files changed, 445 insertions(+), 160 deletions(-)
>   create mode 100755 tests/qemu-iotests/220
>   create mode 100644 tests/qemu-iotests/220.out
>


--=20
Best regards,
Vladimir
