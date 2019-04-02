Received: from eggs.gnu.org ([209.51.188.92]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBF00-0002wO-RS
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBExZ-00063e-PW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:39:58 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBExZ-0005xZ-G6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:39:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id 64so11235627otb.8
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 01:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-8-shameerali.kolothum.thodi@huawei.com>
	<98c7f0fd-8446-8897-0808-e7615af29670@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83933836A@lhreml524-mbs.china.huawei.com>
	<0dcd3f3c-15c4-318f-28bd-4b6706708c0d@redhat.com>
	<CAKv+Gu_-nRqeCT0s6ZwW+q3=sbGmtazFJ9R=19U5SJ=gSUmJLw@mail.gmail.com>
	<a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
In-Reply-To: <a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 08:39:45 +0000
Message-ID: <CAFEAcA9mf3HxzYkCA1rj8xQVRGo5Nbe72KEPXtQtQgA2GYaHmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
 feature "fdt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, Laszlo Ersek <lersek@redhat.com>, Leif Lindholm <Leif.Lindholm@arm.com>

On Fri, 29 Mar 2019 at 20:56, Auger Eric <eric.auger@redhat.com> wrote:
> This series:
> - [PATCH v3 00/10] ARM virt: ACPI memory hotplug support,
> https://patchwork.kernel.org/cover/10863301/
>
> aims to introduce PCDIMM support in qemu. In ACPI mode, it builds the
> SRAT and DSDT parts and relies on GED to trigger the hotplug.
>
> We noticed that if we build the hotpluggable memory dt nodes on top of
> the above ACPI tables, the DIMM slots are interpreted as not
> hotpluggable memory slots (at least we think so).
>
> We think the EDK2 GetMemoryMap() uses the dt node info and ignores the
> fact that those slots are exposed as hotpluggable in the SRAT for example.
>
> So in this series, we are forced to not generate the hotpluggable memory
> dt nodes if we want the DIMM slots to be effectively recognized as
> hotpluggable.
>
> Could you confirm we have a correct understanding of the EDK2 behaviour
> and if so, would there be any solution for EDK2 to absorb both the DT
> nodes and the relevant SRAT/DSDT tables and make the slots hotpluggable.
>
> At qemu level, detecting we are booting in ACPI mode and purposely
> removing the above mentioned DT nodes does not look straightforward.

My initial response would be to say that hotpluggable memory
should be suitably marked up in both the DTB and the ACPI tables
so that guest software that cares can tell that it is hotplugged
whether it is choosing to consume the DT or the ACPI tables.
QEMU should definitely not be reporting the hardware as looking
different to the guest based on some guess about what guest
software it is booting.

thanks
-- PMM
