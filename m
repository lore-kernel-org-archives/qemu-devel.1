Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA796C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8054D206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8054D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQOc-0000fk-Ok
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQNg-0005Bq-W3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQNf-0004Dl-Nn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30754
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCQNf-0004DM-Iz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02CG60RJ009466
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:08:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqr9u050a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:06:52 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 12 Mar 2020 16:05:48 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 16:05:45 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02CG4jkR34406682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:04:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBF2452050;
 Thu, 12 Mar 2020 16:05:44 +0000 (GMT)
Received: from dyn-9-152-224-122.boeblingen.de.ibm.com (unknown
 [9.152.224.122])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 958835204E;
 Thu, 12 Mar 2020 16:05:44 +0000 (GMT)
Subject: Re: [PATCH v9 10/15] s390x: protvirt: Move diag 308 data over SIDA
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-11-frankja@linux.ibm.com>
 <8231b188-50ca-e8e8-5e5d-fc07e0dfd20d@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 12 Mar 2020 17:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8231b188-50ca-e8e8-5e5d-fc07e0dfd20d@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6bAU38SGVhtALf8t3Tc3s1W3pTOhWUsri"
X-TM-AS-GCONF: 00
x-cbid: 20031216-0028-0000-0000-000003E3B8B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031216-0029-0000-0000-000024A900D4
Message-Id: <0c8657b3-8f97-624b-1268-3cd0dbb1d36e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_09:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=3 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120083
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
--6bAU38SGVhtALf8t3Tc3s1W3pTOhWUsri
Content-Type: multipart/mixed; boundary="YtgqXKKsJlhnI1ZprZvqltQ2WJqsLY3JH"

--YtgqXKKsJlhnI1ZprZvqltQ2WJqsLY3JH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/12/20 4:17 PM, Christian Borntraeger wrote:
>=20
>=20
> On 11.03.20 14:21, Janosch Frank wrote:
>> For protected guests the IPIB is written/read to/from the SIDA, so we
>=20
> I think we need to make up our mind regarding IPLB vs. IPIB....
>=20
> Otherwise
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Shall I put that onto the list of things I need to fix in my cleanup seri=
es?

> 			=09
>> need those accesses to go through s390_cpu_pv_mem_read/write().
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/diag.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b245e557037ded06..a733485caf162111 100644
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
>> @@ -124,13 +125,22 @@ void handle_diag_308(CPUS390XState *env, uint64_=
t r1, uint64_t r3, uintptr_t ra)
>>              return;
>>          }
>>          iplb =3D g_new0(IplParameterBlock, 1);
>> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
>> +        if (!s390_is_pv()) {
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

>> +        if (!s390_is_pv()) {
>> +            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->le=
n));
>> +        } else {
>> +            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len)=
);
>> +        }
>> =20
>>          if (!iplb_valid(iplb)) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>> @@ -152,12 +162,17 @@ out:
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
>> +        if (!s390_is_pv()) {
>> +            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>> +        } else {
>> +            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len=
));
>> +        }
>> +        env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>          return;
>>      case DIAG308_PV_START:
>>          iplb =3D s390_ipl_get_iplb_pv();
>>



--YtgqXKKsJlhnI1ZprZvqltQ2WJqsLY3JH--

--6bAU38SGVhtALf8t3Tc3s1W3pTOhWUsri
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5qXdgACgkQ41TmuOI4
ufjSwBAAgyqw5CYuM/xFahknb8hjKNYjLmDj+aZ0pIvIWh+gZLMYD3qxqAMG5Z5g
aICInykGnxOEk4xC7l37xtvU8X2XiF/1AwegZzfzCMUa8tVH8Ose6kQjQ3bVlRS1
8qL+Qzayk9UWxGe2O/RGoKhz16iVBbbiz1H3QbzpwKu7taCpRPaX5N3ZcPlRoSbI
UD3o3bOUKfO1/DUFvqllAJCLvaB5mwu/UMW0hk9UB9nOtVBNbVoTgxCJ6pmpFFIv
m9qpowNMS77DQtZdC+7d7nWPS6ou3WJHPjAdEBbss1MGgibkZgj9Wb+yaHl7zj/E
s2uTXQFtM5aWmxaZnEazfobcP8fZhoOl37iypoDDLKo87XImkdJBfR3Oa56p4HS+
X72aksTdnNMRBBozYOJLlbAERHN4MaNv5GlQDPVcRaUX8e7xe28MRV4R6Ehvov9M
1ByInyoSTg5tmGkkzSkBPub5TMka89GZ4JKtVAze7chjvEiedRRIVU6I9WQxGzOB
FIseLyCEVVtWzoc0AvQK6+Aanxj/nybRRof/wyY9Dx79u9tPYuWbcNZ+5gR3I9i+
kpbOtKJwiSFeF6qh0EVsmuAyTM1/FtGwyA10QeEUXHgV8VZkI+6hpH8JYsisSHEN
GoLBFIp98mFmQHPIzGzImDanEa5X4+RmznABsWiHu/FVDashJZ0=
=V/dc
-----END PGP SIGNATURE-----

--6bAU38SGVhtALf8t3Tc3s1W3pTOhWUsri--


