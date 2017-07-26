Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daInr-0000WK-AP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIno-00066D-7m
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:40:27 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1daInn-00065g-Tf
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:40:24 -0400
Received: by mail-wm0-x229.google.com with SMTP id c184so76487887wmd.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 02:40:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
Date: Wed, 26 Jul 2017 12:40:18 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks: Set non-zero GMS memory
 size for IGD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 26 Jul 2017, at 08:22 AM, Zhang, Xiong Y <xiong.y.zhang@intel.com> =
wrote:
>=20
> Sorry, we indeed found Intel windows guest graphic driver couldn't be =
bind when GMS memory size is zero. And we have fixed it and the next =
intel windows driver release will contain this fix.
> So currently please use x-igd-gms in legacy mode to work around this.=20=

>=20
> BTW, how did you know window driver allocate extra ~4G memory when GMS =
size set to 0 ?

We noticed that with new IGD driver memory usage on VMs raised by around =
4G.

Then we examined memory allocations with poolmon =
(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/poolmon=
)
and saw that around 4G of memory is allocated with IGD driver pool tag.

Additionally we noticed that on VMs with less than 5G of memory IGD =
driver does not load and system does fallback to standard VGA driver.

>=20
> thanks
>> -----Original Message-----
>> From: Alex Williamson [mailto:alex.williamson@redhat.com]
>> Sent: Tuesday, July 25, 2017 11:32 PM
>> To: Dmitry Fleytman <dmitry@daynix.com>
>> Cc: qemu-devel@nongnu.org; Zhang, Xiong Y <xiong.y.zhang@intel.com>
>> Subject: Re: [PATCH] vfio/pci-quirks: Set non-zero GMS memory size =
for IGD
>>=20
>> [cc +Zhang, Xiong Y]
>>=20
>>=20
>> Intel, any comments?
>>=20
>>=20
>> On Mon, 24 Jul 2017 15:07:29 +0300
>> Dmitry Fleytman <dmitry@daynix.com> wrote:
>>=20
>>> There is a claim that GMS memory is unused however
>>> Intel Windows 10 drivers starting from V.4534 (10/7/2016)
>>> allocate extra ~4G memory when GMS size set to 0.
>>>=20
>>> This patch fixes this issue by seting IGD GMS memory
>>> size to minimum by changing default value of x-igd-gms
>>> device parameter.
>>>=20
>>> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
>>> ---
>>> hw/vfio/pci-quirks.c | 13 +++++++++----
>>> hw/vfio/pci.c        |  2 +-
>>> 2 files changed, 10 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>> index 349085e..197cb90 100644
>>> --- a/hw/vfio/pci-quirks.c
>>> +++ b/hw/vfio/pci-quirks.c
>>> @@ -1527,10 +1527,15 @@ static void
>> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>>     }
>>>=20
>>>     /*
>>> -     * Assume we have no GMS memory, but allow it to be overrided =
by
>> device
>>> -     * option (experimental).  The spec doesn't actually allow zero =
GMS
>> when
>>> -     * when IVD (IGD VGA Disable) is clear, but the claim is that =
it's unused,
>>> -     * so let's not waste VM memory for it.
>>> +     * There is a claim that GMS memory is unused and we want to =
waste
>> for it
>>> +     * as less VM memory as possible, however Intel Windows 10 =
drivers
>> starting
>>> +     * from V.4534 (10/7/2016) allocate extra ~4G memory when GMS
>> size set to 0.
>>> +     * The spec as well doesn't actually allow zero GMS when IVD
>>> +     * (IGD VGA Disable) is clear.
>>> +     *
>>> +     * Therefore we set GMS memory size to minimal by default via =
device
>>> +     * option x-igd-gms (experimental) and allow further tweaking =
of this
>>> +     * parameter.
>>>      */
>>>     gmch &=3D ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
>>>=20
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index d4051cb..bda07b7 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2982,7 +2982,7 @@ static Property vfio_pci_dev_properties[] =3D =
{
>>>                        sub_vendor_id, PCI_ANY_ID),
>>>     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>>>                        sub_device_id, PCI_ANY_ID),
>>> -    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>>> +    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 1),
>>>     /*
>>>      * TODO - support passed fds... is this necessary?
>>>      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
>=20
