Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D04C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A2820866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyS2TRPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A2820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3Dr-0001Mn-UG
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 09:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb3CT-0000ul-DM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb3CR-0001P1-9P
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:22:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hb37N-0006Yq-2b; Wed, 12 Jun 2019 09:16:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CD94XC160527;
 Wed, 12 Jun 2019 13:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=iFhQJUuRihZtyuMSzNQOvKuA/OVG9lyCE/ld8Ndms4s=;
 b=kyS2TRPUE5mtDdrtWoLjX3ArSn1CofrTlMLDZx3WRf66Y+eEy69xNG0x74vbWKFRDBF2
 uMxPbs5Dqa2s3FoGtv52JCQGr+8lNz/xSZ64LA0rvZPPcZ96XsjTDLqoUNaidwY+T9zP
 7fGjRMawmkTbKhHxXd8O2RVyftTeI2MJM8cPBIhpdVvuPiTj7Ol6CB8UhZLOMzDxCvN5
 G6eiSwme5SHXHyj/Pd0xa9e+abT5tGWkzZn7P1vRwDuT6PIe7Rt7ngJHkMl4q3aNKzSx
 UH25E8AFyylYPwoHWLshZpBN1C5odQJM2GRIcAoS+CIqa1D6zGFGl8tmsf3qq8A48L60 AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t04etubsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 13:16:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CDEoXD054207;
 Wed, 12 Jun 2019 13:16:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2t1jpj0vcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 13:16:41 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CDGe38004826;
 Wed, 12 Jun 2019 13:16:40 GMT
Received: from [10.0.5.157] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 06:16:39 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <15FA5898-482E-4730-8EC0-66044C236808@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Wed, 12 Jun 2019 16:16:33 +0300
In-Reply-To: <dc9c9c32-2fcb-a501-525b-a9bba8f22340@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
References: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
 <20190612094237.47462-8-shmuel.eiderman@oracle.com>
 <dc9c9c32-2fcb-a501-525b-a9bba8f22340@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120091
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [QEMU] [PATCH 7/8] bootdevice: FW_CFG interface
 for LCHS values
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, kraxel@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 12 Jun 2019, at 15:27, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 06/12/19 11:42, Sam Eiderman wrote:
>> Using fw_cfg, supply logical CHS values directly from QEMU to the =
BIOS.
>>=20
>> Non-standard logical geometries break under QEMU.
>>=20
>> A virtual disk which contains an operating system which depends on
>> logical geometries (consistent values being reported from BIOS INT13
>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has =
non-standard
>> logical geometries - for example 56 SPT (sectors per track).
>> No matter what QEMU will report - SeaBIOS, for large enough disks - =
will
>> use LBA translation, which will report 63 SPT instead.
>>=20
>> In addition we cannot force SeaBIOS to rely on physical geometries at
>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
>> report more than 16 physical heads when moved to an IDE controller,
>> since the ATA spec allows a maximum of 16 heads - this is an artifact =
of
>> virtualization.
>>=20
>> By supplying the logical geometries directly we are able to support =
such
>> "exotic" disks.
>>=20
>> We serialize this information in a similar way to the "bootorder"
>> interface.
>> The fw_cfg entry is "bootdevices" and it serializes a struct.
>> At the moment the struct holds the values of logical CHS values but =
it
>> can be expanded easily due to the extendable ABI implemented.
>>=20
>> (In the future, we can pass the bootindex through "bootdevices" =
instead
>> "bootorder" - unifying all bootdevice information in one fw_cfg =
value)
>=20
> I would disagree with that. UEFI guest firmware doesn't seem to have =
any
> use for this new type of information ("logical CHS values"), so the
> current interface (the "bootorder" fw_cfg file) should continue to =
work.
> The ArmVirtQemu and OVMF platform firmwares (built from the edk2
> project, and bundled with QEMU 4.1+) implement some serious parsing =
and
> processing for "bootorder=E2=80=9D.

I agree, I didn=E2=80=99t mean to say that =E2=80=9Cbootdevices" will =
replace =E2=80=9Cbootorder=E2=80=9D,
they will have to reside side by side.
I just meant to emphasis that bootorder is not extendible - adding more =
disk
specific fields other than bootorder (that for some platforms will be =
unused)
is not possible. =E2=80=9Cbootdevices=E2=80=9D will work for LCHS, if =
another entry has to be
passed - it can be added to =E2=80=9Cbootdevice=E2=80=9D.
Migrating =E2=80=9Cbootorder=E2=80=9D into a different fw_cfg value is a =
tedious, probably not
worth it, effort.

>=20
> Independently, another comment:
>=20
>> The PV interface through fw_cfg could have also been implemented =
using
>> device specific keys, e.g.: "/etc/bootdevice/%s/logical_geometry" =
where
>> %s is the device name QEMU produces - but this implementation would
>> require much more code refactoring, both in QEMU and SeaBIOS, so the
>> current implementation was chosen.
>>=20
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> ---
>> bootdevice.c            | 42 =
++++++++++++++++++++++++++++++++++++++++++
>> hw/nvram/fw_cfg.c       | 14 +++++++++++---
>> include/sysemu/sysemu.h |  1 +
>> 3 files changed, 54 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/bootdevice.c b/bootdevice.c
>> index 2b12fb85a4..84c2a83f25 100644
>> --- a/bootdevice.c
>> +++ b/bootdevice.c
>> @@ -405,3 +405,45 @@ void del_boot_device_lchs(DeviceState *dev, =
const char *suffix)
>>         }
>>     }
>> }
>> +
>> +typedef struct QEMU_PACKED BootDeviceEntrySerialized {
>> +    /* Do not change field order - add new fields below */
>> +    uint32_t lcyls;
>> +    uint32_t lheads;
>> +    uint32_t lsecs;
>> +} BootDeviceEntrySerialized;
>> +
>> +/* Serialized as: struct size (4) + (device name\0 + device struct) =
x devices */
>> +char *get_boot_devices_info(size_t *size)
>> +{
>> +    FWLCHSEntry *i;
>> +    BootDeviceEntrySerialized s;
>> +    size_t total =3D 0;
>> +    char *list =3D NULL;
>> +
>> +    list =3D g_malloc0(sizeof(uint32_t));
>> +    *((uint32_t *)list) =3D (uint32_t)sizeof(s);
>> +    total =3D sizeof(uint32_t);
>> +
>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
>> +        char *bootpath;
>> +        size_t len;
>> +
>> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix);
>> +        s.lcyls =3D i->lcyls;
>> +        s.lheads =3D i->lheads;
>> +        s.lsecs =3D i->lsecs;
>=20
> You should document the endianness of the fields in
> BootDeviceEntrySerialized, and then call byte order conversion =
functions
> here accordingly (most probably cpu_to_le32()).
>=20
> As written, this code would break if you ran qemu-system-x86_64 /
> qemu-system-i386 (with TCG acceleration) on a big endian host.

