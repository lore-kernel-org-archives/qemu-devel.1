Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwVAX-0001Nx-J5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwVAU-0004Pl-BT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:19:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwVAU-0004Nz-3a
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:19:34 -0400
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
Date: Mon, 25 Sep 2017 17:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170925143439.GA3030@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 25.09.2017 16:34, Eduardo Habkost wrote:
> On Mon, Sep 25, 2017 at 03:46:47PM +0200, Igor Mammedov wrote:
>> On Mon, 25 Sep 2017 10:31:53 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>> On Mon, Sep 25, 2017 at 01:53:16PM +0200, Cornelia Huck wrote:
>>>> On Fri, 22 Sep 2017 11:16:34 +0200
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>  =20
>>>>> Historically we've marked all devices as hotpluggable by default. H=
owever,
>>>>> most devices are not hotpluggable, and you also need a HotplugHandl=
er to
>>>>> support these devices. So if the user tries to "device_add" or "dev=
ice_del"
>>>>> such a non-hotpluggable device during runtime, either nothing reall=
y usable
>>>>> happens, or QEMU even crashes/aborts unexpectedly (see for example =
commit
>>>>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>>>>> So let's change this dangerous default behaviour and mark the devic=
es as
>>>>> non-hotpluggable by default. Certain parent devices classes which a=
re known
>>>>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable=
 =3D true",
>>>>> so that devices that are derived from these classes continue to wor=
k as
>>>>> expected.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  v2: Add missing devices and dropped "RFC" status. See Eduardo's re=
ply on
>>>>>  the previous version of this patch for the rationale which devices=
 need
>>>>>  to be hotpluggable:
>>>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06128.htm=
l
>>>>>
>>>>>  hw/char/virtio-serial-bus.c   |  1 +
>>>>>  hw/core/qdev.c                | 10 ++++------
>>>>>  hw/mem/nvdimm.c               |  3 +++
>>>>>  hw/mem/pc-dimm.c              |  1 +
>>>>>  hw/pci/pci.c                  |  1 +
>>>>>  hw/ppc/spapr_cpu_core.c       |  1 +
>>>>>  hw/s390x/ccw-device.c         |  1 +
>>>>>  hw/scsi/scsi-bus.c            |  1 +
>>>>>  hw/usb/bus.c                  |  1 +
>>>>>  hw/usb/dev-smartcard-reader.c |  1 +
>>>>>  hw/xen/xen_backend.c          |  1 +
>>>>>  target/i386/cpu.c             |  4 ++--
>>>>>  target/s390x/cpu.c            |  1 +
>>>>>  13 files changed, 19 insertions(+), 8 deletions(-) =20
>>>>
>>>> Hm, this seems to break hotplug of virtio devices:
>>>>
>>>> (qemu) device_add virtio-net-pci,id=3Dxxx
>>>> Device 'virtio-net-device' does not support hotplugging
>>>>
>>>> (qemu) device_add virtio-net-ccw,id=3Dyyy
>>>> Device 'virtio-net-device' does not support hotplugging
>>>>
>>>> We probably need to enable hotplug for virtio devices as well? =20

D'oh, I only checked "normal" PCI devices, not the ones like virtio
devices that consist of two devices internally :-/

>>> I've seen a similar case broken by "[PATCH] hw/core/qdev: Do not
>>> allow hot-plugging without hotplug controller", because we're
>>> blocking creation of devices created internally by other devices,
>>> not just the ones created by device_add.  I need to find the
>>> exact reproducer again.
>>>
>>> It would probably simplify things if we move the check for
>>> DeviceClass::hotpluggable to qmp_device_add(), instead of
>>> device_set_realized().
>> if we would have to do that, than we are probably doing
>> something wrong and not using property right. Perhaps we
>> should fix property instead of trying find a place to check
>> it where it would hurt less.
>=20
> I disagree.  It depends on the purpose and semantics we define
> for DeviceClass::hotpluggable.  My goal is to have a reliable way
> to tell the user if a device really supports device_add, and I
> think it wouldn't make sense to report hotpluggable=3Dtrue on a
> device that is never instantiated directly by the user and only
> used internally.

I think an alternative was would maybe be to check for "user_creatable"
in device_set_realized() in addition to "hotpluggable": If
user_creatable is false, we can be sure that it is an internal plugging
only. Not sure whether this works for the virtio-xxx-device devices,
though, since they are marked as user_creatable =3D true currently...

 Thomas
