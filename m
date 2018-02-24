Received: from eggs.gnu.org ([2001:4830:134:3::10]:47158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1epbZd-0003z8-TV
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1epbZa-0002kq-PK
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:17:17 -0500
Received: from [195.159.176.226] (port=52560 helo=blaine.gmane.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gceq-qemu-devel2@m.gmane.org>)
	id 1epbZa-0002jj-IZ
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:17:14 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1epbXV-0003VB-F3
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:15:05 +0100
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sat, 24 Feb 2018 18:07:15 +0300
Message-ID: <p6ruv5$hfn$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] VM memory caching model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Sorry in advance, if wrong maillist.

Where may I find comprehensive description how virtualization CPU
extensions (like VMX) interact with CPU data caches as well as
corresponding qemu implementation details? I've looked through
memory_ldst.inc.c with little success.

I am trying to debug virtio_blk issues found on Xeon X5675. I run nested
guest under qemu-kvm from ESXi 5.5 hosted guest, this is quite odd setup
but still. Currently (master qemu, host and guest - 4.15 kernel), virtio
is broken in this setup due to some kind of memory synchronization
issues. Let me please recall, that main virtio communication abstraction
is a queue. The queue is consisted from three parts: descriptor table,
avail ring, used ring. This structures are supposed to be shared memory
between the guest and the hypervisor. All of them are structures
allocated by the guest device driver, pointers in guest physical address
space are transferred to the hypervisor through PCI MMIO configuration
BAR. This is so-called modern PCI virtio.

When the guest wants to notify the hypervisor for update, the guest
device driver writes to PCI BAR. At the hypervisor side, notification is
implemented through eventfd and KVM_IOEVENTFD ioctl. It works as
expected, since I see that qemu receives a lot of notification for the
queue. However, qemu sees no updates in avail ring where guest driver
increments so called "avail index" at each transfer. At the hypervisor
side avail ring index is always 1, so as virtio_queue_empty_rcu() always
says that incoming queue is empty one.
