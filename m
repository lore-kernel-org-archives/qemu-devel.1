Received: from eggs.gnu.org ([2001:4830:134:3::10]:60313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dzrSm-0004iG-3g
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dzrSl-0006au-99
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:44:20 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dzrSl-0006ad-2e
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:44:19 -0400
Received: by mail-wr0-x241.google.com with SMTP id z1so8645089wre.1
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 14:44:18 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171004130258.0a977151@nial.brq.redhat.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
	<20171004130258.0a977151@nial.brq.redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 4 Oct 2017 14:43:47 -0700
Message-ID: <CAKmqyKPMJn92F1c+K8Wy_Ka6us0p1ver_0YQUcRdyr-TRoW_ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Oct 4, 2017 at 4:02 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 3 Oct 2017 13:05:11 -0700
> Alistair Francis <alistair.francis@xilinx.com> wrote:
>
>> List all possible valid CPU options.
>>
>> Although the board only ever has a Cortex-M3 we mark the Cortex-M4 as
>> supported because the Netduino2 Plus supports the Cortex-M4 and the
>> Netduino2 Plus is similar to the Netduino2.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>> RFC v2:
>>  - Use a NULL terminated list
>>  - Add the Cortex-M4 for testing
>>
>>
>>  hw/arm/netduino2.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index f936017d4a..b68ecf2c08 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -34,18 +34,25 @@ static void netduino2_init(MachineState *machine)
>>      DeviceState *dev;
>>
>>      dev = qdev_create(NULL, TYPE_STM32F205_SOC);
>> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
>> +    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
>>      object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
>>
>>      armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>>                         FLASH_SIZE);
>>  }
>>
>> +const char *netduino_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-m3"),
> style nit,                               ^^^ put entries on new line with typical 4 space alignment

Do you mean like this?

const char *netduino_valid_cpus[] = {
                                    ARM_CPU_TYPE_NAME("cortex-m3"),
                                    ARM_CPU_TYPE_NAME("cortex-m4"),
                                    NULL };

Thanks,
Alistair

>> +                                      ARM_CPU_TYPE_NAME("cortex-m4"),
>> +                                      NULL
>> +                                    };
>
>> +
>>  static void netduino2_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Netduino 2 Machine";
>>      mc->init = netduino2_init;
>>      mc->ignore_memory_transaction_failures = true;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
>> +    mc->valid_cpu_types = netduino_valid_cpus;
>>  }
>>
>>  DEFINE_MACHINE("netduino2", netduino2_machine_init)
>
