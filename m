Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePtQa-0008Lg-4z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePtQW-0000Qa-IY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePtQW-0000Ol-Aa
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 15 Dec 2017 17:05:19 +0000
Message-Id: <20171215170519.31392-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC virtio-dev] vhost-user-slave: add vhost-user
 slave device type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

The vhost-user slave device facilitates vhost-user device emulation
through vhost-user protocol exchanges and access to shared memory.
Software-defined networking, storage, and other I/O appliances can
provide services through this device.

This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
device differs from vhost-pci because it is a single virtio device type
that exposes the vhost-user protocol instead of a family of new virtio
device types, one for each vhost-user device type.

This device supports vhost-user slave and vhost-user master
reconnection.  It also contains a UUID so that vhost-user slave programs
can identify a specific device among many without using bus addresses.

It is somewhat unconventional for a virtio device because it makes use
of additional resources called doorbells, notifications, and shared
memory.  A mapping of these resources to the virtio PCI transport is
provided.  Other transports, such as CCW may not be able to support
this device.

Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex      | 292 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 introduction.tex |   1 +
 2 files changed, 293 insertions(+)

diff --git a/content.tex b/content.tex
index c840588..96778bc 100644
--- a/content.tex
+++ b/content.tex
@@ -3022,6 +3022,8 @@ Device ID  &  Virtio Device    \\
 \hline
 22         &   pstore device \\
 \hline
+24         &   vhost-user slave device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
@@ -5819,6 +5821,296 @@ descriptor for the \field{sense_len}, \field{residual},
 \field{status_qualifier}, \field{status}, \field{response} and
 \field{sense} fields.
 
