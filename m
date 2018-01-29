Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEsu-0005qQ-S3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1egEsp-0008ST-LS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:28 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1egEsp-0008Rh-Eh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:23 -0500
Received: by mail-pf0-x241.google.com with SMTP id 23so6237736pfp.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:14:22 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 30 Jan 2018 03:13:40 +0800
Message-Id: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 0/4] Allow custom socket option in socket_listen
 and socket_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

socket_listen and socket_connect do not allow custom socket option.
This would be inconvenient if the caller wants a non-blocking socket,
or wants to set TCP_NODELAY or other options.

This series of patches add specific config structures, QemuSocketConfig,
which contains QemuSocketOption. All the QemuSocketOption are formed
as a linked list.

The caller is reponsible for setting up the config structure. Passing
an NULL pointer would use the original socket_listen/socket_connect,
so existing functions are not affected.

Note that the caller needs to check errno after socket_connect when
using a non-blocking socket. It does not have to in other cases.

Zihan Yang (4):
  qemu-socket: Allow custom socket option in socket_listen
  qemu-socket: Allow custom socket options in socket_connect
  net/socket: change net_socket_listen_init to use functions in
    include/qemu/sockets.h
  net/socket: change net_socket_connect_init to use functions in
    sockets.h

 block/sheepdog.c       |   2 +-
 block/ssh.c            |   2 +-
 include/qemu/sockets.h |  22 ++++++-
 io/channel-socket.c    |   4 +-
 net/socket.c           |  93 ++++++++++++++---------------
 qga/channel-posix.c    |   2 +-
 util/qemu-sockets.c    | 156 ++++++++++++++++++++++++++++++++++++++++---------
 7 files changed, 197 insertions(+), 84 deletions(-)

-- 
2.7.4
