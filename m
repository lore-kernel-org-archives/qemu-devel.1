Received: from eggs.gnu.org ([2001:4830:134:3::10]:40598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWQ3Y-0004r9-4R
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWQ3T-0008D2-FT
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWQ3T-0008Cn-7F
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:15 -0500
References: <1485333658-23035-1-git-send-email-thuth@redhat.com>
	<b04729a5-5dd7-ddef-0752-cf240aa88885@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b9c89de-ab1e-8103-340a-0a823e73e74c@redhat.com>
Date: Wed, 25 Jan 2017 17:04:11 +0100
MIME-Version: 1.0
In-Reply-To: <b04729a5-5dd7-ddef-0752-cf240aa88885@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] null-machine: Add support for the
 "-kernel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 25.01.2017 15:42, Laurent Vivier wrote:
> Le 25/01/2017 =C3=A0 09:40, Thomas Huth a =C3=A9crit :
>> We can have basic support for the "-kernel" parameter quite easily
>> by using the generic loader device. This should be enough for most
>> boards which do not need special machine-specific magic for loading
>> a kernel (and for those that need special magic, the generic "none"
>> machine is likely not suitable for using it as an instruction set
>> simulator board anyway).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  PS: If we can't agree on using the generic loader here, I can also
>>      prepare a patch instead that simply prints out an error message
>>      if the user tried to use the "-kernel" parameter.
>>
>>  hw/core/null-machine.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>> index 27c8369..866e699 100644
>> --- a/hw/core/null-machine.c
>> +++ b/hw/core/null-machine.c
>> @@ -5,6 +5,7 @@
>>   *
>>   * Authors:
>>   *  Anthony Liguori   <aliguori@us.ibm.com>
>> + *  Thomas Huth       <thuth@redhat.com>
>>   *
>>   * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>>   * See the COPYING file in the top-level directory.
>> @@ -16,6 +17,7 @@
>>  #include "qemu/error-report.h"
>>  #include "hw/hw.h"
>>  #include "hw/boards.h"
>> +#include "hw/core/generic-loader.h"
>>  #include "sysemu/sysemu.h"
>>  #include "exec/address-spaces.h"
>>  #include "cpu.h"
>> @@ -40,6 +42,18 @@ static void machine_none_init(MachineState *mch)
>>          memory_region_allocate_system_memory(ram, NULL, "ram", mch->r=
am_size);
>>          memory_region_add_subregion(get_system_memory(), 0, ram);
>>      }
>> +
>> +    /* Load kernel */
>> +    if (mch->kernel_filename) {
>> +        DeviceState *loader;
>> +
>> +        loader =3D qdev_create(sysbus_get_default(), TYPE_GENERIC_LOA=
DER);
>> +        qdev_prop_set_string(loader, "file", mch->kernel_filename);
>> +        if (cpu) {
>> +            qdev_prop_set_uint32(loader, "cpu-num", cpu->cpu_index);
>> +        }
>> +        qdev_init_nofail(loader);
>> +    }
>>  }
>=20
> It seems you need to check "-cpu" is set otherwise we have a segfault i=
n
> the loader:
>=20
> Thread 1 "qemu-system-m68" received signal SIGSEGV, Segmentation fault.
> ...
> #0  0x000055555564e5f8 in generic_loader_realize (dev=3D<optimized out>=
,
> errp=3D0x7fffffffd900) at hw/core/generic-loader.c:141
>=20
> 140         if (!s->force_raw) {
> 141             size =3D load_elf_as(s->file, NULL, NULL, &entry, NULL,=
 NULL,
> 142                                big_endian, 0, 0, 0, s->cpu->as);
> 143
>=20
> (gdb) p s->cpu
> $2 =3D (CPUState *) 0x0

Oh, nice catch! ... but I think this should rather be fixed in the
generic-loader instead, e.g. by using get_system_memory() instead of
s->cpu->as if s->cpu is NULL. Otherwise you can still trigger the crash
if using the loader device directly, e.g. with "-M none -device
loader,file=3Dsomething". I'll send a separate patch for this...

 Thomas
