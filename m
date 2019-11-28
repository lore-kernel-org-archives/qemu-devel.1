Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E36C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AFA215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AFA215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaE9D-0006dB-KG
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaE86-0006Ck-JE
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaE85-0000et-45
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:22:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaE84-0000aC-R2
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:22:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAS7Lnv0025634
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:22:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whmt0b5a9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:22:18 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 28 Nov 2019 07:22:16 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 07:22:14 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAS7LXR249807760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 07:21:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A9974C052;
 Thu, 28 Nov 2019 07:22:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B01A4C04A;
 Thu, 28 Nov 2019 07:22:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.157.187])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 07:22:12 +0000 (GMT)
Subject: Re: [PATCH v4 3/6] s390x: Move initial reset
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-4-frankja@linux.ibm.com>
 <a49ea81f-7275-3d4b-a1e5-5f8c666ea127@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Date: Thu, 28 Nov 2019 08:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a49ea81f-7275-3d4b-a1e5-5f8c666ea127@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uEyp2E07IOs2KtWzywTbCbY8qV9SC8EoB"
X-TM-AS-GCONF: 00
x-cbid: 19112807-0028-0000-0000-000003C0FC92
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112807-0029-0000-0000-000024840608
Message-Id: <f6fa8125-716f-24e0-46a0-c39d0832e21f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-27,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280061
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uEyp2E07IOs2KtWzywTbCbY8qV9SC8EoB
Content-Type: multipart/mixed; boundary="pjZZmnyZiKtUXDYbbrPomTmHSvSTNoWqy"

