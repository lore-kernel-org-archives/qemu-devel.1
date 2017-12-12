Received: from eggs.gnu.org ([2001:4830:134:3::10]:55293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOoO5-0005wR-Bb
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOoNy-0000va-V4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:30:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33068
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eOoNy-0000uo-Or
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:30:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBCHQaeW062563
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 12:30:28 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ethhsxr91-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 12:30:28 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 12 Dec 2017 12:30:27 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-4-git-send-email-walling@linux.vnet.ibm.com>
	<8f61fa61-9b27-ac88-e781-be2e8df3a6f4@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2017 12:30:23 -0500
MIME-Version: 1.0
In-Reply-To: <8f61fa61-9b27-ac88-e781-be2e8df3a6f4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <046eae0b-e094-8d94-3fea-3390942930b1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com

On 12/12/2017 12:00 PM, David Hildenbrand wrote:
> On 11.12.2017 23:19, Collin L. Walling wrote:
>> Set boot menu options for an s390 guest and store them in
>> the iplb. These options are set via the QEMU command line
>> option:
>>
>>      -boot menu=3Don|off[,splash-time=3DX]
>>
>> or via the libvirt domain xml:
>>
>>      <os>
>>        <bootmenu enable=3D'yes|no' timeout=3D'X'/>
>>      </os>
>>
>> Where X represents some positive integer representing
>> milliseconds.
>>
>> A loadparm other than 'prompt' will disable the menu and
>> just boot the specified entry.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/ipl.c          | 55 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   hw/s390x/ipl.h          |  8 +++++--
>>   pc-bios/s390-ccw/iplb.h |  8 +++++--
>>   3 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d06fc1..ed5e8d1 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -23,6 +23,8 @@
>>   #include "hw/s390x/ebcdic.h"
>>   #include "ipl.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/config-file.h"
>> +#include "qemu/cutils.h"
>>  =20
>>   #define KERN_IMAGE_START                0x010000UL
>>   #define KERN_PARM_AREA                  0x010480UL
>> @@ -33,6 +35,9 @@
>>   #define ZIPL_IMAGE_START                0x009000UL
>>   #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
>>  =20
>> +#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
>> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> these should go to ipl.h and maybe be renamed to something like
>
> IPL_BLOCK_... (not sure if even CCW/SCSI specific ones make sense)


I agree to move them to the header file.

I do not think we need CCW/SCSI specific ones at this time.

I'd prefer to keep the "BOOT_MENU_FLAG*" scheme, as it mirrors the same=20
naming
convention Iuse in the bios.


>
>> +
>>   static bool iplb_extended_needed(void *opaque)
>>   {
>>       S390IPLState *ipl =3D S390_IPL(object_resolve_path(TYPE_S390_IPL=
, NULL));
>> @@ -219,6 +224,51 @@ static Property s390_ipl_properties[] =3D {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>  =20
>> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_flags,
>> +                                   uint16_t *boot_menu_timeout)
>> +{
>> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>> +    char *lp =3D object_property_get_str(OBJECT(machine), "loadparm",=
 NULL);
>> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
>> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
>> +    const char *p =3D qemu_opt_get(opts, "menu");
>> +    unsigned long timeout =3D 0;
>> +
>> +    if (memcmp(lp, "PROMPT  ", 8) =3D=3D 0) {
>> +        *boot_menu_flags =3D BOOT_MENU_FLAG_BOOT_OPTS;
>> +
> remove this empty line
>
>> +    } else if (*lp) {
>> +        /* If loadparm is set to any value, then discard boot menu */
> I find the connection between -boot and loadparm quite confusing.
> Shouldn't the s390-ccw bios handle this? You should just forward here
> what is given via -boot IMHO.


My idea was to handle the setting of all boot flags and timeout options=20
under one
function.=C2=A0 IMO, it reads easier when the boot menu options are handl=
ed=20
in one place
instead of having them potentially changing in the bios (interpreting=20
loadparm).

I'm more-or-less curious to see what the feedback on this will be.=C2=A0 =
If the
consensus is to interpret loadparm in the bios instead, then I'm okay=20
with that
too.


>
>> +        return;
>> +
>> +    } else if (!p) {
>> +        /* In the absence of -boot menu, use zipl loader parameters *=
/
>> +        *boot_menu_flags =3D BOOT_MENU_FLAG_ZIPL_OPTS;
>> +
>> +    } else if (strncmp(p, "on", 2) =3D=3D 0) {
>> +        *boot_menu_flags =3D BOOT_MENU_FLAG_BOOT_OPTS;
>> +
>> +        p =3D qemu_opt_get(opts, "splash-time");
>> +
>> +        if (p && qemu_strtoul(p, NULL, 10, &timeout)) {
>> +            error_report("splash-time value is invalid, forcing it to=
 0.");
>> +            return;
>> +        }
>> +
>> +        /* Store timeout value as seconds */
>> +        timeout /=3D 1000;
> So we pass ms on the command line? Why?


The QEMU user documentation specifies the splash-time as milliseconds.
I figured it would be best to conform to that.


>
>> +
>> +        if (timeout > 0xffff) {
>> +            error_report("splash-time value is greater than 65535000,=
"
>> +                         " forcing it to 65535000.");
>> +            *boot_menu_timeout =3D 0xffff;
>> +            return;
>> +        }
>> +
>> +        *boot_menu_timeout =3D timeout;
>> +    }
>> +}
>> +
>>   static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>   {
>>       DeviceState *dev_st;
>> @@ -245,6 +295,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ip=
l)
>>               ipl->iplb.pbt =3D S390_IPL_TYPE_CCW;
>>               ipl->iplb.ccw.devno =3D cpu_to_be16(ccw_dev->sch->devno)=
;
>>               ipl->iplb.ccw.ssid =3D ccw_dev->sch->ssid & 3;
>> +            s390_ipl_set_boot_menu(&ipl->iplb.ccw.boot_menu_flags,
>> +                                   &ipl->iplb.ccw.boot_menu_timeout);
>>           } else if (sd) {
>>               SCSIBus *bus =3D scsi_bus_from_device(sd);
>>               VirtIOSCSI *vdev =3D container_of(bus, VirtIOSCSI, bus);
>> @@ -266,6 +318,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ip=
l)
>>               ipl->iplb.scsi.channel =3D cpu_to_be16(sd->channel);
>>               ipl->iplb.scsi.devno =3D cpu_to_be16(ccw_dev->sch->devno=
);
>>               ipl->iplb.scsi.ssid =3D ccw_dev->sch->ssid & 3;
>> +            s390_ipl_set_boot_menu(&ipl->iplb.scsi.boot_menu_flags,
>> +                                   &ipl->iplb.scsi.boot_menu_timeout)=
;
> can you call this only once for both cases below and only pass ipl? The
> function can figure out using ipl->iplb.pbt what to set.


Can do.


>
>>           } else {
>>               return false; /* unknown device */
>>           }
>> @@ -273,6 +327,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ip=
l)
>>           if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
>>               ipl->iplb.flags |=3D DIAG308_FLAGS_LP_VALID;
>>           }
>> +
> unrelated change
>
>>           return true;
>>       }
>>  =20
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 8a705e0..ff3b397 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -17,7 +17,9 @@
>>  =20
>>   struct IplBlockCcw {
>>       uint64_t netboot_start_addr;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint16_t boot_menu_timeout;
>> +    uint8_t  boot_menu_flags;
>>       uint8_t  ssid;
>>       uint16_t devno;
>>       uint8_t  vm_flags;
>> @@ -51,7 +53,9 @@ struct IplBlockQemuScsi {
>>       uint32_t lun;
>>       uint16_t target;
>>       uint16_t channel;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint16_t boot_menu_timeout;
>> +    uint8_t  boot_menu_flags;
>>       uint8_t  ssid;
>>       uint16_t devno;
>>   } QEMU_PACKED;
>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>> index 890aed9..fe909d2 100644
>> --- a/pc-bios/s390-ccw/iplb.h
>> +++ b/pc-bios/s390-ccw/iplb.h
>> @@ -14,7 +14,9 @@
>>  =20
>>   struct IplBlockCcw {
>>       uint64_t netboot_start_addr;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint16_t boot_menu_timeout;
>> +    uint8_t  boot_menu_flags;
>>       uint8_t  ssid;
>>       uint16_t devno;
>>       uint8_t  vm_flags;
>> @@ -48,7 +50,9 @@ struct IplBlockQemuScsi {
>>       uint32_t lun;
>>       uint16_t target;
>>       uint16_t channel;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[74];
>> +    uint16_t boot_menu_timeout;
>> +    uint8_t  boot_menu_flags;
>>       uint8_t  ssid;
>>       uint16_t devno;
>>   } __attribute__ ((packed));
>>
> These look good to me (but as discussed, I think HW folks have to agree
> on this).
>


Thanks for your feedback.

--=20
- Collin L Walling
