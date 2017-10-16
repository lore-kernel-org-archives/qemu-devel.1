Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4ABE-0005aY-2c
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4ABB-0006Ln-Fi
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:32:00 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:33224)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4ABA-0006KG-St
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:31:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 17 Oct 2017 05:31:53 +1100
From: geoff@hostfission.com
In-Reply-To: <c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
	<286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
	<92FEAF6E-3002-4F0F-B845-4EC3D29381A4@redhat.com>
	<c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
Message-ID: <34b4df5da848d69b213f538e5751c0d3@hostfission.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi Yan & Ladi.

I have written an initial implementation that supports just the shared=20
memory
mapping at this time. I plan to add events also but before I go further=20
I would
like some feedback if possible on what I have implemented thus far.

Please see:

https://github.com/gnif/kvm-guest-drivers-windows/commit/8655cf12fbdd77b9=
91f96d97bc20f967b5907c12

Kind Regards,
Geoff

On 2017-10-15 23:29, geoff@hostfission.com wrote:
> On 2017-10-15 23:24, Yan Vugenfirer wrote:
>>> On 15 Oct 2017, at 15:21, geoff@hostfission.com wrote:
>>>=20
>>> Hi Yan,
>>>=20
>>> Thank you for the information. I am rather new to Windows Driver=20
>>> development and learning as I go, so this may take some time, but=20
>>> since the driver only needs to perform very basic functions I do not=20
>>> see this as being too much of a challenge.
>>=20
>> I think you can look into Windows virtio-balloon implementation as an
>> example of simple driver:
>> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/Ba=
lloon
>>=20
>> It relies on virtio library
>> (https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/V=
irtIO)
>> and it is WDF driver (MS framework that simplifies the drivers
>> development) that makes it very simple.
>>=20
>=20
> Thanks again, I already have a prototype driver working using WDF,
> it's more learning the windows internals and how to best implement
> things.
>=20
>>>=20
>>> -Geoff
>>>=20
>>> On 2017-10-15 22:14, Yan Vugenfirer wrote:
>>>> He Geoff,
>>>> The official virtio-win drivers upstream repository is here:
>>>> https://github.com/virtio-win/kvm-guest-drivers-windows
>>>> 1. There is no ivshmem Windows Driver for now as far as I know
>>>> 2. We are signing the drivers for community usage
>>>> https://fedoraproject.org/wiki/Windows_Virtio_Drivers from the same
>>>> repository.
>>>> The process will be: submit the code for review with pull request
>>>> (better use existing virtio library for virtio communication between
>>>> the guest and the host), pass internal tests and at the least being
>>>> able to pass MS HCK\HLK tests, later on the driver will be pulled=20
>>>> into
>>>> official build and release with rest of the drivers for community
>>>> usage.
>>>> 3. We are happy to cooperate on adding new functionality to current
>>>> package of virtio drivers for Windows
>>>> 4. As already mentioned:=20
>>>> https://github.com/virtio-win/kvm-guest-drivers-windows
>>>> Thanks a lot!
>>>> If you have more questions, please don=E2=80=99t hesitate to talk to=
 me,=20
>>>> Ladi
>>>> or anyone else from Red Hat involved with virtio-win development.
>>>> Best regards,
>>>> Yan.
>>>>> On 15 Oct 2017, at 12:32, geoff--- via Qemu-devel=20
>>>>> <qemu-devel@nongnu.org> wrote:
>>>>> Hi All,
>>>>> I am writing some code that needs to share a block of ram between a=
=20
>>>>> Windows guest and Linux host. For this I am using the ivshmem=20
>>>>> device and I have written a very primitive driver for windows that=20
>>>>> allows a single application to request to memory map the pci bar=20
>>>>> (shared memory) into the program's context using DeviceIoControl.
>>>>> This is all working fine, but the next problem is I need the driver=
=20
>>>>> to be signed. In it's current state I would not even suggest it be=20
>>>>> signed as it was just hacked together to test my concept, but now I=
=20
>>>>> know it's viable I would be willing to invest whatever time is=20
>>>>> required to write a driver that would be acceptable for signing.
>>>>> The ideal driver would be general purpose and could be leveraged=20
>>>>> for any user mode application use, not just my specific case. It=20
>>>>> would need to implement the IRQ/even features of ivshmem and=20
>>>>> possibly even some kind of security to prevent unauthorized use by=20
>>>>> rogue applications (shared secret configured on the chardev?).
>>>>> I have several qustions:
>>>>> 1) Has someone done this? I can't find any reference to a windows=20
>>>>> driver for this device anywhere.
>>>>> 2) If I was to pursue writing this driver, how would be the best=20
>>>>> way to go about it so as to ensure that it is in a state that it=20
>>>>> could be signed with the RedHat vendor key?
>>>>> 3) What is the likelihood of having such a driver signed?
>>>>> 4) Is there a preferred git host for such a driver?
>>>>> Kind Regards
>>>>> -Geoff
>>>=20
