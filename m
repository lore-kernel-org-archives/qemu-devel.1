Received: from eggs.gnu.org ([2001:4830:134:3::10]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1e32ev-0000bH-21
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1e32er-0000kW-Sl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:18:01 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:41870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1e32er-0000ic-8f
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:17:57 -0400
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-ID: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
Date: Fri, 13 Oct 2017 09:17:32 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] host physical address width issues/questions for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Sunit Jain <sunit.jain@oracle.com>

Hi,

I am new to the alias. I have some questions on this subject
and seek some clarifications from the experts in the team.
I ran into a couple of issues when I tried with large configuration
( >= 1TB memory, > 255 CPUs) for x86_64 guest machine.

1. QEMU uses the default value of 40 (TCG_PHYS_ADDR_BITS) for address
    width if user has not specified phys-bits or host-phys-bits=true
    property. The default value is obviously not sufficient and
    causing guest kernel to crash if configured with >= 1TB
    memory. Depending on the linux kernel version in the guest the
    panic was in different code paths. The workaround is for the
    user to specify the phys-bits property or set the property
    host-phys-bits=true.

    QUESTIONS:
    1) Could we change the default value to same as the host physcial
       address for x86_64 machines?  Are there any side effects on this?
    2) Adding a check to fail to boot the guest if phys-bits is not
       sufficient for the specified maxmem or if it is more than
       the host phys bits value. Do you have any objections if I
       add a patch for this?

2. host_address_width in DMAR table structure

    In this case, the default value is set to 39
    (VTD_HOST_ADDRESS_WIDTH - 1). With interrupt remapping
    enabled for the intel iommu and the guest is configured
    with > 255 cpus and >= 1TB memory, the guest kernel hangs
    during boot up. This need to be fixed.

    QUESTION:
    The question here again is can we fix this to use the
    real address width from the host as the default?

Please let me know if you have some suggestions in fixing these
two problem cases for supporting large config guests. Also, please
let me know if there are any other known limitations in the current
implementation.

Thanks.
--Prasad
