Received: from eggs.gnu.org ([2001:4830:134:3::10]:44966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8S-0005BP-Vu
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8R-0007gz-7Y
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDD8R-0007gm-3F
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Apr 2018 20:02:25 +0200
Message-Id: <1525111345-14606-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1525111345-14606-1-git-send-email-thuth@redhat.com>
References: <1525111345-14606-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] net: Get rid of 'vlan' terminology and
 use 'hub' instead in the doc files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

'vlan' is very confusing since it does not mean something like IEEE
802.1Q, but rather emulated hubs, so let's switch to that terminology
instead. While we're at it, move the subsection about hub a little bit
downward in the documentation (it's not as important anymore as it was
before the invention of the -netdev parameter), and extend it a little
bit.

Buglink: https://bugs.launchpad.net/qemu/+bug/658904
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index b901cc2..22418f5 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -714,20 +714,12 @@ state is not saved or restored properly (in particular USB).
 @node pcsys_network
 @section Network emulation
 
-QEMU can simulate several network cards (PCI or ISA cards on the PC
-target) and can connect them to an arbitrary number of Virtual Local
-Area Networks (VLANs). Host TAP devices can be connected to any QEMU
-VLAN. VLAN can be connected between separate instances of QEMU to
-simulate large networks. For simpler usage, a non privileged user mode
-network stack can replace the TAP device to have a basic network
-connection.
-
-@subsection VLANs
-
-QEMU simulates several VLANs. A VLAN can be symbolised as a virtual
-connection between several network devices. These devices can be for
-example QEMU virtual Ethernet cards or virtual Host ethernet devices
-(TAP devices).
+QEMU can simulate several network cards (e.g. PCI or ISA cards on the PC
+target) and can connect them to a network backend on the host or an emulated
+hub. The various host network backends can either be used to connect the NIC of
+the guest to a real network (e.g. by using a TAP devices or the non-privileged
+user mode network stack), or to other guest instances running in another QEMU
+process (e.g. by using the socket host network backend).
 
 @subsection Using TAP network interfaces
 
@@ -763,7 +755,7 @@ network). The virtual network configuration is the following:
 
 @example
 
-         QEMU VLAN      <------>  Firewall/DHCP server <-----> Internet
+     guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
                            |          (10.0.2.2)
                            |
                            ---->  DNS server (10.0.2.3)
@@ -798,11 +790,23 @@ When using the @option{'-netdev user,hostfwd=...'} option, TCP or UDP
 connections can be redirected from the host to the guest. It allows for
 example to redirect X11, telnet or SSH connections.
 
-@subsection Connecting VLANs between QEMU instances
+@subsection Hubs
+
+QEMU can simulate several hubs. A hub can be thought of as a virtual connection
+between several network devices. These devices can be for example QEMU virtual
+ethernet cards or virtual Host ethernet devices (TAP devices). You can connect
+guest NICs or host network backends to such a hub using the @option{-netdev
+hubport} or @option{-nic hubport} options. The legacy @option{-net} option
+also connects the given device to the emulated hub with ID 0 (i.e. the default
+hub) unless you specify a netdev with @option{-net nic,netdev=xxx} here.
+
+@subsection Connecting emulated networks between QEMU instances
 
-Using the @option{-net socket} option, it is possible to make VLANs
-that span several QEMU instances. See @ref{sec_invocation} to have a
-basic example.
+Using the @option{-netdev socket} (or @option{-nic socket} or
+@option{-net socket}) option, it is possible to create emulated
+networks that span several QEMU instances.
+See the description of the @option{-netdev socket} option in the
+@ref{sec_invocation,,Invocation chapter} to have a basic example.
 
 @node pcsys_other_devs
 @section Other Devices
-- 
1.8.3.1
