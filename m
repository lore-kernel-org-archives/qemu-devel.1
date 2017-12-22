Received: from eggs.gnu.org ([2001:4830:134:3::10]:59295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eSL1M-0003Fj-TK
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eSL1J-0000VM-ST
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:57:44 -0500
Date: Fri, 22 Dec 2017 11:57:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171222115734.1f2f03ca.cohuck@redhat.com>
In-Reply-To: <20171218224616.21030-1-david@redhat.com>
References: <20171218224616.21030-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/tcg: TEST PROTECTION and
 memory hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Mon, 18 Dec 2017 23:46:14 +0100
David Hildenbrand <david@redhat.com> wrote:

> While trying to fix TCG so I can properly detect memory in kvm-unit-tests
> ... looks like I accidentally made memory hotplug under TCG work (whoops).

:)

> 
> qemu-system-s390x ... -m 2048,maxmem=4096M,slots=4 ...
> 
> [root@localhost ~]# cat /proc/meminfo
> MemTotal:        4143632 kB
> MemFree:         3845248 kB
> MemAvailable:    3947932 kB
> 
> [root@localhost ~]# lsmem
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000000fffffff  256M online        no     0
> 0x0000000010000000-0x000000006fffffff  1.5G online       yes   1-6
> 0x0000000070000000-0x00000000ffffffff  2.3G online        no  7-15
> 
> Memory block size:       256M
> Total online memory:       4G
> Total offline memory:      0B
> 
> I am not sure if we want to have memory hotplug in its current form later
> on (the guest can hotplug memory itself). This is different compared to
> all other architectures. E.g. when booting Fedora 27, it will simply
> hotplug and add all memory. This doesn't make any sense in the context of
> VMs where you want to be able to control from the outside, when and how
> much more memory is given to a VM. But anyhow, seems to work ...

Yes, s390x is different from anyone else in that respect.

I played with it for a bit and it behaves exactly the same under kvm
and under tcg.

> 
> 
> David Hildenbrand (2):
>   s390x/tcg: implement TEST PROTECTION
>   s390x/sclp: fix missing be conversion
> 
>  hw/s390x/sclp.c           |  4 ++--
>  target/s390x/helper.h     |  2 +-
>  target/s390x/mem_helper.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  target/s390x/translate.c  |  2 +-
>  4 files changed, 43 insertions(+), 6 deletions(-)
> 

Thanks, applied.
