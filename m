Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJiJk-0007wk-EF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJiJg-0004wd-Fb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJiJg-0004wK-69
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASG0ilr032507
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:00:58 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehad5a753-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:00:57 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 11:00:55 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
	<20171128120425.6fa912c1.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 11:00:52 -0500
MIME-Version: 1.0
In-Reply-To: <20171128120425.6fa912c1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a91be6cc-0595-5aca-ffa8-371cd920df48@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On 11/28/2017 06:04 AM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 15:55:34 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
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
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/ipl.c          | 23 +++++++++++++++++++++++
>>   hw/s390x/ipl.h          |  8 ++++++--
>>   pc-bios/s390-ccw/iplb.h |  8 ++++++--
>>   3 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d06fc1..0ca9e37 100644
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
>> @@ -219,6 +221,23 @@ static Property s390_ipl_properties[] =3D {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>  =20
>> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_enabled,
>> +                                   uint16_t *boot_menu_timeout)
>> +{
>> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
>> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
>> +    const char *p;
>> +    long result =3D 0;
>> +
>> +    *boot_menu_enabled =3D qemu_opt_get_bool(opts, "menu", false);
> This is already parsed in vl.c, isn't it? Can you simply check
> boot_menu?


Well then... how convenient! :)

>
>> +
>> +    if (*boot_menu_enabled) {
>> +        p =3D qemu_opt_get(opts, "splash-time");
> hw/nvram/fw_cfg.c parses splash-time as well, but I'm not sure if it is
> worth parsing it in vl.c as well.

It's probably best we parse it ourselves.=C2=A0 I see that fw_cfg.c also =
does
some validation on the splash-time value, so I'll add something similar.

>
>> +        qemu_strtol(p, NULL, 10, &result);
>> +        *boot_menu_timeout =3D result;
>> +    }
>> +}
>> +
>>   static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>   {
>>       DeviceState *dev_st;


--=20
- Collin L Walling
