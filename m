Received: from eggs.gnu.org ([209.51.188.92]:60290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gziY2-0004eF-B4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gziY1-00047R-E5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:49:58 -0500
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<3a6bf5ea-5b48-18c2-8a2c-0ced777be816@redhat.com>
	<892e3eb7-66f5-92a3-5891-de8665fc984a@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D6875@lhreml524-mbs.china.huawei.com>
	<d3c99948-2fdb-f345-8b22-03a7e181122c@redhat.com>
	<6f4276b4-c79c-00a0-530e-be72c8093ad1@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D778D@lhreml524-mbs.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5d04d6d-6e99-ba52-c903-6f59d83eff6c@redhat.com>
Date: Fri, 1 Mar 2019 14:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392D778D@lhreml524-mbs.china.huawei.com>
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
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Auger Eric <eric.auger@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On 02/28/19 15:02, Shameerali Kolothum Thodi wrote:

> Ah..I missed the fact that, firmware indeed sees an update in the blob =
len here
> (rounded or not) after reboot. So don=E2=80=99t think x86 has the same =
issue and padding
> is not the right solution as Igor explained in his reply.
>=20
> I will try to debug this further. Any pointers welcome.

How about this.

(1) The firmware looks up the fw_cfg file called "etc/table-loader" in
the fw_cfg file directory (identified by constant selector key 0x0019,
FW_CFG_FILE_DIR).

(2) The directory entry, once found, tells the firmware two things
simultaneously. The selector key, and the size of the blob.

(3) The firmware selects the selector key from step (2).

(4) QEMU regenerates the ACPI payload (as a select callback).

(5) The firmware reads the number of bytes from the fw_cfg blob that it
learned in step (2).

Here's the problem. As long as QEMU used to perform step (4) only for
the purpose of refreshing PCI resources in the ACPI payload, step (4)
wouldn't *resize* the blob.

However, if step (4) enlarges the blob, then the byte count that step
(5) uses -- from step (2) -- for reading, is obsolete.

Thanks
Laszlo
