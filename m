Received: from eggs.gnu.org ([2001:4830:134:3::10]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gRcvx-0005ke-Up
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gRcvs-0004qg-9W
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gRcvq-0004oK-5v
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:57:40 -0500
Date: Tue, 27 Nov 2018 10:56:21 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20181127125619.GD7857@localhost.localdomain>
References: <20181127024959.7060-1-ehabkost@redhat.com>
	<20181127024959.7060-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127024959.7060-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 2/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hello, Eduardo.

Just some minor comments regarding the Python code.

On Tue, Nov 27, 2018 at 12:49:59AM -0200, Eduardo Habkost wrote:
> Many of the current virtio-*-pci device types actually represent
> 3 different types of devices:
> * virtio 1.0 non-transitional devices
> * virtio 1.0 transitional devices
> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> 
> That would be just an annoyance if it didn't break our device/bus
> compatibility QMP interfaces.  With these multi-purpose device
> types, there's no way to tell management software that
> transitional devices and legacy devices require a Conventional
> PCI bus.
> 
> The multi-purpose device types would also prevent us from telling
> management software what's the PCI vendor/device ID for them,
> because their PCI IDs change at runtime depending on the bus
> where they were plugged.
> 
> This patch adds separate device types for each of those virtio
> device flavors:
> 
> - virtio-*-pci: the existing multi-purpose device types
>   - Configurable using `disable-legacy` and `disable-modern`
>     properties
>   - Legacy driver support is automatically enabled/disabled
>     depending on the bus where it is plugged
>   - Supports Conventional PCI and PCI Express buses
>     (but Conventional PCI is incompatible with
>     disable-legacy=off)
>   - Changes PCI vendor/device IDs at runtime
> - virtio-*-pci-transitional: virtio-1.0 device supporting legacy drivers
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-non-transitional: modern-only
>   - Supports both Conventional PCI and PCI Express buses
> 
> The existing TYPE_* macros for these types will point to an
> abstract base type, so existing casts in the code will keep
> working for all variants.
> 
> A simple test script (tests/acceptance/virtio_version.py) is
> included, to check if the new device types are equivalent to
> using the `disable-legacy` and `disable-modern` options.
> 
> Acked-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
[...]
> ---
>  hw/virtio/virtio-pci.h             |  24 ++--
>  hw/virtio/virtio-pci.c             |  60 ++++++++--
>  tests/acceptance/virtio_version.py | 177 +++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+), 24 deletions(-)
>  create mode 100644 tests/acceptance/virtio_version.py
> 
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index b26731a305..cd36f7e2fa 100644
[...]
> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> new file mode 100644
> index 0000000000..a8d0b20b75
> --- /dev/null
> +++ b/tests/acceptance/virtio_version.py
> @@ -0,0 +1,177 @@
> +"""
> +Check compatibility of virtio device types
> +"""
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +import sys
> +import os
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
> +from qemu import QEMUMachine
> +from avocado_qemu import Test
> +
> +# Virtio Device IDs:
> +VIRTIO_NET = 1
> +VIRTIO_BLOCK = 2
> +VIRTIO_CONSOLE = 3
> +VIRTIO_RNG = 4
> +VIRTIO_BALLOON = 5
> +VIRTIO_RPMSG = 7
> +VIRTIO_SCSI = 8
> +VIRTIO_9P = 9
> +VIRTIO_RPROC_SERIAL = 11
> +VIRTIO_CAIF = 12
> +VIRTIO_GPU = 16
> +VIRTIO_INPUT = 18
> +VIRTIO_VSOCK = 19
> +VIRTIO_CRYPTO = 20
> +
> +PCI_VENDOR_ID_REDHAT_QUMRANET = 0x1af4
> +
> +# Device IDs for legacy/transitional devices:
> +PCI_LEGACY_DEVICE_IDS = {
> +    VIRTIO_NET:     0x1000,
> +    VIRTIO_BLOCK:   0x1001,
> +    VIRTIO_BALLOON: 0x1002,
> +    VIRTIO_CONSOLE: 0x1003,
> +    VIRTIO_SCSI:    0x1004,
> +    VIRTIO_RNG:     0x1005,
> +    VIRTIO_9P:      0x1009,
> +    VIRTIO_VSOCK:   0x1012,
> +}
> +
> +def pci_modern_device_id(virtio_devid):
> +    return virtio_devid + 0x1040
> +
> +def devtype_implements(vm, devtype, implements):
> +    return devtype in [d['name'] for d in vm.command('qom-list-types', implements=implements)]
> +
> +def get_interfaces(vm, devtype, interfaces=['pci-express-device', 'conventional-pci-device']):

Usually is not a good idea to use a mutable (in this case a list)
default value as an argument:

def my_func(param=[1,2,3]):
     param.append(666)
     print(param)

my_func()
[1, 2, 3, 666]
my_func()
[1, 2, 3, 666, 666]
my_func()
[1, 2, 3, 666, 666, 666]

Yes, you're not changing the value right now, but it's something we can
not guarantee for the future when, for example, someone not Python
experienced have to change this code.

Another way safer to write this function could be:

def get_interfaces(vm, devtype, interfaces=None):
    if not interfaces:
        interfaces = ['pci-express-device', 'conventional-pci-device']
    return [i for i in interfaces if devtype_implements(vm, devtype, i)]

