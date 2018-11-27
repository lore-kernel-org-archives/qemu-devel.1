Received: from eggs.gnu.org ([2001:4830:134:3::10]:60354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRd58-00049G-KG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRd55-0007YT-An
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRd52-0007WI-OK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:07:10 -0500
Date: Tue, 27 Nov 2018 11:06:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127130617.GD18284@habkost.net>
References: <20181127024959.7060-1-ehabkost@redhat.com>
	<20181127024959.7060-3-ehabkost@redhat.com>
	<20181127125619.GD7857@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127125619.GD7857@localhost.localdomain>
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
To: Caio Carrara <ccarrara@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Nov 27, 2018 at 10:56:21AM -0200, Caio Carrara wrote:
> Hello, Eduardo.
> 
> Just some minor comments regarding the Python code.
> 
[...]
> > +def devtype_implements(vm, devtype, implements):
> > +    return devtype in [d['name'] for d in vm.command('qom-list-types', implements=implements)]
> > +
> > +def get_interfaces(vm, devtype, interfaces=['pci-express-device', 'conventional-pci-device']):
> 
> Usually is not a good idea to use a mutable (in this case a list)
> default value as an argument:
> 
> def my_func(param=[1,2,3]):
>      param.append(666)
>      print(param)
> 
> my_func()
> [1, 2, 3, 666]
> my_func()
> [1, 2, 3, 666, 666]
> my_func()
> [1, 2, 3, 666, 666, 666]
> 
> Yes, you're not changing the value right now, but it's something we can
> not guarantee for the future when, for example, someone not Python
> experienced have to change this code.

Oops, thanks for catching this!

> 
> Another way safer to write this function could be:
> 
> def get_interfaces(vm, devtype, interfaces=None):
>     if not interfaces:
>         interfaces = ['pci-express-device', 'conventional-pci-device']
>     return [i for i in interfaces if devtype_implements(vm, devtype, i)]

Maybe I should just use a tuple, then?

    def get_interfaces(vm, devtype, interfaces=('pci-express-device', 'conventional-pci-device')):
        return [i for i in interfaces if devtype_implements(vm, devtype, i)]

but probably I can simply eliminate the parameter because nobody
is using it:

    def get_pci_interfaces(vm, devtype):
        interfaces = ('pci-express-device', 'conventional-pci-device')
        return [i for i in interfaces if devtype_implements(vm, devtype, i)]

> 
> > +    return [i for i in interfaces if devtype_implements(vm, devtype, i)]
> > +
> > +class VirtioVersionCheck(Test):
> > +    """
> > +    Check if virtio-version-specific device types result in the
> > +    same device tree created by `disable-modern` and
> > +    `disable-legacy`.
> > +
> > +    :avocado: enable
> > +    :avocado: tags=x86_64
> > +    """
> > +
> > +    # just in case there are failures, show larger diff:
> > +    maxDiff = 4096
> > +
> > +    def run_device(self, devtype, opts=None, machine='pc'):
> > +        """
> > +        Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
> > +        """
> > +        with QEMUMachine(self.qemu_bin) as vm:
> > +            vm.set_machine(machine)
> > +            if opts:
> > +                devtype += ',' + opts
> > +            vm.add_args('-device', '%s,id=devfortest' % (devtype))
> > +            vm.add_args('-S')
> > +            vm.launch()
> > +
> > +            pcibuses = vm.command('query-pci')
> > +            alldevs = [dev for bus in pcibuses for dev in bus['devices']]
> > +            import pprint
> > +            pprint.pprint(alldevs)
> 
> I think it's an undesired print here, right?

Oops!  Yes, debugging leftover.

> 
> > +            devfortest = [dev for dev in alldevs
> > +                          if dev['qdev_id'] == 'devfortest']
> > +            return devfortest[0], get_interfaces(vm, devtype)
> > +
> > +
> > +    def assert_devids(self, dev, devid, non_transitional=False):
> > +        self.assertEqual(dev['id']['vendor'], PCI_VENDOR_ID_REDHAT_QUMRANET)
> > +        self.assertEqual(dev['id']['device'], devid)
> > +        if non_transitional:
> > +            self.assertTrue(0x1040 <= dev['id']['device'] <= 0x107f)
> > +            self.assertGreaterEqual(dev['id']['subsystem'], 0x40)
> > +
> > +    def check_all_variants(self, qemu_devtype, virtio_devid):
> > +        """Check if a virtio device type and its variants behave as expected"""
> > +        # Force modern mode:
> > +        dev_modern,_ = self.run_device(qemu_devtype,
> 
> s/dev_modern,_/dev_modern, _/ (blank space after comma. There are other
> cases bellow)

I will change it, thanks!

> 
> > +                                       'disable-modern=off,disable-legacy=on')
> > +        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
> > +                           non_transitional=True)
[...]

-- 
Eduardo
