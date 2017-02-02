Received: from eggs.gnu.org ([2001:4830:134:3::10]:39578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZIk6-0004Lj-5f
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZIk4-00045U-Hj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZIk4-000447-C7
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:08 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  2 Feb 2017 14:51:58 +0000
Message-Id: <20170202145159.20440-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com

Socket activation (sometimes known as systemd socket activation)
allows an Internet superserver to pass a pre-opened listening socket
to the process, instead of having qemu-nbd open a socket itself.  This
is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
standard file descriptor range.

This patch partially implements socket activation.

The limitation of this implementation is that qemu-nbd can only listen
on a single file descriptor, and so if LISTEN_FDS > 1 (eg. for
listening on multiple interfaces or ports) socket activation will
fail.  However for the simple case of listening on a single port, and
either all interfaces with IPv4+IPv6, or just a loopback interface,
the current implementation works fine.  Fixing this properly would
require considerable changes throughout qemu, since qemu's currently
handling of getaddrinfo is plainly wrong.

To use qemu-nbd from systemd, you create
/etc/systemd/system/nbd.socket:

  [Unit]
  Description=QEMU Network Block Device server
  [Socket]
  ListenStream=10809
  [Install]
  WantedBy=sockets.target

and /etc/systemd/system/nbd.service:

  [Service]
  ExecStart=/usr/sbin/qemu-nbd -v -t /path/to/file

and enable the socket service (only):

  systemctl enable nbd.socket
  systemctl start nbd.socket

and then connecting to port 10809 will start qemu-nbd and service the
file, with systemd opening the listening socket.

In the ExecStart line, the qemu-nbd -v option is only needed if you
want enhanced debugging.  The -t option is required unless you want to
fiddle with systemd settings for rate-limiting.

If you try to use the -p and similar options with socket activation
then qemu-nbd will give an error.

(I wasn't sure where to document this -- there is no obvious
documentation for qemu-nbd beyond the simple list of command line
arguments)

This is based on the implementations in
libvirt (src/util/virutil.c:virGetListenFDs) and
nbdkit (src/main.c:get_socket_activation), and also on Denis Plotnikov's
implementation of --server-sock-fd
(https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg07781.html).

Rich.
