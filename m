Received: from eggs.gnu.org ([2001:4830:134:3::10]:45152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uNa-0005hk-V7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uNX-0008LC-Ty
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:55:19 -0400
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:47983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d2uNX-0008KN-K6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:55:15 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 819494DBD0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:55:13 +0200 (CEST)
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<b8a8565a-e537-64a8-295e-09ae4797b055@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ba3d5eb9-27a5-b367-b358-c1ccd39601f0@kaod.org>
Date: Tue, 25 Apr 2017 08:55:06 +0200
MIME-Version: 1.0
In-Reply-To: <b8a8565a-e537-64a8-295e-09ae4797b055@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/24/2017 04:38 PM, C=C3=A9dric Le Goater wrote:
> On 04/24/2017 03:12 PM, Peter Maydell wrote:
>> On 24 April 2017 at 02:58, David Gibson <david@gibson.dropbear.id.au> =
wrote:
>>> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc=
68769d:
>>>
>>>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/2=
0170421' into staging (2017-04-21 15:59:27 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170424
>>>
>>> for you to fetch changes up to 4cab48942a1c5353f0a314fab1aa85a5f0a614=
61:
>>>
>>>   target/ppc: Style fixes (2017-04-24 08:56:19 +1000)
>>>
>>> ----------------------------------------------------------------
>>> ppc patch queue 2017-04-24
>>>
>>> Here's my first pull request for qemu-2.10, consisting of assorted
>>> patches which have accumulated while qemu-2.9 stabilized.  Highlights
>>> are:
>>>     * Rework / cleanup of the XICS interrupt controller
>>>     * Substantial improvement to the 'powernv' machine type
>>>         - Includes an MMIO XICS version
>>>     * POWER9 support improvements
>>>         - POWER9 guests with KVM
>>>         - Partial support for POWER9 guests with TCG
>>>     * IOMMU and VFIO improvements
>>>     * Assorted minor changes
>>>
>>> There are several IPMI patches here that aren't usually in my area of
>>> maintenance, but there isn't a regular maintainer and these patches
>>> are for the benefit of the powernv machine type.
>>
>>
>> Hi -- I'm afraid this pullreq generates a new clang sanitizer warning
>> running 'make check':
>>
>> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67:15: runtime
>> error: null pointer passed as argument 1, which is declared to never
>> be null
>>
>> It looks like we try to call open(NULL, ...).
>>
>> Affected tests are in check-qtest-i386:
>> tests/bios-tables-test
>>   /i386/acpi/piix4/ipmi
>>   /i386/acpi/q35/ipmi
>> tests/ipmi-kcs-test
>>
>> Here's a backtrace:
>>
>> #0  0x00005555567e6197 in get_image_size (filename=3D0x0) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67
>> #1  0x00005555568ead3c in ipmi_fru_init (fru=3D0x55555ab98588)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:19=
02
>> #2  0x00005555568e91ac in ipmi_sim_realize (dev=3D<optimised out>,
>> errp=3D<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:19=
43
>> #3  0x00005555567d6df6 in device_set_realized (obj=3D<optimised out>,
>> value=3D<optimised out>, errp=3D<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:905
>> #4  0x0000555556d7b1f8 in property_set_bool (obj=3D0x55555ab93c90,
>> v=3D<optimised out>, name=3D<optimised out>, opaque=3D<optimised out>,
>> errp=3D0x7fffffffde90) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1860
>> #5  0x0000555556d7dd1d in object_property_set_qobject (obj=3D0x0,
>> value=3D<optimised out>, name=3D0x58fdf801 <error: Cannot access memor=
y at
>> address 0x58fdf801>, errp=3D0x1) at
>> /home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
>> #6  0x0000555556d78cb2 in object_property_set_bool
>> (obj=3D0x55555ab93c90, value=3D<optimised out>, name=3D0x55555710e087
>> "realized", errp=3D0x7fffffffde90) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1163
>> #7  0x000055555661d80d in qdev_device_add (opts=3D<optimised out>,
>> errp=3D<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/qdev-monitor.c:630
>> #8  0x00005555566374cb in device_init_func (opaque=3D<optimised out>,
>> opts=3D0x0, errp=3D0x58fdf801)
>>     at /home/petmay01/linaro/qemu-for-merges/vl.c:2305
>> #9  0x000055555701dc81 in qemu_opts_foreach (list=3D<optimised out>,
>> func=3D<optimised out>, opaque=3D<optimised out>, errp=3D<optimised ou=
t>) at
>> /home/petmay01/linaro/qemu-for-merges/util/qemu-option.c:1114
>> #10 0x0000555556633289 in main (argc=3D<optimised out>, argv=3D<optimi=
sed
>> out>, envp=3D<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/vl.c:4583
>>
>> It looks like the device doesn't handle not having its fru.filename
>> property set -- this should either cause an error in realize or the
>> rest of the device code should handle NULL.
>=20
> I missed that one beacause the IPMI tests are not run on ppc64. I will=20
> work on a fix and include the IPMI tests under ppc64 also.

I could not reproduce the error with the clang environment I am=20
using (f24). Nevertheless, I have sent a couple of patches which=20
should fix the problem.

Thanks,

C. =20
