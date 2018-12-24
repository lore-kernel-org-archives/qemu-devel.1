Received: from eggs.gnu.org ([208.118.235.92]:45908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbOms-0002xv-Tv
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbOmn-0001VY-RH
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gbOmn-0001TK-JS
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:41 -0500
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Mon, 24 Dec 2018 06:52:34 -0500
Message-Id: <20181224115235.16881-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/1] qom-get access to kernel-irqchip
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com

On preparing to test Peter Xu's "q35: change defaults for kernel irqchip =
and
IR" patch [1] I realized that kernel-irqchip property of the Machine
Class object cannot be read via qom-get api.

Actually there isn't such as kernel_irqchip property, rather it is
a compound of kernel_irqchip_allowed, kernel_irqchip_required, and
kernel_irqchip_split. Maybe that is the reason why a getter for
kernel-irqchip was not implemented. Thus, as I don't have all the context=
,
I prefer to submit this a RFC implementation.

It was tested using the following code that I don't think is worth to
merge with this series, although I would like to keep it here as a
reference:

from avocado_qemu import Test

class MachineKernelIrqChip(Test):
    """
    :avocado: enable
    """
    def get_kernel_irqchip(self):
        return self.vm.command('qom-get', path=3D'/machine',
                                          property=3D'kernel-irqchip')
    def test_default(self):
        self.vm.add_args('-M', 'q35,accel=3Dkvm')
        self.vm.launch()
        self.assertEqual(self.get_kernel_irqchip(), 'off')

    def test_off(self):
        self.vm.add_args('-M', 'q35,accel=3Dkvm,kernel-irqchip=3Doff')
        self.vm.launch()
        self.assertEqual(self.get_kernel_irqchip(), 'off')

    def test_on(self):
        self.vm.add_args('-M', 'q35,accel=3Dkvm,kernel-irqchip=3Don')
        self.vm.launch()
        self.assertEqual(self.get_kernel_irqchip(), 'on')

    def test_split(self):
        self.vm.add_args('-M', 'q35,accel=3Dkvm,kernel-irqchip=3Dsplit')
        self.vm.launch()
        self.assertEqual(self.get_kernel_irqchip(), 'split')

References:
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg582840.html

Wainer dos Santos Moschetta (1):
  hw/core: add qom getter for kernel-irqchip property

 hw/core/machine.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--=20
2.19.2
