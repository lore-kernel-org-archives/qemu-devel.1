Received: from eggs.gnu.org ([209.51.188.92]:50886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h196Z-0001ij-Md
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h196X-00072q-AM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:23:31 -0500
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<3a6bf5ea-5b48-18c2-8a2c-0ced777be816@redhat.com>
	<892e3eb7-66f5-92a3-5891-de8665fc984a@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D6875@lhreml524-mbs.china.huawei.com>
	<d3c99948-2fdb-f345-8b22-03a7e181122c@redhat.com>
	<6f4276b4-c79c-00a0-530e-be72c8093ad1@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D778D@lhreml524-mbs.china.huawei.com>
	<f5d04d6d-6e99-ba52-c903-6f59d83eff6c@redhat.com>
	<20190301183924.5fdd2a0f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <44dbd7af-d6f9-34fd-915c-8a748960dd2e@redhat.com>
Date: Tue, 5 Mar 2019 13:14:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190301183924.5fdd2a0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] ARM virt: ACPI memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Auger Eric <eric.auger@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On 03/01/19 18:39, Igor Mammedov wrote:
> On Fri, 1 Mar 2019 14:49:45 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
>=20
>> On 02/28/19 15:02, Shameerali Kolothum Thodi wrote:
>>
>>> Ah..I missed the fact that, firmware indeed sees an update in the blo=
b len here
>>> (rounded or not) after reboot. So don=E2=80=99t think x86 has the sam=
e issue and padding
>>> is not the right solution as Igor explained in his reply.
>>>
>>> I will try to debug this further. Any pointers welcome. =20
>>
>> How about this.
>>
>> (1) The firmware looks up the fw_cfg file called "etc/table-loader" in
>> the fw_cfg file directory (identified by constant selector key 0x0019,
>> FW_CFG_FILE_DIR).
>>
>> (2) The directory entry, once found, tells the firmware two things
>> simultaneously. The selector key, and the size of the blob.
>>
>> (3) The firmware selects the selector key from step (2).
>>
>> (4) QEMU regenerates the ACPI payload (as a select callback).
>>
>> (5) The firmware reads the number of bytes from the fw_cfg blob that i=
t
>> learned in step (2).
>>
>> Here's the problem. As long as QEMU used to perform step (4) only for
>> the purpose of refreshing PCI resources in the ACPI payload, step (4)
>> wouldn't *resize* the blob.
>>
>> However, if step (4) enlarges the blob, then the byte count that step
>> (5) uses -- from step (2) -- for reading, is obsolete.

> I've thought that was a problem with IO based fw_cfg, as reading size/c=
ontent
> were separates steps and that it was solved by DMA based fw_cfg file re=
ad.

The DMA backend is not relevant for this question, for two reasons:

(a) The question whether the fw_cfg transfer takes places with port IO
vs. DMA is hidden from the fw_cfg client code; that code goes through an
abstract library API.

(b) While the DMA method indeed lets the firmware specify the details of
the transfer with one action, the issue is with the number of bytes that
the firmware requests (that is, not with *how* the firmware requests the
transfer). The firmware has to know the size of the transfer before it
can initiate the transfer (regardless of port IO vs. DMA).


My question is: assume the firmware item in question is selected, and
the QEMU-side select callback runs (regenerating the ACPI payload). Does
this action update the blob size in the fw_cfg file directory as well?

If it does, then I can work around the problem in the firmware. I can
add a re-lookup to the code after the item selection, in order to get
the fresh blob size from the fw_cfg file directory. Then we can use that
size for the actual transfer.

This won't help old firmware on new QEMU, but at least new firmware on
old QEMU will not be hurt (the re-fetching of the fw_cfg file directory
will come with a small performance penalty, but functionally it will be
a no-op).

Thanks
Laszlo
