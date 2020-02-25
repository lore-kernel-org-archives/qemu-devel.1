Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769CBC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F38020726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F38020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YOC-0006r6-BS
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6YNG-0006Jr-7f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6YNE-0000se-Sz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:27:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19030
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6YNE-0000q3-M8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:27:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PBKJ9d035828
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:27:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1asgp6u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:27:35 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 25 Feb 2020 11:27:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 11:27:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PBRUNx55115948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 11:27:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8099242042;
 Tue, 25 Feb 2020 11:27:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3034A42041;
 Tue, 25 Feb 2020 11:27:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.153.129])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 11:27:30 +0000 (GMT)
Subject: Re: [PATCH v4 07/16] s390x: Add SIDA memory ops
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-8-frankja@linux.ibm.com>
 <86138afc-dd99-edab-7612-f377ba0b6246@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 25 Feb 2020 12:27:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <86138afc-dd99-edab-7612-f377ba0b6246@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qG95btXGnIlTvpYjL88SuhM0okNk5esbX"
X-TM-AS-GCONF: 00
x-cbid: 20022511-0016-0000-0000-000002EA16F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022511-0017-0000-0000-0000334D421A
Message-Id: <bf874bb9-34b1-0973-c814-4aa694c539a1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_03:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=930 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qG95btXGnIlTvpYjL88SuhM0okNk5esbX
Content-Type: multipart/mixed; boundary="X26Kbd0QR2XWcF2l9zOu9p2CbUXtf9Twq"

--X26Kbd0QR2XWcF2l9zOu9p2CbUXtf9Twq
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/25/20 10:59 AM, David Hildenbrand wrote:
> On 20.02.20 13:56, Janosch Frank wrote:
>> Protected guests save the instruction control blocks in the SIDA
>> instead of QEMU/KVM directly accessing the guest's memory.
>>
>> Let's introduce new functions to access the SIDA.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  linux-headers/linux/kvm.h |  2 ++
>>  target/s390x/cpu.h        |  7 ++++++-
>>  target/s390x/kvm.c        | 23 +++++++++++++++++++++++
>>  target/s390x/kvm_s390x.h  |  2 ++
>>  target/s390x/mmu_helper.c |  9 +++++++++
>>  5 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index 2e647f2d9b..7ccf5988d2 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -483,6 +483,8 @@ struct kvm_s390_mem_op {
>>  /* types for kvm_s390_mem_op->op */
>>  #define KVM_S390_MEMOP_LOGICAL_READ	0
>>  #define KVM_S390_MEMOP_LOGICAL_WRITE	1
>> +#define KVM_S390_MEMOP_SIDA_READ	2
>> +#define KVM_S390_MEMOP_SIDA_WRITE	3
>>  /* flags for kvm_s390_mem_op->flags */
>>  #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>>  #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index cbc53c99cf..491d6860a8 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -823,7 +823,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr ladd=
r, uint8_t ar, void *hostbuf,
>>  #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
>>          s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
>>  void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
>> -
>> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset,  void *host=
buf,
>> +                       int len, bool is_write);
>> +#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
>> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
>> +#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
>> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
>> =20
>>  /* sigp.c */
>>  int s390_cpu_restart(S390CPU *cpu);
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index eec0b92479..f222836df5 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -846,6 +846,29 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uin=
t8_t ar, void *hostbuf,
>>      return ret;
>>  }
>> =20
>> +int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
>> +                       int len, bool is_write)
>> +{
>> +    int ret =3D 0;
>=20
> move that after the struct declaration/definition. No need to initializ=
e
> to 0.

Ack

>=20
>> +    struct kvm_s390_mem_op mem_op =3D {
>> +        .sida_offset =3D offset,
>> +        .size =3D len,
>> +        .op =3D is_write ? KVM_S390_MEMOP_SIDA_WRITE
>> +                       : KVM_S390_MEMOP_SIDA_READ,
>> +        .buf =3D (uint64_t)hostbuf,
>> +    };
>> +
>> +    if (!cap_mem_op) {
>> +        return -ENOSYS;
>> +    }
>=20
> if (!cap_mem_op || !cap_protected)
>=20
> And move cap_protected from patch 15 in here.

Ack

>=20
>> +
>> +    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
>> +    if (ret < 0) {
>> +        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
>=20
> I'd even error_report(). After all, this should never fail.

Hmm, might even make sense to exit here.
In my experience a failed memop will soon result in bigger problems as
it effectively stops a cpu.

>=20
>> +    }
>> +    return ret;
>> +}
>> +
>>  /*
>>   * Legacy layout for s390:
>>   * Older S390 KVM requires the topmost vma of the RAM to be
>> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
>> index 0b21789796..9c38f6ccce 100644
>> --- a/target/s390x/kvm_s390x.h
>> +++ b/target/s390x/kvm_s390x.h
>> @@ -19,6 +19,8 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kv=
m_s390_irq *irq);
>>  void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t =
te_code);
>>  int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostb=
uf,
>>                      int len, bool is_write);
>> +int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int l=
en,
>> +                       bool is_write);
>>  void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
>>  int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>> index c9f3f34750..ad485399db 100644
>> --- a/target/s390x/mmu_helper.c
>> +++ b/target/s390x/mmu_helper.c
>> @@ -474,6 +474,15 @@ static int translate_pages(S390CPU *cpu, vaddr ad=
dr, int nr_pages,
>>      return 0;
>>  }
>> =20
>> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostb=
uf,
>> +                       int len, bool is_write)
>> +{
>> +    int ret;
>> +
>> +    ret =3D kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
>> +    return ret;
>=20
> if (kvm_enabled()) {
> ...
> } else {
>     /* Helpful comment */
>     g_assert_not_reached();
> }
>=20

