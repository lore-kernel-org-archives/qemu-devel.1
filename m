Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A941720726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A941720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YTj-0002Bs-Tr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6YSx-0001iO-Ke
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6YSw-0000P1-71
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:33:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45262
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6YSu-0000ND-ES
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:33:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PBTowG084987
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:33:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb162x84f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:33:26 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 25 Feb 2020 11:33:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 11:33:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PBXLwh2032006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 11:33:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E88B74203F;
 Tue, 25 Feb 2020 11:33:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FABA4204C;
 Tue, 25 Feb 2020 11:33:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.153.129])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 11:33:20 +0000 (GMT)
Subject: Re: [PATCH v4 06/16] s390x: protvirt: KVM intercept changes
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-7-frankja@linux.ibm.com>
 <2f1aabd4-426c-6314-0dd9-1817853adbc3@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 25 Feb 2020 12:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2f1aabd4-426c-6314-0dd9-1817853adbc3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qjcl6bzaWThuNFz49CYOAHinr6CegYMkP"
X-TM-AS-GCONF: 00
x-cbid: 20022511-0020-0000-0000-000003AD681A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022511-0021-0000-0000-000022057E1E
Message-Id: <2dc9d39d-1087-e2ab-bfcb-ce98f06de111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_03:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250094
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qjcl6bzaWThuNFz49CYOAHinr6CegYMkP
Content-Type: multipart/mixed; boundary="xfjOaqaIzZ2ERnLY1d4n5Zzv3izn33b52"

--xfjOaqaIzZ2ERnLY1d4n5Zzv3izn33b52
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/25/20 11:01 AM, David Hildenbrand wrote:
> On 20.02.20 13:56, Janosch Frank wrote:
>> Secure guests no longer intercept with code 4 for an instruction
>> interception. Instead they have codes 104 and 108 for secure
>> instruction interception and secure instruction notification
>> respectively.
>>
>> The 104 mirrors the 4 interception.
>>
>> The 108 is a notification interception to let KVM and QEMU know that
>> something changed and we need to update tracking information or
>> perform specific tasks. It's currently taken for the following
>> instructions:
>>
>> * stpx (To inform about the changed prefix location)
>> * sclp (On incorrect SCCB values, so we can inject a IRQ)
>> * sigp (All but "stop and store status")
>> * diag308 (Subcodes 0/1)
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/kvm.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 1d6fd6a27b..eec0b92479 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -115,6 +115,8 @@
>>  #define ICPT_CPU_STOP                   0x28
>>  #define ICPT_OPEREXC                    0x2c
>>  #define ICPT_IO                         0x40
>> +#define ICPT_PV_INSTR                   0x68
>> +#define ICPT_PV_INSTR_NOTIFICATION      0x6c
>> =20
>>  #define NR_LOCAL_IRQS 32
>>  /*
>> @@ -1693,6 +1695,8 @@ static int handle_intercept(S390CPU *cpu)
>>              (long)cs->kvm_run->psw_addr);
>>      switch (icpt_code) {
>>          case ICPT_INSTRUCTION:
>> +        case ICPT_PV_INSTR:
>> +        case ICPT_PV_INSTR_NOTIFICATION:
>>              r =3D handle_instruction(cpu, run);
>>              break;
>>          case ICPT_PROGRAM:
>>
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
Thanks!


--xfjOaqaIzZ2ERnLY1d4n5Zzv3izn33b52--

--Qjcl6bzaWThuNFz49CYOAHinr6CegYMkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5VBgAACgkQ41TmuOI4
ufizEQ/+L6UlhkhyAd7IBIb7PGWmOX8jS3qIB3Ocg/vxjnl2ZTbTiog+IDmqhZAa
YyvEtSfEPoe5zrNSW8A8f0yvjbGVwWfAmGraDJuc0SnlufMRRtoEkkFIFL2iCCZY
bzDOaQmuQfIGRhSz02U3B+rCAB8MfpDeRP8Jm170WOVj1N/nPliGgC1nSfBH9X8m
HqPyIAcJBHvLV7hLu3ATAoV2NqlhrVbfS0CV8q/q9ylhsIZZBJaT6L4pwaoX5MDB
4W0cXhNjeA30mTq9PGK7rpw2HWRxm4L7hSW8i/N5GbnAXHrVbOPDaepGcmTaawho
s/pe3QHGD4h2WPuB6NTrDOUPQ/XMphoLdg6DovQoZZqIaXUFEwfo3r+91pDLlpNH
V7ACVinWdqee51p1Akx+srmeeFg9w1ctK5T6Jxr8Z8pOnj4j2IK8mq4CqvxGg6uA
TbKBQ8nUHiPW6jShqG7PKXzaLnCvNNmu2YKDN1zrziJ65C6B8maQ+Z+Y6mCaLxfY
Bz8kmnTqfHL3hu0VJDFabMMbBfvEAlLKDXaCgrAS10RgVxOpK3DvCYmd4hQeF1Cr
02K3GGkgUv4K/haDuRmFTPwYKZaU6udPHDCIKqwO4LloikyBcEJgmlNOykyPqQwM
qYdiWHKVK+eq9+xXO26Psq6DAd0Yxg1Dowf71xkFMr+NiGCA7Z4=
=G1jX
-----END PGP SIGNATURE-----

--Qjcl6bzaWThuNFz49CYOAHinr6CegYMkP--


