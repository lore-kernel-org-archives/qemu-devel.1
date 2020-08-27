Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE83C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB5A22B4E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hr6fDyEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB5A22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIws-0005Ep-Kt
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBIvc-0003tx-UI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:31:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kBIva-0004f6-5H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:31:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07REI1qa019714
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=llkrkwnx1+QpWEwrUgTs8Ph+yO4+B/eTHAu0YKet6po=;
 b=Hr6fDyEYKwEyCpVs3UFc1l02RolKNXa31aJGqG2Wtg4VNx3OZG4Y2rlRuzh7Bp0bG9Dj
 FBiVDxOyRYPkDCOWoaGDQ9FOkzssyOMFWXmF+F+QTnq1YhIQ8/n7ieeeRv1L+DT7fTF4
 iBp4cOWQgZiv7OV/HK6IfTaoCrV4clb8nTKqJW8VNr/UshhjxiYCphinL28vc+s4QOyH
 1+AHRmSxOWOY+Oyi7kSz5UNsDT+38Rwxrg2b2mr24Nye2yhTmrfdH+1+Ug5gVarjt7E3
 nUAgdeLuNiMhUN0/25TNvXbueuPj8p9Ai4a7Vs58pKK/ftsnWUFh5J7ii8qlHXdPVQ9N LQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 336efng9j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:30:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07REMdZA005167
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 336buh05rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 07REUdOF62521808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C814AE059
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEF17AE057
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.54])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:30:38 +0000 (GMT)
Subject: Re: [PATCH RFC v2 3/4] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
To: qemu-devel@nongnu.org
References: <20200827093152.3026-1-frankja@linux.ibm.com>
 <20200827093152.3026-4-frankja@linux.ibm.com>
 <c5190ed1-a4f9-45c3-97b3-4924cff5da31@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3428e0f6-43a1-b509-d804-fad083c21cb8@linux.ibm.com>
Date: Thu, 27 Aug 2020 16:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c5190ed1-a4f9-45c3-97b3-4924cff5da31@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EpGqrzvZl8dv7JiZoACLBN3pNlA7ZJ4qY"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-27_07:2020-08-27,
 2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=1 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 10:30:56
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EpGqrzvZl8dv7JiZoACLBN3pNlA7ZJ4qY
Content-Type: multipart/mixed; boundary="jblMLQR3vkjAeHpiTd8UoY3dwl3V7WKlC"

--jblMLQR3vkjAeHpiTd8UoY3dwl3V7WKlC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/20 2:52 PM, Thomas Huth wrote:
> On 27/08/2020 11.31, Janosch Frank wrote:
>> Currently we always overwrite the mentioned exception new PSWs before
>> loading the enabled wait PSW. Let's save the PSW before overwriting
>> and restore it right before starting the loaded kernel.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> Maybe we should rather statically allocate a lowcore so we don't dirty=

>> 0x0 at all.
>>
>> ---
>>  pc-bios/s390-ccw/jump2ipl.c |  3 ++
>>  pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++---------=
-
>>  2 files changed, 48 insertions(+), 17 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index 143d027bf7..a44f3ab5b3 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -13,12 +13,15 @@
>>  #define KERN_IMAGE_START 0x010000UL
>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>> =20
>> +extern uint64_t *psw_save_io, *psw_save_ext;
>=20
> I think that should be
>=20
>  extern uint64_t psw_save_io[], psw_save_ext[];
>=20
> instead ... otherwise you'll end up with some funny bugs here, won't yo=
u?

What kind of bugs are you expecting?

>=20
>>  uint64_t *reset_psw =3D 0, save_psw, ipl_continue;
>> =20
>>  static void jump_to_IPL_2(void)
>>  {
>>      /* Restore reset PSW and io and external new PSWs */
>=20
> Ok, now the comment makes sense :-)
>>      *reset_psw =3D save_psw;
>> +    memcpy((void *)0x1f0, psw_save_io, 16);
>> +    memcpy((void *)0x1b0, psw_save_ext, 16);
>=20
> Could you use &lowcore->external_new_psw and &lowcore->io_new_psw
> instead of the magic numbers?

I can, but that means that I need to declare lowcore in netmain.c as
well as including s390-arch.h

>=20
>  Thomas
>=20
>=20
>=20



--jblMLQR3vkjAeHpiTd8UoY3dwl3V7WKlC--

--EpGqrzvZl8dv7JiZoACLBN3pNlA7ZJ4qY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9Hw44ACgkQ41TmuOI4
ufj7Ng//cX+EKKxRAEoTgq9XIwN11pC8vpeWGNZxQq8tiM11DEBH3yaVe951pqoL
c8rk3i7r0xwNrCEQXeqv7eNzCoifga7orH+8sJITW+svBjb1l90iek3UXDZ4y2wR
9smoAHmGDVmUXjEvI5wN+cuXiFI97nXio3EQ2pFdHoMtSAscFOP6Ztv+3FCqFcvH
3WV2cfkK1uObROWOcEbvPW6YMGz2+YxvOqRLfYhagM2RxOqzPuURHUZ8xQntT3KU
DyvPhTcVmVYuPz7FS5tOfK1eswyMbnNMqKICWZOudQO/ZALUvrrPvqsEtGfb+n7i
H3RIksO7q55DNTf4mP3/rb6Qsg4Jvf4EJgEf/pTpSoCXeoy06HeLCj1vrwS9yHhx
EAKN8QhbFa8igJdsHj04QumrvfhwDM/CWCOxBzXq+4mT7YARXggB8dWX3hNg8YAO
FZM7vV4JgQ4LMFPcXcHTvY55Ff+sfyYfjOKu1tu1mJ2+CTwF8gr7Xo/OUHgdgm12
ecdg63VZA4PIcQry7E3aK9whrdjiYCLcDsTWKb+sWIP4WiwaSGlXmDy9fnj1MlH7
OAzMh21UGTQCe9UxcEl4tFrYihPvh6pGadUHwtduWsyWsyijYKcqv5eJfutBXNpR
wt6k3UnAXI/8DdTkhi47fzzoaalbTygT9lbD52P1dJYo4uuMcu4=
=ccas
-----END PGP SIGNATURE-----

--EpGqrzvZl8dv7JiZoACLBN3pNlA7ZJ4qY--


