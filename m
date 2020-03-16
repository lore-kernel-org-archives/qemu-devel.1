Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A245C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165BF2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165BF2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmkP-0006vt-QQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jDme5-0004xl-4E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jDme3-0002qf-M8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:06:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jDme3-0002QI-Cx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:06:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02GA1q8M094595
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:06:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrubmjsb6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:06:47 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 16 Mar 2020 10:06:45 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Mar 2020 10:06:43 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02GA6gHE56164526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 10:06:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99B0E52052;
 Mon, 16 Mar 2020 10:06:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.172.134])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 494185204F;
 Mon, 16 Mar 2020 10:06:42 +0000 (GMT)
Subject: Re: [PATCH v9] s390x: protvirt: Fence huge pages
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200312162510.5472-1-frankja@linux.ibm.com>
 <09c0b73f-9587-ded0-35c3-f7ce231af69d@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 16 Mar 2020 11:06:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <09c0b73f-9587-ded0-35c3-f7ce231af69d@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lRI0yoZxLRIUDHsIrpNcCVsGDAH4chUv4"
X-TM-AS-GCONF: 00
x-cbid: 20031610-0028-0000-0000-000003E595FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031610-0029-0000-0000-000024AAE671
Message-Id: <0cf5c31d-0b7a-ea39-287d-7014845e765f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-16_02:2020-03-12,
 2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160049
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRI0yoZxLRIUDHsIrpNcCVsGDAH4chUv4
Content-Type: multipart/mixed; boundary="Lr3RiBCL2e1Qow6DkrPjaqD97NXjsgP9J"

--Lr3RiBCL2e1Qow6DkrPjaqD97NXjsgP9J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/13/20 9:21 AM, Christian Borntraeger wrote:
>=20
>=20
> On 12.03.20 17:25, Janosch Frank wrote:
>> Let's bail out of the protected transition if we detect that huge
>> pages might be in use.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> I'd like to squash this into the unpack patch to give a proper error
>> message if we try to transition into the protected mode while being
>> backed by huge pages.=20
>=20
> Looks good.
> But maybe we can do it better. Why not reverse the logic and
> instead of having kvm_s390_get_hpage_1m, let us define an protvirt_allo=
wed
> that as of today only returns hugepages !=3D 1:
> Then we could (for kvm-stub.c) also say protvirt_allowed=3Dfalse;
> And if other reasons come along we can extend.
>=20
> We could also keep this patch separate, does not really matter.

The *_allowed() functions are all based on the machine and part of
s390-virtio-ccw.c so having one in kvm.c looks strange.

!protvirt_allowed could have any number of reasons in the future, I
introduced this patch to give a specific error message that can help the
user to chose the right options when looking for the error.

Other ideas or a revised one?

>=20
>>
>> ---
>>  hw/s390x/ipl.h             | 16 ++++++++++++++++
>>  hw/s390x/s390-virtio-ccw.c |  1 -
>>  target/s390x/diag.c        | 23 ++++++++---------------
>>  target/s390x/kvm-stub.c    |  5 +++++
>>  target/s390x/kvm.c         |  5 +++++
>>  target/s390x/kvm_s390x.h   |  1 +
>>  6 files changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index af5bb130a6334821..95e3183c9cccf8b6 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -185,6 +185,22 @@ struct S390IPLState {
>>  typedef struct S390IPLState S390IPLState;
>>  QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of ip=
lb wrong");
>> =20
>> +#define DIAG_308_RC_OK              0x0001
>> +#define DIAG_308_RC_NO_CONF         0x0102
>> +#define DIAG_308_RC_INVALID         0x0402
>> +#define DIAG_308_RC_NO_PV_CONF      0x0902
>> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
>> +
>> +#define DIAG308_RESET_MOD_CLR       0
>> +#define DIAG308_RESET_LOAD_NORM     1
>> +#define DIAG308_LOAD_CLEAR          3
>> +#define DIAG308_LOAD_NORMAL_DUMP    4
>> +#define DIAG308_SET                 5
>> +#define DIAG308_STORE               6
>> +#define DIAG308_PV_SET              8
>> +#define DIAG308_PV_STORE            9
>> +#define DIAG308_PV_START            10
>> +
>>  #define S390_IPL_TYPE_FCP 0x00
>>  #define S390_IPL_TYPE_CCW 0x02
>>  #define S390_IPL_TYPE_PV 0x05
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index ebdaaa3a001f6e8c..d32f35c7f47b9c1d 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -361,7 +361,6 @@ out_err:
>>      return rc;
>>  }
>> =20
>> -#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
>>  static void s390_machine_inject_pv_error(CPUState *cs)
>>  {
>>      int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b245e557037ded06..b1ca81633b83bbdc 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -21,6 +21,7 @@
>>  #include "hw/s390x/ipl.h"
>>  #include "hw/s390x/s390-virtio-ccw.h"
>>  #include "hw/s390x/pv.h"
>> +#include "kvm_s390x.h"
>> =20
>>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>>  {
>> @@ -50,21 +51,6 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1=
, uint64_t r3)
>>      return diag288_class->handle_timer(diag288, func, timeout);
>>  }
>> =20
>> -#define DIAG_308_RC_OK              0x0001
>> -#define DIAG_308_RC_NO_CONF         0x0102
>> -#define DIAG_308_RC_INVALID         0x0402
>> -#define DIAG_308_RC_NO_PV_CONF      0x0902
>> -
>> -#define DIAG308_RESET_MOD_CLR       0
>> -#define DIAG308_RESET_LOAD_NORM     1
>> -#define DIAG308_LOAD_CLEAR          3
>> -#define DIAG308_LOAD_NORMAL_DUMP    4
>> -#define DIAG308_SET                 5
>> -#define DIAG308_STORE               6
>> -#define DIAG308_PV_SET              8
>> -#define DIAG308_PV_STORE            9
>> -#define DIAG308_PV_START            10
>> -
>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>>                                uintptr_t ra, bool write)
>>  {
>> @@ -166,6 +152,13 @@ out:
>>              return;
>>          }
>> =20
>> +        if (kvm_s390_get_hpage_1m()) {
>> +            error_report("Protected VMs can currently not be backed w=
ith "
>> +                         "huge pages");
>> +            env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
>> +            return;
>> +        }
>> +
>>          s390_ipl_reset_request(cs, S390_RESET_PV);
>>          break;
>>      default:
>> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
>> index c4cd497f850eb9c7..aa185017a2a886ca 100644
>> --- a/target/s390x/kvm-stub.c
>> +++ b/target/s390x/kvm-stub.c
>> @@ -39,6 +39,11 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)=

