Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B6CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63542068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63542068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCLM-0003T8-2N
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iYCCA-0000l8-5b
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iYCC8-0006il-S8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:54:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43014
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iYCC8-0006iT-LX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:54:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMGqcFd082357
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 11:54:07 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdfxvptp3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 11:54:06 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 22 Nov 2019 16:54:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 16:54:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAMGs0SC51642374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 16:54:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 810A311C052;
 Fri, 22 Nov 2019 16:54:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C17811C04C;
 Fri, 22 Nov 2019 16:54:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.73.27])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Nov 2019 16:53:59 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] s390x: Move clear reset
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191122140002.42972-1-frankja@linux.ibm.com>
 <20191122140002.42972-5-frankja@linux.ibm.com>
 <13192666-7c97-f3fd-fa8d-84a037dae286@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 22 Nov 2019 17:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <13192666-7c97-f3fd-fa8d-84a037dae286@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aEK1HGmmi7sZtHIyC7JqMvYZ5CGKRpDNE"
X-TM-AS-GCONF: 00
x-cbid: 19112216-4275-0000-0000-00000384FA36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112216-4276-0000-0000-000038987C14
Message-Id: <031245df-971d-e75b-140f-42f22b7ad451@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220145
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEK1HGmmi7sZtHIyC7JqMvYZ5CGKRpDNE
Content-Type: multipart/mixed; boundary="d4vUGYoVlYOCEG4RpFbpiVdls66pyh4kO"

--d4vUGYoVlYOCEG4RpFbpiVdls66pyh4kO
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/22/19 3:30 PM, David Hildenbrand wrote:
> On 22.11.19 15:00, Janosch Frank wrote:
>> Let's also move the clear reset function into the reset handler.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/cpu-qom.h |  1 +
>>  target/s390x/cpu.c     | 50 ++++++++---------------------------------=
-
>>  2 files changed, 10 insertions(+), 41 deletions(-)
>>
>> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
>> index 6f0a12042e..dbe5346ec9 100644
>> --- a/target/s390x/cpu-qom.h
>> +++ b/target/s390x/cpu-qom.h
>> @@ -37,6 +37,7 @@ typedef struct S390CPUDef S390CPUDef;
>>  typedef enum cpu_reset_type {
>>      S390_CPU_RESET_NORMAL,
>>      S390_CPU_RESET_INITIAL,
>> +    S390_CPU_RESET_CLEAR,
>>  } cpu_reset_type;
>> =20
>>  /**
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 1f423fb676..017181fe4a 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -94,6 +94,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_ty=
pe type)
>>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>> =20
>>      switch (type) {
>> +    case S390_CPU_RESET_CLEAR:
>> +        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fi=
elds));
>=20
> I think the preferred term in QEMU is "fall through".
>=20
>> +        /* Fallthrough */
>>      case S390_CPU_RESET_INITIAL:
>>          /* initial reset does not clear everything! */
>>          memset(&env->start_initial_reset_fields, 0,
>> @@ -121,46 +124,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
>>      }
>>  }
>> =20
>> -/* CPUClass:reset() */
>> -static void s390_cpu_full_reset(CPUState *s)
>> -{
>> -    S390CPU *cpu =3D S390_CPU(s);
>> -    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>> -    CPUS390XState *env =3D &cpu->env;
>> -
>> -    scc->parent_reset(s);
>> -    cpu->env.sigp_order =3D 0;
>> -    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>> -
>> -    memset(env, 0, offsetof(CPUS390XState, end_reset_fields));
>> -
>> -    /* architectured initial values for CR 0 and 14 */
>> -    env->cregs[0] =3D CR0_RESET;
>> -    env->cregs[14] =3D CR14_RESET;
>> -
>> -#if defined(CONFIG_USER_ONLY)
>> -    /* user mode should always be allowed to use the full FPU */
>> -    env->cregs[0] |=3D CR0_AFP;
>> -    if (s390_has_feat(S390_FEAT_VECTOR)) {
>> -        env->cregs[0] |=3D CR0_VECTOR;
>> -    }
>> -#endif
>=20
> Huh, what happened to that change?

Seems like I missed it

>=20
> Note that we now also do "env->bpbc =3D false" - is that ok?

That's ok, clear and initial reset do a memset to bpbc, but as reset
normal doesn't we need to set it explicitly.



--d4vUGYoVlYOCEG4RpFbpiVdls66pyh4kO--

--aEK1HGmmi7sZtHIyC7JqMvYZ5CGKRpDNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3YEqcACgkQ41TmuOI4
ufiaFRAAvqGi28df/RooaW14w/y/eGukPKgkybkKfBTTUez/EPvem4n64PRBhGCC
jzirz9vcIVM5S2XC0lSjofBr6v+xIEs1hcnLJ6g5w5YvWIy/r9SmKcj4YFMOZYN+
+bcyPgRCoNTiMm80sbBVlijCyqWxvlA8jciNOFrfMIAZTvF7HcCFPnk0W/7GFAuZ
BeXaOssMheqfUhfVzP9q1eUxLcQlxY7iYK0tvKl1LsunlMDn1ocjMe82u9werOCH
qYZ3KJ1/TiNMGPRRteg4wYZ9rx4oNE3Sgoqc2JZZuEkgPE9Cs8EONzvBj5tzJlOP
/rOAoWgSdjbMzfaBndGd1FyasEobl839cCY79dz3TOj4qe3cfxIhjSVTISzV1i2I
ZBPNFJosO7YjvJVqct68QIbF1SQTLvzPoXDNdkucr8K157XRUF7AbL0bHhsbxtTJ
WjggnB4fAzkN7oDnpH9T+oLYvbYSQnfVx0Qbdx4aljmotLjM2ennHG+jCj7Cvhr5
EhjF5dMfeeGwRySGprrb+p9XTo6x5iBWkghCYQp8e2Q/qThv15s1Sk/lr265Bs1B
KJb/zwN5WF57f6BnqlvA37DE8SsOrRFCcdvXlq2VubjUUYUi412JIkb57pGr/644
M199F9m41jFoRofiEYUNFg8OZmzkqCQSljy/iWnoWkF+ygS9NOk=
=8F3P
-----END PGP SIGNATURE-----

--aEK1HGmmi7sZtHIyC7JqMvYZ5CGKRpDNE--


