Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e7ex3-0002rX-83
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e7ex2-000811-91
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:59:49 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e7ex2-0007yP-22
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:59:48 -0400
Received: by mail-wm0-x241.google.com with SMTP id t139so7093594wmt.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 02:59:47 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <ff2f55ec-ef33-6512-3a5d-3ade1eaaf92e@amsat.org>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<7d590a446dfe29a1815c3cad2a93f7d6b0d8a214.1508279421.git.alistair.francis@xilinx.com>
	<ff2f55ec-ef33-6512-3a5d-3ade1eaaf92e@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 26 Oct 2017 11:59:16 +0200
Message-ID: <CAKmqyKONB9phsgZbXkzQ7=i6RiWiDqAa6fuqexKJNbmkL0di6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Oct 23, 2017 at 1:14 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 10/17/2017 07:31 PM, Alistair Francis wrote:
>> List all possible valid CPU options.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>> An implementation for single CPU machines is still being discussed. A
>> solution proposed by Eduardo is this:
>>
>> 1) Change the default on TYPE_MACHINE to:
>>      mc->valid_cpu_types =3D { TYPE_CPU, NULL };
>>
>>    This will keep the existing behavior for all boards.
>>
>> 2) mc->valid_cpu_types=3DNULL be interpreted as "no CPU model
>>    except the default is accepted" or "-cpu is not accepted" in
>>    machine_run_board_init() (I prefer the former, but both
>>    options would be correct)
>>
>> 3) Boards like xlnx_zynqmp could then just do this:
>>
>>    static void xxx_class_init(...) {
>>        mc->default_cpu_type =3D MY_CPU_TYPE;
>>        /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
>>        mc->valid_cpu_types =3D NULL;
>>    }
>>
>> V3:
>>  - Make variable static
>> V2:
>>  - Don't use the users -cpu
>>  - Fixup allignment
>>
>>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
>> index 519a16ed98..d5a5425356 100644
>> --- a/hw/arm/xlnx-zcu102.c
>> +++ b/hw/arm/xlnx-zcu102.c
>> @@ -160,6 +160,11 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, Machine=
State *machine)
>>      arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
>>  }
>>
>> +static const char *xlnx_zynqmp_valid_cpus[] =3D {
>> +                                            ARM_CPU_TYPE_NAME("cortex-a=
53"),
>> +                                            NULL
>> +                                              };
>
> Why so many spaces? :) Maybe Peter can clean it when applying.
>
> static const char *xlnx_zynqmp_valid_cpus[] =3D {
>     ARM_CPU_TYPE_NAME("cortex-a53"),
>     NULL
> };

The spaces are there to keep the elements under the array (while being
less then 80 characters).

Alistair

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +
>>  static void xlnx_ep108_init(MachineState *machine)
>>  {
>>      XlnxZCU102 *s =3D EP108_MACHINE(machine);
>> @@ -185,6 +190,12 @@ static void xlnx_ep108_machine_class_init(ObjectCla=
ss *oc, void *data)
>>      mc->block_default_type =3D IF_IDE;
>>      mc->units_per_default_bus =3D 1;
>>      mc->ignore_memory_transaction_failures =3D true;
>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
>> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
>> +     * users a sane error if they specify a different CPU, but we never
>> +     * use their CPU choice.
>> +     */
>> +    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
>>  }
>>
>>  static const TypeInfo xlnx_ep108_machine_init_typeinfo =3D {
>> @@ -240,6 +251,12 @@ static void xlnx_zcu102_machine_class_init(ObjectCl=
ass *oc, void *data)
>>      mc->block_default_type =3D IF_IDE;
>>      mc->units_per_default_bus =3D 1;
>>      mc->ignore_memory_transaction_failures =3D true;
>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
>> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
>> +     * users a sane error if they specify a different CPU, but we never
>> +     * use their CPU choice.
>> +     */
>> +    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
>>  }
>>
>>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
>>
