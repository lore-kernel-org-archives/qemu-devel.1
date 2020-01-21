Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43648C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1964B22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1964B22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmwD-0002ds-4Q
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1itmtI-0007O8-1A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1itmtG-0006W1-HV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1itmtG-0006Rf-7T
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 22:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; d="scan'208";a="278302177"
Received: from hyperv-sh3.bj.intel.com ([10.240.193.95])
 by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 22:19:52 -0800
From: Jing Liu <jing2.liu@linux.intel.com>
To: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event mapping
Date: Tue, 21 Jan 2020 21:54:33 +0800
Message-Id: <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
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

Bit 1 msi_sharing reported in the MsiState register indicates the mapping mode
device uses.

Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per event and
fixed static vectors and events relationship. This fits for devices with a high interrupt
rate and best performance;
Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and events
dynamic mapping and fits for devices not requiring a high interrupt rate.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 msi-state.c |  3 ++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index dcf6c71..2fd1686 100644
--- a/content.tex
+++ b/content.tex
@@ -1770,7 +1770,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   \hline
   \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
     When VIRTIO_F_MMIO_MSI has been negotiated, reading
-    from this register returns the global MSI enable/disable status.
+    from this register returns the global MSI enable/disable status
+    and whether device uses MSI sharing mode.
     \lstinputlisting{msi-state.c}
   }
   \hline
@@ -1926,12 +1927,18 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 mask and unmask the MSI vector applying to the one selected by writing
 to \field{MsiVecSel}.
 
+VIRTIO_MMIO_MSI_CMD_MAP_CONFIG command is to set the configuration event and MSI vector
+mapping. VIRTIO_MMIO_MSI_CMD_MAP_QUEUE is to set the queue event and MSI vector
+mapping. They SHOULD only be used in MSI sharing mode.
+
 \begin{lstlisting}
 #define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
 #define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
 #define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
 #define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
 #define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
+#define  VIRTIO_MMIO_MSI_CMD_MAP_CONFIG       0x6
+#define  VIRTIO_MMIO_MSI_CMD_MAP_QUEUE        0x7
 \end{lstlisting}
 
 Setting a special NO_VECTOR value means disabling an interrupt for an event type.
@@ -1941,10 +1948,49 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 #define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
 \end{lstlisting}
 
+\subparagraph{MSI Vector and Event Mapping}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization / MSI Vector Configuration}
+The reported \field{msi_sharing} bit in the \field{MsiState} return value shows
+the MSI sharing mode that device uses.
+
+When \field{msi_sharing} bit is 0, it indicates the device uses non-sharing mode
+and vector per event fixed static relationship is used. The first vector is for device
+configuraiton change event, the second vector is for virtqueue 1, the third vector
+is for virtqueue 2 and so on.
+
+When \field{msi_sharing} bit is 1, it indicates the device uses MSI sharing mode,
+and the vector and event mapping is dynamic. Writing \field{MsiVecSel}
+followed by writing VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command
+maps interrupts triggered by the configuration change/selected queue events respectively
+to the corresponding MSI vector.
+
+\devicenormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / MSI Vector Configuration}
+
+When the device reports \field{msi_sharing} bit as 0, it SHOULD support a number of
+vectors that greater than the maximum number of virtqueues.
+Device MUST report the number of vectors supported in \field{MsiVecNum}.
+
+When the device reports \field{msi_sharing} bit as 1, it SHOULD support at least
+2 MSI vectors and MUST report in \field{MsiVecNum}. Device SHOULD support mapping any
+event type to any vector under \field{MsiVecNum}.
+
+Device MUST support unmapping any event type (NO_VECTOR).
+
+The device SHOULD restrict the reported \field{msi_sharing} and \field{MsiVecNum}
+to a value that might benefit system performance.
+
+\begin{note}
+For example, a device which does not expect to send interrupts at a high rate might
+return \field{msi_sharing} bit as 1.
+\end{note}
+
 \drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / MSI Vector Configuration}
 When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configure
 and enable MSI.
 
+To set up the event and vector mapping for MSI sharing mode, driver SHOULD
+write a valid \field{MsiVecSel} followed by VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
+command to map the configuration change/selected queue events respectively.
+
 To configure MSI vector, driver SHOULD firstly specify the MSI vector index by
 writing to \field{MsiVecSel}.
 Then notify the MSI address and data by writing to \field{MsiAddrLow}, \field{MsiAddrHigh},
diff --git a/msi-state.c b/msi-state.c
index b1fa0c1..d470be4 100644
--- a/msi-state.c
+++ b/msi-state.c
@@ -1,4 +1,5 @@
 le32 {
     msi_enabled : 1;
-    reserved : 31;
+    msi_sharing: 1;
+    reserved : 30;
 };
-- 
2.7.4


