Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8CC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF13C2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NIDeHcR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF13C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH9s-0000g1-Rb
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3g-0000iX-Ov
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004xk-7B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004aJ-U9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315euoutp02cecf5403a8e64ae29d5f59b97db4a8aa~wd839G0ej1409714097euoutp02-
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205093315euoutp02cecf5403a8e64ae29d5f59b97db4a8aa~wd839G0ej1409714097euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895195;
 bh=+wnUiFJnUH2TCdGlOKcFQFDHt2RwQPVUHtykAtH6SQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NIDeHcR77KzVh7MgpL0IkLtxXygWKV12zh3UMQJHMuEFGc/1LtEOrS1eBm+ccP9e/
 oz8YBa1xz80ftmo8e3LFQFTFFgVfOJOjiGZ2ldwYsy5LUqVlFeR+e8U1iLR2j+9Hs3
 at09EqHBu5MD8jUt2QjtlWsF88Zy15/J4GQLo6KI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eucas1p2fd736ab9bf748bb0ca772adae2e96c34~wd83x0GYf1343613436eucas1p21;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.8A.60698.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eucas1p2e1ae9525ecdee6b9f2462f71a20b0fa4~wd83fJsUT1336113361eucas1p2H;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eusmtrp194afe1bce4705a7b0eca2295005cd5bd~wd83erjsi1029010290eusmtrp1X;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c0-5e3a8bdb8d6e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.8D.08375.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093314eusmtip22b0f35e96b2eb2c657488a4dde39dc8e~wd83Lb3QK0075000750eusmtip2L;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 4/9] hw/misc/memexpose: Add documentation
Date: Wed,  5 Feb 2020 10:33:00 +0100
Message-Id: <1580895185-24341-5-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djP87q3u63iDF4flrfYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlfD+4
 hblgm2vF5CU1DYxvzboYOTgkBEwkVjSEdzFycQgJrGCUaO9fwAjhfGGUuNZ4kwXC+cwocbd5
 A3sXIydYx46Gi0wQieWMEg/b7yG0XOjdxwxSxSagJrHzyGdGEFtEQFLid9dpsDizQIbE81nd
 YLawgIPE1M1nmUHuYBFQlbh0hxskzCsQIHG4+zDUMjmJm+c6wco5BQIlNn36yAayS0LgMpvE
 +hMLoIpcJGZ3PWSDsIUlXh3fAhWXkTg9uYcFwq6XaLmzgwmiuYNRom/ldKgGa4kvG5aygBzB
 LKApsX6XPkTYUWLO9q1MkDDik7jxVhDifD6JSdumM0OEeSU62oQgqvUkup/cZILZuqzxEdRW
 D4n3b7qYIcGzhFFi1/6F7BMY5WchLFvAyLiKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMj
 MPZP/zv+dQfjvj9JhxgFOBiVeHgDJljGCbEmlhVX5h5ilOBgVhLhPa8PFOJNSaysSi3Kjy8q
 zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoFx+p9Hp+Ssf3jvnNz333qFdvMd
 X56jy3SE/B6WVoW4snktkaw939W2LnbHCft3usL+nTMPTqn9c1jfT/fDkTtu3THRbfcvL6rO
 rZW/efBQhLuKw9+/hkfYD6/f9vOee+ajiYl9dcLuJkJbHY+USuX/0E1qNHh7n5vTkrXf+g6r
 TlFu4Iv0lY+UWIozEg21mIuKEwGxdeDn+QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xe7q3u63iDCav57XYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlfD+4hblgm2vF5CU1DYxvzboYOTkk
 BEwkdjRcZOpi5OIQEljKKDG3A8QBSchI/Di9hg3CFpb4c62LDaLoE6NEy9F5jCAJNgE1iZ1H
 PoPZIgKSEr+7TjOD2MwCWRI7Z98HGyQs4CAxdfNZoDgHB4uAqsSlO9wgYV6BAInD3YfZIebL
 Sdw81wnWyikQKLHp00ewvUJANde+fmWdwMi3gJFhFaNIamlxbnpusaFecWJucWleul5yfu4m
 RmAobjv2c/MOxksbgw8xCnAwKvHwrphkGSfEmlhWXJl7iFGCg1lJhPe8PlCINyWxsiq1KD++
 qDQntfgQoynQTROZpUST84FxklcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUI
 po+Jg1OqgdHC+NnBK7+Ob4x/dbxH0XujK3+am1SWdEfhy8v6pdd99+2+3qTKdvPu2519b7RD
 FuuI1Bqxvfj5ddp5uVCpzYKbZzxJSJ905eeqrjdCTQ+uT9w1cfepvarKMWy5czpD2G/uNt0e
 d67wpPSqwPnTW/bL/pl2IVwh3e/kxqSp3NuFviVxK+qaP+tWYinOSDTUYi4qTgQAhObok1sC
 AAA=
X-CMS-MailID: 20200205093315eucas1p2e1ae9525ecdee6b9f2462f71a20b0fa4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093315eucas1p2e1ae9525ecdee6b9f2462f71a20b0fa4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093315eucas1p2e1ae9525ecdee6b9f2462f71a20b0fa4
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093315eucas1p2e1ae9525ecdee6b9f2462f71a20b0fa4@eucas1p2.samsung.com>
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


