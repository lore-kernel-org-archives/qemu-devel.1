Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B17C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACB52071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QVPEz+uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACB52071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ3K-000148-Jl
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kDQ2G-0000Pk-1b
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kDQ2D-0004fK-Hk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:30:35 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 082A2j2Q055911
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2020 06:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=34agCoMrejinwYg0gnhdrqXM/e+LabRoH97zbHfFV9M=;
 b=QVPEz+uKe3qxo6nPBynez40o9Qsss/jeXt2D3bgEC9WwSy+Y9IZp78yOLIuOAEFlm/V9
 JDs3nZYCbX+bzM65J5AD+2XPoK6zKX/9oMvhecWPJM4J26OI/j1tPWsDzR35eGzqCyVb
 +8FbtBAzno3cxV0qy4TIloUmJd6ecebxqYfHCfAriulHAGKWblkhogXL3D13abC2uC7Y
 JLOzjs0PqRUThMzR9hiHKMiRiItDKUthlu7vK5n3nSxpgr9ljvMVTFZ6pO9smUxqmts+
 iH9KWsstHVte8YxsgK1JXXYrpLngem186/UmAO2uKSTCd9HtOX9qrd4IqMdgfE4TdjJh 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33a6uuw5vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:30:31 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082AMLSY141047
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2020 06:30:31 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33a6uuw5ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2020 06:30:31 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082AQx7c019592;
 Wed, 2 Sep 2020 10:30:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 339ap7s4yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2020 10:30:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 082AUQIG18809126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2020 10:30:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 840B942057;
 Wed,  2 Sep 2020 10:30:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3112E42045;
 Wed,  2 Sep 2020 10:30:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.35.147])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2020 10:30:26 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200831150910.317171-1-frankja@linux.ibm.com>
 <20200831150910.317171-5-frankja@linux.ibm.com>
 <de13e951-212a-0a16-e50c-ceeed688f655@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c35adf44-864f-e74f-4f62-b715f7fee5ef@linux.ibm.com>
Date: Wed, 2 Sep 2020 12:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <de13e951-212a-0a16-e50c-ceeed688f655@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PyLWfbK3u4cZZEFVCmUFWbro9QlipQS44"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-02_03:2020-09-02,
 2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 06:30:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PyLWfbK3u4cZZEFVCmUFWbro9QlipQS44
Content-Type: multipart/mixed; boundary="tYPFgodtDiPj5vX2bLuYTrRsfJA67mQ2I"

--tYPFgodtDiPj5vX2bLuYTrRsfJA67mQ2I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/1/20 7:22 PM, Thomas Huth wrote:
> On 31/08/2020 17.09, Janosch Frank wrote:
>> Currently we always overwrite the mentioned exception new PSWs before
>> loading the enabled wait PSW. Let's save the PSW before overwriting
>> and restore it right before starting the loaded kernel.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/jump2ipl.c |  4 +++
>>  pc-bios/s390-ccw/netmain.c  |  3 ++
>>  pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++---------=
-
>>  3 files changed, 52 insertions(+), 17 deletions(-)
>=20
> Patch looks basically fine to me, I just got some questions for my
> understanding below...
>=20
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index 5b8352d257..bb94ba7550 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -14,6 +14,7 @@
>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>>  #define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
>> =20
>> +extern uint64_t psw_save_io[], psw_save_ext[];
>>  static uint64_t *reset_psw =3D 0, save_psw, ipl_continue;
>> =20
>>  void write_reset_psw(uint64_t psw)
>> @@ -59,6 +60,9 @@ void jump_to_IPL_code(uint64_t address)
>>      /* Ensure the guest output starts fresh */
>>      sclp_print("\n");
>> =20
>> +    memcpy(&lowcore->io_new_psw, psw_save_io, 16);
>> +    memcpy(&lowcore->external_new_psw, psw_save_ext, 16);
>> +
>>      /*
>>       * HACK ALERT.
>>       * We use the load normal reset to keep r15 unchanged. jump_to_IP=
L_2
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 056e93a818..74ef28fbc6 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -32,6 +32,7 @@
>>  #include <time.h>
>>  #include <pxelinux.h>
>> =20
>> +#include "s390-arch.h"
>>  #include "s390-ccw.h"
>>  #include "cio.h"
>>  #include "virtio.h"
>> @@ -43,6 +44,8 @@
>>  extern char _start[];
>>  void write_iplb_location(void) {}
>> =20
>> +LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>> +
>>  #define KERNEL_ADDR             ((void *)0L)
>>  #define KERNEL_MAX_SIZE         ((long)_start)
>>  #define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux =
kernel */
>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>> index ce519300a1..939aac3a7c 100644
>> --- a/pc-bios/s390-ccw/start.S
>> +++ b/pc-bios/s390-ccw/start.S
>> @@ -34,7 +34,17 @@ remainder:
>>  	larl	%r2,memsetxc
>>  	ex	%r3,0(%r2)
>>  done:
>> -	j      main		/* And call C */
>> +        /* prepare i/o call handler */
>> +        larl  %r1, io_new_code
>> +        larl  %r2, io_new_psw
>> +        stg   %r1, 8(%r2)
>> +        mvc   0x1f0(16),0(%r2)
>> +        /* prepare external call handler */
>> +        larl  %r1, external_new_code
>> +        larl  %r2, external_new_psw
>> +        stg   %r1, 8(%r2)
>=20
> Can't you specify the external_new_code and io_new_code in the
> external_new_psw / io_new_psw directly? Or is our relocation code not
> good enough for this?

Initially I had some problems with this. I just had another try and it
seems to work well, but as the testing infrastructure doesn't really
work, I can't vouch for that.

