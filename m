Received: from eggs.gnu.org ([2001:4830:134:3::10]:58496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1gCUm8-0008Dk-LG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1gCUm3-0002QF-Mv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laine@redhat.com>) id 1gCUm2-0002Lm-Mt
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:12:59 -0400
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
Date: Tue, 16 Oct 2018 15:12:40 -0400
MIME-Version: 1.0
In-Reply-To: <20181016170236.GJ7995@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On 10/16/2018 01:02 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Oct 15, 2018 at 03:14:04PM -0300, Eduardo Habkost wrote:
>> On Sun, Oct 14, 2018 at 05:35:12PM -0400, Michael S. Tsirkin wrote:
>>> On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:
>>>> The current virtio-*-pci device types actually represent 3
>>>> different types of devices:
>>>> * virtio 1.0 non-transitional devices
>>>> * virtio 1.0 transitional devices
>>>> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
>>>>
>>>> That would be just an annoyance if it didn't break our device/bus
>>>> compatibility QMP interfaces.  With this multi-purpose device
>>>> type, there's no way to tell management software that
>>>> transitional devices and legacy devices require a Conventional
>>>> PCI bus.
>>>>
>>>> The multi-purpose device types would also prevent us from telling
>>>> management software what's the PCI vendor/device ID for them,
>>>> because their PCI IDs change at runtime depending on the bus
>>>> where they were is plugged.
>>>>
>>>> This patch adds separate device types for each of those virtio
>>>> device flavors:
>>>>
>>>> - virtio-*-pci: the existing multi-purpose device types
>>>>   - Configurable using `disable-legacy` and `disable-modern`
>>>>     properties
>>>>   - Legacy driver support is automatically enabled/disabled
>>>>     depending on the bus where it is plugged
>>>>   - Supports Conventional PCI and PCI Express buses
>>>>     (but Conventional PCI is incompatible with
>>>>     disable-legacy=3Doff)
>>>>   - Changes PCI vendor/device IDs at runtime
>>>> - virtio-*-pci-0.9: legacy virtio device
>>>>   - Supports Conventional PCI buses only, because
>>>>     it has a PIO BAR
>>>> - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy=
 drivers
>>>>   - Supports Conventional PCI buses only, because
>>>>     it has a PIO BAR
>>>> - virtio-*-pci-1.0: modern-only
>>>>   - Supports both Conventional PCI and PCI Express buses
>>>
>>> I would prefer a "modern" suffix since it will likely cover future
>>> revisions as well.
>>
>> That's on purpose. The new device types don't cover future
>> revisions, otherwise we'll have exactly the same ambiguity
>> problems in the future.
>>
>> The moment we have a new virtio specification released, a device
>> type called "modern" will automatically become ambiguous.
>=20
> Agreed, I don't want to see us back in the same mess, if a
> virtio-2.0 ever gets released with non-backcompatible
> changes.
>=20
> How about using only the major digit in the device names eg
>=20
>   'virtio-blk-0.x'
>   'virtio-blk-1.x'
>=20
> to make it clearer that we cover 1.0 and 1.1 (and 1.2, etc
> by the same device.

+1 from me on either "-1" or "-1.x", and a -1 on "-1.0" or "-modern".

>=20
> This assumes that virtio authors are indeed using semantic
> versioning where minor digit indicates backcompat changes
> and major digit indicates breaking  compat changes.=20
>=20
>=20
>>> Besides, I don't have a problem with this but I'd like an
>>> ack from someone on the management side, confirming
>>> these new interfaces are actually going to be used.
>>>
>>> Could you copy some relevant people as well pls?
>>
>> CCing Andrea, Daniel, and Laine from the libvirt side.
>=20
> I don't have a objection from libvirt side.
>=20
> Last time, I suggested/discussed this I was not convinced that the bene=
fit
> was compelling enough to justify the  work across all levels in the sta=
ck.
>=20
> Apps using the new device model names would either make themselves
> incompatible with older libvirt/QEMU, or they would increase their
> code complexity & testing matrix by having to support both old & new
> names. The usage would also harm migration to older hosts.
>=20
> This just to be able to switch from i440fx to q35 for OS which don't
> support virtio-1.0, but for such old OS, q35 isn't offering any
> compelling features, so they might as well stick with the thing that
> is known to work well.

The *current* compelling reason is to permit management apps to use Q35
for "old" OSes that don't have a driver for virtio-1.0, (and especially
*new* management apps that want to support only Q35 from the start), but
there are other future advantages that will make us appreciate that this
was done. For example, libosinfo currently reports separately that an
supports virtio-0.9 devices and/or virtio-1.0 devices, but a management
app would need to have extra logic to take account of the fact that the
only way to get a virtio-0.9 device would be to place it on a
conventional PCI bus; if qemu offers the two as separate devices then
all the management app has to do is use the device that libosinfo tells
it to use, and it will automatically be placed on the right kind of bus.
(and I've heard from Eduardo that eventually we'll be able to learn the
PCI ID of the devices from qmp introspection, so the management app will
be able to just look for a device ID that is on both the qemu and the OS
list, and use that).

Obviously using these devices will make it impossible to migrate a guest
that uses them to an older host that doesn't have "new" qemu + libvirt,
but if that's important to a management app, then they can just do
things in the more complicated manner needed by the "combined" virtio
device variants. (Again, if a management app is just being
designed/written now, it can assume these new devices from the start and
ignore the older combined device).

In the end, having a device that changed PCI ID depending on what kind
of slot it was plugged into was an idea "too clever for its own good",
should be avoided when new devices are added in the future, and we
should at least provide an alternative that doesn't do that for existing
devices.


>=20
> If QEMU supports this, we'd support it in libvirt, but my recommendatio=
n
> to apps would still likely be to not use it and simply stick with i440f=
x
> for such older OS.

*maybe* for existing apps. But for any new app that doesn't have older
versions of hosts to worry about, I would say using the new versioned
device names will make their code much simpler.
