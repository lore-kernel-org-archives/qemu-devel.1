Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D28C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE952071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE952071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4k2g-0002eF-Kf
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4k1r-00027U-Ks
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4k1q-0001RS-CL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:30:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4k1p-0001Q7-UF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:30:02 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KBTvMW014261
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:30:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubx475w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:29:58 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 11:29:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 11:29:25 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01KBTOM054984954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 11:29:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCBBCA405B;
 Thu, 20 Feb 2020 11:29:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 882D8A4054;
 Thu, 20 Feb 2020 11:29:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 11:29:24 +0000 (GMT)
Subject: Re: [PATCH v3 13/17] s390x: protvirt: Move diag 308 data over SIDAD
To: Cornelia Huck <cohuck@redhat.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-14-frankja@linux.ibm.com>
 <20200220120052.7691f6f8.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 20 Feb 2020 12:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200220120052.7691f6f8.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oCrK6YUVKF31QAcb0Kr5xzFqNjG8nza9E"
X-TM-AS-GCONF: 00
x-cbid: 20022011-0012-0000-0000-0000038894CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022011-0013-0000-0000-000021C52B48
Message-Id: <f6a00841-e617-a090-9606-d4a86c16396c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200086
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCrK6YUVKF31QAcb0Kr5xzFqNjG8nza9E
Content-Type: multipart/mixed; boundary="1qy9tE2njeaQnGnSU8Cvd6b4UmWeQAsqo"

--1qy9tE2njeaQnGnSU8Cvd6b4UmWeQAsqo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 12:00 PM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 10:16:32 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> For protected guests the IPIB is written/read to/from the satellite
>> block, so we need to make those accesses virtual to make them go
>> through KVM mem ops.

=2E.we need those accesses to go through s390_cpu_pv_mem_read/write() so
we use the memop IOCTL to access the sattelite block.

>=20
> Confused. What does 'make those accesses virtual' mean?

I need to update the patch description.
Virtual memory access was needed when I overloaded the normal memops to
access the SIDA. Real access would have accessed guest memory directly
which results in a guest crash for protected VMs.

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/diag.c | 32 +++++++++++++++++++++++++-------
>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 6aaeef6029..59ae122e82 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -88,6 +88,7 @@ static int diag308_parm_check(CPUS390XState *env, ui=
nt64_t r1, uint64_t addr,
>>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, ui=
ntptr_t ra)
>>  {
>>      CPUState *cs =3D env_cpu(env);
>> +    S390CPU *cpu =3D S390_CPU(cs);
>>      uint64_t addr =3D  env->regs[r1];
>>      uint64_t subcode =3D env->regs[r3];
>>      IplParameterBlock *iplb;
>> @@ -118,14 +119,24 @@ void handle_diag_308(CPUS390XState *env, uint64_=
t r1, uint64_t r3, uintptr_t ra)
>>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>>              return;
>>          }
>> +
>=20
> Whitespace.

Ack.

>=20
>>          iplb =3D g_new0(IplParameterBlock, 1);
>> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
>> +        if (!env->pv) {
>> +            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
>> +        } else {
>> +            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
>> +        }
>> +
>>          if (!iplb_valid_len(iplb)) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>>              goto out;
>>          }
>> =20
>> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));=

>> +        if (!env->pv) {
>> +            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->le=
n));
>> +        } else {
>> +            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len)=
);
>> +        }
>> =20
>>          if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
>>              !(iplb_valid_pv(iplb) && s390_ipl_pv_check_components(ipl=
b) >=3D 0)) {
>> @@ -137,23 +148,30 @@ void handle_diag_308(CPUS390XState *env, uint64_=
t r1, uint64_t r3, uintptr_t ra)
>>          env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>  out:
>>          g_free(iplb);
>> -        return;
>> +        break;
>>      case DIAG308_STORE:
>>      case DIAG308_PV_STORE:
>>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>>              return;
>>          }
>> +
>=20
> Whitespace.

Ack.

>=20
>>          if (subcode =3D=3D DIAG308_PV_STORE) {
>>              iplb =3D s390_ipl_get_iplb_secure();
>>          } else {
>>              iplb =3D s390_ipl_get_iplb();
>>          }
>> -        if (iplb) {
>> -            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>> -            env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>> -        } else {
>> +        if (!iplb) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>> +            return;
>>          }
>> +
>> +        if (!env->pv) {
>> +            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>> +        } else {
>> +            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len=
));
>> +        }
>> +
>> +        env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>          break;
>>      case DIAG308_PV_START:
>>          iplb =3D s390_ipl_get_iplb_secure();
>=20
>=20



--1qy9tE2njeaQnGnSU8Cvd6b4UmWeQAsqo--

--oCrK6YUVKF31QAcb0Kr5xzFqNjG8nza9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5ObZQACgkQ41TmuOI4
ufhHJhAAwZLk5H3egU/MsIZFnoTKlpwEcnrB3swxToET6MmEiOz4P/6UbopdGWJ+
649S8Z/cKbLmGBAphaPve2eworkBQ+HQrzASNLtJ7aSXzQEahrP5GUseOUchxrZp
joDeui34S4aHSm+DyEK3S45V+waW7zE0/q4OMt/boJvjZnlPehfWdat/jBonS4Ys
j8Cwg0xB3jg0kzbWPeXVibb7KQk37jGJwCfe2kyDU2sLakMct8069xlfBu/4tP03
VzBXDbHSOwhRVhp631RPYnWgVjWjH5Zn19rhVsuHUkGC5NjY6874PFVpXNJS3tm1
SCuc3BxbxzxJmCCdTTRawFn21M1b34VQWEq6hNaOmgIW9uZy2bsMcSl55wX2uBX9
gmntFtgWsrmxLf4nDFsExs0XHwi0wDrptQ7I3F1bHwvKta12APCrL5IBCWwLUlzh
aCSUd4jO0Ldaks51R2oTArm1MksW54Asu5PuTdG4FM38ysV5TzfiBqHDJ86IuMQr
iexsm2YuA7eEo1DgBCyqj7V/3umqkvy1DpsGDW0MHOuDNQJqzWREjQTLqlC3H79b
/OSPzP35oH5F55CB9V3HB73+2te6v/78Xff0rWMLjAopwzNc8O03UBa97LBCsnnN
HXIQUm9xWtlOglJejpvzVXMqPxBymzsRFqBtea7gFjh9kQd55cA=
=eSRw
-----END PGP SIGNATURE-----

--oCrK6YUVKF31QAcb0Kr5xzFqNjG8nza9E--