--pjZZmnyZiKtUXDYbbrPomTmHSvSTNoWqy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/28/19 8:00 AM, Thomas Huth wrote:
> On 27/11/2019 18.50, Janosch Frank wrote:
>> Let's move the intial reset into the reset handler and cleanup
>> afterwards.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>   target/s390x/cpu-qom.h |  2 +-
>>   target/s390x/cpu.c     | 44 ++++++++++++++++------------------------=
--
>>   target/s390x/cpu.h     |  2 +-
>>   target/s390x/sigp.c    |  2 +-
>>   4 files changed, 20 insertions(+), 30 deletions(-)
>>
>> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
>> index f3b71bac67..6f0a12042e 100644
>> --- a/target/s390x/cpu-qom.h
>> +++ b/target/s390x/cpu-qom.h
>> @@ -36,6 +36,7 @@ typedef struct S390CPUDef S390CPUDef;
>>  =20
>>   typedef enum cpu_reset_type {
>>       S390_CPU_RESET_NORMAL,
>> +    S390_CPU_RESET_INITIAL,
>>   } cpu_reset_type;
>>  =20
>>   /**
>> @@ -62,7 +63,6 @@ typedef struct S390CPUClass {
>>       void (*parent_reset)(CPUState *cpu);
>>       void (*load_normal)(CPUState *cpu);
>>       void (*reset)(CPUState *cpu, cpu_reset_type type);
>> -    void (*initial_cpu_reset)(CPUState *cpu);
>>   } S390CPUClass;
>>  =20
>>   typedef struct S390CPU S390CPU;
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 67d6fbfa44..55e2d1fe7b 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -94,6 +94,23 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_t=
ype type)
>>       s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>>  =20
>>       switch (type) {
>> +    case S390_CPU_RESET_INITIAL:
>> +        /* initial reset does not clear everything! */
>> +        memset(&env->start_initial_reset_fields, 0,
>> +               offsetof(CPUS390XState, end_reset_fields) -
>> +               offsetof(CPUS390XState, start_initial_reset_fields));
>> +
>> +        /* architectured initial value for Breaking-Event-Address reg=
ister */
>> +        env->gbea =3D 1;
>> +
>> +        /* architectured initial values for CR 0 and 14 */
>> +        env->cregs[0] =3D CR0_RESET;
>> +        env->cregs[14] =3D CR14_RESET;
>> +
>> +        /* tininess for underflow is detected before rounding */
>> +        set_float_detect_tininess(float_tininess_before_rounding,
>> +                                  &env->fpu_status);
>> +       /* fall through */
>>       case S390_CPU_RESET_NORMAL:
>>           env->pfault_token =3D -1UL;
>>           env->bpbc =3D false;
>> @@ -101,32 +118,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
>>       default:
>>           g_assert_not_reached();
>>       }
>> -}
>> -
>> -/* S390CPUClass::initial_reset() */
>> -static void s390_cpu_initial_reset(CPUState *s)
>> -{
>> -    S390CPU *cpu =3D S390_CPU(s);
>> -    CPUS390XState *env =3D &cpu->env;
>> -
>> -    s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
>> -    /* initial reset does not clear everything! */
>> -    memset(&env->start_initial_reset_fields, 0,
>> -        offsetof(CPUS390XState, end_reset_fields) -
>> -        offsetof(CPUS390XState, start_initial_reset_fields));
>> -
>> -    /* architectured initial values for CR 0 and 14 */
>> -    env->cregs[0] =3D CR0_RESET;
>> -    env->cregs[14] =3D CR14_RESET;
>> -
>> -    /* architectured initial value for Breaking-Event-Address registe=
r */
>> -    env->gbea =3D 1;
>> -
>> -    env->pfault_token =3D -1UL;
>> -
>> -    /* tininess for underflow is detected before rounding */
>> -    set_float_detect_tininess(float_tininess_before_rounding,
>> -                              &env->fpu_status);
>>  =20
>>       /* Reset state inside the kernel that we cannot access yet from =
QEMU. */
>>       if (kvm_enabled()) {
>=20
> You're doing the if (kvm_enabled()) now also for S390_CPU_RESET_NORMAL =

> ... is that OK? It's doing an KVM_S390_INITIAL_RESET ioctl(), so that=20
> sounds suspicious to me. Don't you have to add a check for type !=3D=20
> S390_CPU_RESET_NORMAL here?
>=20
>   Thomas

Yes, I need to fence the NORMAL case again.

>=20
>=20



--pjZZmnyZiKtUXDYbbrPomTmHSvSTNoWqy--

--uEyp2E07IOs2KtWzywTbCbY8qV9SC8EoB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3fdaMACgkQ41TmuOI4
ufjPORAAuEY6hvXMH2jqhhWT5JqhUcsjI3zxmArNvQTJsmHxqY/dQTl9oF+V+kgC
xA/MvMXDNlLRVvY7znWGroOjHGGVP/yGqaohJ2ho4a1hz0i/J0oYrMpaRmptEmKR
quvFLC6/toY2eKTkgqwQjRse2vFsg4HDOFSdm4tYSLZGoPtLPKd9iuBSzHVtTSXY
aCVsclAbl+zLL5jtflhYXNj9E7Mwdxmj1CwdOVPvpZDkEhhIVeWW6lxh/TAzKi06
bcpxdJz6LeJREp7Qdw8p5AGAFtr2NyFelq94LUoSFjllfeSMu3xvfG6aQHKpMSsI
D//Z0HgR+LOsszd5fzN0UfkooIptN5oyG42mBhYKfZ+s44oylXrCbHKJjwCIQqWj
k7YUH4kqDhMlTrUSXJ5WI9UqaNlJ15c5wL4ICO8T6mGX8/xDhStk7VQB3TZim8RV
+bn8l1g7cQBpjiG1DnN6dOStumNrezT4ar+6YVUb7jBGk/ku7IBB04l6Vp0VtkpX
N6kojunjSK01QPalKcgsHZNEXfMK5l/M2PMS2DTZ9KZ0mWdfelNitz6QMHwB4CDs
P0veI4uTza7496bXPLaTizjN7tpiUqxK/lpctfJ3Sbhv8br/7E4nxbceC73mjaWo
m2a1xwaoTw+/Om6UBBRFTaEd37TFHkrcK/2q6PA6Pwvpb6ITQ58=
=sgMQ
-----END PGP SIGNATURE-----

--uEyp2E07IOs2KtWzywTbCbY8qV9SC8EoB--


