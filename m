Received: from eggs.gnu.org ([2001:4830:134:3::10]:52853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1frjxx-00053Q-3I
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1frjxp-0007EX-QS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:11:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1frjxp-0007Cl-K4
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:11:21 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so12501246iob.7
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 06:11:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1677821534769507@iva4-ed922e5c836e.qloud-c.yandex.net>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
	<CAMxuvayBTG7XghOmdTdxT8uR+WH68GC00i3=jWHDU8w+-Ym4Tw@mail.gmail.com>
	<1677821534769507@iva4-ed922e5c836e.qloud-c.yandex.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Aug 2018 15:11:19 +0200
Message-ID: <CAMxuvaxognWTGfUdd-103JqXM24TofHJeiztFFwHSApBR6zDOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Hi

On Mon, Aug 20, 2018 at 2:51 PM, Yury Kotov <yury-kotov@yandex-team.ru> wro=
te:
> 16.08.2018, 18:36, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>=
:
>> On Thu, Aug 16, 2018 at 5:32 PM, Yury Kotov <yury-kotov@yandex-team.ru> =
wrote:
>>>  We are using QEMU (2.12.0) with SPDK (18.04.1) over vhost-user to emul=
ate block
>>>  devices. One of our cases it to restart SPDK without restarting VM (in=
 case
>>>  of some updates or smth like it). We tried to use the 'reconnect' opti=
on for
>>>  the '-chardev' device:
>>>    -object memory-backend-file,id=3Dmem0,size=3D1G,mem-path=3D/dev/huge=
pages,share=3Don \
>>>    -numa node,memdev=3Dmem0 \
>>>    -chardev socket,id=3Dspdk_vhost_blk1,path=3D/var/tmp/vhost.1,reconne=
ct=3D10 \
>>>    -device vhost-user-blk-pci,chardev=3Dspdk_vhost_blk1,num-queues=3D4
>>>
>>>  After this, vhost-user-blk initialization fails with an error below:
>>>    qemu-system-x86_64: -device ...: Failed to set msg fds.
>>>    qemu-system-x86_64: -device ...: vhost-user-blk: vhost initializatio=
n failed:
>>>                                     Operation not permitted
>>>
>>>  We got the same error with the latest QEMU (c542a9f9794ec8e0bc3f).
>>>
>>>  We made some investigations and found out that there are several issue=
s:
>>>
>>>  1. Reconnect option postpones the first connection till machine init d=
one event.
>>>     But we need this connection during vhost blk device initialization =
which
>>>     happens before the machine init done handling.
>>>
>>>  2. If the connection is forced, then the reconnection will be successf=
ul
>>>     after SPDK restart. The problem is that virtual queue will not star=
t.
>>>     The reason for it is that virtual queue initialization commands
>>>     should be resent:
>>>     * VHOST_USER_SET_FEATURES
>>>     * VHOST_USER_SET_MEM_TABLE
>>>     * VHOST_USER_SET_VRING_NUM
>>>     * VHOST_USER_SET_VRING_BASE
>>>     * VHOST_USER_SET_VRING_ADDR
>>>     * VHOST_USER_SET_VRING_KICK
>>>     * VHOST_USER_SET_VRING_CALL
>>>
>>>  The patch set resolves both of these issues.
>>>
>>>  Test case:
>>>
>>>  1. Start fio process (inside VM):
>>>       fio --name test --ioengine=3Dlibaio --iodepth=3D64 --bs=3D4096 \
>>>           --rw=3Drandrw --direct=3D1 --sync=3D1 --verify=3Dmd5 \
>>>           --size=3D64M --filename=3D/dev/vda --loops=3D100
>>>
>>>  2. Restart SPDK many times.
>>>     We are expecting that during SPDK restart fio will pause and fio sh=
ould
>>>     continue to work after restart completion.
>>>
>>>  3. fio process completed successfully without any error.
>>
>> Can you write a test case in vhost-user-test.c ? (perhaps under
>> QTEST_VHOST_USER_FIXME scope...)
>>
>
> This is a great idea and we were definitely going to do that during comin=
g couple of weeks. We thought that we could make a follow up commit with ne=
cessary tests added a bit later though, since currently we need to figure o=
ut the state of vhost-user tests in general, before we can try to add any n=
ew stuff, and that will take some time. So far we have stress-tested these =
fixes manually.

Yes, some vhost-user tests are disabled by default (sadly for travis
CI reason - not a really bug), and it's easy to introduce regressions.

I sent a related series "[PATCH 0/4] Fix socket chardev regression" to
make it work again.

> Do you suggest we wait with this series as well until we have all tests r=
eady? Or do we proceed now and make a follow up series with vhost user test=
s later like we suggested?

I would rather have the tests with the series.

>
>>>  Yury Kotov (3):
>>>    chardev: prevent extra connection attempt in tcp_chr_machine_done_ho=
ok
>>>    vhost: refactor vhost_dev_start and vhost_virtqueue_start
>>>    vhost-user: add reconnect support for vhost-user
>>>
>>>   chardev/char-socket.c | 5 +-
>>>   hw/virtio/vhost-user.c | 65 ++++++++++++--
>>>   hw/virtio/vhost.c | 223 +++++++++++++++++++++++++++++++--------------=
-
>>>   include/hw/virtio/vhost.h | 2 +
>>>   4 files changed, 215 insertions(+), 80 deletions(-)
>>>
>>>  --
>>>  2.7.4
