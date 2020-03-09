Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233DC18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12872464B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12872464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBL6x-0005W9-1q
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBKuJ-0000N2-GR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBKuH-0006j1-2l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:05:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21210
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBKuG-0006ip-Ru
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:05:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029FpWnW124380
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 12:05:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ynra323a2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 12:05:27 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 16:05:26 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 16:05:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 029G4Nsa22413568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 16:04:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAECA42042;
 Mon,  9 Mar 2020 16:05:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B03084203F;
 Mon,  9 Mar 2020 16:05:22 +0000 (GMT)
Received: from dyn-9-152-224-87.boeblingen.de.ibm.com (unknown [9.152.224.87])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 16:05:22 +0000 (GMT)
Subject: Re: [PATCH v7 08/15] s390x: protvirt: SCLP interpretation
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-9-frankja@linux.ibm.com>
 <6b57a6b8-f864-c5f6-f53f-1ac09e95e271@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 9 Mar 2020 17:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6b57a6b8-f864-c5f6-f53f-1ac09e95e271@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aFvvOvhPsYdUevY2I1sO0GG19KCqYkgH2"
X-TM-AS-GCONF: 00
x-cbid: 20030916-4275-0000-0000-000003A9E19D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030916-4276-0000-0000-000038BEF8C0
Message-Id: <22482097-5701-2b58-df84-5843e3c97030@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_06:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=3 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090106
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aFvvOvhPsYdUevY2I1sO0GG19KCqYkgH2
Content-Type: multipart/mixed; boundary="cBbaiDQWpRck91gkjHdhwi9gvNMUiwgj6"

--cBbaiDQWpRck91gkjHdhwi9gvNMUiwgj6
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/9/20 4:27 PM, David Hildenbrand wrote:
> On 09.03.20 12:21, Janosch Frank wrote:
>> SCLP for a protected guest is done over the SIDAD, so we need to use
>> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
>> memory when reading/writing SCBs.
>>
>> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
>> since the function that injects the sclp external interrupt would
>> reject a zero sccb address.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c         | 28 ++++++++++++++++++++++++++++
>>  include/hw/s390x/sclp.h |  2 ++
>>  target/s390x/kvm.c      | 21 ++++++++++++++++-----
>>  3 files changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index af0bfbc2ec..b4bc2dd659 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -193,6 +193,34 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *=
sccb, uint32_t code)
>>      }
>>  }
>> =20
>> +/*
>> +* We only need the address to have something valid for the
>> +* service_interrupt call.
>> +*/
>> +#define SCLP_PV_DUMMY_ADDR 0x4000
>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>> +                                uint32_t code)
>> +{
>> +    SCLPDevice *sclp =3D get_sclp_device();
>> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>> +    SCCB work_sccb;
>> +    hwaddr sccb_len =3D sizeof(SCCB);
>> +
>> +    /*
>> +     * Only a very limited amount of calls is permitted by the
>> +     * Ultravisor and we support all of them, so we don't check for
>> +     * them. All other specification exceptions are also interpreted
>> +     * by the Ultravisor and hence never cause an exit we need to
>> +     * handle.
>> +     */
>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>> +    sclp_c->execute(sclp, &work_sccb, code);
>> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>> +                          be16_to_cpu(work_sccb.h.length));
>> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>> +    return 0;
>> +}
>> +
>>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t cod=
e)
>>  {
>>      SCLPDevice *sclp =3D get_sclp_device();
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index c54413b78c..c0a3faa37d 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>>  void sclp_service_interrupt(uint32_t sccb);
>>  void raise_irq_cpu_hotplug(void);
>>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t cod=
e);
>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>> +                                uint32_t code);
>> =20
>>  #endif
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 295ed12a38..5c7757ac28 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1226,12 +1226,23 @@ static void kvm_sclp_service_call(S390CPU *cpu=
, struct kvm_run *run,
>>      sccb =3D env->regs[ipbh0 & 0xf];
>>      code =3D env->regs[(ipbh0 & 0xf0) >> 4];
>> =20
>> -    r =3D sclp_service_call(env, sccb, code);
>> -    if (r < 0) {
>> -        kvm_s390_program_interrupt(cpu, -r);
>> -        return;
>> +    switch (run->s390_sieic.icptcode) {
>> +    case ICPT_PV_INSTR_NOTIFICATION:
>> +        /* The notification intercepts are currently handled by KVM *=
/
>> +        fprintf(stderr, "unexpected SCLP PV notification\n");
>=20
> Maybe g_assert(env->pv);
>=20
> error_report() ?

Sure, I just followed suit with the other aborts in this file.

>=20
>> +        exit(1);
>> +        break;
>> +    case ICPT_PV_INSTR:
>> +        sclp_service_call_protected(env, sccb, code);
>> +        break;
>> +    case ICPT_INSTRUCTION:
>=20
> Maybe g_assert(!env->pv);
>=20
>> +        r =3D sclp_service_call(env, sccb, code);
>> +        if (r < 0) {
>> +            kvm_s390_program_interrupt(cpu, -r);
>> +            return;
>> +        }
>> +        setcc(cpu, r);
>>      }
>> -    setcc(cpu, r);
>=20
> What about the cc in case of ICPT_PV_INSTR?

Set to 0 by the Ultravisor/SIE

>=20
>>  }
>> =20
>>  static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)=

>>
>=20
>=20



--cBbaiDQWpRck91gkjHdhwi9gvNMUiwgj6--

--aFvvOvhPsYdUevY2I1sO0GG19KCqYkgH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5maUIACgkQ41TmuOI4
ufhQnxAAkttGw9bWNHItLT0lB8Ls/9E4cQdYw9ghZGa0/XmWy6ampRoo00sBiqSG
Ek/qY7c0moJaFP7PTbZT7c+pt45JxTRyF/gVXXhsllpYn0EMwH4LZYXilUGOo53s
Jz4LNnmk4nS8rdG+6le2Hl9Rv+AS+mbrPFMbsN1p4cQjAKh+0o1/DITBtjV92n1a
Ek0ixUwdpm1DAVXsACA30LGciIYaJTj6G/TUtEYrNeYPDYQyhwUMn0EmrqOv2wJ6
ZkGjrgOF0siwo4IIc9KoXo6aD5w/AzgMwGX7EBPJ3zZEnrhXTifdV8ibRypFYm3k
ZCnQ+RHLuwLUewtFoGLPTr+F/a3unaprUR89gBXNdrRdzsO8Y4yzs7YSC/jpqHSJ
YDPT1zQT4Rm3pPxAWvMgS3dpnAUC1bm119f7FA12UiunbNpBTFvZYb43MRtP+wkt
RR1TIsJ418LHtwL+KqM+iMTR3+26kHX+gBU8+lSod7COZXynTDFZMR7jE98C43iT
RGeWnOaTIjenk3Y187n+RXC/UXtycXmu+5R34J287kvNZHfvy3Kz6+CoB9aRZpAZ
czrhoYD3tGN1S1iIVDT2IoZuzufxcAuy2z78FOmwvIzuAX/q0waxSjPKD9VCsnIF
FN56UQUISCK4N73H7opul2l2zELr45NiK7ameKFa0t3MEUWd7/M=
=8ds7
-----END PGP SIGNATURE-----

--aFvvOvhPsYdUevY2I1sO0GG19KCqYkgH2--


