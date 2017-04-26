Received: from eggs.gnu.org ([2001:4830:134:3::10]:56110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1d3NdS-0007xc-Cx
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1d3NdO-0003Jb-9o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:09:38 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lyan@suse.com>) id 1d3NdN-0003HI-Tb
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:09:34 -0400
References: <20170426131252.6340.68549.malonedeb@chaenomeles.canonical.com>
From: Liang Yan <lyan@suse.com>
Message-ID: <e0567c06-bcab-9753-96ee-ca912042f784@suse.com>
Date: Wed, 26 Apr 2017 10:09:10 -0400
MIME-Version: 1.0
In-Reply-To: <20170426131252.6340.68549.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Bug 1686390] [NEW] vnc server closed socket after
 arrow "down" keyevent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 4/26/17 9:12 AM, leon wrote:
> Public bug reported:
>
> This is a rewrite for https://bugs.launchpad.net/qemu/+bug/1670377
>
> QEMU 2.6 or later
> tigervncviwer 1.6 =20
>
> Once get into grub boot interface(choose boot os, or recovery mode),
> keep pressing arrow down button for couple times, qemu will close the
> connection, vnc used zrle mode.
One correction is that hold pressing "down" key, and do not release it
for a while, then the connection will be closed.
>
> Interesting place:
> 1. when stopped at grub interface, only arrow up and down key could tri=
gger it,=20
> 2.  only in zrle or tight mode, could work well in raw mode
> 2. it only triggered by remote connection, not happen if local vncviewe=
r and vnc server
According to the trace file, it looks like socket is closed right after
qio_channel_socket_writev, so it may something wrong when update fb by
zrle mode. Anyone know how to trace buffer size change?


46531@1493059183.573496:ps2_put_keycode 0x55f2943ae3b0 keycode 208
46531@1493059183.573498:system_wakeup_request reason=3D3
46531@1493059183.573500:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe75347160
46531@1493059183.573503:apic_report_irq_delivered coalescing 32932
46531@1493059183.573505:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe75347180
46531@1493059183.573507:apic_report_irq_delivered coalescing 32934
46531@1493059183.573509:input_event_sync
46531@1493059183.573518:buffer_resize vnc-input/0x55f293ec3c30: old
4096, new 4096
46531@1493059183.573521:object_class_dynamic_cast_assert
qio-channel-socket->qio-channel (io/channel.c:60:qio_channel_writev_full)=

46531@1493059183.573524:object_dynamic_cast_assert
qio-channel-socket->qio-channel-socket
(io/channel-socket.c:508:qio_channel_socket_writev)
46531@1493059183.573528:object_class_dynamic_cast_assert
qio-channel-socket->qio-channel (io/channel.c:123:qio_channel_close)
46531@1493059183.573531:object_dynamic_cast_assert
qio-channel-socket->qio-channel-socket
(io/channel-socket.c:688:qio_channel_socket_close)

Thanks,
Liang
>
> A trace is attached.
>
> Thanks
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> ** Attachment added: "qemu trace file"
>    https://bugs.launchpad.net/bugs/1686390/+attachment/4868238/+files/t=
race.txt
>
