Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7583C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE362080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE362080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Eke-00010K-SN
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6EgK-0002Hy-2w
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6EgH-0007q7-Ow
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:26:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6EgH-0007pu-HL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:25:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01OEKRuU156392
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:25:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb009a2gv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:25:51 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 24 Feb 2020 14:25:40 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 24 Feb 2020 14:25:37 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01OEOdWJ48038306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 14:24:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1F524C05A;
 Mon, 24 Feb 2020 14:25:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88CF64C044;
 Mon, 24 Feb 2020 14:25:35 +0000 (GMT)
Received: from dyn-9-152-224-56.boeblingen.de.ibm.com (unknown [9.152.224.56])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2020 14:25:35 +0000 (GMT)
Subject: Re: [PATCH v4 03/16] s390x: protvirt: Support unpack facility
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-4-frankja@linux.ibm.com>
 <b8a56f22-c283-f344-435e-d2f36fef7ade@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 24 Feb 2020 15:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b8a56f22-c283-f344-435e-d2f36fef7ade@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q8D4G5aOCQ16xzKt8FjTvZd3PzXk1IhOJ"
X-TM-AS-GCONF: 00
x-cbid: 20022414-0008-0000-0000-00000355F671
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022414-0009-0000-0000-00004A770F2A
Message-Id: <8d9db172-0b83-f534-dd80-c2b29d3cfb7b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_04:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=3 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8D4G5aOCQ16xzKt8FjTvZd3PzXk1IhOJ
Content-Type: multipart/mixed; boundary="dKQ0iUVUPZqdljKplixUi7LyocEMBuRMz"

--dKQ0iUVUPZqdljKplixUi7LyocEMBuRMz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/24/20 3:13 PM, Christian Borntraeger wrote:
>=20
>=20
> On 20.02.20 13:56, Janosch Frank wrote:
>> When a guest has saved a ipib of type 5 and calls diagnose308 with
>> subcode 10, we have to setup the protected processing environment via
>> Ultravisor calls. The calls are done by KVM and are exposed via an
>> API.
>>
>> The following steps are necessary:
>> 1. Create a VM (register it with the Ultravisor)
>> 2. Create secure CPUs for all of our current cpus
>=20
> maybe rephrase that to reflect the enable/disable change?

Yep

>=20
>> 3. Forward the secure header to the Ultravisor (has all information on=

>> how to decrypt the image and VM information)
>> 4. Protect image pages from the host and decrypt them
>> 5. Verify the image integrity
>>
>> Only after step 5 a protected VM is allowed to run.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes=

>> to machine]
>=20
> [...]
>=20
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..8ae20f31c1
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Secure execution functions
>> + *
>> + * Copyright IBM Corp. 2020
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include <sys/ioctl.h>
>> +
>> +#include <linux/kvm.h>
>> +
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "pv.h"
>> +
>> +const char *cmd_names[] =3D {
>> +    "VM_CREATE",
>> +    "VM_DESTROY",
>=20
> ENABLE/DISABLE?

Ack.

>=20
>> +    "VM_SET_SEC_PARAMS",
>> +    "VM_UNPACK",
>> +    "VM_VERIFY",
>> +    "VM_PREP_RESET",
>> +    "VM_UNSHARE_ALL",
>> +    NULL
>> +};
>=20
> Wild idea. Not sure if this is acceptable in QEMU.
>=20
> These strings are only for the error_report, no?
> Could we use a MACRO that uses this a as a string and b as the inter va=
lue?
>=20
> -static int s390_pv_cmd(uint32_t cmd, void *data)
> +#define S390_PV_CMD(cmd, data) s390_pv_cmd(cmd, #cmd, data)
> +static int s390_pv_cmd(uint32_t cmd, const char *name, void *data)
>=20
>=20
> and then replace all calls with S390_PV_CMD. (Of course also change the=

> error report to use name).
>=20
>> +
>> +static int s390_pv_cmd(uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV command %d (%s) failed: header rc %x rrc=
 %x "
>> +                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, =
pv_cmd.rrc,
>> +                     rc);
>> +    }
>> +    return rc;
>> +}
> [...]
>=20
> Maybe also change the subject. We do more than just unpack.
>=20

The name is not about unpack, it's about the unpack facility



--dKQ0iUVUPZqdljKplixUi7LyocEMBuRMz--

--q8D4G5aOCQ16xzKt8FjTvZd3PzXk1IhOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5T3N8ACgkQ41TmuOI4
ufjCPQ//bCqK6LPDsVkv/NfdYyAJjE3jNOVAwIKhky9kEwEN8xoqjnwRtvHtf3r/
y/yChj4yThvKeVZ7eDPG/SGYp55CldzIQFOsCLPHpRog6IZhJhl6rejEjE8+L15q
+bRrT+nqwPs/NyudgOemfjFweEyLo5U+oMVgT1cLL/G4GMIevHj2JS034fpDSLMu
1ARfhJnda3IhSCkSoHIJAFPL7JEKjc10wAZJnxl7A3gxlAHZTwoXQtZ6pKn+SYDc
3yGbSW3g6XYB0a2Ae0b4n17F9Qx83guMDMYyBJTLMAXfyJlSekrcfbxxyob60qNp
cM/ZdkGxlpLd3eQ78knIRgwbqCnUKrOmOibZPuiFPlfSKCtu0CQL9ooOsZ6YEaJN
vhnqHfTtizYr7xG2HZZgWi+FkEaFDPYImMVF+iQaAnhiGIuDKTQYE1me6vSCN3ME
XoXm6cCk1HhSBETxhQzCK9LDKBOtpYrcXBNflg60HaboDM72Kqebk/hlLEH6PLys
SOx6uMSWUMhIZGFksf+R0P9Id9etk4kdRgNqrDdyshm83rjHW7R+kzDHe9NUg2Mj
wpq0GKGyLEJNi//zVfFoFtBfeQO+1ddimRSsSDhY9AV1AoOgFISJzhJc1CXtFdjx
jJpejtl2/0Z2kUSCnug2XjJET/L9oaTmgjRTlm+/m1NwfOnm7qw=
=MAaS
-----END PGP SIGNATURE-----

--q8D4G5aOCQ16xzKt8FjTvZd3PzXk1IhOJ--


