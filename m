Received: from eggs.gnu.org ([2001:4830:134:3::10]:42996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGjr-0002T3-Gn
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGjm-0003YG-MI
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diGjm-0003X8-Dl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:05:10 -0400
Date: Thu, 17 Aug 2017 11:04:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817110449.3654e13e.cohuck@redhat.com>
In-Reply-To: <1502951113-4246-6-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-6-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Add
 qvirtio_(un)plug_device_test wrapper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 08:25:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> To support hot-plugging tests with virtio-ccw later, the current
> tests should become independent from PCI specific functions. Thus
> let's add some proper wrapper function for virtio device hot-plugging
> and -unplugging first.
> It also seems like device unplugging works fine on ppc64 when using
> the generic qtest_hot_unplug_device() function, so hot-unplugging
> is now tested on ppc64, too.

Yeah for more coverage!

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include  |  4 ++--
>  tests/libqos/virtio.c   | 27 +++++++++++++++++++++++++++
>  tests/libqos/virtio.h   |  5 +++++
>  tests/virtio-net-test.c |  8 ++------
>  tests/virtio-rng-test.c |  9 +++------
>  5 files changed, 39 insertions(+), 14 deletions(-)

> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 635b942..49e733d 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -241,15 +241,11 @@ static void pci_basic(gconstpointer data)
>  
>  static void hotplug(void)
>  {
> -    const char *arch = qtest_get_arch();
> -
>      qtest_start("-device virtio-net-pci");
>  
> -    qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);
> +    qvirtio_plug_device_test("virtio-net", "net1", PCI_SLOT_HP, NULL);

Same comment as for a previous patch regarding implicit aliasing.

Also, 'PCI_SLOT_HP' sounds a bit pci-y to me?

>  
> -    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
> -    }
> +    qvirtio_unplug_device_test("net1", PCI_SLOT_HP);
>  
>      test_end();
>  }
> diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
> index dcecf77..04c4279 100644
> --- a/tests/virtio-rng-test.c
> +++ b/tests/virtio-rng-test.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>  #include "libqos/pci.h"
> +#include "libqos/virtio.h"
>  
>  #define PCI_SLOT_HP             0x06
>  
> @@ -20,13 +21,9 @@ static void pci_nop(void)
>  
>  static void hotplug(void)
>  {
> -    const char *arch = qtest_get_arch();
> +    qvirtio_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);

Dito.

>  
> -    qpci_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
> -
> -    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        qpci_unplug_acpi_device_test("rng1", PCI_SLOT_HP);
> -    }
> +    qvirtio_unplug_device_test("rng1", PCI_SLOT_HP);
>  }
>  
>  int main(int argc, char **argv)
