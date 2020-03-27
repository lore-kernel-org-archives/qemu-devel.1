Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD753C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EFE20578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EFE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmKP-0006vF-Kp
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jHmJS-0006UH-2X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jHmJQ-0003Ps-So
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:34:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jHmJQ-0003NC-JU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:34:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02RAWclJ131021
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 06:34:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3017ju4saf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 06:34:03 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 27 Mar 2020 10:33:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 27 Mar 2020 10:33:55 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02RAXvNr63176744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2020 10:33:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E22BAE045;
 Fri, 27 Mar 2020 10:33:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F138AE04D;
 Fri, 27 Mar 2020 10:33:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.165.66])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2020 10:33:56 +0000 (GMT)
Subject: Re: [PATCH 2/8] pc-bios: s390x: Get rid of magic offsets into the
 lowcore
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <20200324150847.10476-3-frankja@linux.ibm.com>
 <2398e6fc-9a55-eb67-e974-28f162f0f74c@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 27 Mar 2020 11:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2398e6fc-9a55-eb67-e974-28f162f0f74c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hTyD0hzlsy5k11bTfaO7dtgmcjiEpJHxD"
X-TM-AS-GCONF: 00
x-cbid: 20032710-0012-0000-0000-000003990882
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032710-0013-0000-0000-000021D60A02
Message-Id: <6f1a4370-6090-66ac-6da1-7502f0ad5353@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-27_02:2020-03-26,
 2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=895 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270092
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
--hTyD0hzlsy5k11bTfaO7dtgmcjiEpJHxD
Content-Type: multipart/mixed; boundary="VQvaxVAPqALkyj4AjQ6PZUTuI0p2ssCbP"

--VQvaxVAPqALkyj4AjQ6PZUTuI0p2ssCbP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/27/20 11:25 AM, David Hildenbrand wrote:
> On 24.03.20 16:08, Janosch Frank wrote:
>> If we have a lowcore struct that has members for offsets that we want
>> to touch, why not use it?
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
>>  pc-bios/s390-ccw/main.c |  8 +++-----
>>  2 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>> index aaa432deddb9242e..9ad794a789c47df2 100644
>> --- a/pc-bios/s390-ccw/cio.h
>> +++ b/pc-bios/s390-ccw/cio.h
>> @@ -122,12 +122,17 @@ typedef struct schib {
>>  } __attribute__ ((packed, aligned(4))) Schib;
>> =20
>>  typedef struct subchannel_id {
>> -        __u32 cssid:8;
>> -        __u32:4;
>> -        __u32 m:1;
>> -        __u32 ssid:2;
>> -        __u32 one:1;
>> -        __u32 sch_no:16;
>> +    union {
>> +        struct {
>> +            __u16 cssid:8;
>> +	    __u16:4;
>=20
> Broken indentation. Also, do we want to give that strange-looking
> "__u32:4" a name ("reserved").

Fixed indentation and renamed.

>=20
>> +            __u16 m:1;
>> +            __u16 ssid:2;
>> +            __u16 one:1;
>> +        };
>> +        __u16 sch_id;
>> +    };
>> +        __u16 sch_no;
>>  } __attribute__ ((packed, aligned(4))) SubChannelId;
>> =20
>>  struct chsc_header {
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 4e65b411e1d890ba..8b912454c940a390 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -36,11 +36,9 @@ LowCore *lowcore; /* Yes, this *is* a pointer to ad=
dress 0 */
>>   */
>>  void write_subsystem_identification(void)
>>  {
>> -    SubChannelId *schid =3D (SubChannelId *) 184;
>> -    uint32_t *zeroes =3D (uint32_t *) 188;
>> -
>> -    *schid =3D blk_schid;
>> -    *zeroes =3D 0;
>> +    lowcore->subchannel_id =3D blk_schid.sch_id;
>> +    lowcore->subchannel_nr =3D blk_schid.sch_no;
>> +    lowcore->io_int_parm =3D 0;
>>  }
>> =20
>>  void write_iplb_location(void)
>>
>=20
> Looks sane to me.
>=20



--VQvaxVAPqALkyj4AjQ6PZUTuI0p2ssCbP--

--hTyD0hzlsy5k11bTfaO7dtgmcjiEpJHxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl591pQACgkQ41TmuOI4
ufg/YQ//WHUR8ZAt9qC2TO/GKX9sLHX0eclxShLHKfesGwv7RngHQUYLIoM1fI8T
WxtCXWksR5ti8OghZnLSyzt8/7OAO+fFtNSWaE7bNpbKWaIKNXi6X5K8818wghWo
ENG5OktxuKioNhCNQmIOEVhgKWUSe3T35X/3PKHEWm92H2R3mHKIBDUHTDrX6r1F
CnOXXl0p2KhPDTJVBcYju6iF1yiCr15zXDDiohh2ZvE+N9VlaCyQ8EKsDgKXvJob
FJkJHgsQ5wCPhP0f2C855dOoGBfeB5J20Yz9esGlpwcv3kcOELP/Eeq0bIMNoZQp
LkFxpXMeJE3+qgIaF+gWJYqvLy0fwKKhHXPpYGGj/biBkpPTy+8iGDRJk69vTJgT
Vn155nZ3os0V7zp2631HaCSVLo/U0Q7yy0VwEZC+N9VxKLmqFbvfcY05kYp1nPIA
LDfcNkW/Z0vJiT8z1frmFS887/M0l24fbKPn/qNQ9DfZLoT3k/BB+/w9refGKPi6
aTKt41uoTdEXRUQ9dt8oID82POQb0up141hbdqxck1rn3MPAIXbff4dRQWQDHXhE
wX16kSBDFb0dVN+6GYC1J7aojwLkI3aI7KB1dcprW+nVdE1thnTLJYbEQ8yPbU9H
ds5Ghn02O4N6T0lHmfMntw3oXfhvTa9+OohoKioroenRTvGUl8I=
=xs8V
-----END PGP SIGNATURE-----

--hTyD0hzlsy5k11bTfaO7dtgmcjiEpJHxD--


