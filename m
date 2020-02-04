Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7591EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309BE20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KgtLze26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309BE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywRR-0001BU-4h
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQD-0008Jz-C7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-00005P-Tq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQ9-0008SV-2J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113107euoutp026242c148d2784e5329fe7332e69f0c37~wL6f7u0q02964429644euoutp02k
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113107euoutp026242c148d2784e5329fe7332e69f0c37~wL6f7u0q02964429644euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815867;
 bh=8LLBPAO/LldhOK3S6vWhA9qETZneTqAWHe8OySLFLVo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KgtLze268SxE9N6lABtn5q/6HvCTZyK+zptlcq9HzaXS63zLQtdnf/Rfvby8PVLiE
 ngzypLYdyWOvfqFv9D0c672R4/J7tVLi5PPDTpH1AfzhtGtrHJmwLNN9YurLPxKEKi
 dkbTgVPk8kOOQp0pb7koR2IR5ZbI5tABda6w7mfw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204113107eucas1p1fd78c006df0101467b7fbd2641ef9d6c~wL6fqWhsz0453204532eucas1p16;
 Tue,  4 Feb 2020 11:31:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 81.10.60698.BF5593E5; Tue,  4
 Feb 2020 11:31:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113107eucas1p2769c0c8204a57751a4e6c5d4fb40e2d5~wL6fYmjsl0640206402eucas1p27;
 Tue,  4 Feb 2020 11:31:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113107eusmtrp162f6086b3ef6083eafaf341f3445b89f~wL6fYCDW82134721347eusmtrp1O;
 Tue,  4 Feb 2020 11:31:07 +0000 (GMT)
X-AuditID: cbfec7f5-e577d9c00001ed1a-5d-5e3955fb7dbb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.0A.07950.BF5593E5; Tue,  4
 Feb 2020 11:31:07 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113106eusmtip24bd2d45e97ffffd6462b24e717764223~wL6fFHl4K1661216612eusmtip2U;
 Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 4/9] hw/misc/memexpose: Add documentation
Date: Tue,  4 Feb 2020 12:30:46 +0100
Message-Id: <1580815851-28887-5-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djP87q/Qy3jDPa8ELfYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlnJk2
 j7HggWNFz5OVjA2MT427GDk5JARMJF6vWsoGYgsJrGCUuDNfqouRC8j+wijx5exeNgjnM6NE
 y7KZLDAd78//gupYzijx71g+XEdD3y5mkASbgJrEziOfGUFsEQFJid9dp8HizAIZEs9ndYPZ
 wgLmEudb7oDZLAKqEtPWnAGzeQUCJHbOesAKsUxO4ua5TrA4p0CgxPs9k5hAlkkInGGTuLLl
 KyNEkYtE772dzBC2sMSr41vYIWwZidOTe6CurpdoubMDqrmDUaJv5XQ2iIS1xJcNS4GKOICu
 05RYv0sfIuwo0dl8BSwsIcAnceOtIMT9fBKTtk1nhgjzSnS0CUFU60l0P7nJBLN1WeMjqK0e
 Eg/bZjJBwmcJo8TEt8dZJzDKz0JYtoCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg
 9J/+d/zrDsZ9f5IOMQpwMCrx8Go4WsQJsSaWFVfmHmKU4GBWEuE9r28ZJ8SbklhZlVqUH19U
 mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAMja02s89xffvMvbz0SpGD5Zq/M
 YtXrBhc+yn5hrxHTC173scVCKMraS+tup5flJ81r75ttXi7QmLPRbdWpu2GbJvvO5TunHvNB
 dlbHsaSK4KNvmPa25qjOKvi6dt2EXarTNA8f4jVmM13L+CpIauHzio7SrXm2kwIMbB0jAjvX
 6JfE5lyamBmmxFKckWioxVxUnAgAvMAoEvoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7q/Qy3jDI7fZLPYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlnJk2j7HggWNFz5OVjA2MT427GDk5
 JARMJN6f/8XWxcjFISSwlFFi8+UDbBAJGYkfp9dA2cISf651QRV9YpQ4Na8JLMEmoCax88hn
 RhBbREBS4nfXaWYQm1kgS2Ln7PtMILawgLnE+ZY7YHEWAVWJaWvOgNm8AgESO2c9YIVYICdx
 81wnWJxTIFDi/Z5JYL1CQDUXds1in8DIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg
 OG479nPLDsaud8GHGAU4GJV4eDUcLeKEWBPLiitzDzFKcDArifCe17eME+JNSaysSi3Kjy8q
 zUktPsRoCnTURGYp0eR8YKzklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLp
 Y+LglGpgTPO+sm6p4grDvOfHT0zZHLpQe5/eLNbymz8eHOR9cmXSjv3FevqlGtMbk9mmSzJH
 CjXPjxQP7r5eVXvH2Xuug3NyyRJ2BVmVTWL7Y61/bJK2kZFf1fP88a+ISPMD1uXsAjN13vp9
 t+Cel7Pu0a9bbOXTrNdnbaq7plq/TEbxjNFS84+lyxpZlViKMxINtZiLihMBHpq8bl0CAAA=
