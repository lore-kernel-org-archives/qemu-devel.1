Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1biN-0007cx-UN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1biH-0000eh-Tl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:19:39 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:59035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e1biH-0000bh-Ms
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:19:33 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B386DD530D
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 19:19:25 +0200 (CEST)
Date: Mon, 9 Oct 2017 19:19:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171009191915.6bd2bc69@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] i386/kvm: QEMU crash when doing 'info cpus' after CPU
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi x86 folks,

While trying to reproduce on x86 an issue we're currently hitting on ppc,
I got this:

$ ./x86_64-softmmu/qemu-system-x86_64 -snapshot -no-shutdown -nographic -machine q35,accel=kvm -smp 1,maxcpus=2 -serial mon:stdio -drive file=$HOME/images/fedora26-x86_64.qcow2,if=virtio
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) device_add host-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=foo
(qemu) info cpus
error: failed to get MSR 0x38d
qemu-system-x86_64: /home/greg/Work/qemu/qemu-devel/target/i386/kvm.c:2121: kvm_get_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
Aborted (core dumped)

Same happens with a pc machine.

But it doesn't happen if I use cpu-add instead of device_add:

(qemu) cpu-add 1
(qemu) [    8.335221] CPU1 has been hot-added
(qemu) info cpus
* CPU #0: pc=0xffffffffb08986e6 (halted) thread_id=23964
  CPU #1: pc=0x00000000fffffff0 thread_id=24001

This is with the QEMU master branch SHA1 530049bc1dcc24c.

Cheers,

--
Greg
