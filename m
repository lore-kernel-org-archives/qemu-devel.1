Received: from eggs.gnu.org ([209.51.188.92]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmZZv-0001aY-P5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmZYd-0007PK-Sp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:36:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmZYd-0007Mw-Kz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:36:15 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<ab10ffce-c591-a08c-3ecf-145f1ef0cd07@redhat.com>
	<alpine.BSF.2.21.9999.1901240336030.16385@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d20eac18-c7f7-4c8b-579a-ec2f1db22342@redhat.com>
Date: Thu, 24 Jan 2019 08:36:09 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901240336030.16385@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 00/44] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, sameo@linux.intel.com

On 24/01/19 03:38, BALATON Zoltan wrote:
>>
>> I started looking at this, and found two bugs in current code
>> (unreachable devices that shouldn't be there - SERIAL_ISA for ARM,
>> ACPI_NVDIMM for MIPS).=C2=A0 There are a few issues in that the script=
 is not
>=20
> The ACPI_NVDIMM for MIPS is pulled in by CONFIG_VT82C686 which needs
> ACPI which needs NVDIMM even though it's probably not used. At least I
> think so, I haven't tested if it could be removed.

Oh, you're right.

The functions exported by hw/acpi/nvdimm.o are called by hw/i386/pc.c,
hw/i386/pc_piix.c, hw/i386/pc_q35.c, hw/acpi/nvdimm.c, hw/acpi/piix4.c
(piix4_device_plug_cb), hw/i386/acpi-build.c.  hw/acpi/piix4.c indeed is
used by Malta.  I'll change it so that the symbol is selected by
CONFIG_ACPI_X86.

Maybe
