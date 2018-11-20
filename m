Received: from eggs.gnu.org ([2001:4830:134:3::10]:37683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gPBAc-00089z-By
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gPBAb-0001lc-0I
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:54:46 -0500
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-3-marcandre.lureau@redhat.com>
	<20181120173324.64a36d8e@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d84bafe2-184b-bc62-9cde-0d1421cb484d@redhat.com>
Date: Tue, 20 Nov 2018 19:54:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181120173324.64a36d8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 02/14] qom: make interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 11/20/18 17:33, Igor Mammedov wrote:
> On Wed,  7 Nov 2018 16:36:40 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
>> Interfaces don't have instance, let's make the interface type really
>> abstract to avoid confusion.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/hw/acpi/acpi_dev_interface.h | 6 +-----
>>  include/hw/arm/linux-boot-if.h       | 5 +----
>>  include/hw/fw-path-provider.h        | 4 +---
>>  include/hw/hotplug.h                 | 6 +-----
>>  include/hw/intc/intc.h               | 4 +---
>>  include/hw/ipmi/ipmi.h               | 4 +---
>>  include/hw/isa/isa.h                 | 4 ----
>>  include/hw/mem/memory-device.h       | 4 +---
>>  include/hw/nmi.h                     | 4 +---
>>  include/hw/stream.h                  | 4 +---
>>  include/hw/timer/m48t59.h            | 4 +---
>>  include/qom/object_interfaces.h      | 6 +-----
>>  include/sysemu/tpm.h                 | 4 +---
>>  target/arm/idau.h                    | 4 +---
>>  tests/check-qom-interface.c          | 4 +---
>>  15 files changed, 14 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/ac=
pi_dev_interface.h
>> index dabf4c4fc9..43ff119179 100644
>> --- a/include/hw/acpi/acpi_dev_interface.h
>> +++ b/include/hw/acpi/acpi_dev_interface.h
>> @@ -25,11 +25,7 @@ typedef enum {
>>       INTERFACE_CHECK(AcpiDeviceIf, (obj), \
>>                       TYPE_ACPI_DEVICE_IF)
>> =20
>> -
>> -typedef struct AcpiDeviceIf {
>> -    /* <private> */
>> -    Object Parent;
>> -} AcpiDeviceIf;
>> +typedef struct AcpiDeviceIf AcpiDeviceIf;
>> =20
>>  void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
>> =20
>> diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boo=
t-if.h
>> index aba4479a14..7bbdfd1cc6 100644
>> --- a/include/hw/arm/linux-boot-if.h
>> +++ b/include/hw/arm/linux-boot-if.h
>> @@ -16,10 +16,7 @@
>>  #define ARM_LINUX_BOOT_IF(obj) \
>>      INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
>> =20
>> -typedef struct ARMLinuxBootIf {
>> -    /*< private >*/
>> -    Object parent_obj;
>> -} ARMLinuxBootIf;
>> +typedef struct ARMLinuxBootIf ARMLinuxBootIf;
> I like how it makes interface truly opaque and removes the need for
> structure declaration but:
>=20
>  1: I'm not sure if it's acceptable thing to do from language point of =
view

Yeah, it's fine. If you have just

struct ARMLinuxBootIf;

(and, optionally, a typedef to it,) then this type is called an
"incomplete type" (for translation units that don't see the actual type
definition). You can't apply the "sizeof" operator to it, you can't put
it in other structs and arrays etc. I'm too lazy to look up the exact
details in the C standard now. :) But, importantly,
"pointer-to-ARMLinuxBootIf" is a complete type, and you can do all the
usual things with that. (Define variables of that pointer type, embed
them in other structures, use it as an array element type, pass them to
functions, and so on.)

Thanks
Laszlo

>  2: For a reader not aware of a trick, it's sort of confusing to have f=
orward declaration but without structure itself. So if #1 is acceptable w=
e probably should document interface trick in object.h
>=20
> [...]
>=20
