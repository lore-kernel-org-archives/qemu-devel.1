Received: from eggs.gnu.org ([2001:4830:134:3::10]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1frjf1-0005ZQ-Ro
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1frjez-0004U4-TE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:51:55 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:42234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1frjex-0004Rh-S7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:51:53 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAMxuvayBTG7XghOmdTdxT8uR+WH68GC00i3=jWHDU8w+-Ym4Tw@mail.gmail.com>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
	<CAMxuvayBTG7XghOmdTdxT8uR+WH68GC00i3=jWHDU8w+-Ym4Tw@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 20 Aug 2018 15:51:47 +0300
Message-Id: <1677821534769507@iva4-ed922e5c836e.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

16.08.2018, 18:36, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>=
:
> On Thu, Aug 16, 2018 at 5:32 PM, Yury Kotov <yury-kotov@yandex-team.ru>=
 wrote:
>> =C2=A0We are using QEMU (2.12.0) with SPDK (18.04.1) over vhost-user t=
o emulate block
>> =C2=A0devices. One of our cases it to restart SPDK without restarting =
VM (in case
>> =C2=A0of some updates or smth like it). We tried to use the 'reconnect=
' option for
>> =C2=A0the '-chardev' device:
>> =C2=A0=C2=A0=C2=A0-object memory-backend-file,id=3Dmem0,size=3D1G,mem-=
path=3D/dev/hugepages,share=3Don \
>> =C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem0 \
>> =C2=A0=C2=A0=C2=A0-chardev socket,id=3Dspdk_vhost_blk1,path=3D/var/tmp=
/vhost.1,reconnect=3D10 \
>> =C2=A0=C2=A0=C2=A0-device vhost-user-blk-pci,chardev=3Dspdk_vhost_blk1=
,num-queues=3D4
>>
>> =C2=A0After this, vhost-user-blk initialization fails with an error be=
low:
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: -device ...: Failed to set msg f=
ds.
>> =C2=A0=C2=A0=C2=A0qemu-system-x86_64: -device ...: vhost-user-blk: vho=
st initialization failed:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Oper=
ation not permitted
>>
>> =C2=A0We got the same error with the latest QEMU (c542a9f9794ec8e0bc3f=
).
>>
>> =C2=A0We made some investigations and found out that there are several=
 issues:
>>
>> =C2=A01. Reconnect option postpones the first connection till machine =
init done event.
>> =C2=A0=C2=A0=C2=A0=C2=A0But we need this connection during vhost blk d=
evice initialization which
>> =C2=A0=C2=A0=C2=A0=C2=A0happens before the machine init done handling.
>>
>> =C2=A02. If the connection is forced, then the reconnection will be su=
ccessful
>> =C2=A0=C2=A0=C2=A0=C2=A0after SPDK restart. The problem is that virtua=
l queue will not start.
>> =C2=A0=C2=A0=C2=A0=C2=A0The reason for it is that virtual queue initia=
lization commands
>> =C2=A0=C2=A0=C2=A0=C2=A0should be resent:
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_FEATURES
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_MEM_TABLE
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_NUM
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_BASE
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_ADDR
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_KICK
>> =C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_CALL
>>
>> =C2=A0The patch set resolves both of these issues.
>>
>> =C2=A0Test case:
>>
>> =C2=A01. Start fio process (inside VM):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fio --name test --ioengine=3Dlibai=
o --iodepth=3D64 --bs=3D4096 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--rw=3Dran=
drw --direct=3D1 --sync=3D1 --verify=3Dmd5 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--size=3D6=
4M --filename=3D/dev/vda --loops=3D100
>>
>> =C2=A02. Restart SPDK many times.
>> =C2=A0=C2=A0=C2=A0=C2=A0We are expecting that during SPDK restart fio =
will pause and fio should
>> =C2=A0=C2=A0=C2=A0=C2=A0continue to work after restart completion.
>>
>> =C2=A03. fio process completed successfully without any error.
>
> Can you write a test case in vhost-user-test.c ? (perhaps under
> QTEST_VHOST_USER_FIXME scope...)
>

This is a great idea and we were definitely going to do that during comin=
g couple of weeks. We thought that we could make a follow up commit with =
necessary tests added a bit later though, since currently we need to figu=
re out the state of vhost-user tests in general, before we can try to add=
 any new stuff, and that will take some time. So far we have stress-teste=
d these fixes manually.

Do you suggest we wait with this series as well until we have all tests r=
eady? Or do we proceed now and make a follow up series with vhost user te=
sts later like we suggested?

>> =C2=A0Yury Kotov (3):
>> =C2=A0=C2=A0=C2=A0chardev: prevent extra connection attempt in tcp_chr=
_machine_done_hook
>> =C2=A0=C2=A0=C2=A0vhost: refactor vhost_dev_start and vhost_virtqueue_=
start
>> =C2=A0=C2=A0=C2=A0vhost-user: add reconnect support for vhost-user
>>
>> =C2=A0=C2=A0chardev/char-socket.c | 5 +-
>> =C2=A0=C2=A0hw/virtio/vhost-user.c | 65 ++++++++++++--
>> =C2=A0=C2=A0hw/virtio/vhost.c | 223 +++++++++++++++++++++++++++++++---=
------------
>> =C2=A0=C2=A0include/hw/virtio/vhost.h | 2 +
>> =C2=A0=C2=A04 files changed, 215 insertions(+), 80 deletions(-)
>>
>> =C2=A0--
>> =C2=A02.7.4
