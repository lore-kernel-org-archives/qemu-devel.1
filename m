Received: from eggs.gnu.org ([2001:4830:134:3::10]:57979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSdQ0-0004Fq-LO
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSdPy-0008P8-05
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:40:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSdPx-0008Oy-OS
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:40:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181129152552.14363-1-liq3ea@163.com>
	<87ftvj4shh.fsf@dusky.pond.sub.org>
	<CAFEAcA9LtBfxmaLnwX_ZFoGxZd6fFAkjdqJKiwy-Ztmcs5aM3w@mail.gmail.com>
Date: Fri, 30 Nov 2018 08:40:48 +0100
In-Reply-To: <CAFEAcA9LtBfxmaLnwX_ZFoGxZd6fFAkjdqJKiwy-Ztmcs5aM3w@mail.gmail.com>
	(Peter Maydell's message of "Thu, 29 Nov 2018 19:11:55 +0000")
Message-ID: <87efb3nhbz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Hot-pluggable device without ->unrealize() is
 highly suspect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: fam@euphon.net, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>

Juan, David, there's a migration bit for you towards the end.

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 29 Nov 2018 at 19:03, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Li Qiang <liq3ea@163.com> writes:
>>
>> > Currently the dc390 device has no unrealize function. This
>> > can cause memory leak when hotplug/unplug device. Also more
>> > serious, it will trigger an assert when rehotplug.
>> [...]
>>
>> When a hot-pluggable device doesn't have an ->unrealize() method, unplug
>> is probably broken.  I think we should track down such devices for
>> review.  Any takers?
>
> Add an assert somewhere and catch it with the usual
> "instantiate everything" qtest?

Not as easy as it sounds.

For unplug to work, the device and all its parents in the QOM type
hierarchy up to "device" have to undo their ->realize() in their
->unrealize().

Example: "dc390" -> "am53c974" -> "pci-device" -> "device"

* device: does not implement DeviceClass::realize(), nothing to do.

* pci_device: implements DeviceClass::realize(), ::unrealize() as
  pci_qdev_realize(), pci_qdev_unrealize().  They call
  PCIDeviceClass::realize() and PCIDeviceClass::exit(), respectively.

* am53c974: implements PCIDeviceClass::realize(), ::unrealize() as
  esp_pci_scsi_realize() and esp_pci_scsi_uninit().

* dc390: implements PCIDeviceClass::realize() as dc390_scsi_realize(),
  overriding esp_pci_scsi_realize().  dc390_scsi_realize() calls
  esp_pci_scsi_realize().  Bug: it fails to overide
  esp_pci_scsi_uninit().

Three patterns:

(1) A class implements whatever realize interface its parent class
    demands.  Example: am53c974.

(2) A (generally abstract) class implements ::realize() and
    ::unrealize(), and its implementation calls methods its children may
    implement.  Example: pci_device.

(3) A class overrides its parent's implementation, and calls it.
    Example: dc390.

How can we assert any realize-like thing has a matching unrealize-like
thing?

Any class that calls realize-/unrealize-like methods its children may
implement needs to assert the child implements both or none.

The troublemaker is (3), where we may end up with an overridden
realize-like method and an non-matching, un-overridden unrealize-like
method.  Got any smart ideas?

> More generally, what is causing dc390 to be hotpluggable?
> I can't see anything obvious in the class init.

It's a PCI device.  These are all hot-pluggable by default.

>                                                 If we
> have APIs where the default is "you get this weird thing
> you weren't thinking about but it's broken because
> you weren't thinking about it" then we will have a whole
> class of bugs that we then need to squash device by device[*].
> I think it would be better for devices to have to explicitly
> opt in to implementing things like hotplug -- that way the
> failure mode is just "this isn't hotpluggable", we can
> report that helpfully to the user, and if anybody cares
> they can add the support.

I tend to agree, although for PCI devices, not being hot-pluggable is
kind of weird, except for the ones that only occur soldered onto
mainboards.

> [*] Also currently true for migration support. We should
> require devices to either provide a VMState or explicitly
> say they have no state needing migration or explicitly
> say they don't support migration, and then assert that
> they do one or the other of those, rather than having the
> default be "we'll allow migration but not migrate any
> of the device's state".

True.  Cc: Juan & Dave.
