Received: from eggs.gnu.org ([2001:4830:134:3::10]:43783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1ergRm-00015b-ES
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1ergRi-0006Qz-7w
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:53:46 -0500
References: <20180213102258.26145-1-david.engraf@sysgo.com>
	<20180215093600.18505-1-david.engraf@sysgo.com>
	<20180302014546.GD13135@umbus.fritz.box>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <be9b719c-b1cf-8e82-3799-fca9e5fe896e@sysgo.com>
Date: Fri, 2 Mar 2018 09:53:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180302014546.GD13135@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] PPC: e500: Fix duplicate kernel load
 and device tree overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Am 02.03.2018 um 02:45 schrieb David Gibson:
> On Thu, Feb 15, 2018 at 10:36:00AM +0100, David Engraf wrote:
>> This patch fixes an incorrect behavior when the -kernel argument has b=
een
>> specified without -bios. In this case the kernel was loaded twice. At =
address
>> 32M as a raw image and afterwards by load_elf/load_uimage at the
>> corresponding load address. In this case the region for the device tre=
e and
>> the raw kernel image may overlap.
>>
>> The patch fixes the behavior by loading the kernel image once with
>> load_elf/load_uimage and skips loading the raw image.
>>
>> When here do not use bios_name/size for the kernel and use a more gene=
ric
>> name called payload_name/size.
>>
>> New in v3: dtb must be stored between kernel and initrd because Linux =
can
>>             handle the dtb only within the first 64MB. Add a comment t=
o
>>             clarify the behavior.
>>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>=20
> Sorry I've taken so long to reply to this.  It looks fine to me,
> however, other changes mean it longer quite applies to the
> ppc-for-2.12 tree.  Can you fix that up and repost please.

What other changes do you mean? In v3 I just restored the old behavior=20
by putting the dtb right after the kernel image. This behavior has been=20
changed by mistake in v1/v2. v3 now uses the correct storage location aga=
in.

Best regards
- David


