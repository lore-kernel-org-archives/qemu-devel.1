Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48421C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2607921835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icv3d-0003Fh-AL
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1icv1c-0001s5-08
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1icv1Z-0000tg-OC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:34:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1icv1Y-0000mS-RV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:34:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5HRXRK134282
 for <qemu-devel@nongnu.org>; Thu, 5 Dec 2019 12:34:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wq2ucuqgf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 12:34:39 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Dec 2019 17:34:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Dec 2019 17:34:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB5HYYwE54132746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Dec 2019 17:34:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1935311C050;
 Thu,  5 Dec 2019 17:34:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A2F611C04A;
 Thu,  5 Dec 2019 17:34:33 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.180.36])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Dec 2019 17:34:33 +0000 (GMT)
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
To: Cornelia Huck <cohuck@redhat.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
 <20191205181532.46bee55c.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Dec 2019 18:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191205181532.46bee55c.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cRLum6UrFSSMQ0HMQ7s0GcKwzRezfJNHQ"
X-TM-AS-GCONF: 00
x-cbid: 19120517-0020-0000-0000-0000039471B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120517-0021-0000-0000-000021EBA0FB
Message-Id: <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_05:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050147
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cRLum6UrFSSMQ0HMQ7s0GcKwzRezfJNHQ
Content-Type: multipart/mixed; boundary="MTXuauC15rkK56ItspVCTmvCn1Mx9j1m6"

--MTXuauC15rkK56ItspVCTmvCn1Mx9j1m6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/5/19 6:15 PM, Cornelia Huck wrote:
> On Fri, 29 Nov 2019 04:48:02 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
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
>>  target/s390x/kvm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index ad6e38c876..3d9c44ba9d 100644
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
>> @@ -151,6 +153,7 @@ static int cap_s390_irq;
>>  static int cap_ri;
>>  static int cap_gs;
>>  static int cap_hpage_1m;
>> +static int cap_protvirt;
>> =20
>>  static int active_cmma;
>> =20
>> @@ -342,6 +345,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);=

>> +    cap_protvirt =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
>> =20
>>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
>> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
>>              (long)cs->kvm_run->psw_addr);
>>      switch (icpt_code) {
>>          case ICPT_INSTRUCTION:
>> +        case ICPT_PV_INSTR:
>> +        case ICPT_PV_INSTR_NOTIFICATION:
>>              r =3D handle_instruction(cpu, run);
>=20
> I'm still a bit uneasy about going through the same path for both 104
> and 108. How does the handler figure out whether it should emulate an
> instruction, or just process a notification? Is it guaranteed that a
> given instruction is always showing up as either a 104 or a 108, so
> that the handler can check the pv state?

diag 308 subcode 0/1 are 108, but all other subcodes are defined as a
104 (if they are an exit at all)...

>=20
> [Even if that works, it still feels a bit unclean to me.]
>=20
>>              break;
>>          case ICPT_PROGRAM:
>=20
>=20



--MTXuauC15rkK56ItspVCTmvCn1Mx9j1m6--

--cRLum6UrFSSMQ0HMQ7s0GcKwzRezfJNHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3pP6kACgkQ41TmuOI4
ufihixAAnqET7tN5AIT4GPNa0v/oUUeNSA7vY5UP1/ouGhwNOt0eOi+3cAwKeLnd
g3JPt5L2lpT6ch3yyRO82NP0GHZPJ7dgupau3Unzf2W0PuHrrzCf8PpIhxnhdey0
FVOnIUn+hioa2QnaULqwZnkKT5RJ3Xou6527q3Ve/KHuTj9bBNyhN/ZFnaJv9xCD
SEshvWXpN9nf8trpTSYmQVh8O8hgIw9HFyLs6K/q6LDEWfmuPWnxHBx2xzmgK/zo
zVlwxBob/vp82tvoU9HbHxzpqVH5OogamWJTIDoldGHQth5HEpltHklua9LiFoyC
S15qQLaLG8byRB82ti5NOGHrjIOusBkdV6xlnSzW7CrRwF+4ISnjhLO/Khaayids
nENCARp40U6LrnHHRxnNE3eQVqs6HXSEW48S9TbJbsebB48NVqk4yqhcHQFOCBHR
QWTu/8qcs1aTtVf/H3jMg/oF5rSKxyF8VkfBVTDI6X5C4NlXKS6vQbRiHdBsarij
nJo2Iwm88A1k14uUWKTHvyaY5E9mIqu6Rd6JEUR3UNe5geq/zkjmIXU9G5yR9hHV
+LAHIM5WhWlsFLDk9GEbEVMtiQe5Ye8v2kIbIwP+rCN6joFSbkkhIKh8scFX5fjv
Gi3VfKNFMb3rP9FVA79DKcu4E0gDA62sudoA275Iv2S2kIwjUDU=
=23mO
-----END PGP SIGNATURE-----

--cRLum6UrFSSMQ0HMQ7s0GcKwzRezfJNHQ--


