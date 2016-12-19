Received: from eggs.gnu.org ([2001:4830:134:3::10]:56620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmh-0003M0-9q
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIvmf-0001aU-0h
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:37967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIvme-0001XE-NY
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:07:08 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 19:05:52 +0800
Message-Id: <1482145554-88823-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
References: <1482145554-88823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/3] spec/vhost-user: extend vhost-user to
 support the vhost-pci based inter-vm communiaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

The protocol feature, VHOST_USER_PROTOCOL_F_VHOST_PCI, indicates the
support of vhost-pci. The vhost-pci extension requires the master side
implementation to support an asynchronous socket read method. This is
used when the slave side vhost-pci device and driver finishes the
feature bits negotiation. The negotiated feature bits are sent to the
master. If the feature bits sent by the slave are a subset of the ones
that were sent by the master, the master should perform a reset of the
master device (e.g. virtio_net), to re-negotiate the feature bits using
the ones sent by the slave.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 docs/specs/vhost-user.txt | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index d70bd83..18e49d0 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -17,12 +17,15 @@ The protocol defines 2 sides of the communication, master and slave. Master is
 the application that shares its virtqueues, in our case QEMU. Slave is the
 consumer of the virtqueues.
 
-In the current implementation QEMU is the Master, and the Slave is intended to
+In the traditional implementation QEMU is the master, and the slave is intended to
 be a software Ethernet switch running in user space, such as Snabbswitch.
 
 Master and slave can be either a client (i.e. connecting) or server (listening)
 in the socket communication.
 
+The current vhost-user protocol is extended to support the vhost-pci based inter-VM
+communication. In this case, both the slave and master are QEMU instances.
+
 Message Specification
 ---------------------
 
@@ -36,7 +39,7 @@ consists of 3 header fields and a payload:
  * Request: 32-bit type of the request
  * Flags: 32-bit bit field:
    - Lower 2 bits are the version (currently 0x01)
-   - Bit 2 is the reply flag - needs to be sent on each reply from the slave
+   - Bit 2 is the reply flag - needs to be sent on each reply
    - Bit 3 is the need_reply flag - see VHOST_USER_PROTOCOL_F_REPLY_ACK for
      details.
  * Size - 32-bit size of the payload
@@ -119,9 +122,9 @@ The protocol for vhost-user is based on the existing implementation of vhost
 for the Linux Kernel. Most messages that can be sent via the Unix domain socket
 implementing vhost-user have an equivalent ioctl to the kernel implementation.
 
-The communication consists of master sending message requests and slave sending
-message replies. Most of the requests don't require replies. Here is a list of
-the ones that do:
+Traditionally, the communication consists of master sending message requests and
+slave sending message replies. Most of the requests don't require replies. Here
+is a list of the ones that do:
 
  * VHOST_USER_GET_FEATURES
  * VHOST_USER_GET_PROTOCOL_FEATURES
@@ -130,6 +133,10 @@ the ones that do:
 
 [ Also see the section on REPLY_ACK protocol extension. ]
 
+Currently, the communication also supports the slave actively sending messages
+to the master. Here is a list of them:
+ * VHOST_USER_SET_FEATURES
+
 There are several messages that the master sends with file descriptors passed
 in the ancillary data:
 
@@ -259,6 +266,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD      1
 #define VHOST_USER_PROTOCOL_F_RARP           2
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
+#define VHOST_USER_PROTOCOL_F_VHOST_PCI      4
 
 Message types
 -------------
@@ -279,8 +287,9 @@ Message types
       Id: 2
       Ioctl: VHOST_SET_FEATURES
       Master payload: u64
+      Slave payload: u64
 
-      Enable features in the underlying vhost implementation using a bitmask.
+      Feature bits negotiation between the master and slave using a bitmask.
       Feature bit VHOST_USER_F_PROTOCOL_FEATURES signals slave support for
       VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
 
-- 
2.7.4