>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> ---
>>   hw/ppc/e500.c | 116 +++++++++++++++++++++++++++++++++++-------------=
----------
>>   1 file changed, 70 insertions(+), 46 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index c4fe06ea2a..414c4beaab 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -784,8 +784,10 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
>>       int initrd_size =3D 0;
>>       hwaddr cur_base =3D 0;
>>       char *filename;
>> +    const char *payload_name;
>> +    bool kernel_as_payload;
>>       hwaddr bios_entry =3D 0;
>> -    target_long bios_size;
>> +    target_long payload_size;
>>       struct boot_info *boot_info;
>>       int dt_size;
>>       int i;
>> @@ -913,11 +915,6 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
>>       /* Register spinning region */
>>       sysbus_create_simple("e500-spin", params->spin_base, NULL);
>>  =20
>> -    if (cur_base < (32 * 1024 * 1024)) {
>> -        /* u-boot occupies memory up to 32MB, so load blobs above */
>> -        cur_base =3D (32 * 1024 * 1024);
>> -    }
>> -
>>       if (params->has_mpc8xxx_gpio) {
>>           qemu_irq poweroff_irq;
>>  =20
>> @@ -952,8 +949,61 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
>>                                       sysbus_mmio_get_region(s, 0));
>>       }
>>  =20
>> -    /* Load kernel. */
>> -    if (machine->kernel_filename) {
>> +    /*
>> +     * Smart firmware defaults ahead!
>> +     *
>> +     * We follow the following table to select which payload we execu=
te.
>> +     *
>> +     *  -kernel | -bios | payload
>> +     * ---------+-------+---------
>> +     *     N    |   Y   | u-boot
>> +     *     N    |   N   | u-boot
>> +     *     Y    |   Y   | u-boot
>> +     *     Y    |   N   | kernel
>> +     *
>> +     * This ensures backwards compatibility with how we used to expos=
e
>> +     * -kernel to users but allows them to run through u-boot as well=
.
>> +     */
>> +    kernel_as_payload =3D false;
>> +    if (bios_name =3D=3D NULL) {
>> +        if (machine->kernel_filename) {
>> +            payload_name =3D machine->kernel_filename;
>> +            kernel_as_payload =3D true;
>> +        } else {
>> +            payload_name =3D "u-boot.e500";
>> +        }
>> +    } else {
>> +        payload_name =3D bios_name;
>> +    }
>> +
>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
>> +
>> +    payload_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loa=
daddr, NULL,
>> +                            1, PPC_ELF_MACHINE, 0, 0);
>> +    if (payload_size < 0) {
>> +        /*
>> +         * Hrm. No ELF image? Try a uImage, maybe someone is giving u=
s an
>> +         * ePAPR compliant kernel
>> +         */
>> +        payload_size =3D load_uimage(filename, &bios_entry, &loadaddr=
, NULL,
>> +                                   NULL, NULL);
>> +        if (payload_size < 0) {
>> +            fprintf(stderr, "qemu: could not load firmware '%s'\n", f=
ilename);
>> +            exit(1);
>> +        }
>> +    }
>> +
>> +    g_free(filename);
>> +
>> +    if (kernel_as_payload) {
>> +        kernel_base =3D loadaddr;
>> +        kernel_size =3D payload_size;
>> +    }
>> +
>> +    cur_base =3D loadaddr + payload_size;
>> +
>> +    /* Load bare kernel only if no bios/u-boot has been provided */
>> +    if (machine->kernel_filename && !kernel_as_payload) {
>>           kernel_base =3D cur_base;
>>           kernel_size =3D load_image_targphys(machine->kernel_filename=
,
>>                                             cur_base,
>> @@ -967,6 +1017,11 @@ void ppce500_init(MachineState *machine, PPCE500=
Params *params)
>>           cur_base +=3D kernel_size;
>>       }
>>  =20
>> +    if (cur_base < (32 * 1024 * 1024)) {
>> +        /* u-boot occupies memory up to 32MB, so load blobs above */
>> +        cur_base =3D (32 * 1024 * 1024);
>> +    }
>> +
>>       /* Load initrd. */
>>       if (machine->initrd_filename) {
>>           initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_M=
ASK;
>> @@ -983,47 +1038,16 @@ void ppce500_init(MachineState *machine, PPCE50=
0Params *params)
>>       }
>>  =20
>>       /*
>> -     * Smart firmware defaults ahead!
>> -     *
>> -     * We follow the following table to select which payload we execu=
te.
>> -     *
>> -     *  -kernel | -bios | payload
>> -     * ---------+-------+---------
>> -     *     N    |   Y   | u-boot
>> -     *     N    |   N   | u-boot
>> -     *     Y    |   Y   | u-boot
>> -     *     Y    |   N   | kernel
>> -     *
>> -     * This ensures backwards compatibility with how we used to expos=
e
>> -     * -kernel to users but allows them to run through u-boot as well=
.
>> +     * Reserve space for dtb behind the kernel image because Linux ha=
s a bug
>> +     * where it can only handle the dtb if it's within the first 64MB=
 of where
>> +     * <kernel> starts. dtb cannot not reach initrd_base because INIT=
RD_LOAD_PAD
>> +     * ensures enough space between kernel and initrd.
>>        */
>> -    if (bios_name =3D=3D NULL) {
>> -        if (machine->kernel_filename) {
>> -            bios_name =3D machine->kernel_filename;
>> -        } else {
>> -            bios_name =3D "u-boot.e500";
>> -        }
>> -    }
>> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> -
>> -    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadad=
dr, NULL,
>> -                         1, PPC_ELF_MACHINE, 0, 0);
>> -    if (bios_size < 0) {
>> -        /*
>> -         * Hrm. No ELF image? Try a uImage, maybe someone is giving u=
s an
>> -         * ePAPR compliant kernel
>> -         */
>> -        kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr,=
 NULL,
>> -                                  NULL, NULL);
>> -        if (kernel_size < 0) {
>> -            fprintf(stderr, "qemu: could not load firmware '%s'\n", f=
ilename);
>> +    dt_base =3D (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_M=
ASK;
>> +    if (dt_base + DTB_MAX_SIZE > ram_size) {
>> +            fprintf(stderr, "qemu: not enough memory for device tree\=
n");
>>               exit(1);
>> -        }
>>       }
>> -    g_free(filename);
>> -
>> -    /* Reserve space for dtb */
>> -    dt_base =3D (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK=
;
>>  =20
>>       dt_size =3D ppce500_prep_device_tree(machine, params, dt_base,
>>                                          initrd_base, initrd_size,
>=20

--=20
Mit freundlichen Gr=FC=DFen/Best regards,

David Engraf
Product Engineer

SYSGO AG
Office Mainz
Am Pfaffenstein 14 / D-55270 Klein-Winternheim / Germany

Phone: +49-6136-9948-0 / Fax: +49-6136-9948-10
E-mail: david.engraf@sysgo.com
_________________________________________________________________________=
________

Web: https://www.sysgo.com
Blog: https://www.sysgo.com/blog
Events: https://www.sysgo.com/events
Newsletter: https://www.sysgo.com/newsletter
_________________________________________________________________________=
________

Handelsregister/Commercial Registry: HRB Mainz 90 HRB 8066
Vorstand/Executive Board: Etienne Butery (CEO), Kai Sablotny (COO)
Aufsichtsratsvorsitzender/Supervisory Board Chairman: Marc Darmon
USt-Id-Nr./VAT-Id-No.: DE 149062328