>=20
>> +        mvc   0x1b0(16),0(%r2)
>> +        j      main		/* And call C */
>> =20
>>  memsetxc:
>>  	xc	0(1,%r1),0(%r1)
>> @@ -64,13 +74,16 @@ consume_sclp_int:
>>          oi      6(%r15),0x2
>>          lctlg   %c0,%c0,0(%r15)
>>          /* prepare external call handler */
>> -        larl %r1, external_new_code
>> -        stg %r1, 0x1b8
>> -        larl %r1, external_new_mask
>> -        mvc 0x1b0(8),0(%r1)
>> -        /* load enabled wait PSW */
>> -        larl %r1, enabled_wait_psw
>> -        lpswe 0(%r1)
>> +        larl  %r1, external_new_psw
>> +        lghi  %r2, 0x1b0
>> +        /* Is the BIOS' external new PSW already set? */
>> +        clc   0(16, %r1), 0(%r2)
>> +        je    load_ewait
>> +        /* No, save old PSW and write BIOS PSW */
>> +        larl  %r3, psw_save_ext
>> +        mvc   0(16, %r3), 0x1b0
>> +        mvc   0x1b0(16),0(%r1)
>> +        j     load_ewait
>> =20
>>  /*
>>   * void consume_io_int(void)
>> @@ -84,11 +97,20 @@ consume_io_int:
>>          oi    4(%r15), 0xff
>>          lctlg %c6,%c6,0(%r15)
>>          /* prepare i/o call handler */
>> -        larl  %r1, io_new_code
>> -        stg   %r1, 0x1f8
>> -        larl  %r1, io_new_mask
>> -        mvc   0x1f0(8),0(%r1)
>> -        /* load enabled wait PSW */
>> +        larl  %r1, io_new_psw
>> +        lghi  %r2, 0x1f0
>> +        /* Is the BIOS' PSW already set? */
>> +        larl  %r3, load_ewait
>> +        clc   0(16, %r1), 0(%r2)
>> +        bcr   8, %r3
>=20
> Why not a "je load_ewait" again, like in the consume_sclp_int handler?

Great question

>=20
>> +        /* No, save old PSW and write BIOS PSW */
>> +        larl  %r3, psw_save_io
>> +        mvc   0(16, %r3), 0x1f0
>> +        mvc   0x1f0(16),0(%r1)
>> +        j     load_ewait
>> +
>> +load_ewait:
>> +        /* PSW is the correct one, time to load the enabled wait PSW =
*/
>>          larl  %r1, enabled_wait_psw
>>          lpswe 0(%r1)
>> =20
>> @@ -107,11 +129,17 @@ io_new_code:
>>          br    %r14
>> =20
>>          .align  8
>> +        .globl psw_save_io
>> +        .globl psw_save_ext
>>  disabled_wait_psw:
>>          .quad   0x0002000180000000,0x0000000000000000
>>  enabled_wait_psw:
>>          .quad   0x0302000180000000,0x0000000000000000
>> -external_new_mask:
>> -        .quad   0x0000000180000000
>> -io_new_mask:
>> -        .quad   0x0000000180000000
>> +external_new_psw:
>> +        .quad   0x0000000180000000,0
>> +io_new_psw:
>> +        .quad   0x0000000180000000,0
>> +psw_save_io:
>> +        .quad   0,0
>> +psw_save_ext:
>> +        .quad   0,0
>>
>=20
> In case you respin, could you maybe add some local #defines for 0x1f0
> and 0x1b0 ?

At the top of this file?

>=20
>  Thomas
>=20



--tYPFgodtDiPj5vX2bLuYTrRsfJA67mQ2I--

--PyLWfbK3u4cZZEFVCmUFWbro9QlipQS44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9PdEEACgkQ41TmuOI4
ufhk6g//ZZwtJEdBl6PxNAyDGc4Bl4mXHYzXYuU9fIDBl8UjKDZO4zXqgN3QsjeI
AdRtH5LYpY5/JfFCeRnoczBbCv4oD3jt7ImXgsX6RNRqq3jk6PiBRilr2XKMjiT1
JrLwihYVqKKctWRjEwLv7t94aepyYrB8axspNuldqyAbSQ57I60xws7Fr9TRQHdT
TX5loiKd4/kXQbOex8gP3+/r+Rz2FD5jLmTZ6vdSSm6aVkJ7AAFfoQqrdbrIQb6b
A3XTnaw3D54g3l69Kq8Lgdb3ajPIXZmIGY2ajZPjLZz0FsEr2e8wItOYEqQUUqDk
euyAPzlazOVoL9sO8hl+NHmeB0r6SRrB6WHAblSTwnBVwvKGvtRyb56C+AZiS+y5
cuGQjsop2U5HgD8SgqkIAmj74MQiQ/awFlUOi0KvtDE/+NsJBNoqTFh9+IYtBB3S
VKUCNdC2kPRGA2Fa0n9WiZvmhbFvOO3K9pafn6EyA3Bm4eNrD5MHb9u5rzWO8NmG
LhE8NZDaGxTeXxT4wh8SzPvPUDzvh9LoOmRGmFIyWK/6m0SLrNr/z9kuHn6YnjTI
DtploAOM1fvLs1PznzrOURf7kbOtAaMPwjnhht6G/sDw+ZKdNyogrYq6RNc/St40
Kgw0GzhaCljSuscbrCZJ98wM4bITQPdwWLFiNez4W54MurYNOP4=
=gwds
-----END PGP SIGNATURE-----

--PyLWfbK3u4cZZEFVCmUFWbro9QlipQS44--


