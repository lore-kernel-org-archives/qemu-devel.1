Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CF720870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CF720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mnR-0000Nq-JF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mmh-0008EX-5V
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mmg-0005Iq-2y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:27:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9mmf-0005HR-Pr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:27:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0259KmRA077844
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 04:27:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q26dsw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:27:12 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 09:27:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 09:27:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0259R6UL23724202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 09:27:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D7854204B;
 Thu,  5 Mar 2020 09:27:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AAA542041;
 Thu,  5 Mar 2020 09:27:06 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 09:27:06 +0000 (GMT)
Subject: Re: [PATCH v6 09/18] s390x: protvirt: Move STSI data over SIDAD
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-10-frankja@linux.ibm.com>
 <c0ff7502-7867-8190-3e13-4cb63460f278@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 10:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c0ff7502-7867-8190-3e13-4cb63460f278@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2nCxLBhukzDucmtmDrjVY1oXzBN996g8x"
X-TM-AS-GCONF: 00
x-cbid: 20030509-0016-0000-0000-000002ED6166
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030509-0017-0000-0000-00003350B42F
Message-Id: <f785a6e0-1323-77a6-34d6-9b97b5de98f1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_02:2020-03-04,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=3 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050059
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nCxLBhukzDucmtmDrjVY1oXzBN996g8x
Content-Type: multipart/mixed; boundary="g8jngkCcOPNmYJV7jM6stCuA1i44pbhor"

--g8jngkCcOPNmYJV7jM6stCuA1i44pbhor
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 6:43 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> For protected guests, we need to put the STSI emulation results into
>> the SIDA, so SIE will write them into the guest at the next entry.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/kvm.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index cdcd538b4f..43fc0c088b 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1797,11 +1797,16 @@ static int handle_tsch(S390CPU *cpu)
>> =20
>>  static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
>>  {
>> +    CPUS390XState *env =3D &cpu->env;
>>      SysIB_322 sysib;
>>      int del;
>> =20
>> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib)))=
 {
>> -        return;
>> +    if (env->pv) {
>> +        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));
>> +    } else {
>=20
> else if please (not sure if I mentioned that already)

Ack

>=20
>> +        if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysi=
b))) {
>> +            return;
>=20
> With that, you can convert the ack to a
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!



--g8jngkCcOPNmYJV7jM6stCuA1i44pbhor--

--2nCxLBhukzDucmtmDrjVY1oXzBN996g8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5gxekACgkQ41TmuOI4
ufgnYRAAoc005yRguEacnfb8PFN5MjZXS5WhZ3wpyld8e5YJ8eLg8kR7ajlh1TI+
7YFfYCdP1WgQu/FjWlEz7Q2jIjrqbNgqe+yCQ7OcQ2SWYHSGnHv9wU9GC8i6p5jn
pk055EPDNzA470/4vemo3NSVzOVIswhRYOLR79lvd0/A0Xh9esEcZIAGecF/8CSf
5RUByYDxup0W7wBlQnvhY/GxnWGSv9r/tR8zHUQwBym08EyrOBybBazW8lz+T1g7
+9B7wR7Mz1aVGTnVYk5m6FUEclwQnIjtkHf5dvifj71e9qzkwioShOMH3wqiCZH1
cjK/mkcokD5ImyCRmyLP/HxWNSby51sblE6aH0vhHmZDgf2VgJ25uxAiPUifQB/P
tGTH/ocLdC4wvg0jEHuhDYRndR1zlxtxHUiKdE5Zk8WqUr/mO1mVZysvdESnZ7v/
lqiCZl/ZUM+ZY7XUj9z7/TO8SzMdZ91I7LIqyvjV3Va975UhRE4xwaFBaFsaC2r5
UyQ0TwPxjZDEnJG5Piu6BfVClRA57OCZE9NJTnGSEOSFCYoP4ZPqZf3Ut8us6UDY
uwrzOi1us6gV0K0mJoOpj7htbrFG9f5FI8x3pP40vXQIPTaOkCydXpEbqPHnMmMm
eNu0pI8+S2AhRdLuYls+04tbPM3dZ55pvpQkv9TFyN42CO7o57c=
=j0Ai
-----END PGP SIGNATURE-----

--2nCxLBhukzDucmtmDrjVY1oXzBN996g8x--


