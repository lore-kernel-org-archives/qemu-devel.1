Received: from eggs.gnu.org ([2001:4830:134:3::10]:55645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVJZD-0004Xf-2X
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVJZ8-0002lg-51
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fVJZ7-0002kl-Sw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:10 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 19 Jun 2018 11:32:28 -0500
Message-Id: <20180619163228.13790-5-venu.busireddy@oracle.com>
In-Reply-To: <20180619163228.13790-1-venu.busireddy@oracle.com>
References: <20180619163228.13790-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH virtio 1/1] Add "Group Identifier" support to
 virtio PCI capabilities.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

Add VIRTIO_PCI_CAP_GROUP_ID_CFG (Group Identifier) capability to the
virtio PCI capabilities to allow for the grouping of devices.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/content.tex b/content.tex
index 7a92cb1..7ea6267 100644
--- a/content.tex
+++ b/content.tex
@@ -599,6 +599,8 @@ The fields are interpreted as follows:
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Group Identifier */
+#define VIRTIO_PCI_CAP_GROUP_ID_CFG      6
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -997,6 +999,47 @@ address \field{cap.length} bytes within a BAR range
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{Group Identifier capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The VIRTIO_PCI_CAP_GROUP_ID_CFG capability provides means for grouping devices together.
+
+The capability is immediately followed by an identifier of arbitrary size as below:
+
+\begin{lstlisting}
+struct virtio_pci_group_id_cap {
+        struct virtio_pci_cap cap;
+        u8 group_id[]; /* Group Identifier */
+};
+\end{lstlisting}
+
+The fields \field{cap.bar}, \field{cap.length}, \field{cap.offset}
+and \field{group_id} are read-only for the driver.
+
+The specification does not impose any restrictions on the size or
+structure of group_id[]. Vendors are free to declare this array as
+large as needed, as long as the combined size of all capabilities can
+be accommodated within the PCI configuration space.
+
+If there is enough room in the PCI configuration space to accommodate
+the group identifier, the fields \field{cap.bar}, \field{cap.offset}
+and \field{cap.length} should be set to 0.
+
+If there isn't enough room, some or all of the group identifier can be
+presented in the BAR region, in which case the fields \field{cap.bar},
+\field{cap.offset} and \field{cap.length} should be set appropriately.
+
+In either case, the field \field{cap.cap_len} indicates the length of
+the group identifier information present in the configuration space
+itself.
+
+\devicenormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The device MAY present the VIRTIO_PCI_CAP_GROUP_ID_CFG capability.
+
+\drivernormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The driver MUST NOT write to group_id[] area or the BAR region.
+
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
 Transitional devices MUST present part of configuration
