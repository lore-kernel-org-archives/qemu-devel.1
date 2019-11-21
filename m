Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ACC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0EE20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkiO-0003p6-TX
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXkeB-0007HT-TK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXkeA-000303-QX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXkeA-0002zi-HA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALBRj1C019330
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:29:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdqmgvp6w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:29:13 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 11:29:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 11:29:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xALBT56x46661778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 11:29:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ECABA4060;
 Thu, 21 Nov 2019 11:29:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6AF5A405B;
 Thu, 21 Nov 2019 11:29:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 11:29:04 +0000 (GMT)
Subject: Re: [PATCH 15/15] s390x: protvirt: Handle SIGP store status correctly
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-16-frankja@linux.ibm.com>
 <92f11251-6348-0767-b6cf-d6dbed6e6fca@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 12:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <92f11251-6348-0767-b6cf-d6dbed6e6fca@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Db1jOXmY5b35wzvBbi16AKuqdRsS9ri4z"
X-TM-AS-GCONF: 00
x-cbid: 19112111-0028-0000-0000-000003BD8AE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112111-0029-0000-0000-00002480B2B4
Message-Id: <40b6b928-3b37-d5fa-b900-d0ddf8672e42@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210104
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Db1jOXmY5b35wzvBbi16AKuqdRsS9ri4z
Content-Type: multipart/mixed; boundary="dPYDsU1T0XCepjqsnG4d8KGtGh3wYiJEf"

--dPYDsU1T0XCepjqsnG4d8KGtGh3wYiJEf
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 12:24 PM, David Hildenbrand wrote:
> On 20.11.19 12:43, Janosch Frank wrote:
>> Status storing is obviously not done by qemu anymore.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   target/s390x/sigp.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
>> index 2ce22d4dc1..68634d694a 100644
>> --- a/target/s390x/sigp.c
>> +++ b/target/s390x/sigp.c
>> @@ -144,7 +144,9 @@ static void sigp_stop_and_store_status(CPUState *c=
s, run_on_cpu_data arg)
>>       case S390_CPU_STATE_STOPPED:
>>           /* already stopped, just store the status */
>>           cpu_synchronize_state(cs);
>> -        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>> +        if (!cpu->env.pv) {
>> +            s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);=

>> +        }
>=20
> Confused, how is that case handled? The CPU is already stopped, so it=20
> won't be run again (consequently, next SIE entry can't store it). Who=20
> will store the status?

Firmware does some magic

>=20
>>           break;
>>       }
>>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>> @@ -497,7 +499,8 @@ void do_stop_interrupt(CPUS390XState *env)
>>       if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) =3D=3D 0) {
>>           qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);=

>>       }
>> -    if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS) {
>> +    /* Storing will occur on next SIE entry for fmt 4 */
>> +    if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS && !env->pv=
) {
>>           s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>>       }
>>       env->sigp_order =3D 0;
>>
>=20
>=20



--dPYDsU1T0XCepjqsnG4d8KGtGh3wYiJEf--

--Db1jOXmY5b35wzvBbi16AKuqdRsS9ri4z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WdQAACgkQ41TmuOI4
ufgVlg/+L1YlqQ1lhxxobKCz0IBoAg3w1qSXDVleZnmtkeP65VWQJEiRfldRlxhy
nL78HterCh23WvEQGyXGswHXfh1LsvRlhWXN881fhO9BzpG+bMieBIC17B5mPFB5
b526Zw3vJMKsWwTHS0ImtPah2NmK2zOcu2zcOWx7S8/XF6WQUVpcLTZdSL+RDDhJ
VLeVQgSQgPHAXI7NPcq1HqsMC0XUbGqG2ui8yOrwg8CIcCojeH8z/ZXX9zXSQmWS
7jdKjqi3nIJyKWDZzhl2v2qGeQ4XUCVuXiNo3gytQyFExO4J0LKrSQo+LnZqLINy
pUn6lzZuC/2w4HbB/UDCd+GnzYsYebhjjoPKfZJ+Uu9XWbhUmbwtxC/NbkmUhHPG
RdCMsyjf+jUaIMFolaj7cgHOZq3rcJEBijfqlsjBZ7pP4bCQ/8E1dqzxy2iGU4tT
x8OGHzjwc/8yUwYX0z09EKofCnZH8STC6R/3gqjmjtvvt7J7fovUugLIbfH7zP/S
bLmu/FCRnReWPSnH45R9iG/Y/nsu/B412I03dIgRFqClpgHnIWsJvNQC1oYQ2YTJ
o9uqxFpUCF1STadjy2Y2HGiG01jc/KoHVMU1NWQj/GP6Xt+pX3EnOhsLMOtNUzXe
83dpk20DCgRul8pJM6VNEF4WvSuuLueeBVkX7puo5kaomOUFYD8=
=GDiW
-----END PGP SIGNATURE-----

--Db1jOXmY5b35wzvBbi16AKuqdRsS9ri4z--


