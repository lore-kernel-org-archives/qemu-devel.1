Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E7320870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E7320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Pss-00042O-4I
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9PsB-0003Zt-Di
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9Ps9-0000Ks-UD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:59:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9Ps9-0000Hz-LD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:59:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0248ttwM084480
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 03:59:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj3eru62h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:59:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 08:59:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 08:59:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0248xBF859572292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 08:59:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB7A952051;
 Wed,  4 Mar 2020 08:59:11 +0000 (GMT)
Received: from dyn-9-152-224-55.boeblingen.de.ibm.com (unknown [9.152.224.55])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C4845204E; 
 Wed,  4 Mar 2020 08:59:11 +0000 (GMT)
Subject: Re: [PATCH] pc-bios: s390x: Save iplb location in lowcore
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200303155010.2519-1-frankja@linux.ibm.com>
 <49294c6a-38f6-8358-b613-72d3c3c7cf4f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 4 Mar 2020 09:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <49294c6a-38f6-8358-b613-72d3c3c7cf4f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GQyHNTDad26aYrpe77K8XKu2CegBrGO60"
X-TM-AS-GCONF: 00
x-cbid: 20030408-0020-0000-0000-000003B055FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030408-0021-0000-0000-0000220889EB
Message-Id: <7eee8f67-d1a1-39e5-af8b-4bd6dc815005@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_01:2020-03-03,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=3 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=697 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040070
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GQyHNTDad26aYrpe77K8XKu2CegBrGO60
Content-Type: multipart/mixed; boundary="EE7DbAn6MsSkFMUW42I93wspO5j1Z9Lun"

--EE7DbAn6MsSkFMUW42I93wspO5j1Z9Lun
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/3/20 5:13 PM, David Hildenbrand wrote:
> On 03.03.20 16:50, Janosch Frank wrote:
>> The POP states that for a list directed IPL the IPLB is stored into
>> memory by the machine loader and its address is stored at offset 0x14
>> of the lowcore.
>>
>> ZIPL currently uses the address in offset 0x14 to access the IPLB and
>> acquire flags about secure boot. If the IPLB address points into
>> memory which has an unsupported mix of flags set, ZIPL will panic
>> instead of booting the OS.
>>
>> As the lowcore can have quite a high entropy for a guest that did drop=

>> out of protected mode (i.e. rebooted) we encountered the ZIPL panic
>> quite often.
>=20
> How did this ever work? Or does this only become relevant with secure b=
oot?

I'd guess that until secure boot ZIPL never touched this and with it we
never hit the right combination of flags to trigger a ZIPL panic.

This way of getting to the IPLB was used before diag308 was available,
i.e. way before KVM got to IBM Z. It looks like ZIPL only uses it for
secure boot for some reason and hence we never implemented it before.

I'm also in discussion with the ZIPL developers to make this more robust.=


>=20
> Fixes: ? Or has this always been broken?

