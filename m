Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B7EC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39633214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39633214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4cX-0001kn-Gu
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iS4bF-000174-Cs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iS4b6-00030X-Gg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:34:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iS4az-0002zd-2x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:34:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5JXjX2133536
 for <qemu-devel@nongnu.org>; Tue, 5 Nov 2019 14:34:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19ttue-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 14:34:26 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 5 Nov 2019 19:34:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 5 Nov 2019 19:34:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5JYKhp55115950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 19:34:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9EB74C04E;
 Tue,  5 Nov 2019 19:34:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 553E14C04A;
 Tue,  5 Nov 2019 19:34:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.10.78])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 19:34:20 +0000 (GMT)
Subject: Re: [PATCH] s390x: Properly fetch and test the short psw on diag308
 subc 0/1
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191105184434.16148-1-frankja@linux.ibm.com>
 <76ba0773-b6da-a73a-0a76-9a23f004a9b7@redhat.com>
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
Date: Tue, 5 Nov 2019 20:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <76ba0773-b6da-a73a-0a76-9a23f004a9b7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MbQ7TVbOTUvpwQgjFe9wftTCX0Vmli6Hf"
X-TM-AS-GCONF: 00
x-cbid: 19110519-4275-0000-0000-0000037B1368
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110519-4276-0000-0000-0000388E5EEF
Message-Id: <d638849d-638a-797e-a550-9e68e807e2f2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050162
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MbQ7TVbOTUvpwQgjFe9wftTCX0Vmli6Hf
Content-Type: multipart/mixed; boundary="jAp30CCyS8FQAjqaBKcbNLQI134FjzH6V"

--jAp30CCyS8FQAjqaBKcbNLQI134FjzH6V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 8:29 PM, David Hildenbrand wrote:
> On 05.11.19 19:44, Janosch Frank wrote:
>> We need to actually fetch the cpu mask and set it after checking for
>> psw bit 12 instead of completely ignoring it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   target/s390x/cpu.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 736a7903e2..0acba843a7 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -76,8 +76,15 @@ static bool s390_cpu_has_work(CPUState *cs)
>>   static void s390_cpu_load_normal(CPUState *s)
>>   {
>>       S390CPU *cpu =3D S390_CPU(s);
>> -    cpu->env.psw.addr =3D ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
>> -    cpu->env.psw.mask =3D PSW_MASK_32 | PSW_MASK_64;
>> +    uint64_t spsw =3D ldq_phys(s->as, 0);
>> +
>> +    /* Mask out bit 12 and instruction address */
>> +    cpu->env.psw.mask =3D spsw & 0xfff7ffff80000000UL;
>> +    cpu->env.psw.addr =3D spsw & 0x7fffffffUL;
>=20
> "set it after checking for psw bit 12" does not match your code.

Ok, I need to alter the commit message, see below for the reason.

>=20
>> +
>> +    if (!(spsw & 0x8000000000000UL)) {
>> +        s390_program_interrupt(&cpu->env, PGM_SPECIFICATION, 0, RA_IG=
NORED);
>> +    }
>=20
> So, this code is called from s390_machine_reset() via run_on_cpu() - so=
=20
> not from a helper. There is no state to rewind. This feels wrong to me.=

>=20
> In tcg_s390_program_interrupt(), we do
>=20
> 1. A cpu_restore_state(), which is bad with a ra of 0
> 2. A cpu_loop_exit(), which is bad, as we are not in the cpu loop.
>=20
> We *could* do here instead
>=20
> /* This code is not called from the CPU loop, but via run_on_cpu() */
> if (tcg_enabled()) {
>      /*
>       * HW injects a PGM exception with ILC 0. We won't rewind.
>       */
>      env->int_pgm_ilen =3D 2;
>      trigger_pgm_exception(&cpu->env, PGM_SPECIFICATION);
> } else {
>      kvm_s390_program_interrupt(env_archcpu(&cpu->env),
>                                 PGM_SPECIFICATION);
> }
>=20
>=20
> BUT I do wonder if we should actually get a PGM_SPECIFICATION for the=20
> *diag* instruction, not on the boot CPU. I think you should check +=20
> inject inside handle_diag_308() instead. Then that complicated handling=
=20
> is gone.
>=20

I'm not completely sure if we are allowed to do that.
I think we need to load the PSW, so we can indicate the PSW which caused
the spec exception. At least that's what lpar does and I'll need to
speak with the architecture designers to verify that we absolutely need
to do it.

I would have also preferred to just do a spec on the diag.





--jAp30CCyS8FQAjqaBKcbNLQI134FjzH6V--

--MbQ7TVbOTUvpwQgjFe9wftTCX0Vmli6Hf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3BzrsACgkQ41TmuOI4
ufju9g/+Nb64tMtmns3fqAzX071epAHOyqhYvwgR0wmafAePBI/j20mzcreBsV+U
n0VuLH1S+6MzxQFNyYKnVvSLXbgHo5ZyGXsEqV64T9eLEs/sjQN+sis/jxn8cWog
HIeW7d1dX6Hn0FI84lAGalth6SGwU6aHR2YE0eTJxqup7p7/dafeAOg9bG3wyN3z
yDQKZVUJc4rB2UhnVE69BPZ/KDHG9cAiGMHY0U3fcpyh/R180trdICUIs7jN4bL4
hhyE+7FZqJJsci0Bh8cTBqTxWdzK3r+ptm/AqN24Lo8S7GUTkbdJ26xZdAuA1CWK
j9B6CBzVe82PDXPt67sXrG7T6Y/YPkEkHVS0Gqi1aeEhzmSCaJ6TJuAIcLZ8t127
n0KGKmIJbJ7EN9gtjTJzGKqVXiUSu50JbOLctNi7BZ0HM3fYhPaG/z2icmagDoWj
TZkFUYXeNCBc7DBSgvFuOoIsNh7T6f+k7feYLCroKO4bfV53J8X1UI/OE0zDfh0Z
x7xmHGSyw9Y5wx1XeE9QunZjOF7s8X16F8iiDxWGDUuCW0IsBzksKowQ1hj/S43T
/1Qez4HgoaGUD4OeR29M1trsb8ujtb+4kOr80XIwRRiqYBTRcArAu5j2G+yS+w3I
XshhdkNVle4I3PpTct1vCkf5JWmSvGHZx/i+XVkbXk1q1N632x8=
=fJ4q
-----END PGP SIGNATURE-----

--MbQ7TVbOTUvpwQgjFe9wftTCX0Vmli6Hf--


