Received: from eggs.gnu.org ([2001:4830:134:3::10]:55298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpkav-0001KG-8W
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 19:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpkaq-0007Rc-C3
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 19:50:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:52228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpkaq-0007Qe-5s
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 19:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpkap-0001Dw-2o
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 23:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F12BE2E80C1
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 23:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Mar 2017 23:41:03 -0000
From: James Clarke <jrtc27@jrtc27.com>
Reply-To: Bug 1643619 <1643619@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161121164013.8062.14361.malonedeb@soybean.canonical.com>
Message-Id: <20170319234103.18157.22597.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1643619] Re: netlink broken on big-endian mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This has been fixed by 40493c5f2b0f124c9b2581e539bba14522e51269, which
is exactly the same diff as given here.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1643619

Title:
  netlink broken on big-endian mips

Status in QEMU:
  Fix Committed

Bug description:
  Debian QEMU version 2.7.0, but the bug also appears in current git
  master (commit c36ed06e9159)

  As the summary says, netlink is completely broken on big-endian mips
  running qemu-user.

  Running 'ip route' from within a Debian chroot with QEMU simply hangs.
  Running amd64 strace on qemu-mips-static shows that it's waiting for a
  netlink response from the kernel which never comes.

  [...]
  [pid 11249] socket(AF_NETLINK, SOCK_RAW|SOCK_CLOEXEC, NETLINK_ROUTE) =3D 3
  [pid 11249] setsockopt(3, SOL_SOCKET, SO_SNDBUF, [32768], 4) =3D 0
  [pid 11249] setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) =3D 0
  [pid 11249] bind(3, {sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0000=
0000}, 12) =3D 0
  [pid 11249] getsockname(3, {sa_family=3DAF_NETLINK, nl_pid=3D11249, nl_gr=
oups=3D00000000}, [12]) =3D 0
  [pid 11249] time([1479745823])          =3D 1479745823
  [pid 11249] sendto(3, {{len=3D671088640, type=3D0x1a00 /* NLMSG_??? */, f=
lags=3DNLM_F_REQUEST|NLM_F_MULTI|0x100, seq=3D539046744, pid=3D0}, "\2\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\10\0\35\0\0\0\1"}, 40, 0, NULL, 0) =3D 40
  [pid 11249] recvmsg(3,

  Notice the len in the buffer passed to the kernel is 0x28000000 which
  looks byteswapped.

  Removing the call to fd_trans_unregister in the NR_socket syscall in
  do_syscall fixes this for me, but I don't understand why the fd
  translation was immediately unregistered after being registered just
  before in do_socket - presumably it was added for a reason.

  --- a/linux-user/syscall.c
  +++ b/linux-user/syscall.c
  @@ -9331,7 +9331,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
   #ifdef TARGET_NR_socket
       case TARGET_NR_socket:
           ret =3D do_socket(arg1, arg2, arg3);
  -        fd_trans_unregister(ret);
           break;
   #endif
   #ifdef TARGET_NR_socketpair

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1643619/+subscriptions
