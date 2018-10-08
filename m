Received: from eggs.gnu.org ([2001:4830:134:3::10]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1g9dqE-0005Fa-QD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1g9dq9-0006qu-RC
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1g9dq9-0006qg-Ky
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:17:25 -0400
Date: Mon, 8 Oct 2018 15:17:20 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1810081505210.28877@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] possible BUG, ATS12NSOPW fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org

Hi Peter,

I am chasing an address translation error, and it looks like it might be
a QEMU bug, because I cannot reproduce the problem on a physical board.

The issue is that a requested ATS12NSOPW translation in Xen is reported
as failing by QEMU, but actually the address is correct. The workflow is
as follows:

1) Linux as Dom0 registers a memory area with Xen at boot, see:
drivers/xen/time.c:xen_setup_runstate_info in Linux

2) Xen tries to update such region with new data every so often, see:
xen/arch/arm/domain.c:update_runstate_area

As you can see from the code, Xen uses __raw_copy_to_guest and
__copy_to_guest to copy the new values to the guest. Both of them
eventually call xen/arch/arm/guestcopy.c:copy_guest:

copy_guest -> translate_get_page -> get_page_from_gva -> gvirt_to_maddr

to do the translation because Xen only memorizes the guest virtual
address as passed by xen_setup_runstate_info in Linux. gvirt_to_maddr
uses ATS12NSOPW for the translation.

I double-checked all the addresses and they are correct. For some reason
after starting the guest, ATS12NSOPW starts to fail for
ffffffc006f91628, which is the same virtual address corresponding to the
same runstate region allocated in Linux.

I added a couple of printf's to QEMU and Xen:

(XEN) DEBUG do_vcpu_op 1458 area.v=ffffffc006f91628
### This is the virtual address as passed by Linux
[...]
(QEMU) DEBUG do_ats_write 2256 ret=1 phys_addr=200 value=ffffffc006f91628
(QEMU) DEBUG do_ats_write 2326 par64=80b
### This is the output from QEMU, I added the printks to do_ats_write, line numbers 2256 and 2326
(XEN) p2m.c:1426: d1v0: gvirt_to_maddr failed va=0xffffffc006f91628 flags=0x1 par=0x80b
(XEN) DEBUG translate_get_page 42 addr=ffffffc006f91628 linear=1 write=1
(XEN) DEBUG raw_copy_to_guest 120 caller=domain.c#update_runstate_area+0x78/0x10c
(XEN) DEBUG update_runstate_area 294
### This is Xen failing the copy_to_guest in update_runstate_area.


Do you have any ideas on what's wrong? I am happy to run more tests
with QEMU to get more data.

Cheers,

Stefano