Ack.

>=20



--X26Kbd0QR2XWcF2l9zOu9p2CbUXtf9Twq--

--qG95btXGnIlTvpYjL88SuhM0okNk5esbX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5VBKEACgkQ41TmuOI4
ufj8XRAAwaJ98ISQtbFsc5+PtDq3129oxB8KonjfC2gWR78s90fVDQ37jiPa1hrC
FXMca/N0cQoF6IpgvcJ3KAEgahDsXQ5KlcVWjoAftt4Pg8/GebO/bxMl1mStD3IN
Dz8hYMZC3ElmUGYkYIcgrWv3snZHj2zpzoIJVI1VSqkkKpIQ39E214Y6Epb3XdJQ
skpN2aOxSB5BhfsENRoQifjyv0/bC5IWAwW3GoGq+y4BuDVxEQ6XHyrsyfzIbUMU
wCpOLoxn1JxCQNjF8JKbCZjhOw8kGh3Ux/eqwFm0yDALPRspHbaRU4uaXkfZci6g
kKaBtR/Kd4z6P1O2+5pqGnMiI7XfePl/eZT9cXvJpt6qDYx0/t7NuLLieylwL6Kg
HmciYoiFSOir4Wse+8CbDhkfeXaRRmmTaku90jQs3LDr/JJsT4IR4FMhoKNFrARQ
EGlwJdFPIhX4aEp6ED9RndM6tEF8jSW75QeonVXfNpXhs8lpvGRCQSctE7rPO7/G
ffnvCAG0I+jpNCkCcMMEz+uGbTCrL6dzoXE4U3abUqbVQltOc4clmO5wkWL+C+WV
rTMt3zUOV+oh1Pmwq3yR2Zf67WNMZ83/6zVyF814vgv35aWqpGlixIBx2ySQgST4
BGGjr0Hmg61JrnmUpeZxonD1OT0i5c4X8gdtxeyghr0QqaLeWvk=
=7stP
-----END PGP SIGNATURE-----

--qG95btXGnIlTvpYjL88SuhM0okNk5esbX--


