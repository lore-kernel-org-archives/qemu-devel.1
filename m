Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA300C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D52072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAD9r-0002Ma-NH
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jAD97-0001KC-Io
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jAD96-0003zA-8O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:36:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62440
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jAD95-0003sB-Vw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:36:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 026DXvbv126218
 for <qemu-devel@nongnu.org>; Fri, 6 Mar 2020 08:36:07 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj6nmtyvd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 08:36:06 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 6 Mar 2020 13:36:05 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Mar 2020 13:36:03 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 026Da2EP51839226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2020 13:36:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F62A4C04E;
 Fri,  6 Mar 2020 13:36:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACBC94C046;
 Fri,  6 Mar 2020 13:36:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.37.7])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2020 13:36:01 +0000 (GMT)
Subject: Re: [PATCH v6 03/18] s390x: protvirt: Support unpack facility
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-4-frankja@linux.ibm.com>
 <41dabcca-2840-7420-5a46-bd9e6e575f12@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 6 Mar 2020 14:36:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <41dabcca-2840-7420-5a46-bd9e6e575f12@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3o34VW6mEocGbYygijrEzJaFi1LUOL9ow"
X-TM-AS-GCONF: 00
x-cbid: 20030613-4275-0000-0000-000003A8FBD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030613-4276-0000-0000-000038BE0E88
Message-Id: <6b523699-9ce7-803c-409b-797bb51232c2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-06_04:2020-03-06,
 2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060098
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3o34VW6mEocGbYygijrEzJaFi1LUOL9ow
Content-Type: multipart/mixed; boundary="TWFzByA1bz8907tsFG5vNDhEmck7aL2zJ"

--TWFzByA1bz8907tsFG5vNDhEmck7aL2zJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/6/20 12:48 PM, Christian Borntraeger wrote:
>=20
>=20
> On 04.03.20 12:42, Janosch Frank wrote:
> [...]
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 3dd396e870..69b1cc5dfc 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -37,6 +37,8 @@
>>  #include "sysemu/hw_accel.h"
>>  #include "hw/qdev-properties.h"
>>  #ifndef CONFIG_USER_ONLY
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "hw/s390x/pv.h"
>>  #include "hw/boards.h"
>>  #include "sysemu/arch_init.h"
>>  #include "sysemu/sysemu.h"
>> @@ -191,6 +193,7 @@ static void s390_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>> =20
>>  #if !defined(CONFIG_USER_ONLY)
>>      MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    S390CcwMachineState *ccw =3D S390_CCW_MACHINE(ms);
>>      unsigned int max_cpus =3D ms->smp.max_cpus;
>>      if (cpu->env.core_id >=3D max_cpus) {
>>          error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
>=20
> I messed this up and this can break for the none machine.
>=20
> Something like this on top:

Christian and I found out that we also need to fence CONFIG_USER_ONLY,
so machine_is_pv is now in an ifdef and I squashed the changes into the
support unpack facility patch.

CI is now happy again ;-)


>=20
>=20
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 7840e784f1..1b42b0fa25 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -181,6 +181,18 @@ static void s390_cpu_disas_set_info(CPUState *cpu,=
 disassemble_info *info)
>      info->print_insn =3D print_insn_s390;
>  }
> =20
> +static bool machine_is_pv(MachineState *ms)
> +{
> +    Object *obj;
> +
> +    /* we have to bail out for the "none" machine */
> +    obj =3D object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
> +     if (!obj) {
> +        return false;
> +    }
> +    return S390_CCW_MACHINE(obj)->pv;
> +}
> +
>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> @@ -198,7 +210,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> -    S390CcwMachineState *ccw =3D S390_CCW_MACHINE(ms);
>      unsigned int max_cpus =3D ms->smp.max_cpus;
>      if (cpu->env.core_id >=3D max_cpus) {
>          error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
> @@ -213,7 +224,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          goto out;
>      }
> =20
> -    cpu->env.pv =3D ccw->pv;
> +    cpu->env.pv =3D machine_is_pv(ms);
>      /* sync cs->cpu_index and env->core_id. The latter is needed for T=
CG. */
>      cs->cpu_index =3D cpu->env.core_id;
>  #endif
>=20
>=20



--TWFzByA1bz8907tsFG5vNDhEmck7aL2zJ--

--3o34VW6mEocGbYygijrEzJaFi1LUOL9ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5iUcEACgkQ41TmuOI4
ufjUmxAAiLucU7JMmU9coeNlzW+97FGe2J/IUW3bCkBB2IlIVB47I4/KXFn0Gv+r
rt7PIq0w0GVRg8mEumiVfJaT4TEQY7KX4E9TpX8FUg28BwIYlL9yS6RlTzOmVoHU
gkPDilyjWjOKGuO7MD6ThyJQbVASNHYm1Q1BRm5z5uzRgHjphVNE5JUSiAvf+LVO
SOPHWI0lBPhPh9t/y5thUsqNH3kxv7dbeUXzsvQoZMmDQ3E4aHKBKlZYOayd9sfc
7f3cHFmu1FsFB3lf5uoSivyQbWapqrWnSS6seWIdTiNGIv1ZcnNF/TVTgRq+id4o
CXM4CjuF2AhBkMBdJ8rrUDnnVes5ajVFv5mpOlpeNvVMLPfDn+O56wkYqDgSYs15
HgUdUa2+SH5PPxEDB3kvXjuMqkaGR09hB9Xdt2FsMyZ5NoDx1fWWMQHP1t0Qa5jt
wCYEFAW2+h79J0XrQBsHPUL6bQ03ijkZVwgo2ab+g3gSUT9UMmROSebXo3qKbEBn
A1riZaq3OZG6/nu8Jk5A6aREJs0wLeq5pr8YPrLnXZIA1fkt0IZMI/zHbY2Fv3p0
4vWqoJEdCByctc3KXgfzJTPBdMC/+xPJjE00KTANQ0AsAFnpritGIkHnRAa71s9V
mFLs0P3Php42Qtjv6lyzcyv1BPbPh1CeT//+wq8ZzPVpbcZ46eo=
=SVBN
-----END PGP SIGNATURE-----

--3o34VW6mEocGbYygijrEzJaFi1LUOL9ow--


