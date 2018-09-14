Received: from eggs.gnu.org ([2001:4830:134:3::10]:34052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g0oX0-0000aY-AK
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g0oWw-0000xy-Um
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g0oWw-0000sF-MM
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:53:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 14 Sep 2018 17:52:30 +0400
Message-Id: <20180914135230.15178-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
review, let's define a common set of backend conventions to help with
management layer implementation, and interoperability.

v2:
 - drop --pidfile
 - add some notes about daemonizing & stdin/out/err

Cc: libvir-list@redhat.com
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/vhost-user.txt | 109 +++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index ba5e37d714..339b335e9c 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, mas=
ter and slave. Master is
 the application that shares its virtqueues, in our case QEMU. Slave is t=
he
 consumer of the virtqueues.
=20
-In the current implementation QEMU is the Master, and the Slave is inten=
ded to
-be a software Ethernet switch running in user space, such as Snabbswitch=
.
+In the current implementation QEMU is the Master, and the Slave is the
+external process consuming the virtio queues, for example a software
+Ethernet switch running in user space, such as Snabbswitch, or a block
+device backend processing read & write to a virtual disk. In order to
+facilitate interoperability between various backend implementations,
+it is recommended to follow the "Backend program conventions"
+described in this document.
=20
 Master and slave can be either a client (i.e. connecting) or server (lis=
tening)
 in the socket communication.
@@ -859,3 +864,103 @@ resilient for selective requests.
 For the message types that already solicit a reply from the client, the
 presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being set =
brings
 no behavioural change. (See the 'Communication' section for details.)
+
+Backend program conventions
+---------------------------
+
+vhost-user backends provide various services and they may need to be
+configured manually depending on the use case. However, it is a good
+idea to follow the conventions listed here when possible. Users, QEMU
+or libvirt, can then rely on some common behaviour to avoid
+heterogenous configuration and management of the backend program and
+facilitate interoperability.
+
+In order to be discoverable, default vhost-user backends should be
+located under "/usr/libexec", and be named "vhost-user-$device" where
+"$device" is the device name in lower-case following the name listed
+in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
+backend would be named "vhost-user-rproc-serial").
+
+Mechanisms to list, and to select among alternatives implementations
+or modify the default backend are not described at this point (a
+distribution may use update-alternatives, for example, to list and to
+pick a different default backend).
+
+The backend program must not daemonize itself, but it may be
+daemonized by the management layer. It may also have a restricted
+access to the system.
+
+File descriptors 0, 1 and 2 will exist, and have regular
+stdin/stdout/stderr usage (they may be redirected to /dev/null by the
+management layer, or to a log handler).
+
+The backend program must end (as quickly and cleanly as possible) when
+the SIGTERM signal is received. Eventually, it may be SIGKILL by the
+management layer after a few seconds.
+
+The following command line options have an expected behaviour. They
+are mandatory, unless explicitly said differently:
+
+* --socket-path=3DPATH
+
+This option specify the location of the vhost-user Unix domain socket.
+It is incompatible with --fd.
+
+* --fd=3DFDNUM
+
+When this argument is given, the backend program is started with the
+vhost-user socket as file descriptor FDNUM. It is incompatible with
+--socket-path.
+
+* --print-capabilities
+
+Output to stdout a line-seperated list of backend capabilities, and
+then exit successfully. Other options and arguments should be ignored,
+and the backend program should not perform its normal function.
+
+At the time of writing, there are no common capabilities. Some
+device-specific capabilities are listed in the respective sections. By
+convention, device-specific capabilities are prefixed by their device
+name.
+
+vhost-user-input program conventions
+------------------------------------
+
+Capabilities:
+
+input-evdev-path
+
+    The --evdev-path command line option is supported.
+
+input-no-grab
+
+    The --no-grab command line option is supported.
+
+* --evdev-path=3DPATH (optional)
+
+Specify the linux input device.
+
+* --no-grab (optional)
+
+Do no request exclusive access to the input device.
+
+vhost-user-gpu program conventions
+----------------------------------
+
+Capabilities:
+
+gpu-render-node
+
+    The --render-node command line option is supported.
+
+gpu-virgl
+
+    The --virgl command line option is supported.
+
+* --render-node=3DPATH (optional)
+
+Specify the GPU DRM render node.
+
+* --virgl (optional)
+
+Enable virgl rendering support.
--=20
2.19.0
