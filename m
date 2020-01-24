Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C94C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559532072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559532072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyaZ-0005Uh-IH
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iuyZr-0004w2-Ic
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iuyZl-00089F-7P
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:00:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iuyZk-00088N-U4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:00:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00OCw7vg089426
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:00:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xqmjt6hc5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:00:39 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 24 Jan 2020 13:00:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 24 Jan 2020 13:00:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00OD0YYV62914618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 13:00:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1C5AAE05F;
 Fri, 24 Jan 2020 13:00:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7C5EAE059;
 Fri, 24 Jan 2020 13:00:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.180.45])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2020 13:00:33 +0000 (GMT)
Subject: Re: [PATCH] s390x: sigp: Fix sense running reporting
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200124100137.28656-1-frankja@linux.ibm.com>
 <20200124110547.50c73851.cohuck@redhat.com>
 <63618540-bc70-918a-6a26-14656f66742f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 24 Jan 2020 14:00:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <63618540-bc70-918a-6a26-14656f66742f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4SjR6a11OpgNIW6PpgKvnA0rIiPjbzP64"
X-TM-AS-GCONF: 00
x-cbid: 20012413-4275-0000-0000-0000039A8998
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012413-4276-0000-0000-000038AE9A02
Message-Id: <88a233f5-31d0-fef9-b80a-8d31a8fb7d65@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-24_03:2020-01-24,
 2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001240107
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4SjR6a11OpgNIW6PpgKvnA0rIiPjbzP64
Content-Type: multipart/mixed; boundary="Ey2lfihp3w0AsRm3ybBkcPPIIFUaGD9Fk"

--Ey2lfihp3w0AsRm3ybBkcPPIIFUaGD9Fk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/24/20 1:03 PM, David Hildenbrand wrote:
> On 24.01.20 11:05, Cornelia Huck wrote:
>> On Fri, 24 Jan 2020 05:01:37 -0500
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> The logic was inversed and reported running if the cpu was stopped.
>>
>> s/inversed/inverted/ ?
>>
>>> Let's fix that.
>>>
>>
>> Fixes: d1b468bc8869 ("s390x/tcg: implement SIGP SENSE RUNNING STATUS")=

>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  target/s390x/sigp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
>>> index 727875bb4a..286c0d6c9c 100644
>>> --- a/target/s390x/sigp.c
>>> +++ b/target/s390x/sigp.c
>>> @@ -347,7 +347,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, =
SigpInfo *si)
>>>      }
>>> =20
>>>      /* If halted (which includes also STOPPED), it is not running */=

>>> -    if (CPU(dst_cpu)->halted) {
>>> +    if (!CPU(dst_cpu)->halted) {
>>>          si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>>>      } else {
>>>          set_sigp_status(si, SIGP_STAT_NOT_RUNNING);
>>
>> I'm wondering why nobody noticed this before...
>=20
> AFAIR, it "SENSE RUNNING" allows you to test if the target CPU is
> scheduled by the hypervisor. So it is used for performance optimization=
,
> but correctness of a program barely depends on it.
>=20
> a) You can always return "not running" and it would be totally fine
>=20
> b) Return "running" would also most probably always valid (although it
> does not make too much sense for STOPPED CPUs).
>=20
> E.g., in KVM we set CPUSTAT_RUNNING whenever we load the CPU. This can
> also happen (AFAIR) when the CPU state is already stopped (e.g.,
> currently getting stopped) or still sleeping (e.g., about to wake up, o=
r
> in kvm_vcpu_block()).
>=20
>=20
> Long story short: There is no trusting on these values.

That answer makes me highly uncomfortable...

>=20
>=20
> But yeah, the heuristic we are using is sub-optimal. :)
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!



--Ey2lfihp3w0AsRm3ybBkcPPIIFUaGD9Fk--

--4SjR6a11OpgNIW6PpgKvnA0rIiPjbzP64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4q6nEACgkQ41TmuOI4
ufimXRAArZcAA2P6X7QUjj6tK8pURhlB8cKKR05VY+YR5p0z1nB6mjjTAcQvU3gy
TKhbGQeOibXqq9cfMrpeY65pcX1AN8+EUM64Ta4IQ0UZxvCkHfuFYhgTixle9Je5
3SezGcPzBTyhJe25VtmpihILNIrqFz5itZTWvJlC4virsw9m69cb6qM1wFIF2zIJ
3cuR3fTPOj0bDuoJ/UHHyTHFHBsUtWDnQbtvSvpvKXzg7PKJ4W8aW0MoZMPqNtYN
5E+t2X3QesHqMuT1sKQVk2LOqY9OqlcMotff7LnuY1S10sZ1idg/ZLPRBGOd2843
iODnaVyDwYlG0ssYf+kPAjNTvoDJUWmyLSsPP7G9rROEuOJM/vendZZimB+uwAjj
bh0wZgOgDU6kixhn0IFQCzz3H6ATiPOP7Nq1DySOzksgiksdkeqZgOjuMHS7siIr
kHLXFOO3hMabhYln7RTJ36PHRoISsL42g803xHTlP8jPn3Z4lNs1Cq4Qlvk/qwDr
5QfunR9TvV5sP3PyAIU4aTKrypE/pV8PmZ3LoEcwPHaXKSPPQgQQGBK+p1Yk2c3p
REL5uw6W2/vUanTlbutUwYd36Zqu8N9FYd5yoI4STyMARW0s57M+Dien66N1v+G7
aQt1ng5je50MyLnnHo9ZtrwVe40//QwWNwFz6M6rJiiN4b553XM=
=roos
-----END PGP SIGNATURE-----

--4SjR6a11OpgNIW6PpgKvnA0rIiPjbzP64--


