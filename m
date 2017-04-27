Received: from eggs.gnu.org ([2001:4830:134:3::10]:34227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3kID-0002jX-Md
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3kIB-0002Jn-0H
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:44913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3kIA-0002JG-Q2
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3kI7-0005Zf-8w
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:21:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 413B72E825B
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:20:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 14:10:46 -0000
From: Daniel Berrange <1686390@bugs.launchpad.net>
Reply-To: Bug 1686390 <1686390@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170426131252.6340.68549.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170427141046.23217.10668.malone@wampee.canonical.com>
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

>  Wrote wire 0x5579e6bd2c60 51480 -> -2

That is QIO_CHANNEL_ERR_BLOCK, aka EAGAIN.

This is fixed in the 2.9.0 release with

commit 537848ee62195fc06c328b1cd64f4218f404a7f1
Author: Michael Tokarev <mjt@tls.msk.ru>
Date:   Fri Feb 3 12:52:29 2017 +0300

    vnc: do not disconnect on EAGAIN
    =

    When qemu vnc server is trying to send large update to clients,
    there might be a situation when system responds with something
    like EAGAIN, indicating that there's no system memory to send
    that much data (depending on the network speed, client and server
    and what is happening).  In this case, something like this happens
    on qemu side (from strace):
    =

    sendmsg(16, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"\244\"..., 729186}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D 103950
    sendmsg(16, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"lz\346"..., 1559618}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EAGAIN
    sendmsg(-1, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"lz\346"..., 1559618}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EBADF
    =

    qemu closes the socket before the retry, and obviously it gets EBADF
    when trying to send to -1.
    =

    This is because there WAS a special handling for EAGAIN, but now it doe=
sn't
    work anymore, after commit 04d2529da27db512dcbd5e99d0e26d333f16efcc, be=
cause
    now in all error-like cases we initiate vnc disconnect.
    =

    This change were introduced in qemu 2.6, and caused numerous grief for =
many
    people, resulting in their vnc clients reporting sporadic random discon=
nects
    from vnc server.
    =

    Fix that by doing the disconnect only when necessary, i.e. omitting this
    very case of EAGAIN.
    =

    Hopefully the existing condition (comparing with QIO_CHANNEL_ERR_BLOCK)
    is sufficient, as the original code (before the above commit) were
    checking for other errno values too.
    =

    Apparently there's another (semi?)bug exist somewhere here, since the
    code tries to write to fd# -1, it probably should check if the connecti=
on
    is open before. But this isn't important.
    =

    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
    Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
    Message-id: 1486115549-9398-1-git-send-email-mjt@msgid.tls.msk.ru
    Fixes: 04d2529da27db512dcbd5e99d0e26d333f16efcc
    Cc: Daniel P. Berrange <berrange@redhat.com>
    Cc: Gerd Hoffmann <kraxel@redhat.com>
    Cc: qemu-stable@nongnu.org
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686390

Title:
  vnc server closed socket after arrow "down" keyevent

Status in QEMU:
  Fix Released

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
