Received: from eggs.gnu.org ([209.51.188.92]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLBua-00005j-Mi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLBuZ-0005tz-Mk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 15:26:00 -0400
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-11-thuth@redhat.com>
	<377a2033-504b-a84d-0eb0-765de81af730@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe977ebc-3ec7-fbf5-7a72-c9418286f0f1@redhat.com>
Date: Mon, 29 Apr 2019 21:25:33 +0200
MIME-Version: 1.0
In-Reply-To: <377a2033-504b-a84d-0eb0-765de81af730@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 10/29] hw/arm: Express
 dependencies of stellaris with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 25/04/2019 23.41, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs =
(i.e.
>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak |  7 +------
>>  hw/arm/Kconfig                  | 10 ++++++++++
>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index b7ed3c530b..3f82d635e4 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -16,6 +16,7 @@ CONFIG_MUSCA=3Dy
>>  CONFIG_CHEETAH=3Dy
>>  CONFIG_SX1=3Dy
>>  CONFIG_NSERIES=3Dy
>> +CONFIG_STELLARIS=3Dy
>> =20
>>  CONFIG_VGA=3Dy
>>  CONFIG_NAND=3Dy
>> @@ -24,16 +25,10 @@ CONFIG_SERIAL=3Dy
>>  CONFIG_MAX7310=3Dy
>>  CONFIG_TMP421=3Dy
>>  CONFIG_PCA9552=3Dy
>> -CONFIG_STELLARIS=3Dy
>> -CONFIG_STELLARIS_INPUT=3Dy
>> -CONFIG_STELLARIS_ENET=3Dy
>> -CONFIG_SSD0303=3Dy
>> -CONFIG_SSD0323=3Dy
>>  CONFIG_DDC=3Dy
>>  CONFIG_SII9022=3Dy
>>  CONFIG_ADS7846=3Dy
>>  CONFIG_MAX111X=3Dy
>> -CONFIG_SSI_SD=3Dy
>>  CONFIG_SSI_M25P80=3Dy
>>  CONFIG_ALLWINNER_EMAC=3Dy
>>  CONFIG_IMX_FEC=3Dy
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 71126254ff..b91503f5a6 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -91,6 +91,16 @@ config REALVIEW
>> =20
>>  config STELLARIS
>>      bool
>> +    select ARM_V7M
>> +    select I2C
>> +    select PL011 # UART
>> +    select PL022 # Serial port
>> +    select PL061 # GPIO
>> +    select SSD0303 # OLED display
>> +    select SSD0323 # OLED display
>> +    select SSI_SD
>> +    select STELLARIS_INPUT
>> +    select STELLARIS_ENET # ethernet
>=20
> This one misses CMSDK_APB_WATCHDOG:
>=20
> $ qemu-system-aarch64 -M lm3s811evb
> qemu-system-aarch64: Unknown device 'luminary-watchdog' for default sys=
bus
> Aborted (core dumped)

Oh, well, looks like this has just been added recently in commit
566528f823d1a2e9e, likely after I assembled and tested the initial
version of this patch...
Thanks for catching it, I'll apply your fix in v6!

 Thomas
