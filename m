Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eFJMv-0008NT-AQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eFJMr-0007Xd-8u
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:34:09 -0500
Received: from mail-eopbgr30130.outbound.protection.outlook.com
	([40.107.3.130]:2944
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1eFJMq-0007Tw-HM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:34:05 -0500
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <d81706bb-fe0d-ea9e-be17-4276667787ee@openvz.org>
Date: Thu, 16 Nov 2017 15:33:57 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] weird behavior of libvirt/QEMU with virtserial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>

Hello, All!

We observe the following behavior for QEMU configured by libvirt
to use guest agent as usual for the guest without virtio-serial
driver (Windows or the guest remaining in BIOS stage).

In QEMU on first connect to listen character device socket
the listen socket is removed from poll just after the accept().
virtio_serial_guest_ready() returns 0 and the descriptor
of the connected Unix socket is removed from poll and it will
not be present in poll() until the guest will initialize the driver
and change the state of the serial to "guest connected".

In libvirt connect() to guest agent is performed on restart and
is run under VM state lock. Connec() is blocking and can
wait forever as
- accept queue in QEMU is not polled
- it will exhaust sooner or later.
In this case libvirt can not perform ANY operation on that VM. Weird!

The problem should be addressed from both sides IMHO,
as it is bad to keep stale connection in QEMU.

IMHO we should=C2=A0 tweak io_watch_poll_prepare() to register for
G_IO_ERR | G_IO_HUP | G_IO_NVAL even if the read is disable and
handle connection closing gracefully.

Though there are some questions remaining. What should we
do with the data in the socket queue? Are we free to drop it
as the requester has been left? In the other case we should
fix each qemu client including libvirtd.

Alternatively we can still poll listen socket and close any connections
if there is active one.

Any opinion?

Den

P.S. Quick reproducer

VM config, as usual
=C2=A0=C2=A0=C2=A0 <controller type=3D'virtio-serial' index=3D'0'>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bu=
s=3D'0x00' slot=3D'0x06'
function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <channel type=3D'unix'>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target type=3D'virtio' name=3D'org.qemu.g=
uest_agent.0'/>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'virtio-serial' controller=
=3D'0' bus=3D'0' port=3D'1'/>
=C2=A0=C2=A0=C2=A0 </channel>

Quick reproducer:

strace socat -
UNIX-CONNECT:/var/lib/libvirt/qemu/channel/target/domain-20-vm1/org.qemu.=
guest_agent.0
^C (interrupt)
strace socat -
UNIX-CONNECT:/var/lib/libvirt/qemu/channel/target/domain-20-vm1/org.qemu.=
guest_agent.0
^C (interrupt)
strace socat -
UNIX-CONNECT:/var/lib/libvirt/qemu/channel/target/domain-20-vm1/org.qemu.=
guest_agent.0
^C (interrupt)
strace socat -
UNIX-CONNECT:/var/lib/libvirt/qemu/channel/target/domain-20-vm1/org.qemu.=
guest_agent.0
^C (interrupt)

Normal behavior of the 'socat' is passed connect() routine and waiting on=

select(). Wrong behavior - hang in 'connect'.
