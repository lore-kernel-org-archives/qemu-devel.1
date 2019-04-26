Received: from eggs.gnu.org ([209.51.188.92]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJvlh-0007Is-Ce
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJveV-0003d5-CL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hJveU-0003Xd-GC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:52:11 -0400
References: <cover.1550842915.git.berto@igalia.com>
	<20190423165501.GA27867@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5fe7ed7-c11c-4f36-4973-c86031cbe046@redhat.com>
Date: Fri, 26 Apr 2019 09:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190423165501.GA27867@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/04/19 18:55, Daniel P. Berrang=C3=A9 wrote:
> ping - paolo/marc-andr=C3=A9 - unless I'm missing something, it looks l=
ike
> this chardev series slipped through the cracks and missed 4.0

Yeah, it had a bug unfortunately.  I'm looking at it RSN.

Paolo

>=20
> On Fri, Feb 22, 2019 at 03:46:23PM +0200, Alberto Garcia wrote:
>> This fixes a race condition in which the tcp_chr_read() ioc handler
>> can close a connection that is being written to from another thread.
>>
>> Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.
>>
>> Berto
>>
>> RFC: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01510.ht=
ml
>>
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01834.htm=
l
>> - Fixes memory leaks and adds a qemu_idle_add() function
>>
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06137.htm=
l
>> - Rebased on top of the current master (fc3dbb90f2eb069801bfb4cfe9cbc)
>> - Patches 1 and 2: Remove the changes in char-pty.c, they're not
>>                    needed after the rebase.
>> - Patch 3: Fix conflicts after the rebase.
>>
>> v3:
>> - Patch 3: Add tcp_chr_disconnect_locked() [Daniel]
>>
>> Alberto Garcia (3):
>>   main-loop: Fix GSource leak in qio_task_thread_worker()
>>   main-loop: Add qemu_idle_add()
>>   char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout(=
)
>>
>>  chardev/char-socket.c    | 25 +++++++++++++++++++++----
>>  include/qemu/main-loop.h | 12 ++++++++++++
>>  io/task.c                |  9 +++------
>>  util/main-loop.c         |  9 +++++++++
>>  4 files changed, 45 insertions(+), 10 deletions(-)
>>
>> --=20
>> 2.11.0
>>
>=20
> Regards,
> Daniel
>=20
