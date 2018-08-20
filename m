Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1frkP3-0007Qg-6f
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1frkOy-0005lW-E0
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:39:28 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:41273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1frkOt-0005iR-1k
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:39:20 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAMxuvaxognWTGfUdd-103JqXM24TofHJeiztFFwHSApBR6zDOw@mail.gmail.com>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
	<CAMxuvayBTG7XghOmdTdxT8uR+WH68GC00i3=jWHDU8w+-Ym4Tw@mail.gmail.com>
	<1677821534769507@iva4-ed922e5c836e.qloud-c.yandex.net>
	<CAMxuvaxognWTGfUdd-103JqXM24TofHJeiztFFwHSApBR6zDOw@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 20 Aug 2018 16:39:15 +0300
Message-Id: <1698031534772355@sas1-bf4ab558af9f.qloud-c.yandex.net>
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



20.08.2018, 16:11, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>=
:
> Hi
>
> On Mon, Aug 20, 2018 at 2:51 PM, Yury Kotov <yury-kotov@yandex-team.ru>=
 wrote:
>> =C2=A016.08.2018, 18:36, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@re=
dhat.com>:
>>> =C2=A0On Thu, Aug 16, 2018 at 5:32 PM, Yury Kotov <yury-kotov@yandex-=
team.ru> wrote:
>>>> =C2=A0=C2=A0We are using QEMU (2.12.0) with SPDK (18.04.1) over vhos=
t-user to emulate block
>>>> =C2=A0=C2=A0devices. One of our cases it to restart SPDK without res=
tarting VM (in case
>>>> =C2=A0=C2=A0of some updates or smth like it). We tried to use the 'r=
econnect' option for
>>>> =C2=A0=C2=A0the '-chardev' device:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-object memory-backend-file,id=3Dmem0,size=3D=
1G,mem-path=3D/dev/hugepages,share=3Don \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem0 \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,id=3Dspdk_vhost_blk1,path=3D=
/var/tmp/vhost.1,reconnect=3D10 \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-device vhost-user-blk-pci,chardev=3Dspdk_vh=
ost_blk1,num-queues=3D4
>>>>
>>>> =C2=A0=C2=A0After this, vhost-user-blk initialization fails with an =
error below:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64: -device ...: Failed to s=
et msg fds.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64: -device ...: vhost-user-=
blk: vhost initialization failed:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Operation not permitted
>>>>
>>>> =C2=A0=C2=A0We got the same error with the latest QEMU (c542a9f9794e=
c8e0bc3f).
>>>>
>>>> =C2=A0=C2=A0We made some investigations and found out that there are=
 several issues:
>>>>
>>>> =C2=A0=C2=A01. Reconnect option postpones the first connection till =
machine init done event.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0But we need this connection during vho=
st blk device initialization which
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0happens before the machine init done h=
andling.
>>>>
>>>> =C2=A0=C2=A02. If the connection is forced, then the reconnection wi=
ll be successful
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0after SPDK restart. The problem is tha=
t virtual queue will not start.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The reason for it is that virtual queu=
e initialization commands
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should be resent:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_FEATURES
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_MEM_TABLE
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_NUM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_BASE
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_ADDR
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_KICK
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* VHOST_USER_SET_VRING_CALL
>>>>
>>>> =C2=A0=C2=A0The patch set resolves both of these issues.
>>>>
>>>> =C2=A0=C2=A0Test case:
>>>>
>>>> =C2=A0=C2=A01. Start fio process (inside VM):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fio --name test --ioengine=
=3Dlibaio --iodepth=3D64 --bs=3D4096 \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--=
rw=3Drandrw --direct=3D1 --sync=3D1 --verify=3Dmd5 \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--=
size=3D64M --filename=3D/dev/vda --loops=3D100
>>>>
>>>> =C2=A0=C2=A02. Restart SPDK many times.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0We are expecting that during SPDK rest=
art fio will pause and fio should
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue to work after restart complet=
ion.
>>>>
>>>> =C2=A0=C2=A03. fio process completed successfully without any error.
>>>
>>> =C2=A0Can you write a test case in vhost-user-test.c ? (perhaps under
>>> =C2=A0QTEST_VHOST_USER_FIXME scope...)
>>
>> =C2=A0This is a great idea and we were definitely going to do that dur=
ing coming couple of weeks. We thought that we could make a follow up com=
mit with necessary tests added a bit later though, since currently we nee=
d to figure out the state of vhost-user tests in general, before we can t=
ry to add any new stuff, and that will take some time. So far we have str=
ess-tested these fixes manually.
>
> Yes, some vhost-user tests are disabled by default (sadly for travis
> CI reason - not a really bug), and it's easy to introduce regressions.
>
> I sent a related series "[PATCH 0/4] Fix socket chardev regression" to
> make it work again.
>
>> =C2=A0Do you suggest we wait with this series as well until we have al=
l tests ready? Or do we proceed now and make a follow up series with vhos=
t user tests later like we suggested?
>
> I would rather have the tests with the series.
>

Sounds good. We will resend v2 with tests. However while we do that, we w=
ould be
grateful for more comments on current implementation as well, since it at=
 least
passes our internal functional tests.

>>>> =C2=A0=C2=A0Yury Kotov (3):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0chardev: prevent extra connection attempt in=
 tcp_chr_machine_done_hook
>>>> =C2=A0=C2=A0=C2=A0=C2=A0vhost: refactor vhost_dev_start and vhost_vi=
rtqueue_start
>>>> =C2=A0=C2=A0=C2=A0=C2=A0vhost-user: add reconnect support for vhost-=
user
>>>>
>>>> =C2=A0=C2=A0=C2=A0chardev/char-socket.c | 5 +-
>>>> =C2=A0=C2=A0=C2=A0hw/virtio/vhost-user.c | 65 ++++++++++++--
>>>> =C2=A0=C2=A0=C2=A0hw/virtio/vhost.c | 223 ++++++++++++++++++++++++++=
+++++---------------
>>>> =C2=A0=C2=A0=C2=A0include/hw/virtio/vhost.h | 2 +
>>>> =C2=A0=C2=A0=C2=A04 files changed, 215 insertions(+), 80 deletions(-=
)
>>>>
>>>> =C2=A0=C2=A0--
>>>> =C2=A0=C2=A02.7.4