>>      return 0;
>>  }
>> =20
>> +int kvm_s390_get_hpage_1m(void)
>> +{
>> +    return 0;
>> +}
>> +
>>  int kvm_s390_get_ri(void)
>>  {
>>      return 0;
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 1d6fd6a27b48e35f..c695941076b7aead 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -321,6 +321,11 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize,=
 Error **errp)
>>      cap_hpage_1m =3D 1;
>>  }
>> =20
>> +int kvm_s390_get_hpage_1m(void)
>> +{
>> +    return cap_hpage_1m;
>> +}
>> +
>>  static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
>> index 0b21789796d7c462..dea813f450153c34 100644
>> --- a/target/s390x/kvm_s390x.h
>> +++ b/target/s390x/kvm_s390x.h
>> @@ -23,6 +23,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16=
_t code);
>>  int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
>>  int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
>> +int kvm_s390_get_hpage_1m(void);
>>  int kvm_s390_get_ri(void);
>>  int kvm_s390_get_gs(void);
>>  int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
>>
>=20
>=20



--Lr3RiBCL2e1Qow6DkrPjaqD97NXjsgP9J--

--lRI0yoZxLRIUDHsIrpNcCVsGDAH4chUv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5vT7EACgkQ41TmuOI4
ufhkpQ//ZyFpzBFAdSyHn9pkHCNXBy/GjYb61jpzBU8vHlM8ydWtSDz2Sd+OrdOV
N1Tx9jI3IeiId3X+yCO7hmtaHFEH4rMmNv0wcxGJmqy5GkIIrOuKh2ij8mLsQVV9
iaRo1miQX/h5xdJpxfLGOyxvJp4Wr0rKgALFGyGLi/y6dIk/3arIyjky1icQVGf9
H26lNRtpA24wgFwGF4XYUmB4Mx27muNYZ3C7+el6u/QiUHRpqlYDAojJLw8KFuRM
6Xf7lEMKyTdpjoGQ5PE1VmAan/g1SQzRDtXgkC8hjgVhdsZiJ8Le+Bo2pRqbJU3G
HPbXPVMJJqyIr+JGKvtwXhsd4Qf6SaCAU+SncFc/kB//Q0Q9paxVgRaaW2yMVmcK
fCOO/Go13ChleDqSEz3sT7WcGjaAHsv+jhZ5cX2jTReCyQHWHxXjW4pebUnq6WB+
RrFo/IId+1/xnE+VQkWnvLqGxQAFU9F7i3jjGqTClzfEiZl/AjhS7F2qPBiyXCdi
9Hwu05jpoA7k3HUhN4l1egSLpKT+l+2bF7+sGZhhDTNEqXd+h68HhxFbCGUDXKuP
c60XumI2g4PY1mdMYXmQyBj49vzLqGumUzgDgCa1VUiaCcCDZVVaTPxINlruUKkA
RWmRz0UNGiDv1JydcWI/g9bLjIexfWbD+MW39h+xWtnGmrej8ZU=
=Nra7
-----END PGP SIGNATURE-----

--lRI0yoZxLRIUDHsIrpNcCVsGDAH4chUv4--


