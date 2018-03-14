Received: from eggs.gnu.org ([2001:4830:134:3::10]:43474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1evyck-0000pD-Lp
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1evycg-00071a-MF
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1evycg-000712-H6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:06:46 -0400
Date: Wed, 14 Mar 2018 01:06:44 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <797197129.10905208.1521004004370.JavaMail.zimbra@redhat.com>
In-Reply-To: <47547641.10900867.1521001354668.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Suggestion on 'virtio-pmem' implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@surriel.com>, Pankaj Gupta <pagupta@redhat.com>



Hi,


I am implementing 'virtio-pmem' as a mechanism to
flush guest writes with 'fake DAX' flushing interface.

Below is the high level details of components:

1] 'virtio-pmem' device expose guest physical address
  details(start, len).   

2] 'virtio-pmem' driver in guest discovers this 
    information and configures 'libnvdimm'. Guest 'pmem' 
    driver works on this memory range.

3] Guest 'pmem' driver uses 'virtio-pmem' PV driver to 
   send flush commands.


I need suggestion implementing part 1]

* When tried with 'hotplug_memory.base' address as guest physical 
  address, I am facing 'EPT_MISCONFIG' errors when pmem does mkfs. 
  After digging more it looks like address range I am using as guest
  physical address is either already mapped as MMIO or reserved. 
  Though Guest hot-plugs this physical address into its virtual 
  memory range when guest tries to read/write the memory KVM cannot 
  translate the address and throw 'EPT_MISCONFIG' error.

* While I am trying to get the appropriate guest physical address
  which is free, I could see memory 'pc_dimm_memory_plug' code 
  has a function 'pc_dimm_get_free_addr' which works with 'PC DIMM'
  class. As I am using 'VIRTIO', there is no way AFAIK this function 
  can be used by VIRTIO or my PV device code.


I need ideas to get the free guest physical address from my PV 
device code so that we can use this range in guest address space.

Find below pointer to previous discussion:

https://marc.info/?l=kvm&m=151629709903946&w=2

Thanks,
Pankaj  
  
