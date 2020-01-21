Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB5C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EDB22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EDB22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmw3-0002RS-Fw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1itmtD-0007HG-QK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1itmtC-0006T1-3R
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1itmtB-0006Rf-Ro
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 22:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; d="scan'208";a="278301959"
Received: from hyperv-sh3.bj.intel.com ([10.240.193.95])
 by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 22:19:47 -0800
From: Jing Liu <jing2.liu@linux.intel.com>
To: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] [PATCH v2 2/5] virtio-mmio: Enhance queue notification
 support
Date: Tue, 21 Jan 2020 21:54:30 +0800
Message-Id: <1579614873-21907-3-git-send-email-jing2.liu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zha Bin <zhabin@linux.alibaba.com>, kvm@vger.kernel.org,
 Jing Liu <jing2.liu@linux.intel.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With VIRTIO_F_MMIO_NOTIFICATION feature bit offered, the notification
mechanism is enhanced. Driver reads QueueNotify register to get
notification structure and calculate notification addresses of
each virtqueue.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/content.tex b/content.tex
index 826bc7d..5881253 100644
--- a/content.tex
+++ b/content.tex
@@ -1671,20 +1671,18 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
   \hline 
-  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
-    Writing a value to this register notifies the device that
-    there are new buffers to process in a queue.
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    When VIRTIO_F_MMIO_NOTIFICATION has not been negotiated, writing to this
+    register notifies the device that there are new buffers to process in a queue.
 
-    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, reading this register
+    returns the virtqueue notification structure for calculating notification location.
 
-    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-    the \field{Notification data} value has the following format:
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notification Structure Layout}
+    for the notification structure format.
 
-    \lstinputlisting{notifications-le.c}
-
-    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
-    for the definition of the components.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
+    for the notification data format.
   }
   \hline 
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
@@ -1858,6 +1856,31 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initialization}~\nameref{sec:General Initialization And Device Operation / Device Initialization}.
 
+\subsubsection{Notification Structure Layout}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notification Structure Layout}
+
+When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, the notification location is calculated
+by notification structure. Driver reads \field{QueueNotify} to get this structure formatted
+as follows.
+
+\begin{lstlisting}
+le32 {
+        notify_base : 16;
+        notify_multiplier : 16;
+};
+\end{lstlisting}
+
+\field{notify_multiplier} is combined with virtqueue index to derive the Queue Notify address
+within a memory mapped control registers for a virtqueue:
+
+\begin{lstlisting}
+        notify_base + queue_index * notify_multiplier
+\end{lstlisting}
+
+\begin{note}
+For example, if notify_multiplier is 0, the device uses the same Queue Notify address for all
+queues.
+\end{note}
+
 \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Virtqueue Configuration}
 
 The driver will typically initialize the virtual queue in the following way:
@@ -1893,16 +1916,20 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
 the 16-bit virtqueue index
-of the queue to be notified to \field{QueueNotify}.
+of the queue to be notified to Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
-the following 32-bit value to \field{QueueNotify}:
+the following 32-bit value to Queue Notify address:
 \lstinputlisting{notifications-le.c}
 
 See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
 for the definition of the components.
 
+For device not offering VIRTIO_F_MMIO_NOTIFICATION, the Queue Notify address is \field{QueueNotify}.
+For device offering VIRTIO_F_MMIO_NOTIFICATION, see \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notification Structure Layout}
+for how to calculate the Queue Notify address.
+
 \subsubsection{Notifications From The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
 
 The memory mapped virtio device is using a single, dedicated
-- 
2.7.4


