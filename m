Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9F12067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9F12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJhl-0002yl-Pn
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBJgG-0001NC-Cl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBJgE-0007S3-UG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:46:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBJgE-0007Qv-LS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:46:54 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029EkZPw056333
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 10:46:52 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym850rtcm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:46:52 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 14:46:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 14:46:46 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029EkivD53477478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 14:46:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B2B04C059;
 Mon,  9 Mar 2020 14:46:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 290784C044;
 Mon,  9 Mar 2020 14:46:44 +0000 (GMT)
Received: from dyn-9-152-224-87.boeblingen.de.ibm.com (unknown [9.152.224.87])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 14:46:44 +0000 (GMT)
Subject: Re: [PATCH v7 02/15] s390x: protvirt: Support unpack facility
To: Viktor Mihajlovski <mihajlov@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-3-frankja@linux.ibm.com>
 <96a89714-2c3c-908c-9d66-9bbfe1997168@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 9 Mar 2020 15:46:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <96a89714-2c3c-908c-9d66-9bbfe1997168@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LllO35wtJo7KCsOQAnb0lkRyO9BbgImdk"
X-TM-AS-GCONF: 00
x-cbid: 20030914-0008-0000-0000-0000035ACCC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030914-0009-0000-0000-00004A7C0CF7
Message-Id: <ebe24f7f-8509-8b7c-946e-fa9969fce177@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_06:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=11 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LllO35wtJo7KCsOQAnb0lkRyO9BbgImdk
Content-Type: multipart/mixed; boundary="oSOI4Oueu4plT3R6qAShajg0Auoxccb3J"

--oSOI4Oueu4plT3R6qAShajg0Auoxccb3J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/9/20 3:28 PM, Viktor Mihajlovski wrote:
>=20
>=20
> On 3/9/20 12:21 PM, Janosch Frank wrote:
>> The unpack facility provides the means to setup a protected guest. A
>> protected guest can not be introspected by the hypervisor or any
>> user/administrator of the machine it is running on.
>>
>> Protected guests are encrypted at rest and need a special boot
>> mechanism via diag308 subcode 8 and 10.
>>
>> Code 8 sets the PV specific IPLB which is retained seperately from
>> those set via code 5.
>>
>> Code 10 is used to unpack the VM into protected memory, verify its
>> integrity and start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes=

>> to machine]
> A nit: [Changes...] should go before the s-o-b.

Will be changed anyway

