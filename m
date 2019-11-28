Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFACC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A9E20880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A9E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQXt-0008VO-2O
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaNJ6-0005Z1-Dr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaN3o-0004hK-A5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:54:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2730
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaN3o-0004XC-1W
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:54:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASGlsdF143154
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:54:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjace8rd1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:54:30 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 28 Nov 2019 16:54:28 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 16:54:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xASGsNEL40567072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 16:54:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB6CA405B;
 Thu, 28 Nov 2019 16:54:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80B1FA4060;
 Thu, 28 Nov 2019 16:54:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.73])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 16:54:22 +0000 (GMT)
Subject: Re: [PATCH 08/15] s390x: protvirt: KVM intercept changes
To: Cornelia Huck <cohuck@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-9-frankja@linux.ibm.com>
 <d081f111-857c-048b-c753-3cc021304102@redhat.com>
 <da848181-41a3-0738-84f8-258046965671@linux.ibm.com>
 <20191128174557.2e421e94.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 28 Nov 2019 17:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128174557.2e421e94.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Iw8B01hjoo44gHseis4r6s3CmCXiQSLyv"
X-TM-AS-GCONF: 00
x-cbid: 19112816-0012-0000-0000-0000036D7CED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112816-0013-0000-0000-000021A92ABF
Message-Id: <ebe14d58-f7c7-bf97-e547-92a44c99d5f3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_05:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280142
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
Cc: Thomas Huth <thuth@redhat.com>, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iw8B01hjoo44gHseis4r6s3CmCXiQSLyv
Content-Type: multipart/mixed; boundary="mmCggtJc9AO7lrNrXcoJ9KC743pwE5oEY"

--mmCggtJc9AO7lrNrXcoJ9KC743pwE5oEY
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/28/19 5:45 PM, Cornelia Huck wrote:
> On Thu, 28 Nov 2019 17:38:19 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 11/21/19 4:11 PM, Thomas Huth wrote:
>>> On 20/11/2019 12.43, Janosch Frank wrote: =20
>>>> Secure guests no longer intercept with code 4 for an instruction
>>>> interception. Instead they have codes 104 and 108 for secure
>>>> instruction interception and secure instruction notification
>>>> respectively.
>>>>
>>>> The 104 mirrors the 4, but the 108 is a notification, that something=

>>>> happened and the hypervisor might need to adjust its tracking data t=
o
>>>> that fact. An example for that is the set prefix notification
>>>> interception, where KVM only reads the new prefix, but does not upda=
te
>>>> the prefix in the state description.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  target/s390x/kvm.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 418154ccfe..58251c0229 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -115,6 +115,8 @@
>>>>  #define ICPT_CPU_STOP                   0x28
>>>>  #define ICPT_OPEREXC                    0x2c
>>>>  #define ICPT_IO                         0x40
>>>> +#define ICPT_PV_INSTR                   0x68
>>>> +#define ICPT_PV_INSTR_NOT               0x6c
>>>> =20
>>>>  #define NR_LOCAL_IRQS 32
>>>>  /*
>>>> @@ -151,6 +153,7 @@ static int cap_s390_irq;
>>>>  static int cap_ri;
>>>>  static int cap_gs;
>>>>  static int cap_hpage_1m;
>>>> +static int cap_protvirt;
>>>> =20
>>>>  static int active_cmma;
>>>> =20
>>>> @@ -336,6 +339,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)=

>>>>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>>>>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>>>>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ=
);
>>>> +    cap_protvirt =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED)=
;
>>>> =20
>>>>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>>>>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
>>>> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
>>>>              (long)cs->kvm_run->psw_addr);
>>>>      switch (icpt_code) {
>>>>          case ICPT_INSTRUCTION:
>>>> +        case ICPT_PV_INSTR:
>>>> +        case ICPT_PV_INSTR_NOT:
>>>>              r =3D handle_instruction(cpu, run); =20
>>>
>>> Even if this works by default, my gut feeling tells me that it would =
be
>>> safer and cleaner to have a separate handler for this...
>>> Otherwise we might get surprising results if future machine generatio=
ns
>>> intercept/notify for more or different instructions, I guess?
>>>
>>> However, it's just a gut feeling ... I really don't have much experie=
nce
>>> with this PV stuff yet ... what do the others here think?
>>>
>>>  Thomas =20
>>
>>
>> Adding a handle_instruction_pv doesn't hurt me too much.
>> The default case can then do an error_report() and exit(1);
>>
>> PV was designed in a way that we can re-use as much code as possible, =
so
>> I tried using the normal instruction handlers and only change as littl=
e
>> as possible in the instructions themselves.
>=20
> I think we could argue that handling 4 and 104 in the same function
> makes sense; but the 108 notification should really be separate, I

In my latest answer to Thomas I stated that we could move to a separate
pv instruction handler. I just had another look and rediscovered, that
it would mean a lot more changes. I would need to duplicate the ipa/b
parsing and for diagnose even the base+disp parsing.

So yes, I'd like to treat the 104 like the 4 intercept...

> think. From what I've seen, the expectation of what the hypervisor
> needs to do is just something else in this case ("hey, I did something;=

> just to let you know").

We can remove the notification from QEMU, as far is I know, we moved the
instruction that used this path to a 104 code.

>=20
> Is the set of instructions you get a 104 for always supposed to be a
> subset of the instructions you get a 4 for? I'd expect it to be so.
>=20

Yes
I'll ask if we'll get a new code for instructions that are only valid in
PV mode; currently there are none.


--mmCggtJc9AO7lrNrXcoJ9KC743pwE5oEY--

--Iw8B01hjoo44gHseis4r6s3CmCXiQSLyv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3f+74ACgkQ41TmuOI4
ufgQUw/+M4PgDHnOFsGFrY21mQBmhK/YjK93OJHL1RPghceu59JzZTBKrAr67vHP
73rw3cdtoSAyLEFJVOssfMa91zCcONSB89s83aXxRqZOts/aD1DVndujnBC0j7xM
3mTOSePkzt/KzXilKtFGsXpL3lSGKPhuuCQPB9ENDd6BQW4nbMhQFI5j32aL8JMw
RFpyb6FDCS0+Uk0cm2k6R051pnbIuOOOY9ozGYqbh32VCE/K8x/2Dap8OyVtmMHJ
jjYVTaGpVWdUMvShXe5T/F5TXih28zzcFHgiR+7P/MvpZRIf7GuqcsC7x223ZuYc
a42eueGlb/UmIzDhCueozxoG91uNxz6Jmb1Q6TkwkCOi9psTqEM1Zs+T/En9K/Bq
6yTgDLjF9Yr6iALKFUc95QBE1HxkrUmGNRApWGJTUmOWlDPZuuhhW5W0WE7PLiL5
VAfxoHYa/CsvRu6alb4nd4B/kKD2FpiKwV1tq2tg/LtUKtZfMOhkZ2WB5NUaXZXS
5Q4Iz45eWFS0iLJsh9k2MKC/X+LHrKIiATs5bGKCzAYeG2JOTvGQTFXiBoAcy36h
+O5jszga8gwWt/fe/f8Tw2bSqWLwIT6OGjeSaftdS8OW1FECJn02oqtorkObSWWp
Q2Cq6HGDyHtzoVWkLcG8an5RZjNCM3JbsXa8yzd9ZajOT/NtUZs=
=oPtY
-----END PGP SIGNATURE-----

--Iw8B01hjoo44gHseis4r6s3CmCXiQSLyv--