X-CMS-MailID: 20200204113107eucas1p2769c0c8204a57751a4e6c5d4fb40e2d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113107eucas1p2769c0c8204a57751a4e6c5d4fb40e2d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113107eucas1p2769c0c8204a57751a4e6c5d4fb40e2d5
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113107eucas1p2769c0c8204a57751a4e6c5d4fb40e2d5@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 docs/specs/memexpose-spec.txt | 168 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 docs/specs/memexpose-spec.txt

diff --git a/docs/specs/memexpose-spec.txt b/docs/specs/memexpose-spec.txt
new file mode 100644
index 0000000..60ccea6
--- /dev/null
+++ b/docs/specs/memexpose-spec.txt
@@ -0,0 +1,168 @@
+= Specification for Inter-VM memory region sharing device =
+
+The inter-VM memory region sharing device (memexpose) is designed to allow two
+QEMU devices to share arbitrary physical memory regions between one another, as
+well as pass simple interrupts. It attempts to share memory regions directly
+when feasible, falling back to MMIO via socket communication when it's not.
+
+The device is modeled by QEMU as a PCI device, as well as a memory
+region/interrupt directly usable on platforms like ARM, with an entry in the
+device tree.
+
+An example use case for memexpose is forwarding ARM Trustzone functionality
+between two VMs running different architectures - one running a rich OS on an
+x86_64 VM, the other running the trusted OS on an ARM VM. In this scenario,
+sharing arbitrary memory regions allows such forwarding to work with minimal
+changes to the trusted OS.
+
+
+== Configuring the memexpose device ==
+
+The device uses two character devices to communicate with the other VM - one for
+synchronous memory accesses, another for passing interrupts. A typical
+configuration of the PCI device looks like this:
+
+        -chardev socket,...,path=/tmp/qemu-memexpose-mem,id="mem" \
+        -chardev socket,...,path=/tmp/qemu-memexpose-intr,id="intr" \
+        -device memexpose-pci,mem_chardev="mem",intr_chardev="intr",shm_size=0xN...
+
+While the arm-virt machine device can be enabled like this:
+ 
+        -chardev socket,...,path=/tmp/qemu-memexpose-mem,id="mem-mem" \
+        -chardev socket,...,path=/tmp/qemu-memexpose-intr,id="mem-intr" \
+        -machine memexpose-ep=mem,memexpose-size=0xN...
+
+Normally one of the VMs would have 'server,nowait' options set on these
+chardevs.
+
+At the moment the memory exposed to the other device always starts at 0
+(relative to system_memory). The shm_size/memexpose-size property indicates the
+size of the exposed region.
+
+The *_chardev/memexpose-ep properties are used to point the memexpose device to
+chardevs used to communicate with the other VM.
+
+
+== Memexpose PCI device interface ===
+
+The device has vendor ID 1af4, device ID 1111, revision 0.
+
+=== PCI BARs ===
+
+The device has two BARs:
+- BAR0 holds device registers and interrupt data (0x1000 byte MMIO),
+- BAR1 maps memory from the other VM.
+
+To use the device, you must first enable it by writing 1 to BAR0 at address 0.
+This makes QEMU wait for another VM to connect. Once that is done, you can
+access the other machine's memory via BAR1.
+
+Interrupts can be sent and received by configuring the device for interrupts and
+reading and writing to registers in BAR0.
+
+=== Device registers ===
+
+BAR 0 has following registers:
+
+    Offset  Size  Access      On reset  Function
+        0     8   read/write        0   Enable/disable device
+                                        bit 0: device enabled / disabled
+                                        bit 1..63: reserved
+    0x400     8   read/write        0   Interrupt RX address
+                                        bit 1: interrupt read
+                                        bit 1..63: reserved
+    0x408     8   read-only        UD   RX Interrupt type
+    0x410   128   read-only        UD   RX Interrupt data
+    0x800     8   read/write        0   Interrupt TX address
+    0x808     8   write-only      N/A   TX Interrupt type
+    0x810   128   write-only      N/A   TX Interrupt data
+
+All other addresses are reserved.
+
+=== Handling interrupts ===
+
+To send interrupts, write to TX interrupt address. Contents of TX interrupt type
+and data regions will be send along with the interrupt. The device is holding an
+internal queue of 16 interrupts, any extra interrupts are silently dropped.
+
+To receive interrupts, read the interrupt RX address. If the value is 1, then
+RX interrupt type and data registers contain the data / type sent by the other
+VM. Otherwise (the value is 0), no more interrupts are queued and RX interrupt
+type/data register contents are undefined.
+
+
+=== Platform device protocol ===
+
+The other memexpose device type (provided on e.g. ARM via device tree) is
+essentially identical to the PCI device. It provides two memory ranges that work
+exactly like the PCI BAR regions and an interrupt for signaling an interrupt
+from the other VM.
+
+== Memexpose peer protocol ==
+
+This section describes the current memexpose protocol. It is a WIP and likely to
+change.
+
+A connection between two VMs connected via memexpose happens on two sockets - an
+interrupt socket and a memory socket. All communication on the earlier is
+asynchronous, while communication on the latter is synchronous.
+
+When the device is enabled, QEMU waits for memexpose's chardevs to connect. No
+messages are exchanged upon connection. After devices are connected, the
+following messages can be exchanged:
+
+1. Interrupt message, via interrupt socket. This message contains interrupt type
+   and data.
+
+2. Memory access request message, via memory socket. It contains a target
+   address, access size and valueto write in case of writes.
+
+3. Memory access return message. This contains an access result (as
+   MemTxResult) and a value in case of reads. If the accessed region can be
+   shared directly, then this region's start, size and shmem file descriptor are
+   also sent.
+
+4. Memory invalidation message. This is sent when a VM's memory region changes
+   status and contains such region's start and size. The other VM is expected to
+   drop any shared regions overlapping with it.
+
+5. Memory invalidation response. This is sent in response to a memory
+   invalidation message; after receiving this the remote VM is guaranteed have
+   scheduled region invalidation before accessing the region again.
+
+As QEMU performes memory accesses synchronously, we want to perform memory
+invalidation before returning to guest OS and both VMs might try to perform a
+remote memory access at the same time, all messages passed via the memory socket
+have an associated priority.
+
+At any time, only one message with a given priority is in flight. After sending
+a message, the VM reads messages on the memory socket, servicing all messages
+with a priority higher than its own. Once it receives a message with a priority
+lower than its own, it waits for a response to its own message before servicing
+it. This guarantees no deadlocks, assuming that messages don't trigger further
+messages. Message priorities, from highest to lowest, are as follows:
+
+1. Memory invalidation message/response.
+2. Memory access message/response.
+
+Additionally, one of the VMs is assigned a sub-priority higher than another, so
+that its messages of the same type have priority over the other VM's messages.
+
+Memory access messages have the lowest priority in order to guarantee that QEMU
+will not attempt to access memory while in the middle of a memory region
+listener.
+
+=== Memexpose memory sharing ===
+
+This section describes the memexpose memory sharing mechanism.
+
+Memory sharing is implemented lazily, initially no memory regions are shared
+between devices. When a memory access is performed via a socket, the remote VM
+checks whether the underlying memory range is backed by shareable memory. If it
+is, the VM finds out the maximum contiguous flat range backed by this region and
+sends its file descriptor to the local VM, where it is mapped as a subregion.
+
+The memexpose device registers memory listeners for the memory region it's
+using. Whenever a flat range for this region (that is not this device's
+subregion) changes, that range is sent to the other VM and any directly shared
+memory region intersecting this range is scheduled for removal via a BH.
-- 
2.7.4