>> ---
>>   hw/s390x/Makefile.objs              |   1 +
>>   hw/s390x/ipl.c                      |  59 ++++++++++++-
>>   hw/s390x/ipl.h                      |  72 ++++++++++++++--
>>   hw/s390x/pv.c                       | 104 +++++++++++++++++++++++
>>   hw/s390x/pv.h                       |  34 ++++++++
>>   hw/s390x/s390-virtio-ccw.c          | 127 ++++++++++++++++++++++++++=
+-
>>   include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>   target/s390x/cpu.c                  |  17 ++++
>>   target/s390x/cpu.h                  |   1 +
>>   target/s390x/cpu_features_def.inc.h |   1 +
>>   target/s390x/diag.c                 |  34 +++++++-
>>   11 files changed, 436 insertions(+), 15 deletions(-)
>>   create mode 100644 hw/s390x/pv.c
>>   create mode 100644 hw/s390x/pv.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index e02ed80b68..a46a1c7894 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
>>   obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>   obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>   obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>> +obj-$(CONFIG_KVM) +=3D pv.o
>>   obj-y +=3D s390-ccw.o
>>   obj-y +=3D ap-device.o
>>   obj-y +=3D ap-bridge.o
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 9c1ecd423c..ba3eac30c6 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -33,6 +33,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/option.h"
>>   #include "exec/exec-all.h"
>> +#include "pv.h"
>>
>>   #define KERN_IMAGE_START                0x010000UL
>>   #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -542,11 +543,30 @@ void s390_ipl_update_diag308(IplParameterBlock *=
iplb)
>>   {
>>       S390IPLState *ipl =3D get_ipl_device();
>>
>> -    ipl->iplb =3D *iplb;
>> -    ipl->iplb_valid =3D true;
>> +    /*
>> +     * The IPLB set and retrieved by subcodes 8/9 is completely
>> +     * separate from the one managed via subcodes 5/6.
>> +     */
>> +    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
>> +        ipl->iplb_pv =3D *iplb;
>> +        ipl->iplb_valid_pv =3D true;
>> +    } else {
>> +        ipl->iplb =3D *iplb;
>> +        ipl->iplb_valid =3D true;
>> +    }
>>       ipl->netboot =3D is_virtio_net_device(iplb);
>>   }
>>
>> +IplParameterBlock *s390_ipl_get_iplb_pv(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +
>> +    if (!ipl->iplb_valid_pv) {
>> +        return NULL;
>> +    }
>> +    return &ipl->iplb_pv;
>> +}
>> +
>>   IplParameterBlock *s390_ipl_get_iplb(void)
>>   {
>>       S390IPLState *ipl =3D get_ipl_device();
>> @@ -561,7 +581,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s39=
0_reset reset_type)
>>   {
>>       S390IPLState *ipl =3D get_ipl_device();
>>
>> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL) {
>> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL ||
>> +        reset_type =3D=3D S390_RESET_PV) {
>>           /* use CPU 0 for full resets */
>>           ipl->reset_cpu_index =3D 0;
>>       } else {
>> @@ -635,6 +656,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>       cpu_physical_memory_unmap(addr, len, 1, len);
>>   }
>>
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>> +    int rc;
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                          ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    int i, rc =3D 0;
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
>> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].=
size),
>> +                            ipib_pv->components[i].tweak_pref);
>> +        if (rc) {
>> +            break;
>> +        }
>> +    }
>> +    return rc;
>> +}
>> +
>>   void s390_ipl_prepare_cpu(S390CPU *cpu)
>>   {
>>       S390IPLState *ipl =3D get_ipl_device();
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index d4813105db..b2ccdd9dae 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -15,6 +15,24 @@
>>   #include "cpu.h"
>>   #include "hw/qdev-core.h"
>>
>> +struct IPLBlockPVComp {
>> +    uint64_t tweak_pref;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPVComp IPLBlockPVComp;
>> +
>> +struct IPLBlockPV {
>> +    uint8_t  reserved18[87];    /* 0x18 */
>> +    uint8_t  version;           /* 0x6f */
>> +    uint32_t reserved70;        /* 0x70 */
>> +    uint32_t num_comp;          /* 0x70 */
> Another nit: offset should be 0x74

Ups

>> +    uint64_t pv_header_addr;    /* 0x74 */
>> +    uint64_t pv_header_len;     /* 0x7c */
>> +    struct IPLBlockPVComp components[];
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPV IPLBlockPV;
>> +
>>   struct IplBlockCcw {
>>       uint8_t  reserved0[85];
>>       uint8_t  ssid;[...]



--oSOI4Oueu4plT3R6qAShajg0Auoxccb3J--

--LllO35wtJo7KCsOQAnb0lkRyO9BbgImdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5mVtMACgkQ41TmuOI4
ufjeGw//bn8+xFfxQ+G0nRUCAkYBlRICutS5r1h7OtizRLaWCs30KQvqx5EcKgSi
mKOLtsxj0SVYr/clbb88T1n2CiYeMwZtlKPCKdyNOs5kuL8mcGq1d/M3DsU0DMgh
l80RzYse/cAhAhe7DKfBf99opdaV897yMOmq5k1PMsvLUMeWpZfwX+aLjS7Kz0Qo
6ILo4+uQKIbbOhpBslDMPI4nDpLUMh/oVKpb2Ujryf66axMZgqT82jBxvhpENJkc
3AHGKmPe3G0gqpKPV/iopoxHnWXB5UnOPLx8rAzi3kx8wKsJsPW0iHZQDwGybbdj
o03dAJZs+IgRieq5e/fRYTFShlBkI9nh9r7aAuTCi1+FffyVxuiPaCgqQ5XSx88/
+A/GR6RH6xjm49i6+9o1ugAH9RwOBKtrMXfH2YCY0yM3iz0QM7FlPoTjj7Qc/OOL
bEk3/3A2o8cqjhochNln0N4sG9o4daKSmJMrTR3Ld/1XbSd7lGVGBRidnKHfEpUF
786vn2ZXzNF/AU/WPBqPCIPSYTddzYfnjl5Ym/+0z0fuMKl/CrS4UMqvjzdXlcEz
GBZjObgjmUzJz3eOUdG6BWgHiFL4kfXczMG/BI2pN3uE8PqUQMkgSWaJy1yUzF9u
GgOqQ6HTHcIC0kS3eZfZMRGZBvoYAHexUV0lMb6GHyPtTUJ+ytQ=
=XgPI
-----END PGP SIGNATURE-----

--LllO35wtJo7KCsOQAnb0lkRyO9BbgImdk--


