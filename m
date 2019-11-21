Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F9C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51072070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51072070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmm3-0006GI-KJ
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXmkj-0005MN-5o
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXmkh-0008Bi-IK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:44:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20908
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXmkh-0008BI-Cy
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:44:07 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALDWpA7107765
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:44:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wdhxk36q1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:44:06 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 13:44:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 13:44:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xALDi0LW40960236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 13:44:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F845AE051;
 Thu, 21 Nov 2019 13:44:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1970BAE045;
 Thu, 21 Nov 2019 13:44:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 13:44:00 +0000 (GMT)
Subject: Re: [PATCH 05/15] s390x: protvirt: Sync PV state
To: Cornelia Huck <cohuck@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-6-frankja@linux.ibm.com>
 <20191121142534.0ac78840.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 14:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121142534.0ac78840.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RIh9ZMrEBwxzdlIlFSMD6OnLeGIyTI4I0"
X-TM-AS-GCONF: 00
x-cbid: 19112113-0012-0000-0000-0000036A555B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112113-0013-0000-0000-000021A5E9B3
Message-Id: <308ab831-6401-2a7a-b3d7-9a4fc68f331a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210124
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
--RIh9ZMrEBwxzdlIlFSMD6OnLeGIyTI4I0
Content-Type: multipart/mixed; boundary="72XMGcxXwwS4utmOLG6AtknaDUSniGPjK"

--72XMGcxXwwS4utmOLG6AtknaDUSniGPjK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 2:25 PM, Cornelia Huck wrote:
> On Wed, 20 Nov 2019 06:43:24 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> We do not always have the SIE intercept code handy at each place where=

>> we do emulation. Unfortunately emulation for secure guests often
>> differ slightly from normal emulation and we need to make decisions
>> based on the protected state of the VCPU.
>>
>> Let's sync the protected state and make it available.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  linux-headers/asm-s390/kvm.h | 1 +
>>  target/s390x/cpu.h           | 1 +
>>  target/s390x/kvm.c           | 4 ++++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm=
=2Eh
>> index 41976d33f0..7c46cf6078 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -231,6 +231,7 @@ struct kvm_guest_debug_arch {
>>  #define KVM_SYNC_GSCB   (1UL << 9)
>>  #define KVM_SYNC_BPBC   (1UL << 10)
>>  #define KVM_SYNC_ETOKEN (1UL << 11)
>> +#define KVM_SYNC_PV	(1UL << 12)
>=20
> That should go into the previous patch (will be picked up by header
> sync).

Yes, will be fixed in a second

>=20
>>  /* length and alignment of the sdnx as a power of two */
>>  #define SDNXC 8
>>  #define SDNXL (1UL << SDNXC)
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 17460ed7b3..a787221772 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -116,6 +116,7 @@ struct CPUS390XState {
>> =20
>>      /* Fields up to this point are cleared by a CPU reset */
>>      struct {} end_reset_fields;
>> +    bool pv; /* protected virtualization */
>> =20
>>  #if !defined(CONFIG_USER_ONLY)
>>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c24c869e77..418154ccfe 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -676,6 +676,10 @@ int kvm_arch_get_registers(CPUState *cs)
>>          env->etoken_extension =3D cs->kvm_run->s.regs.etoken_extensio=
n;
>>      }
>> =20
>> +    if (can_sync_regs(cs, KVM_SYNC_PV)) {
>> +        env->pv =3D !!cs->kvm_run->s.regs.pv;
>> +    }
>> +
>>      /* pfault parameters */
>>      if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
>>          env->pfault_token =3D cs->kvm_run->s.regs.pft;
>=20
> As you add a new field to the cpu state... you probably can't migrate
> protected guests, so you don't need a new vmstate subsection?
>=20

We can't migrate currently, but it's on out todo list


--72XMGcxXwwS4utmOLG6AtknaDUSniGPjK--

--RIh9ZMrEBwxzdlIlFSMD6OnLeGIyTI4I0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WlJ8ACgkQ41TmuOI4
ufgwLRAAt4zpZF3fpTbpDkLzWl0nTfcOzaXI8MaX1v9ODjjcehVzsww70xbtzKA7
JlhmLWeHdaEbgk/vuuee5Gb6MXb9Xh5SActAi1vD4v673AWgeGB4q3vlbk1PCFfM
eaw6F7AdGw1eN953ShbDLigWYA0Q/qrajt77li1I4xYGjgnyxhw/W7ibTvTThXoW
aoK1IcD5DaC1amKGIPQTt/9Ym9tJU0KiBeNz8cgBSAgYY4gkSzLE7bq9Aw+83TaH
kCO/MFmtQgL6zlBFMbhbdWHSaSNj0bnDweKfhRvyTKy4YKLiwqK9eQ9hHdqdh0VR
z6wsFj1R0VyPHA/lD9T4Dd5ctzkiaCSKXj9KM+W7aSNkNICH8NrzVApQepVnIhzX
Wr6gY4NUkWmbP2iyIqJKhjYSWnKdAHJ3ZfixmONNjwMZBlNnEThHq/hXC4i0lOrU
9tTC6yr5ac7JFMwnK0vr0gBOXem+IneLO807ZS7xi03ZmEFWFNSvekFhEOiY/vKi
kF2EKyVuT6+xamR9huK5yw/mqiKF0WTyR/UKzD/INatngXTD5FIHgu0KwCONARrl
YUgzRH/kY//eFfT71kOCXO4vjAGzhwCGdJ13GIaYVAOUNGGHRgldDhKE9njasBxX
BSelO11Wonp8TAdo+ByX7wpB4O3AufmTgK5AD5ZkQRIBGori2uE=
=cImb
-----END PGP SIGNATURE-----

--RIh9ZMrEBwxzdlIlFSMD6OnLeGIyTI4I0--


