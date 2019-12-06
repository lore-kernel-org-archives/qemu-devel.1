Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35465C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0998A24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0998A24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFFF-0001fY-Sl
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1idESn-0005n9-AH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1idESl-0007m2-Gc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27332
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1idESl-0007bk-7l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB68hLt6076350
 for <qemu-devel@nongnu.org>; Fri, 6 Dec 2019 03:45:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2tvny4h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 03:45:50 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 6 Dec 2019 08:45:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Dec 2019 08:45:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB68jhKu28049506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2019 08:45:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0CE11C04A;
 Fri,  6 Dec 2019 08:45:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F0B411C04C;
 Fri,  6 Dec 2019 08:45:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.65])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2019 08:45:42 +0000 (GMT)
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
To: Cornelia Huck <cohuck@redhat.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
 <20191205181532.46bee55c.cohuck@redhat.com>
 <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
 <20191205184637.4e6f4d23.cohuck@redhat.com>
 <bc5eb50d-1647-f40a-73b6-53be5445fd85@linux.ibm.com>
 <20191206092913.3af251dd.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 6 Dec 2019 09:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191206092913.3af251dd.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bMWpfGKwgp8lqD7R2IABiCOWWKfJkzPF6"
X-TM-AS-GCONF: 00
x-cbid: 19120608-0008-0000-0000-0000033E0990
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120608-0009-0000-0000-00004A5D2FB1
Message-Id: <c7490fc2-e706-bf51-9979-559a90c65f6c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_02:2019-12-04,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912060074
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bMWpfGKwgp8lqD7R2IABiCOWWKfJkzPF6
Content-Type: multipart/mixed; boundary="UpAqd0QKe9fop8JggoROL2ot6u8mCs15z"

--UpAqd0QKe9fop8JggoROL2ot6u8mCs15z
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/6/19 9:29 AM, Cornelia Huck wrote:
> On Fri, 6 Dec 2019 08:44:52 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 12/5/19 6:46 PM, Cornelia Huck wrote:
>>> On Thu, 5 Dec 2019 18:34:32 +0100
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> On 12/5/19 6:15 PM, Cornelia Huck wrote: =20
>>>>> On Fri, 29 Nov 2019 04:48:02 -0500
>>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>>    =20
>>>>>> Secure guests no longer intercept with code 4 for an instruction
>>>>>> interception. Instead they have codes 104 and 108 for secure
>>>>>> instruction interception and secure instruction notification
>>>>>> respectively.
>>>>>>
>>>>>> The 104 mirrors the 4 interception.
>>>>>>
>>>>>> The 108 is a notification interception to let KVM and QEMU know th=
at
>>>>>> something changed and we need to update tracking information or
>>>>>> perform specific tasks. It's currently taken for the following
>>>>>> instructions:
>>>>>>
>>>>>> * stpx (To inform about the changed prefix location)
>>>>>> * sclp (On incorrect SCCB values, so we can inject a IRQ)
>>>>>> * sigp (All but "stop and store status")
>>>>>> * diag308 (Subcodes 0/1)
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> ---
>>>>>>  target/s390x/kvm.c | 6 ++++++
>>>>>>  1 file changed, 6 insertions(+)
>>>>>> =20
>>>  =20
>>>>>> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
>>>>>>              (long)cs->kvm_run->psw_addr);
>>>>>>      switch (icpt_code) {
>>>>>>          case ICPT_INSTRUCTION:
>>>>>> +        case ICPT_PV_INSTR:
>>>>>> +        case ICPT_PV_INSTR_NOTIFICATION:
>>>>>>              r =3D handle_instruction(cpu, run);   =20
>>>>>
>>>>> I'm still a bit uneasy about going through the same path for both 1=
04
>>>>> and 108. How does the handler figure out whether it should emulate =
an
>>>>> instruction, or just process a notification? Is it guaranteed that =
a
>>>>> given instruction is always showing up as either a 104 or a 108, so=

>>>>> that the handler can check the pv state?   =20
>>>>
>>>> diag 308 subcode 0/1 are 108, but all other subcodes are defined as =
a
>>>> 104 (if they are an exit at all)... =20
>>>
>>> I think that's a reason to really split 108 from 4/104, or at least a=
dd
>>> an parameter... =20
>>
>> And still call the diag 308 handler or have separate handlers?
>=20
> I'd probably split it into a "normal" one and one for pv special
> handling... does that make sense?
>=20
IMHO: not really
We still need to do ipa/ipb parsing for both paths, which will result in
code duplication. Looking at diag308 subcode 4, we would have a code 4
one which just does the device resets and reboots and one which does all
that, plus the teardown of the protected guest.

I tried to inline as much as possible to have as little changes as
possible. Notable exception is sclp, which has more checks than
emulation code...



--UpAqd0QKe9fop8JggoROL2ot6u8mCs15z--

--bMWpfGKwgp8lqD7R2IABiCOWWKfJkzPF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3qFTYACgkQ41TmuOI4
ufgdrg/+LHc8KCGXplddh7D1AitemX/sC+2XGSnd+TMFASkhXmLvaLHVppA7lamX
lfUjo4TdLH0gc5XVhYRoTb9SiwV3nZkInDIjsHY1DRo378hA4t85zzNIOEKEiQi0
wO790CZB30QgRV769V7p01nDm4Wywsa1IM8C9UCzUmVgI+jfnBaGR8cClPhzmSZg
2r2GjuRW3Z3i3Yhv5U1C4aKQKn6R7FQOujc5Ngqppnoc3qmrsD4eIcVoCV1m52n1
O1ITZMUtLRdvs7EgKf9NedVkZrmgZj/95W7YAlf8TCN2sTX54VCnhkugi3UuWShi
XQ5f6JMQ9dhdKy5eQN/sp9u5X+7OZ2NS7RMDTj7HdbdUA/peH4BAlgscq6xIdlLv
T/OA/XNQXULrEvKVPlwFMxjyaANMWToZ6d6ZisiiFS0qT0i3otauXACiTmS2jnmX
WgwwOv7ACtXc99vpkjVHm2OZFg2bBmeYScIoN15AzFO7CC0/MsBGAwUvlH16exgn
aFUNH+nxOMGY9G1il733cuboEGqCdqfj24uzk5lu7yW5vS7lcx+9XgeOObeqOYjq
G2Re0h64xdpD0DO+wwrDg1WXVgiN9M9AN45AS6R/L2K1y7ZBWow/MAwfE6hz8Mbv
9HXAAD+9czgLs7dZdFzvTBhuGQLHvpcJtnrkzqpixoV52x9F/uk=
=zshx
-----END PGP SIGNATURE-----

--bMWpfGKwgp8lqD7R2IABiCOWWKfJkzPF6--