See above

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/jump2ipl.c  |  1 +
>>  pc-bios/s390-ccw/main.c      |  8 +++++++-
>>  pc-bios/s390-ccw/netmain.c   |  1 +
>>  pc-bios/s390-ccw/s390-arch.h | 10 ++++++++--
>>  pc-bios/s390-ccw/s390-ccw.h  |  1 +
>>  5 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index da13c43cc0..4eba2510b0 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -35,6 +35,7 @@ void jump_to_IPL_code(uint64_t address)
>>  {
>>      /* store the subsystem information _after_ the bootmap was loaded=
 */
>>      write_subsystem_identification();
>> +    write_iplb_location();
>> =20
>>      /* prevent unknown IPL types in the guest */
>>      if (iplb.pbt =3D=3D S390_IPL_TYPE_QEMU_SCSI) {
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index a21b386280..4e65b411e1 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -9,6 +9,7 @@
>>   */
>> =20
>>  #include "libc.h"
>> +#include "helper.h"
>>  #include "s390-arch.h"
>>  #include "s390-ccw.h"
>>  #include "cio.h"
>> @@ -22,7 +23,7 @@ QemuIplParameters qipl;
>>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>>  static bool have_iplb;
>>  static uint16_t cutype;
>> -LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
>> +LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>> =20
>>  #define LOADPARM_PROMPT "PROMPT  "
>>  #define LOADPARM_EMPTY  "        "
>> @@ -42,6 +43,11 @@ void write_subsystem_identification(void)
>>      *zeroes =3D 0;
>>  }
>> =20
>> +void write_iplb_location(void)
>> +{
>> +    lowcore->ptr_iplb =3D ptr2u32(&iplb);
>> +}
>> +
>>  void panic(const char *string)
>>  {
>>      sclp_print(string);
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index f2dcc01e27..309ffa30d9 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -40,6 +40,7 @@
>>  #define DEFAULT_TFTP_RETRIES 20
>> =20
>>  extern char _start[];
>> +void write_iplb_location(void) {}
>> =20
>>  #define KERNEL_ADDR             ((void *)0L)
>>  #define KERNEL_MAX_SIZE         ((long)_start)
>> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch=
=2Eh
>> index 504fc7c2f0..5f36361c02 100644
>> --- a/pc-bios/s390-ccw/s390-arch.h
>> +++ b/pc-bios/s390-ccw/s390-arch.h
>> @@ -36,7 +36,13 @@ typedef struct LowCore {
>>      /* prefix area: defined by architecture */
>>      PSWLegacy       ipl_psw;                  /* 0x000 */
>>      uint32_t        ccw1[2];                  /* 0x008 */
>> -    uint32_t        ccw2[2];                  /* 0x010 */
>> +    union {
>> +        uint32_t        ccw2[2];                  /* 0x010 */
>> +        struct {
>> +            uint32_t reserved10;
>> +            uint32_t ptr_iplb;
>> +        };
>> +    };
>>      uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
>>      uint32_t        ext_params;               /* 0x080 */
>>      uint16_t        cpu_addr;                 /* 0x084 */
>> @@ -85,7 +91,7 @@ typedef struct LowCore {
>>      PSW             io_new_psw;               /* 0x1f0 */
>>  } __attribute__((packed, aligned(8192))) LowCore;
>> =20
>> -extern LowCore const *lowcore;
>> +extern LowCore *lowcore;
>> =20
>>  static inline void set_prefix(uint32_t address)
>>  {
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h=

>> index 11bce7d73c..21f27e7990 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -57,6 +57,7 @@ void consume_io_int(void);
>>  /* main.c */
>>  void panic(const char *string);
>>  void write_subsystem_identification(void);
>> +void write_iplb_location(void);
>>  extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE=
)));
>>  unsigned int get_loadparm_index(void);
>=20
> In general LGTM.
>=20
>=20
> Side note: I wonder if the assert in ptr2u32() should actually be
>=20
> IPL_assert((uint64_t)ptr <=3D 0xfffffffful, "ptr2u32: ptr too large");
> 				      ^
> or even better
>=20
> IPL_assert((uint64_t)ptr !=3D (uint32_t)ptr, "ptr2u32: ptr too large");=

>=20
> Otherwise, sign extension will simply always make this pass.
>=20

Do you want to add a patch or shall I add it to my cleanup series?



--EE7DbAn6MsSkFMUW42I93wspO5j1Z9Lun--

--GQyHNTDad26aYrpe77K8XKu2CegBrGO60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5fbd8ACgkQ41TmuOI4
ufiLZRAA1o4L9kUHo1O/ePe7tNgjxNR9a8rr0kQuqecnQqsBjj61Opz/6R6vlhKS
d39Iw0IL/1FqdfhkCgbn3yH4CrSTfD2iEyISLMbhqpHlACUSqjir8nhCbLgBwXoR
cxciiHPLgTeiR9rhB74sPNCoF0l0uyCneIKJPB0O5RlwvSmrtBCuFpnvsY1Iq1D5
sl2SgA0ehP4j/aJ6VR+wJj2Pz6JCLLFFSO/wMs/AKFCeS6RlaE6+xnZ4BOaJvgax
lvalVsA8wmrHPLX4gHU2i2oubqUW2Y0/2+dMIlv9ewWG6XFiaO51UWc50Cpm58qJ
cgNnoJpln6Z9VYGs4ClnT5yg8i2bC5Ec+fJVhrPulodcfPzLfv/d/om6bL2iSG20
WR0EEGMbrflZIEpBhTnyq20tFkVE75FrcfU6faGZ17YfNG9cIUhzUuIoyYmKo5hz
bS4bzTSeD4G2JZBci+wDnLwalyDdaQdPXpwP/mprfPaKvOVM7e/zfn/GU8vVNXwJ
2q3ruZSFYOiVkrV+1K8ihHcljUkGNgWopOnlvpq4Mz8LdKM6B1OiN7vfPNrw+5mT
Or+n8Dv4BQ2Parc441l953zBkkHGGxaGaN327rUzl0q9buW8hEenk7sb9EErwTGB
C2U1Ot6T5RrfkTpuMozsogkoiDsXtuGzmatnCnJMElGP571dFmQ=
=iVf2
-----END PGP SIGNATURE-----

--GQyHNTDad26aYrpe77K8XKu2CegBrGO60--


