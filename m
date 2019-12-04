Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECAEC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9420A2081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9420A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icU3D-0008Kg-KO
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1icU1f-00077j-DY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1icU1e-0003Sl-35
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:45:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46918
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1icU1d-0003Qd-SS
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:45:02 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB4CgQW6081189
 for <qemu-devel@nongnu.org>; Wed, 4 Dec 2019 07:45:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsd53j0m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:45:00 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Dec 2019 12:44:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 12:44:57 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB4Cit3u63307792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 12:44:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EEAB42045;
 Wed,  4 Dec 2019 12:44:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4476D4204B;
 Wed,  4 Dec 2019 12:44:55 +0000 (GMT)
Received: from dyn-9-152-224-146.boeblingen.de.ibm.com (unknown
 [9.152.224.146])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Dec 2019 12:44:55 +0000 (GMT)
Subject: Re: [PATCH v2 08/13] s390x: protvirt: Add new VCPU reset functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-9-frankja@linux.ibm.com>
 <942e3aaa-e79a-ac02-4152-eb160e487865@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 4 Dec 2019 13:44:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <942e3aaa-e79a-ac02-4152-eb160e487865@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OaQfBbZRcz95TeXuiW2WOMGbsyhfCT4ZY"
X-TM-AS-GCONF: 00
x-cbid: 19120412-0020-0000-0000-00000393B1BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120412-0021-0000-0000-000021EAD959
Message-Id: <24c83640-b8a9-bcb0-a678-5152b3138d66@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=3 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912040103
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OaQfBbZRcz95TeXuiW2WOMGbsyhfCT4ZY
Content-Type: multipart/mixed; boundary="7xTZg9JoWch21YLzChw4KTNIIMpzZgeXw"

--7xTZg9JoWch21YLzChw4KTNIIMpzZgeXw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/4/19 12:58 PM, Thomas Huth wrote:
> On 29/11/2019 10.48, Janosch Frank wrote:
>> CPU resets for protected guests need to be done via Ultravisor
>> calls. Hence we need a way to issue these calls for each reset.
>>
>> As we formerly had only one reset function and it was called for
>> initial, as well as for the clear reset, we now need a new interface.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index b802d02ff5..5b1ed3acb4 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -154,6 +154,7 @@ static int cap_ri;
>>  static int cap_gs;
>>  static int cap_hpage_1m;
>>  static int cap_protvirt;
>> +static int cap_vcpu_resets;
>> =20
>>  static int active_cmma;
>> =20
>> @@ -346,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);=

>>      cap_protvirt =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
>> +    cap_vcpu_resets =3D kvm_check_extension(s, KVM_CAP_S390_VCPU_RESE=
TS);
>> =20
>>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
>> @@ -407,20 +409,44 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>>      return 0;
>>  }
>> =20
>> -void kvm_s390_reset_vcpu(S390CPU *cpu)
>> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
>>  {
>>      CPUState *cs =3D CPU(cpu);
>> =20
>> -    /* The initial reset call is needed here to reset in-kernel
>> -     * vcpu data that we can't access directly from QEMU
>> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG=
).
>> -     * Before this ioctl cpu_synchronize_state() is called in common =
kvm
>> -     * code (kvm-all) */
>> +    /*
>> +     * The reset call is needed here to reset in-kernel vcpu data tha=
t
>> +     * we can't access directly from QEMU (i.e. with older kernels
>> +     * which don't support sync_regs/ONE_REG).  Before this ioctl
>> +     * cpu_synchronize_state() is called in common kvm code
>> +     * (kvm-all).
>> +     */
>> +    if (cap_vcpu_resets) {
>> +        if (kvm_vcpu_ioctl(cs, KVM_S390_VCPU_RESET, type)) {
>> +            error_report("CPU reset type %ld failed on CPU %i",
>> +                         type, cs->cpu_index);
>> +        }
>> +        return;
>> +    }
>>      if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
>>          error_report("Initial CPU reset failed on CPU %i", cs->cpu_in=
dex);
>>      }
>=20
> Don't you want to check for type !=3D KVM_S390_VCPU_RESET_NORMAL before=

> doing the INITIAL_RESET here?
>=20
>>  }
>> =20
>> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
>> +{
>> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_INITIAL);
>> +}
>> +
>> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
>> +{
>> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_CLEAR);
>> +}
>> +
>> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
>> +{
>> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_NORMAL);
>> +}
>=20
> ... otherwise this might reset more things than expected?
>=20
> Or do I miss something here?

Hey Thomas I split out this patch into the "architectural compliance"
patch series. Have a look into there, this is an old version.

>=20
>  Thomas
>=20



--7xTZg9JoWch21YLzChw4KTNIIMpzZgeXw--

--OaQfBbZRcz95TeXuiW2WOMGbsyhfCT4ZY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3nqkYACgkQ41TmuOI4
ufhKAxAAqfte9bjb/d57vb/JZxc2Ayv3Nd6rrjbxEvLb6Q/4GYsH+zDmzCnZBKPH
PBqGp63GKR2cr0gO5txuae6oNbkSR7WGf/G3BEHXT5+9/A0RjpYYNwstU6Ytjs2a
YQH7fKekVgsywxQltIJbUwviDWtue6DK+XQGLa1uHi0xsHuwPqpzCjj3DLwk/ba8
gOfjKw6iK0pOF+/o73JSm7uCEqx4X+21omz9NkeHT4WuBouI6ABKSZ2pFicRgu71
KqeoOIUjKDJZ7QyyAL1UxRf5WHKrZLPZ+d+dF58GdwTOv/MAnWKfDEQGlPhc9j5r
W0oT+qGo9Tl7NXElJBE86sIDwiZ9Ms9i9FJvH+4q3qMKEh+6qCQB/FmPvKlqTv4j
ZCrbCEnDSDQ6VS0N29NdIEom9Y2ecCNhQzIqLHi4AR2Jqt8ue3rta+eOV9VQXiJY
5IXXzA7cKAACsOvac4jm02984lUkv4QbX0EcTSDycNbsf3/kXNMHdJ3T5L3t7Tls
eVT7klDjeoQMxwF8TWyJJiEESESik3O6b4TBvg4FR1E0mzWORbO8ygH1KtnLFLoH
5753/YQ/T41UQwu9TZKvaMCAtXA6+lq22rjwbizMRm4NYx56+CvK9LB/314iJRqu
vD3Du3E5208QqOQ6o8n0MipPlDKkHgEZizr2+z+s+9ACtJ/Xsl4=
=LkiN
-----END PGP SIGNATURE-----

--OaQfBbZRcz95TeXuiW2WOMGbsyhfCT4ZY--


