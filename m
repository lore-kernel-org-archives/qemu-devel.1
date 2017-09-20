Received: from eggs.gnu.org ([2001:4830:134:3::10]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dufKz-0002zh-DW
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dufKv-0001j0-2n
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dufKu-0001i7-Qf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:45 -0400
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<84d1e5a0-141f-cd91-f62c-14fe58e73b4b@redhat.com>
	<CAFEAcA_morPirUBzbpX1tHKfSCX+vAEcWX+KmUZKdnNm3O3vhA@mail.gmail.com>
	<54a1ab1c-4da0-ded1-c225-f50d4756b773@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <99dd133d-239e-b53e-d258-7b1bde8639df@redhat.com>
Date: Wed, 20 Sep 2017 13:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <54a1ab1c-4da0-ded1-c225-f50d4756b773@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On 20.09.2017 12:57, Marcel Apfelbaum wrote:
> On 20/09/2017 13:07, Peter Maydell wrote:
>> On 20 September 2017 at 08:50, Marcel Apfelbaum <marcel@redhat.com>
>> wrote:
>>> Hi Thomas,
>>>
>>>
>>> On 19/09/2017 11:55, Thomas Huth wrote:
>>>>
>>>> Historically we've marked all devices as hotpluggable by default.
>>>> However,
>>>> most devices are not hotpluggable, and you also need a
>>>> HotplugHandler to
>>>> support these devices. So if the user tries to "device_add" or
>>>> "device_del"
>>>> such a non-hotpluggable device during runtime, either nothing really
>>>> usable
>>>> happens, or QEMU even crashes/aborts unexpectedly (see for example
>>>> commit
>>>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>>>> So let's change this dangerous default behaviour and mark the
>>>> devices as
>>>> non-hotpluggable by default. Certain parent devices classes which ar=
e
>>>> known
>>>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable =
=3D
>>>> true",
>>>> so that devices that are derived from these classes continue to work=
 as
>>>> expected.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 Note: I've marked the patch as RFC since I'm not 100% s=
ure
>>>> whether I've
>>>> =C2=A0=C2=A0 correctly identified all devices that should still be m=
arked as hot-
>>>> =C2=A0=C2=A0 pluggable. Feedback is welcome!
>>>>
>>>> =C2=A0=C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 10 ++++------
>>>> =C2=A0=C2=A0 hw/cpu/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
>>>> =C2=A0=C2=A0 hw/mem/nvdimm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +++
>>>> =C2=A0=C2=A0 hw/mem/pc-dimm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
>>>> =C2=A0=C2=A0 hw/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0=C2=A0 hw/s390x/ccw-device.c |=C2=A0 1 +
>>>> =C2=A0=C2=A0 hw/scsi/scsi-bus.c=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0=C2=A0 hw/usb/bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0=C2=A0 8 files changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>>> index 606ab53..c4f1902 100644
>>>> --- a/hw/core/qdev.c
>>>> +++ b/hw/core/qdev.c
>>>> @@ -1120,13 +1120,11 @@ static void device_class_init(ObjectClass
>>>> *class,
>>>> void *data)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->realize =3D device_realize;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->unrealize =3D device_unreal=
ize;
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 /* by default all devices were cons=
idered as hotpluggable,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * so with intent to check it in generic qd=
ev_unplug() /
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * device_set_realized() functions make eve=
ry device
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * hotpluggable. Devices that shouldn't be =
hotpluggable,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * should override it in their class_init()
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * All devices are considered as cold-plugg=
able by default. The
>>>> devices
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * that are hotpluggable should override it=
 in their class_init().
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D true;
>>>> +=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
>>>
>>>
>>> I agree with the defensive mode as long as we don't
>>> introduce any regression...
>>
>> Is it possible to hack together some kind of test code that
>> can give us a list of the devices compiled in that have
>> hotpluggable enabled? Then we could compare before and
>> after to see which devices we've changed.
>>
>=20
> Eduardo came up with some cool automated tests not long ago.
> Eduardo, can your tests help?

You mean the scripts/device-crash-test script? That's only for
cold-plugging ... but I could maybe use the device_add HMP test (see
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00817.html ) to
exercise the hotplugging of all devices and add some debug code to
qdev_device_add() to see which devices are dc->hotpluggable and have a
hotplug handler at the same time... I'll give it a try.

 Thomas
