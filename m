Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14261204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14261204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2AE-0005WF-7o
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ia20q-0006aW-P4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ia20o-0008Sq-R4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:26:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24294
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ia20o-0008S8-GG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:26:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xARIMYPF039834
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 13:26:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2whh5ep354-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 13:26:01 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 27 Nov 2019 18:25:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Nov 2019 18:25:56 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xARIPuUL26018046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2019 18:25:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E607E11C04C;
 Wed, 27 Nov 2019 18:25:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E00411C052;
 Wed, 27 Nov 2019 18:25:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.82.185])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Nov 2019 18:25:55 +0000 (GMT)
Subject: Re: [PATCH v4 6/6] s390x: kvm: Make kvm_sclp_service_call void
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-7-frankja@linux.ibm.com>
 <c3b81ef7-860d-8cee-df34-0c6f103a1757@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 27 Nov 2019 19:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c3b81ef7-860d-8cee-df34-0c6f103a1757@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hflbbfw09dU5EBcrJLJpLySLr1TV3vGez"
X-TM-AS-GCONF: 00
x-cbid: 19112718-0012-0000-0000-0000036D0F80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112718-0013-0000-0000-000021A8B9D4
Message-Id: <76627b69-5c0a-a9d6-f20e-f7ce61858774@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270150
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
--hflbbfw09dU5EBcrJLJpLySLr1TV3vGez
Content-Type: multipart/mixed; boundary="vdggy9D8gm8xEXsgn6ErAgPhvuZXh2N7k"

--vdggy9D8gm8xEXsgn6ErAgPhvuZXh2N7k
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/27/19 7:07 PM, David Hildenbrand wrote:
> On 27.11.19 18:50, Janosch Frank wrote:
>> It defaults to returning 0 anyway and that return value is not
>> necessary, as 0 is also the default rc that the caller would return.
>>
>> While doing that we can simplify the logic a bit and return early if
>> we inject a PGM exception. Also we always set a 0 cc, so let's not
>> base it on the rc of the sclp emulation functions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/kvm.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 0c9d14b4b1..08bb1edca0 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1159,13 +1159,13 @@ void kvm_s390_access_exception(S390CPU *cpu, u=
int16_t code, uint64_t te_code)
>>      kvm_s390_vcpu_interrupt(cpu, &irq);
>>  }
>> =20
>> -static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>> +static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>>                                   uint16_t ipbh0)
>>  {
>>      CPUS390XState *env =3D &cpu->env;
>>      uint64_t sccb;
>>      uint32_t code;
>> -    int r =3D 0;
>> +    int r;
>> =20
>>      sccb =3D env->regs[ipbh0 & 0xf];
>>      code =3D env->regs[(ipbh0 & 0xf0) >> 4];
>> @@ -1173,11 +1173,9 @@ static int kvm_sclp_service_call(S390CPU *cpu, =
struct kvm_run *run,
>>      r =3D sclp_service_call(env, sccb, code);
>>      if (r < 0) {
>>          kvm_s390_program_interrupt(cpu, -r);
>> -    } else {
>> -        setcc(cpu, r);
>> +        return;
>>      }
>> -
>> -    return 0;
>> +    setcc(cpu, 0);
>=20
> For now, sclp_service_call will return <=3D 0 ... but don't we actually=

> have the option to return a cc? What does the spec say? Always set to 0=
?
>=20
> At least also the TCG implementation sets the CC to whatever is returne=
d
> here .... and Claudio's unit tests have code to handle cc !=3D 0 ... an=
d
> the kernel as well (drivers/s390/char/sclp.h:sclp_service_call())


There's 0 (initiated), busy and operational and as far as I know we
implement neither.
sclp_service_call() returns either 0 or -PGM_CODE, so we don't need to
check when we're after the pgm injection code.



--vdggy9D8gm8xEXsgn6ErAgPhvuZXh2N7k--

--hflbbfw09dU5EBcrJLJpLySLr1TV3vGez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3ev7MACgkQ41TmuOI4
ufgXThAAvIfJoWNGMwTttYC4BqYcz1NLBpQt3A8SAtElXOXjldh4krKJH4A7n7O2
gOjToelemZneJ5wUIg2WmW+9ouR9eymuQR07tpDVjqQytbpearqrQJ4pqcFTsOC8
vdy7cW5q5FZK3al+Mh68EQ/Jq/bLvcGVCWgxENFWF/Mp8GoEWU2up7JlHgt44w/9
Bg5QTfnVAS7VhLvbzUcD60JO3AcT0v1Y+t/K9EEC06/OHg8MAHrktDKvtPIm/J9f
5XruuXjLxcOXIxlr6ciNu2V16t4YuMXyrxBr5WaRMMlgH3eHwAZVb+CXnnEdwFwB
zl1W1x2TEagGDSCF06gfAjD8h5K4ezj/uydOWupCoAjYGaaxPYGOqCXGNXDBoEZU
1tQ7Ox/9wnTgZ66I4/7mro0sftmpzlh//IVnODTNOzWaWBScuupXl51lLakWOlXE
FbuJdfMm15iAUwxVF7c/twLvc1g66Hb4Aa2FPGhjVDH7qqDqaJihpgOxm6JVL5ti
u3FXvnmqar0aeShzb+KOXUARgtGyEvDqCKdmZjRT0dd/Cav5/96Knb2kmot/c/H4
Zezt7g/1SVFm9EZWd96GtB4X+aYpTJFg5UR+a3pVQCvbHZQSUkBcl9o97wn/F18C
DgqDM9a9XSt0XBp6wFXl8EcK/ME7hQn7EhaYWmzcdwu4L3qUxgQ=
=Hvzb
-----END PGP SIGNATURE-----

--hflbbfw09dU5EBcrJLJpLySLr1TV3vGez--