+\section{Vhost-user Slave Device}\label{sec:Device Types / Vhost-user Slave Device}
+
+The vhost-user slave device facilitates vhost-user device emulation through
+vhost-user protocol exchanges and access to shared memory.  Software-defined
+networking, storage, and other I/O appliances can provide services through this
+device.
+
+This section relies on definitions from the \hyperref[intro:Vhost-user
+Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol is a
+prerequisite for understanding this device.
+
+The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was originally
+designed for processes on a single system communicating over UNIX domain
+sockets.  The vhost-user slave device allows the vhost-user slave to
+communicate with the vhost-user master over the device instead of a UNIX domain
+socket.  This allows the slave and master to run on two separate systems such
+as a virtual machine and a hypervisor.
+
+The vhost-user slave program exchanges vhost-user protocol messages with the
+vhost-user master through this device.  How the device implementation
+communicates with the vhost-user master is beyond the scope of this
+specification.  One possible device implementation uses a UNIX domain socket to
+relay messages to a vhost-user master process.
+
+Existing vhost-user slave programs that communicate over UNIX domain sockets
+can support the vhost-user slave device interface without invasive changes
+because the same vhost-user wire protocol is used.
+
+\subsection{Device ID}\label{sec:Device Types / Vhost-user Slave Device / Device ID}
+  24
+
+\subsection{Virtqueues}\label{sec:Device Types / Vhost-user Slave Device / Virtqueues}
+
+\begin{description}
+\item[0] m2srxq (requests from vhost-user master)
+\item[1] m2stxq (responses to vhost-user master)
+\item[2] s2mrxq (responses from vhost-user master)
+\item[3] s2mtxq (requests to vhost-user master)
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Vhost-user Slave Device / Feature bits}
+
+No feature bits are defined at this time.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Slave Device / Device configuration layout}
+
+  All fields of this configuration are always available.
+
+\begin{lstlisting}
+struct virtio_vhostslave_config {
+        le32 status;
+#define VIRTIO_VHOSTSLAVE_STATUS_SLAVE_UP 0
+#define VIRTIO_VHOSTSLAVE_STATUS_MASTER_UP 1
+        le32 max_vhost_queues;
+        u8 uuid[16];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{status}] contains the vhost-user operational status.  The default
+    value of this field is 0.
+
+    The driver sets VIRTIO_VHOSTSLAVE_STATUS_SLAVE_UP to indicate readiness for
+    the vhost-user master to connect.  The vhost-user master cannot connect
+    unless the driver has set this bit first.
+
+    When the driver clears VIRTIO_VHOSTSLAVE_SLAVE_UP while the vhost-user
+    master is connected, the vhost-user master is disconnected.
+
+    When the vhost-user master disconnects, both
+    VIRTIO_VHOSTSLAVE_STATUS_SLAVE_UP and VIRTIO_VHOSTSLAVE_STATUS_MASTER_UP
+    are cleared by the device.  Communication can be restarted by the driver
+    setting VIRTIO_VHOSTSLAVE_STATUS_SLAVE_UP again.
+
+    A configuration change notification is sent when the device changes
+    this field idendependently of a driver write.
+
+\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
+    supported by this device.  This field is always greater than 0.
+
+\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
+    device.  If the device has no UUID then this field contains the nil
+    UUID (all zeroes).  The UUID allows vhost-user slave programs to identify a
+    specific vhost-user slave device among many without relying on bus
+    addresses.
+\end{description}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Vhost-user Slave Device / Device configuration layout}
+
+The driver MUST NOT write to device configuration fields other than
+\field{status}.
+
+The driver MUST NOT set undefined bits in the \field{status} configuration field.
+
+\devicenormative{\subsection}{Device Initialization}{Device Types / Vhost-user Slave Device / Device Initialization}
+
+The driver SHOULD check the \field{max_vhost_queues} configuration field to
+determine how many queues the vhost-user slave will be able to support.
+
+The driver SHOULD fetch the \field{uuid} configuration field to allow
+vhost-user slave programs to identify a specific device among many.
+
+The driver SHOULD initialize the s2mrxq and s2mtxq virtqueues.  These
+virtqueues used if the VHOST_USER_PROTOCOL_F_SLAVE_REQ vhost-user protocol
+feature is negotiated.
+
+The driver SHOULD place at least one buffer in m2srxq before setting the
+VIRTIO_VHOSTSLAVE_SLAVE_UP bit in the \field{status} configuration field.
+
+The driver MUST handle m2srxq virtqueue notifications that occur before the
+configuration change notification.  It is possible that a vhost-user protocol
+message from the vhost-user master arrives before the driver has seen the
+configuration change notification for the VIRTIO_VHOSTSLAVE_STATUS_MASTER_UP
+\field{status} change.
+
+\subsection{Device Operation}\label{sec:Device Types / Vhost-user Slave Device / Device Operation}
+
+Device operation consists of operating request queues and response queues.
+
+\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-user Slave Device / Device Operation / Device Operation: Request Queues}
+
+The driver receives vhost-user protocol messages from the vhost-user master on
+m2srxq.  The driver sends responses to the vhost-user master on m2stxq.
+
+The driver sends slave-initiated requests on s2mtxq.  The driver receives
+responses from the vhost-user master on s2mrxq.
+
+All virtqueues offer in-order guaranteed delivery semantics for vhost-user
+protocol messages.
+
+Each buffer is a vhost-user protocol message as defined by the
+\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.  File descriptor
+passing is handled differently by the vhost-user slave device.  When a message
+is received that carries one or more file descriptors according to the
+vhost-user protocol, additional device resources become available to the
+driver.
+
+\subsection{Additional Device Resources over PCI}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI}
+
+The vhost-user slave device contains additional device resources beyond
+configuration space and virtqueues.  The nature of these resources is
+transport-specific and therefore only virtio transports that provide these
+resources support the vhost-user slave device.
+
+The following additional resources exist:
+\begin{description}
+  \item[Doorbells] The driver signals the vhost-user master through doorbells.  The signal does not carry any data, it is purely an event.
+  \item[Notifications] The vhost-user master signals the driver for events besides virtqueue activity and configuration changes by sending notifications.
+  \item[Shared memory] The vhost-user master gives access to memory that can be mapped by the driver.
+\end{description}
+
+\subsubsection{Doorbell Numbering}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Doorbell Numbering}
+
+Doorbells are laid out as follows:
+
+\begin{description}
+\item[0] Vring call for vhost-user queue 0
+\item[\ldots]
+\item[N] Vring err for vhost-user queue 0
+\item[\ldots]
+\item[2N] Log
+\end{description}
+
+\subsubsection{Notifications}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Notifications}
+
+Notifications are laid out as follows:
+
+\begin{description}
+\item[0] Vring kick for vhost-user queue 0
+\item[\ldots]
+\item[N-1] Vring kick for vhost-user queue N-1
+\end{description}
+
+\subsubsection{Shared Memory Layout}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Shared Memory Layout}
+
+Shared memory is laid out as follows:
+
+\begin{description}
+\item[0] Vhost memory region 0
+\item[SIZE0] Vhost memory region 1
+\item[\ldots]
+\item[SIZE0 + SIZE1 + \ldots] Log
+\end{description}
+
+The size of vhost memory region 0 is \field{SIZE0}, the size of vhost memory
+region 1 is \field{SIZE1}, and so on.
+
+\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Availability of Additional Resources}
+
+The following vhost-user protocol messages convey access to additional device
+resources:
+
+\begin{description}
+\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost memory regions are available to the driver in shared memory.  Region contents are laid out in the same order as the vhost memory region list.
+\item[VHOST_USER_SET_LOG_BASE] Contents of the log are available to the driver in shared memory.
+\item[VHOST_USER_SET_LOG_FD] The log doorbell is available to the driver.  Writes to the log doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is available to the driver.  The first notification may occur before the driver has processed this message.
+\item[VHOST_USER_SET_VRING_CALL] The vring call doorbell for this queue is available to the driver.  Writes to the vring call doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_VRING_ERR] The vring err doorbell for this queue is available to the driver.  Writes to the vring err doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol slave messages on s2mtxq.  Buffers put onto s2mtxq before this message is received are discarded by the device.
+\end{description}
+
+Additional resources are configured on the virtio PCI transport by the following \field{struct virtio_pci_cap.cfg_type} values:
+
+\begin{lstlisting}
+#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
+#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+\end{lstlisting}
+
+\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Doorbell capability}
+
+The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
+capability.  This capability is immediately followed by an additional
+field, like so:
+
+\begin{lstlisting}
+struct virtio_pci_doorbell_cap {
+        struct virtio_pci_cap cap;
+        le32 doorbell_off_multiplier;
+};
+\end{lstlisting}
+
+The doorbell address within a BAR is calculated as follows:
+
+\begin{lstlisting}
+        cap.offset + doorbell_idx * doorbell_off_multiplier
+\end{lstlisting}
+
+The \field{cap.offset} and \field{doorbell_off_multiplier} are taken from the
+notification capability structure above, and the \field{doorbell_idx} is the
+doorbell number.
+
+\devicenormative{\paragraph}{Doorbell capability}{Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Doorbell capability}
+The device MUST present at least one doorbell capability.
+
+The \field{cap.offset} MUST be 2-byte aligned.  
+
+The device MUST either present \field{doorbell_off_multiplier} as an even power of 2,
+or present \field{doorbell_off_multiplier} as 0.
+
+The value \field{cap.length} presented by the device MUST be at least 2
+and MUST be large enough to support doorbell offsets for all supported
+doorbells in all possible configurations.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+\begin{lstlisting}
+cap.length >= num_doorbells * doorbell_off_multiplier + 2
+\end{lstlisting}
+
+The number of doorbells is \field{num_doorbells} and is dependent on the
+device.
+
+\subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Notification capability}
+
+The notification structure allows MSI-X vectors to be configured for
+notification interrupts.  If MSI-X is not available, bit 2 of the ISR status
+indicates that a notification occurred.
+
+The notification structure is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
+capability.
+
+\begin{lstlisting}
+struct virtio_pci_notification_cfg {
+        le16 notification_select;              /* read-write */
+        le16 notification_msix_vector;         /* read-write */
+};
+\end{lstlisting}
+
+The driver indicates which notification is of interest by writing the
+\field{notification_select} field.  The driver then writes the MSI-X vector or
+\field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to change the
+MSI-X vector for that notification.
+
+\subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Shared Memory capability}
+
+The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
+capability.
+
+\devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vhost-user Slave Device / Additional Device Resources over PCI / Shared Memory capability}
+The device MUST present exactly one shared memory capability.
+
+The device MUST locate shared memory in a Memory Space BAR.
+
+The device SHOULD locate shared memory in a Prefetchable BAR.
+
+The \field{cap.offset} MUST be 4096-byte aligned.
+
+The value \field{cap.length} presented by the device MUST be non-zero and 4096-byte aligned.
+
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
 Currently these device-independent feature bits defined:
diff --git a/introduction.tex b/introduction.tex
index 979881e..0bf400d 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -60,6 +60,7 @@ Levels'', BCP 14, RFC 2119, March 1997. \newline\url{http://www.ietf.org/rfc/rfc
 	\phantomsection\label{intro:SCSI MMC}\textbf{[SCSI MMC]} &
         SCSI Multimedia Commands,
         \newline\url{http://www.t10.org/cgi-bin/ac.pl?t=f&f=mmc6r00.pdf}\\
+	\phantomsection\label{intro:Vhost-user Protocol}\textbf{[Vhost-user Protocol]} & Vhost-user Protocol, \newline\url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/interop/vhost-user.txt;hb=HEAD}, and any future revisions\\
 
 \end{longtable}
 
-- 
2.14.3
