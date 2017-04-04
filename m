Received: from eggs.gnu.org ([2001:4830:134:3::10]:43301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvQPa-0001sj-KS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvQPV-0002dc-WE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cvQPV-0002cl-RJ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:30:21 -0400
Date: Tue, 4 Apr 2017 11:30:13 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170404153013.GQ15423@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] PCI regression in 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, aik@ozlabs.ru, alex.williamson@redhat.com


I ran into this while running qemu iotests, and it looks like it is a
regression from 2.8.

Here is the reproducer:

$ ./x86_64-softmmu/qemu-system-x86_64 -drive if=virtio
qemu-system-x86_64: qemu-kvm/memory.c:2078: memory_region_del_subregion: Assertion `subregion->container == mr' failed
Aborted (core dumped)

The proper output is (with no abort):
qemu-system-x86_64: -drive if=virtio: Device needs media, but drive is empty

I bisected it down to this commit:

commit c53598ed18e40a9609573b21f2a361221ca0f806
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Mon Mar 27 15:40:30 2017 +1100

    pci: Add missing drop of bus master AS reference
    
    The recent introduction of a bus master container added
    memory_region_add_subregion() into the PCI device registering path but
    missed memory_region_del_subregion() in the unregistering path leaving
    a reference to the root memory region of the new container.
    
    This adds missing memory_region_del_subregion().
    
    Fixes: 3716d5902d743 ("pci: introduce a bus master container")
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