> +    return [i for i in interfaces if devtype_implements(vm, devtype, i)]
> +
> +class VirtioVersionCheck(Test):
> +    """
> +    Check if virtio-version-specific device types result in the
> +    same device tree created by `disable-modern` and
> +    `disable-legacy`.
> +
> +    :avocado: enable
> +    :avocado: tags=x86_64
> +    """
> +
> +    # just in case there are failures, show larger diff:
> +    maxDiff = 4096
> +
> +    def run_device(self, devtype, opts=None, machine='pc'):
> +        """
> +        Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
> +        """
> +        with QEMUMachine(self.qemu_bin) as vm:
> +            vm.set_machine(machine)
> +            if opts:
> +                devtype += ',' + opts
> +            vm.add_args('-device', '%s,id=devfortest' % (devtype))
> +            vm.add_args('-S')
> +            vm.launch()
> +
> +            pcibuses = vm.command('query-pci')
> +            alldevs = [dev for bus in pcibuses for dev in bus['devices']]
> +            import pprint
> +            pprint.pprint(alldevs)

I think it's an undesired print here, right?

> +            devfortest = [dev for dev in alldevs
> +                          if dev['qdev_id'] == 'devfortest']
> +            return devfortest[0], get_interfaces(vm, devtype)
> +
> +
> +    def assert_devids(self, dev, devid, non_transitional=False):
> +        self.assertEqual(dev['id']['vendor'], PCI_VENDOR_ID_REDHAT_QUMRANET)
> +        self.assertEqual(dev['id']['device'], devid)
> +        if non_transitional:
> +            self.assertTrue(0x1040 <= dev['id']['device'] <= 0x107f)
> +            self.assertGreaterEqual(dev['id']['subsystem'], 0x40)
> +
> +    def check_all_variants(self, qemu_devtype, virtio_devid):
> +        """Check if a virtio device type and its variants behave as expected"""
> +        # Force modern mode:
> +        dev_modern,_ = self.run_device(qemu_devtype,

s/dev_modern,_/dev_modern, _/ (blank space after comma. There are other
cases bellow)

> +                                       'disable-modern=off,disable-legacy=on')
> +        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
> +                           non_transitional=True)
> +
> +        # <prefix>-non-transitional device types should be 100% equivalent to
> +        # <prefix>,disable-modern=off,disable-legacy=on
> +        dev_1_0,nt_ifaces = self.run_device('%s-non-transitional' % (qemu_devtype))
> +        self.assertEqual(dev_modern, dev_1_0)
> +
> +        # Force transitional mode:
> +        dev_trans,_ = self.run_device(qemu_devtype,
> +                                      'disable-modern=off,disable-legacy=off')
> +        self.assert_devids(dev_trans, PCI_LEGACY_DEVICE_IDS[virtio_devid])
> +
> +        # Force legacy mode:
> +        dev_legacy,_ = self.run_device(qemu_devtype,
> +                                       'disable-modern=on,disable-legacy=off')
> +        self.assert_devids(dev_legacy, PCI_LEGACY_DEVICE_IDS[virtio_devid])
> +
> +        # No options: default to transitional on PC machine-type:
> +        no_opts_pc,generic_ifaces = self.run_device(qemu_devtype)
> +        self.assertEqual(dev_trans, no_opts_pc)
> +
> +        #TODO: check if plugging on a PCI Express bus will make the
> +        #      device non-transitional
> +        #no_opts_q35 = self.run_device(qemu_devtype, machine='q35')
> +        #self.assertEqual(dev_modern, no_opts_q35)
> +
> +        # <prefix>-transitional device types should be 100% equivalent to
> +        # <prefix>,disable-modern=off,disable-legacy=off
> +        dev_trans,trans_ifaces = self.run_device('%s-transitional' % (qemu_devtype))
> +        self.assertEqual(dev_trans, dev_trans)
> +
> +        # ensure the interface information is correct:
> +        self.assertIn('conventional-pci-device', generic_ifaces)
> +        self.assertIn('pci-express-device', generic_ifaces)
> +
> +        self.assertIn('conventional-pci-device', nt_ifaces)
> +        self.assertIn('pci-express-device', nt_ifaces)
> +
> +        self.assertIn('conventional-pci-device', trans_ifaces)
> +        self.assertNotIn('pci-express-device', trans_ifaces)
> +
> +
> +    def test_conventional_devs(self):
> +        self.check_all_variants('virtio-net-pci', VIRTIO_NET)
> +        # virtio-blk requires 'driver' parameter
> +        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
> +        self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
> +        self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
> +        self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
> +        self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
> +        # virtio-9p requires 'fsdev' parameter
> +        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
> +
> +    def check_modern_only(self, qemu_devtype, virtio_devid):
> +        """Check if a modern-only virtio device type behaves as expected"""
> +        # Force modern mode:
> +        dev_modern,_ = self.run_device(qemu_devtype,
> +                                       'disable-modern=off,disable-legacy=on')
> +        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
> +                           non_transitional=True)
> +
> +        # No options: should be modern anyway
> +        dev_no_opts,ifaces = self.run_device(qemu_devtype)
> +        self.assertEqual(dev_modern, dev_no_opts)
> +
> +        self.assertIn('conventional-pci-device', ifaces)
> +        self.assertIn('pci-express-device', ifaces)
> +
> +    def test_modern_only_devs(self):
> +        self.check_modern_only('virtio-vga', VIRTIO_GPU)
> +        self.check_modern_only('virtio-gpu-pci', VIRTIO_GPU)
> +        self.check_modern_only('virtio-mouse-pci', VIRTIO_INPUT)
> +        self.check_modern_only('virtio-tablet-pci', VIRTIO_INPUT)
> +        self.check_modern_only('virtio-keyboard-pci', VIRTIO_INPUT)
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 

Thanks,
-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
