Received: from eggs.gnu.org ([2001:4830:134:3::10]:49128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFqT3-0003QN-PE
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFqT0-0000B0-Ia
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFqT0-00009L-AI
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:59:10 -0400
Date: Thu, 25 Oct 2018 20:59:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025205612-mutt-send-email-mst@kernel.org>
References: <20181025005110.249256-1-mst@redhat.com>
	<CAFEAcA9zqAOr7F_Pu1tqxJYd=4JMHa3XgR703Mb4B9LibOGB-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9zqAOr7F_Pu1tqxJYd=4JMHa3XgR703Mb4B9LibOGB-w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brijesh Singh <brijesh.singh@amd.com>

On Thu, Oct 25, 2018 at 08:16:44PM +0100, Peter Maydell wrote:
> On 25 October 2018 at 01:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 6a9fb4e1ba5594cde7739068617ad88e6117db93:
> >
> >   vhost-scsi: prevent using uninitialized vqs (2018-10-24 20:50:13 -0400)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> >
> > AMD IOMMU VAPIC support + fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi; I get some compile failures and a test assertion, I'm afraid:
> 
> On 32-bit hosts (where uint64_t and size_t are not the same):
> 
> /home/peter.maydell/qemu/include/qemu/compiler.h:80:35: error: invalid
> operands to binary - (have 'uint64_t * {aka long long unsigned int *}'
> and 'size_t * {aka unsigned int *}')
>  #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>                                    ^
> /home/peter.maydell/qemu/include/hw/qdev-properties.h:77:15: note: in
> expansion of macro 'type_check'
>              + type_check(_type, typeof_field(_state, _field)),          \
>                ^
> /home/peter.maydell/qemu/include/hw/qdev-properties.h:168:5: note: in
> expansion of macro 'DEFINE_PROP_UNSIGNED'
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>      ^
> /home/peter.maydell/qemu/hw/misc/pci-testdev.c:322:5: note: in
> expansion of macro 'DEFINE_PROP_SIZE'
>      DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
>      ^
> /home/peter.maydell/qemu/rules.mak:69: recipe for target
> 'hw/misc/pci-testdev.o' failed
> 
> On the Windows w64 cross-compile:
> 
> In file included from /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.c:26:0:
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.c: In function
> 'amdvi_int_remap_msi':
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.h:247:46: error: left
> shift count >= width of type [-Werror=shift-count-overflow]
>  #define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
>                                               ^
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.c:1281:25: note: in
> expansion of macro 'AMDVI_DEV_NMI_PASS_MASK'
>          pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
>                          ^
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.h:245:46: error: left
> shift count >= width of type [-Werror=shift-count-overflow]
>  #define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
>                                               ^
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.c:1285:25: note: in
> expansion of macro 'AMDVI_DEV_INT_PASS_MASK'
>          pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
>                          ^
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.h:246:46: error: left
> shift count >= width of type [-Werror=shift-count-overflow]
>  #define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
>                                               ^
> /home/petmay01/qemu-for-merges/hw/i386/amd_iommu.c:1289:25: note: in
> expansion of macro 'AMDVI_DEV_EINT_PASS_MASK'
>          pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
>                          ^
> 
> These should presumably all be "ULL". (The "UL" suffix is
> usually a bug, as it's either unnecessary or should be ULL.)

Yea.  Fixed. Brijesh could you start cleaning up that header generally?
It has all kind of weird code like using bitfields for hardware
accesses. That isn't portable - switch to full dword fields with shift
and | to operate them and proper cpu_to_le APIs or similar please.

> On various Linux hosts (aarch64, s390, x86-64, sparc)
> I get this assertion in the bios-tables-test:
> 
>   /x86_64/acpi/q35/mmio64:
> Looking for expected file 'tests/acpi-test-data/q35/DSDT.mmio64'
> 
> Looking for expected file 'tests/acpi-test-data/q35/DSDT'
> 
> Using expected file 'tests/acpi-test-data/q35/DSDT'
> 
> Looking for expected file 'tests/acpi-test-data/q35/FACP.mmio64'
> 
> Looking for expected file 'tests/acpi-test-data/q35/FACP'
> 
> Using expected file 'tests/acpi-test-data/q35/FACP'
> 
> Looking for expected file 'tests/acpi-test-data/q35/APIC.mmio64'
> 
> Looking for expected file 'tests/acpi-test-data/q35/APIC'
> 
> Using expected file 'tests/acpi-test-data/q35/APIC'
> 
> Looking for expected file 'tests/acpi-test-data/q35/HPET.mmio64'
> 
> Looking for expected file 'tests/acpi-test-data/q35/HPET'
> 
> Using expected file 'tests/acpi-test-data/q35/HPET'
> 
> Looking for expected file 'tests/acpi-test-data/q35/SRAT.mmio64'
> 
> Looking for expected file 'tests/acpi-test-data/q35/SRAT'
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/bios-tables-test.c:398:load_expected_aml:
> assertion failed: (exp_sdt.aml_file)
> FAIL
> 
> 
> thanks
> -- PMM
