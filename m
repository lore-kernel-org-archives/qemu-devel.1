Received: from eggs.gnu.org ([2001:4830:134:3::10]:58061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3k3K-0004zM-4u
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3k3G-0004fJ-Rk
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:42850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3k3G-0004ew-LT
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:05:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3k3F-0005tI-5z
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:05:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 157312E80C4
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:05:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 13:59:14 -0000
From: leon <lyan@suse.com>
Reply-To: Bug 1686390 <1686390@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170426131252.6340.68549.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170427135914.26744.84758.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1686390] Re: vnc server closed socket after arrow
 "down" keyevent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Find the root reason: qio_channel_write is going to write 290124 data,
but only wrote 238644, and for the next write 51489, it returned error,
then trigger vnc_client_io_error and disconnect socket.


ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t data=
len)
{
    Error *err =3D NULL;
    ssize_t ret;
    ret =3D qio_channel_write(
        vs->ioc, (const char *)data, datalen, &err);
    VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
    return vnc_client_io_error(vs, ret, &err);
}

// log file


Write Plain: Pending output 0x5579e6bd2c60 size 524288 offset 290124. Wait =
SSF 0
32760@1493228975.268871:object_class_dynamic_cast_assert qio-channel-socket=
->qio-channel (io/channel.c:60:qio_channel_writev_full)
32760@1493228975.268876:object_dynamic_cast_assert qio-channel-socket->qio-=
channel-socket (io/channel-socket.c:508:qio_channel_socket_writev)
Wrote wire 0x5579e6bd2c60 290124 -> 290124


Write Plain: Pending output 0x5579e6bd2c60 size 524288 offset 290124. Wait =
SSF 0
32760@1493228975.731842:object_class_dynamic_cast_assert qio-channel-socket=
->qio-channel (io/channel.c:60:qio_channel_writev_full)
32760@1493228975.731846:object_dynamic_cast_assert qio-channel-socket->qio-=
channel-socket (io/channel-socket.c:508:qio_channel_socket_writev)
Wrote wire 0x5579e6bd2c60 290124 -> 238644
Write Plain: Pending output 0x5579e6bd2c60 size 65536 offset 51480. Wait SS=
F 0
32760@1493228975.731934:object_class_dynamic_cast_assert qio-channel-socket=
->qio-channel (io/channel.c:60:qio_channel_writev_full)
32760@1493228975.731937:object_dynamic_cast_assert qio-channel-socket->qio-=
channel-socket (io/channel-socket.c:508:qio_channel_socket_writev)
Wrote wire 0x5579e6bd2c60 51480 -> -2
vnc_set_share_mode/0x5579e7b6d730: shared -> disconnected

** Changed in: qemu
     Assignee: (unassigned) =3D> leon (liayan)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686390

Title:
  vnc server closed socket after arrow "down" keyevent

Status in QEMU:
  New

Bug description:
  This is a rewrite for https://bugs.launchpad.net/qemu/+bug/1670377

  QEMU 2.6 or later
  tigervncviwer 1.6

  Once get into grub boot interface(choose boot os, or recovery mode),
  keep holding press arrow down button for a while(no release), qemu
  will close the connection, vnc used zrle mode.

  Interesting place:
  1. when stopped at grub interface, only arrow up and down key could trigg=
er it,
  2.  only in zrle or tight mode, could work well in raw mode
  2. it only triggered by remote connection, not happen if local vncviewer =
and vnc server

  A trace is attached.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686390/+subscriptions
