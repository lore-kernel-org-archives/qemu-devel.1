Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA4C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5ED217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m0jqPAeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5ED217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKsh-00058Y-38
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKqQ-0001AQ-MQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKqO-0003uH-67
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:35:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKqO-0003Ye-0F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:35:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132845euoutp012472c241ec13ed2f5feeb1b2767281df~whKe8M6Hv2847728477euoutp019
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205132845euoutp012472c241ec13ed2f5feeb1b2767281df~whKe8M6Hv2847728477euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909325;
 bh=+wnUiFJnUH2TCdGlOKcFQFDHt2RwQPVUHtykAtH6SQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0jqPAeVf7Kcn55F5pBVL90um7tP6hxqVBy+2SN5RfC6ftZdVJVnyWCnkZX5A//OW
 tDWkVGQbPuLtum0HUzVU5wrq4Yi5s+0PQTTrhdK5m1+uJErPgLbjPM54RStNsScxEJ
 8dj+73ELRKXOAtge28fUew6GxEF6DqFcEsgaEIHE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205132844eucas1p2eb1da5db7fed2aeed686d87e147d1521~whKetLQNW0081500815eucas1p2W;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.1E.61286.C03CA3E5; Wed,  5
 Feb 2020 13:28:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205132844eucas1p1f01b4852725c4db14792dd2202cae7de~whKeUseLW0504605046eucas1p1j;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132844eusmtrp2733a29ea810b46476a981ffead4b268c~whKeUKip13037330373eusmtrp2Y;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a1-5e3ac30c1058
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.FC.07950.C03CA3E5; Wed,  5
 Feb 2020 13:28:44 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132844eusmtip2c95e7d8a9e7a27dadbb1d3cca5a0e55f~whKd593rL0172901729eusmtip2a;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 4/9] hw/misc/memexpose: Add documentation
Date: Wed,  5 Feb 2020 14:28:32 +0100
Message-Id: <1580909317-23884-5-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7o8h63iDH5/NLTYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBnfD25hLtjmWjF5SU0D41uzLkZODgkBE4nGRWsZuxi5OIQEVjBKnDhzhx0kISTw
 hVHiQhMXROIzo8Tb2ZvZuhg5wDomHtCBiC9nlOjYuokZwgFq2Ld7Blg3m4CaxM4jnxlBbBEB
 SYnfXafBipgFGhglHl0/C5YQFnCQaDn5gxXEZhFQlZi1agoTyAZegQCJJf+tIc6Tk7h5rpMZ
 xOYUCJS4/GwKK8gcCYHnbBL3911hgyhykTh9/RILhC0s8er4FnYIW0bi/875TBB2vUTLnR1M
 EM0djBJ9K6dDNVtLfNmwlAVkMbOApsT6XfoQYUeJA0/+M0N8zCdx460gSJgZyJy0bTpUmFei
 o00IolpPovvJTSaYrcsaH7FAlHhIHN+uBgmeJYwSbQ9XsU9glJ+FsGsBI+MqRvHU0uLc9NRi
 w7zUcr3ixNzi0rx0veT83E2MwGRw+t/xTzsYv15KOsQowMGoxMO7YpJlnBBrYllxZe4hRgkO
 ZiUR3vP6QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoY
 5+gc/7t/ZYWyww95hTm6d4q5uo3XBcZ8eNjkF2Tb2Lt4/v8IldfGvcvmXJD8Yasj8PRFwIui
 st2pTdLFNXOLSh+eef9sEY+D2s2Hor1l5UHrOKef/OX0yu/jnc/r9zw50uir92L1qZwWf+MQ
 uz/L2p58fP23RvmUoN+MxLbCe8YWu5QZBXwXKrEUZyQaajEXFScCAKJPTFsCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t/xe7o8h63iDLY3i1vsufCYzeLezZvM
 Fvu3/WO1mHPmAYvF8d4dLA6sHneu7WHzeHJtM5PHwXd7mDze77vK5rH95CSmANYoPZui/NKS
 VIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzvB7cwF2xzrZi8
 pKaB8a1ZFyMHh4SAicTEAzpdjFwcQgJLGSX2/ZjL0sXICRSXkfhxeg0bhC0s8edaFxtE0SdG
 iel797KCJNgE1CR2HvnMCGKLCEhK/O46zQxSxCzQwijx7Ek7E0hCWMBBouXkD7AGFgFViVmr
 pjCBbOYVCJBY8t8aYoGcxM1zncwgNqdAoMTlZ1PAyoWASl5PvMI8gZFvASPDKkaR1NLi3PTc
 YiO94sTc4tK8dL3k/NxNjMDw3Hbs55YdjF3vgg8xCnAwKvHwBkywjBNiTSwrrsw9xCjBwawk
 wnteHyjEm5JYWZValB9fVJqTWnyI0RToponMUqLJ+cDYySuJNzQ1NLewNDQ3Njc2s1AS5+0Q
 OBgjJJCeWJKanZpakFoE08fEwSnVwHiwvkT38mpz1d9SUWo/5JvnKtbpiTovm6DtcGXD9fkT
 z7k3L6kr+rLQ7HByyhb5N3ensW3Xntnrs6ckfZfPUQ//jyV7T58oL83nWb4o5HmgwtXphj0b
 drnayJe6Wy3v8YoO/fu842+tXZlMnETw2Xaf3enzjdInsAX+3byU+8j21oT90vyHziuxFGck
 GmoxFxUnAgCitj8TZQIAAA==
X-CMS-MailID: 20200205132844eucas1p1f01b4852725c4db14792dd2202cae7de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132844eucas1p1f01b4852725c4db14792dd2202cae7de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132844eucas1p1f01b4852725c4db14792dd2202cae7de
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132844eucas1p1f01b4852725c4db14792dd2202cae7de@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 MAINTAINERS                   |   5 ++
 docs/specs/memexpose-spec.txt | 168 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 docs/specs/memexpose-spec.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f0bc72..73dd571 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,11 @@ F: hw/virtio/virtio-crypto.c
 F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
+memexpose
+M: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
+S: Maintained
+F: docs/specs/memexpose-spec.txt
+
 nvme
 M: Keith Busch <keith.busch@intel.com>
 L: qemu-block@nongnu.org
diff --git a/docs/specs/memexpose-spec.txt b/docs/specs/memexpose-spec.txt
new file mode 100644
index 0000000..6266149
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
+    -chardev socket,...,path=/tmp/qemu-memexpose-mem,id="mem" \
+    -chardev socket,...,path=/tmp/qemu-memexpose-intr,id="intr" \
+    -device memexpose-pci,mem_chardev="mem",intr_chardev="intr",shm_size=0xN...
+    
+While the arm-virt machine device can be enabled like this:
+    
+    -chardev socket,...,path=/tmp/qemu-memexpose-mem,id="mem-mem" \
+    -chardev socket,...,path=/tmp/qemu-memexpose-intr,id="mem-intr" \
+    -machine memexpose-ep=mem,memexpose-size=0xN...
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


