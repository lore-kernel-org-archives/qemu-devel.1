Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A65C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DF424679
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DF424679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkD8-0004Wd-B6
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ifkCW-00045x-69
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ifkCU-0002Ur-Qc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:37:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ifkCU-0002Pj-I8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:37:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDCVtF3067828
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:37:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuspgwjw2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:37:39 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 13 Dec 2019 12:37:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:37:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDCbYUs19398720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:37:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DA4DAE045;
 Fri, 13 Dec 2019 12:37:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E006FAE04D;
 Fri, 13 Dec 2019 12:37:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.82.206])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:37:33 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
To: Cornelia Huck <cohuck@redhat.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-5-frankja@linux.ibm.com>
 <20191205111239.01e7b114.cohuck@redhat.com>
 <20191213130616.7da8136c.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 13 Dec 2019 13:37:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213130616.7da8136c.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xaGBN961OECd2dZrBqk0yJB57nTXrfUmk"
X-TM-AS-GCONF: 00
x-cbid: 19121312-0028-0000-0000-000003C82CEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0029-0000-0000-0000248B6A43
Message-Id: <53292e11-e250-64f9-49e7-4afaa278481a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xaGBN961OECd2dZrBqk0yJB57nTXrfUmk
Content-Type: multipart/mixed; boundary="5QkoJbQXO3gy0z3tAsOwPiyUgShXlKZNe"

--5QkoJbQXO3gy0z3tAsOwPiyUgShXlKZNe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/13/19 1:06 PM, Cornelia Huck wrote:
> On Thu, 5 Dec 2019 11:12:39 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Tue,  3 Dec 2019 08:28:13 -0500
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> We need to set the short psw indication bit in the reset psw, as it i=
s
>>> a short psw.
>>>
>>> fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before run=
ning the guest")
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-) =20
>>
>> Thanks, applied (together with a rebuild of the bios images.)
>=20
> This unfortunately breaks 'make check-qtest-s390x':
>=20
>    TEST    check-qtest-s390x: tests/boot-serial-test
>    TEST    check-qtest-s390x: tests/pxe-test
> ERROR - too few tests run (expected 1, got 0)
>=20
> When I revert this, the rebuild, and "s390x: Properly fetch and test
> the short psw on diag308 subc 0/1" (as it exposes the bug this commit
> tried to fix), everything passes again. No idea what is wrong, though :=
(
>=20
> For now, I've dropped the three patches mentioned above from the
> s390-next branch (I plan to send a pull request later). Let's fix this
> on top once we figured out whatever went wrong, no need to rush here.
>=20
>=20
Sounds good


--5QkoJbQXO3gy0z3tAsOwPiyUgShXlKZNe--

--xaGBN961OECd2dZrBqk0yJB57nTXrfUmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3zhg0ACgkQ41TmuOI4
ufhu4w//cj4FbNZS3kBMxTNv+fd7q5ylV9FcUq8k/QAejx1SqvLSVcviac2JD196
Xt8vPQObgASLum4FgpzaQfaxV8qu6mwD9zSsJNtMtq6QOZJLE1sMs+BgscOeEhuJ
sOd4H1T9M495+OrLnC9JYqH/F6EUs7dCCjTgiE40Iaa36k3hK1d4BmgIxeeK4g33
n+1Q7ITvD498xf1V1qfmUGpzxE/0/XNXp8VJnClBIIzR5u8f+ZLjxs0FI7YFQb1b
Fj/UAewoZfIBvw+PzDd+U+Yl/7bqP4KifTEBi1MyfukOHpAUh7+G9m1V+SMCH6LH
D5/hP+Iuqmw3NDF0rgW0f4Uezi1eRIQ9y+GEhm1X1Z5FRlMun+QMpX+kt2ZRrM4I
Lz74Q7KP2oxylS4Z4j2R1W7tCNbzyYXVIOuIO9dYRCueChkm8LOWSG07o9Nc2TVl
vHbj+LnIVzACBFvUZyoclxwO6TgaK1iKYbk0rBXvIBV4Oc/SbAMIH1U+zenH2Mqc
NGj4tg4Pd1mR+0ZtZ+HJ8iMRF9/6wAr6cr4LqginUbJg/h1NhGOpyobKVU7eRbnD
nVUU+68XcZrbUCDp0AvACvb/QKtGrDVqWmalKpcXc1kGwWeCN97Nk2oM8vN+Q+GY
y+FDCO0n60AGdPsPIgSsuA/sYC2jlTj8CnnvOqQtb7fQOMeQyAY=
=eSxO
-----END PGP SIGNATURE-----

--xaGBN961OECd2dZrBqk0yJB57nTXrfUmk--


