Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwtdv-0006qj-J3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwtdr-0004MN-K2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwtdr-0004Lz-AL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:31 -0400
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5d2998d-64aa-8320-ad73-76cde1176cec@redhat.com>
Date: Tue, 26 Sep 2017 19:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170925175944.GD3030@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 25.09.2017 19:59, Eduardo Habkost wrote:
> On Mon, Sep 25, 2017 at 07:42:13PM +0200, Thomas Huth wrote:
>> On 25.09.2017 17:26, Peter Maydell wrote:
>>> On 25 September 2017 at 16:19, Thomas Huth <thuth@redhat.com> wrote:
>>>> Not sure whether this works for the virtio-xxx-device devices,
>>>> though, since they are marked as user_creatable =3D true currently..=
.
>>>
>>> That's deliberate -- for the arm boards with virtio-mmio
>>> the board creates a bunch of virtio-mmio transports and the
>>> virtio-foo-device can be user created to plug into those.
>>
>> Yes, I know ... I'm just wondering whether the virtio-xxx-device devic=
es
>> should be non-user_creatable on the non-ARM targets, since they
>> apparently can't be used with "-device" there...?
>=20
> I wouldn't like to make DeviceClass fields depend on the target.
> Being user-creatable doesn't mean they will work on all machines,
> anyway.  If user/management need more specific info, they need
> something like the query-device-slots command I've proposed some
> time ago.
>=20
>>
>>> If overall trying to do the 'right thing' is tricky here
>>> then perhaps we can start by flipping the default to
>>> not-hotpluggable and marking some devices hotpluggable
>>> that in theory shouldn't be with a comment about why.
>>
>> Yes, if Eduardo's idea to move the test to qmp_device_add() does not
>> work out (I'll try that next), your suggestion is certainly the best
>> thing we can do right now.
>=20
> I think it would work, but we would lose the feature Peter
> mentions below:
>=20
>>
>>> Incidentally I think there's still some advantage in the
>>> "created as part of some other device" devices having
>>> to be explicitly marked hotpluggable, because those
>>> devices do still need some specific code in them to
>>> handle it (ie code to release the resources that are
>>> created in the device's realize method).
>>
>> Ok ... by the way, does anybody know more devices like
>> virtio-xxx-device, i.e. devices that are indirectly plugged when addin=
g
>> other devices?
>=20
> "make check" found a few candidates:
> https://travis-ci.org/ehabkost/qemu/jobs/278743999
>=20
>   Initialization of device dpcd failed: Device 'dpcd' does not support =
hotplugging
> [...]
>   Initialization of device nand failed: Device 'nand' does not support =
hotplugging

I've now had a look at those, and I now feel like the whole
"hotpluggable =3D false by default" idea was either just wrong or there
are other smart ideas necessary to solve this issue: These devices are
created during the instance_init() function of another device, e.g.
"dpcd" is created in the xlnx_dp_init() function, which is the
instance_init of TYPE_XLNX_DP. Now, instance_init() can be called at any
time during runtime, even without really adding the device, e.g. for
parameter introspection (try "device_add xlnx.v-dp,help" at the HMP
prompt for example).

But just setting "hotpluggable =3D true" for a device (e.g. "dpcd") which
could be created during instance_init also does not sound very
attractive to me... Not sure about any good alternative way to tackle
this right now, maybe I've eventually got to check user_creatable in
device_set_realized, too, or move the hotpluggable checks to
qmp_device_add() instead... I'll think about that for a while...
suggestions welcome!

 Thomas
