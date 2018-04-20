Received: from eggs.gnu.org ([2001:4830:134:3::10]:34636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f9RBa-00026L-CA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f9RBX-0002ZA-7c
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:14:26 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:55026
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f9RBW-0002YE-Ul
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:14:23 -0400
References: <20180413075200.15217-1-clg@kaod.org>
	<CAFEAcA_2314nBLZxaK91dNnEaefF9RAf5DA208Zg-Kyp-zQ5cQ@mail.gmail.com>
	<20180419174519.ardehg2pmp47fnvg@toto>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b5fa27c8-5ab1-a0c3-598a-5a377b0a441d@adacore.com>
Date: Fri, 20 Apr 2018 10:14:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180419174519.ardehg2pmp47fnvg@toto>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Alistair Francis <alistair@alistair23.me>, Juan Quintela <quintela@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, joonas.lahtinen@linux.intel.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, zhenyuw@linux.intel.com, QEMU Developers <qemu-devel@nongnu.org>, Yulei Zhang <yulei.zhang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>, zhi.a.wang@intel.com, David Gibson <david@gibson.dropbear.id.au>



On 04/19/2018 07:45 PM, Edgar E. Iglesias wrote:
> On Thu, Apr 19, 2018 at 06:32:07PM +0100, Peter Maydell wrote:
>> On 13 April 2018 at 08:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>> On the POWER9 processor, the XIVE interrupt controller can control
>>> interrupt sources using MMIO to trigger events, to EOI or to turn off
>>> the sources. Priority management and interrupt acknowledgment is also
>>> controlled by MMIO in the presenter sub-engine.
>>>
>>> These MMIO regions are exposed to guests in QEMU with a set of 'ram
>>> device' memory mappings, similarly to VFIO, and the VMAs are populate=
d
>>> dynamically with the appropriate pages using a fault handler.
>>>
>>> But, these regions are an issue for migration. We need to discard the
>>> associated RAMBlocks from the RAM state on the source VM and let the
>>> destination VM rebuild the memory mappings on the new host in the
>>> post_load() operation just before resuming the system.
>>>
>>> To achieve this goal, the following introduces a new RAMBlock flag
>>> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
>>> vmstate_unregister_ram() routines. This flag is then used by the
>>> migration to identify RAMBlocks to discard on the source. Some checks
>>> are also performed on the destination to make sure nothing invalid wa=
s
>>> sent.
>>
>> I think in theory this should Just Work for allowing us to
>> enable migration when the xilinx-spips device is using its
>> execute-from-mmio feature (we would just need to remove the
>> code that puts in the migration blocker).
>>
>> Xilinx folks -- do you have a test image for a board that uses
>> xilinx-spips and exercises the execute-from-mmio code, that
>> we can use to test migration/vmsave with?
>=20
> CC:ing Fred
>=20
> I got an image from Fred a while back ago, I probably still have it
> somewhere but I've totally forgotten the name for it.
>=20
> Fred, do you have the image or roughly remember the filename?
>=20
> Cheers,
> Edgar
>=20

Edgar,

That was a while ago! I don't recall the name sorry for that!

In the worse case maybe building and putting an u-boot binary for
zynq in the SPIs will do the job?
