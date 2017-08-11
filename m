Received: from eggs.gnu.org ([2001:4830:134:3::10]:36595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgAyp-00082Q-Cr
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgAyk-0006I2-UA
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:32:03 -0400
From: Diana Madalina Craciun <diana.craciun@nxp.com>
Date: Fri, 11 Aug 2017 14:31:52 +0000
Message-ID: <AM3PR04MB06161BD9424CFE152E88E3BDFF890@AM3PR04MB0616.eurprd04.prod.outlook.com>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<20170525011034-mutt-send-email-mst@kernel.org>
	<AM3PR04MB061619F6FDC53F7FD4C1DAE4FFF10@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170706023845-mutt-send-email-mst@kernel.org>
	<AM3PR04MB0616507B6F0989360D582F37FFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170731170217-mutt-send-email-mst@kernel.org>
	<AM3PR04MB061656F255D688500AC8622BFFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170801045857-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add global device ID in virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marcel@redhat.com" <marcel@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Mike Caraman <mike.caraman@nxp.com>, Laurentiu
	Tudor <laurentiu.tudor@nxp.com>

On 08/01/2017 05:05 AM, Michael S. Tsirkin wrote:=0A=
> On Mon, Jul 31, 2017 at 03:13:09PM +0000, Diana Madalina Craciun wrote:=
=0A=
>> On 07/31/2017 05:06 PM, Michael S. Tsirkin wrote:=0A=
>>> On Mon, Jul 31, 2017 at 01:22:45PM +0000, Diana Madalina Craciun wrote:=
=0A=
>>>>>> If we are to use a value of 0 for the constant in case of PCI device=
s,=0A=
>>>>>> what happens if we have multiple PCI controllers?=0A=
>>>>> I guess we'd use the PCI Segment number for that?=0A=
>>>>>=0A=
>>>>>=0A=
>>>> Yes, we can use the PCI segment for this scenario. But this would mean=
=0A=
>>>> different solutions for the same problem. The main problem is that we=
=0A=
>>>> can have multiple entities in the system that are using MSIs (for now=
=0A=
>>>> PCI and NXP non-PCI bus infrastructure=0A=
>>>> (https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lwn.net%2FArticles%2F635905%2F&data=3D01%7C01%7Cdiana.craciun%40nxp.com%7C6=
b0c6c879af64718a21908d4d81d534e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdat=
a=3DbpYMMqajWzgzdbdQgy%2FUYR7y%2BswyvwE%2BqFzs7wdIkkA%3D&reserved=3D0). I g=
uess that we may have other=0A=
>>>> platform devices that are using MSIs in the future.=0A=
>>>>=0A=
>>>> Thanks,=0A=
>>>> Diana=0A=
>>>>=0A=
>>>>=0A=
>>> Don't have the time to explore NXP in depth, sorry - there's=0A=
>>> a lot of complexity there.=0A=
>>> Could you maybe stick some bits to specify bus type in there?=0A=
>>> It just looks very wrong to push low level things like this=0A=
>>> that users have no interest in up the stack.=0A=
>>>=0A=
>> Let's generalize the problem a little bit, the NXP details just does not=
=0A=
>> matter much. The problem we have is the following:=0A=
>>=0A=
>> The GIC-ITS, the ARM MSI controller is using deviceIDs in order to remap=
=0A=
>> the interrupts. Each device which is expected to send MSIs has a=0A=
>> deviceID associated with it. These deviceIDs are configured into devices=
=0A=
>> by software/firmware. There is support in the device tree to specify the=
=0A=
>> correlation between requesterID and deviceID:=0A=
>>=0A=
>> "msi-map: Maps a Requester ID to an MSI controller and associated=0A=
>>   msi-specifier data. The property is an arbitrary number of tuples of=
=0A=
>>   (rid-base,msi-controller,msi-base,length)"=0A=
>> (https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftr=
ee%2FDocumentation%2Fdevicetree%2Fbindings%2Fpci%2Fpci-msi.txt&data=3D01%7C=
01%7Cdiana.craciun%40nxp.com%7C259982f3a83b4160083708d4d881d48a%7C686ea1d3b=
c2b4c6fa92cd99c5c301635%7C0&sdata=3DQSRwrYcsTk9%2FgekD0YBYKvpWv05%2BXKiH2ab=
Pp%2FtHpes%3D&reserved=3D0)=0A=
>>=0A=
>> Our problem is that we have to allocate these deviceIDs in QEMU as well=
=0A=
>> and we have to ensure that they are unique. Currently, for PCI, the=0A=
>> assumption requesterID=3DdeviceID is made which will no longer be true i=
n=0A=
>> case other devices are added. So we need a way (preferable a general=0A=
>> one) to allocate these IDs to different devices in the system in a=0A=
>> consistent way which will ensure that two devices do not share the same =
ID.=0A=
> My question would be, do other types of devices that are there=0A=
> right now have some kind of ID like the requester ID?=0A=
> If so I would say just use that, and set high bits in the device ID=0A=
> to specify the type (e.g. 00 for pci, etc).=0A=
=0A=
Would this mean extending the PCI requesterID usage as well? Or assume=0A=
that it's 00 for PCI and no changes are needed? I understand that with=0A=
this approach the allocation is  static: 00 for PCI, 01 for device type=0A=
X, etc., so the situation when we have multiple controllers (PCI or=0A=
whatever other devices) has to be solved differently. Wouldn't be this=0A=
more complex?=0A=
=0A=
>=0A=
>=0A=
> IMHO if possible that is preferable to pushing this up to users.=0A=
>=0A=
>=0A=
>> The reason I put this ID into the controller itself is because on real=
=0A=
>> hardware is actually programmed into the controller. It is needed (for=
=0A=
>> example) when the MSIs are sent.=0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>> Diana=0A=
>>=0A=
> IIUC what happens on real hardware is controller maps each requester ID=
=0A=
> (or presumably other source ID in the request) to the device ID,=0A=
> and the mapping is internal to controller.=0A=
> If you wanted a lot of flexibility then looks like you could pass this=0A=
> mapping to controllers, but is it really necessary?=0A=
> Why don't we build a mapping that's convenient for us?=0A=
>=0A=
>=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
