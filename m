Received: from eggs.gnu.org ([2001:4830:134:3::10]:55347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0U-0002p7-Eq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0P-00084z-Sw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:12:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYo0N-00082y-OI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:59 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:47 +0200
Message-Id: <20181217081047.2039-24-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 23/23] docs: Update pvrdma device
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Interface with the device is changed with the addition of support for
MAD packets.
Adjust documentation accordingly.

While there fix a minor mistake which may lead to think that there is a
relation between using RXE on host and the compatibility with bare-metal
peers.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 docs/pvrdma.txt | 126 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 19 deletions(-)

diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
index 5599318159..5175251b47 100644
--- a/docs/pvrdma.txt
+++ b/docs/pvrdma.txt
@@ -9,8 +9,9 @@ It works with its Linux Kernel driver AS IS, no need for any special guest
 modifications.
 
 While it complies with the VMware device, it can also communicate with bare
-metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
-can work with Soft-RoCE (rxe).
+metal RDMA-enabled machines as peers.
+
+It does not require an RDMA HCA in the host, it can work with Soft-RoCE (rxe).
 
 It does not require the whole guest RAM to be pinned allowing memory
 over-commit and, even if not implemented yet, migration support will be
@@ -78,29 +79,116 @@ the required RDMA libraries.
 
 3. Usage
 ========
+
+
+3.1 VM Memory settings
+======================
 Currently the device is working only with memory backed RAM
 and it must be mark as "shared":
    -m 1G \
    -object memory-backend-ram,id=mb1,size=1G,share \
    -numa node,memdev=mb1 \
 
-The pvrdma device is composed of two functions:
- - Function 0 is a vmxnet Ethernet Device which is redundant in Guest
-   but is required to pass the ibdevice GID using its MAC.
-   Examples:
-     For an rxe backend using eth0 interface it will use its mac:
-       -device vmxnet3,addr=<slot>.0,multifunction=on,mac=<eth0 MAC>
-     For an SRIOV VF, we take the Ethernet Interface exposed by it:
-       -device vmxnet3,multifunction=on,mac=<RoCE eth MAC>
- - Function 1 is the actual device:
-       -device pvrdma,addr=<slot>.1,backend-dev=<ibdevice>,backend-gid-idx=<gid>,backend-port=<port>
-   where the ibdevice can be rxe or RDMA VF (e.g. mlx5_4)
- Note: Pay special attention that the GID at backend-gid-idx matches vmxnet's MAC.
- The rules of conversion are part of the RoCE spec, but since manual conversion
- is not required, spotting problems is not hard:
-    Example: GID: fe80:0000:0000:0000:7efe:90ff:fecb:743a
-             MAC: 7c:fe:90:cb:74:3a
-    Note the difference between the first byte of the MAC and the GID.
+
+3.2 MAD Multiplexer
+===================
+MAD Multiplexer is a service that exposes MAD-like interface for VMs in
+order to overcome the limitation where only single entity can register with
+MAD layer to send and receive RDMA-CM MAD packets.
+
+To build rdmacm-mux run
+# make rdmacm-mux
+
+The application accepts 3 command line arguments and exposes a UNIX socket
+to pass control and data to it.
+-d rdma-device-name  Name of RDMA device to register with
+-s unix-socket-path  Path to unix socket to listen (default /var/run/rdmacm-mux)
+-p rdma-device-port  Port number of RDMA device to register with (default 1)
+The final UNIX socket file name is a concatenation of the 3 arguments so
+for example for device mlx5_0 on port 2 this /var/run/rdmacm-mux-mlx5_0-2
+will be created.
+
+pvrdma requires this service.
+
+Please refer to contrib/rdmacm-mux for more details.
+
+
+3.3 Service exposed by libvirt daemon
+=====================================
+The control over the RDMA device's GID table is done by updating the
+device's Ethernet function addresses.
+Usually the first GID entry is determined by the MAC address, the second by
+the first IPv6 address and the third by the IPv4 address. Other entries can
+be added by adding more IP addresses. The opposite is the same, i.e.
+whenever an address is removed, the corresponding GID entry is removed.
+The process is done by the network and RDMA stacks. Whenever an address is
+added the ib_core driver is notified and calls the device driver add_gid
+function which in turn update the device.
+To support this in pvrdma device the device hooks into the create_bind and
+destroy_bind HW commands triggered by pvrdma driver in guest.
+
+Whenever changed is made to the pvrdma port's GID table a special QMP
+messages is sent to be processed by libvirt to update the address of the
+backend Ethernet device.
+
+pvrdma requires that libvirt service will be up.
+
+
+3.4 PCI devices settings
+========================
+RoCE device exposes two functions - an Ethernet and RDMA.
+To support it, pvrdma device is composed of two PCI functions, an Ethernet
+device of type vmxnet3 on PCI slot 0 and a PVRDMA device on PCI slot 1. The
+Ethernet function can be used for other Ethernet purposes such as IP.
+
+
+3.5 Device parameters
+=====================
+- netdev: Specifies the Ethernet device function name on the host for
+  example enp175s0f0. For Soft-RoCE device (rxe) this would be the Ethernet
+  device used to create it.
+- ibdev: The IB device name on host for example rxe0, mlx5_0 etc.
+- mad-chardev: The name of the MAD multiplexer char device.
+- ibport: In case of multi-port device (such as Mellanox's HCA) this
+  specify the port to use. If not set 1 will be used.
+- dev-caps-max-mr-size: The maximum size of MR.
+- dev-caps-max-qp:      Maximum number of QPs.
+- dev-caps-max-sge:     Maximum number of SGE elements in WR.
+- dev-caps-max-cq:      Maximum number of CQs.
+- dev-caps-max-mr:      Maximum number of MRs.
+- dev-caps-max-pd:      Maximum number of PDs.
+- dev-caps-max-ah:      Maximum number of AHs.
+
+Notes:
+- The first 3 parameters are mandatory settings, the rest have their
+  defaults.
+- The last 8 parameters (the ones that prefixed by dev-caps) defines the top
+  limits but the final values is adjusted by the backend device limitations.
+- netdev can be extracted from ibdev's sysfs
+  (/sys/class/infiniband/<ibdev>/device/net/)
+
+
+3.6 Example
+===========
+Define bridge device with vmxnet3 network backend:
+<interface type='bridge'>
+  <mac address='56:b4:44:e9:62:dc'/>
+  <source bridge='bridge1'/>
+  <model type='vmxnet3'/>
+  <address type='pci' domain='0x0000' bus='0x00' slot='0x10' function='0x0' multifunction='on'/>
+</interface>
+
+Define pvrdma device:
+<qemu:commandline>
+  <qemu:arg value='-object'/>
+  <qemu:arg value='memory-backend-ram,id=mb1,size=1G,share'/>
+  <qemu:arg value='-numa'/>
+  <qemu:arg value='node,memdev=mb1'/>
+  <qemu:arg value='-chardev'/>
+  <qemu:arg value='socket,path=/var/run/rdmacm-mux-rxe0-1,id=mads'/>
+  <qemu:arg value='-device'/>
+  <qemu:arg value='pvrdma,addr=10.1,ibdev=rxe0,netdev=bridge0,mad-chardev=mads'/>
+</qemu:commandline>
 
 
 
-- 
2.17.2