Nice catch, thanks!

>=20
> Thanks
> Laszlo
>=20
>> +
>> +        len =3D strlen(bootpath) + 1;
>> +        list =3D g_realloc(list, total + len + sizeof(s));
>> +        memcpy(&list[total], bootpath, len);
>> +        memcpy(&list[total + len], &s, sizeof(s));
>> +        total +=3D len + sizeof(s);
>> +
>> +        g_free(bootpath);
>> +    }
>> +
>> +    *size =3D total;
>> +
>> +    return list;
>> +}
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 9f7b7789bc..008b21542f 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -916,13 +916,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const =
char *filename,
>>=20
>> static void fw_cfg_machine_reset(void *opaque)
>> {
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>> +    FWCfgState *s =3D opaque;
>>     void *ptr;
>>     size_t len;
>> -    FWCfgState *s =3D opaque;
>> -    char *bootindex =3D get_boot_devices_list(&len);
>> +    char *buf;
>>=20
>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, =
len);
>> +    buf =3D get_boot_devices_list(&len);
>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
>>     g_free(ptr);
>> +
>> +    if (!mc->legacy_fw_cfg_order) {
>> +        buf =3D get_boot_devices_info(&len);
>> +        ptr =3D fw_cfg_modify_file(s, "bootdevices", (uint8_t *)buf, =
len);
>> +        g_free(ptr);
>> +    }
>> }
>>=20
>> static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 173dfbb539..f0552006f4 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -174,6 +174,7 @@ void validate_bootdevices(const char *devices, =
Error **errp);
>> void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>>                           uint32_t lcyls, uint32_t lheads, uint32_t =
lsecs);
>> void del_boot_device_lchs(DeviceState *dev, const char *suffix);
>> +char *get_boot_devices_info(size_t *size);
>>=20
>> /* handler to set the boot_device order for a specific type of =
MachineClass */
>> typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,

