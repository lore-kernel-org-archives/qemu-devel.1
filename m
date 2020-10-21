Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC56C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763A12224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IxbuRJJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763A12224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEzy-0005yi-B2
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVExk-0004Xu-BC; Wed, 21 Oct 2020 10:19:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVExe-0002rL-Ju; Wed, 21 Oct 2020 10:19:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09LE3RpD112925; Wed, 21 Oct 2020 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=f/fQSFT/XoQSA5l0VjOQ4RbX797RNR9GISM6a86hid4=;
 b=IxbuRJJjxvrTE92/sl5qmava4Av5Fk6dkv7VEkBC26wjFRNjpM3n51b3C6lhfl8teOkk
 r78QJ2IVivmplA4k250qtbpC56Ica0J8ugG0z/5N/B9XWp50nndMsPAcmvX0+2Up/nm6
 CcIXZktaL5iJ9yMZuwDE859Uv25u2HXIEmA05bWXzzQB3iwdP6SAWbkHzcMypk9dviyN
 wK5JHej5NuNcaRq31LBZvhFh6pnzYPwDqzedJcT+CIjDxUhXy1+vBfKBVsfUN3iyQdHO
 9XFC+5o+9wgaoH14nrj5May3Twf7acScCZHLHb19tXZYSYP5CnyG7/2mblI/fz5owU2R GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34apb90sk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 10:19:27 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LE3irl114613;
 Wed, 21 Oct 2020 10:19:26 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34apb90sgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 10:19:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09LEI1jS007528;
 Wed, 21 Oct 2020 14:19:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03fra.de.ibm.com with ESMTP id 347r87t9s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2020 14:19:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09LEJLS133882544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2020 14:19:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C8552057;
 Wed, 21 Oct 2020 14:19:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.95])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8934B52051;
 Wed, 21 Oct 2020 14:19:20 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390x: pv: Fix diag318 PV fencing
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20201021134345.110173-1-frankja@linux.ibm.com>
 <20201021134345.110173-3-frankja@linux.ibm.com>
 <fa050bc9-db4e-8800-d7d5-a2931bebce78@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea3dcaba-8d3a-958f-7c6b-f340187f7ba5@linux.ibm.com>
Date: Wed, 21 Oct 2020 16:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fa050bc9-db4e-8800-d7d5-a2931bebce78@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1cPwQKhhVgGvJDFCm05pKj0bXAAVF83xs"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-21_06:2020-10-20,
 2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 09:43:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, cohuck@redhat.com, walling@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1cPwQKhhVgGvJDFCm05pKj0bXAAVF83xs
Content-Type: multipart/mixed; boundary="cmdC2meIf2KuQ3zMXbVwzKa8PCJVU2X3Z"

--cmdC2meIf2KuQ3zMXbVwzKa8PCJVU2X3Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/21/20 4:14 PM, David Hildenbrand wrote:
> On 21.10.20 15:43, Janosch Frank wrote:
>> Diag318 fencing needs to be determined on the current VM PV state and
>> not on the state that the VM has when we create the CPU model.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c    | 10 ++++++++++
>>  target/s390x/kvm.c |  3 +--
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 0cf2290826..69aba402d3 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -22,6 +22,7 @@
>>  #include "hw/s390x/event-facility.h"
>>  #include "hw/s390x/s390-pci-bus.h"
>>  #include "hw/s390x/ipl.h"
>> +#include "hw/s390x/pv.h"
>> =20
>>  static inline SCLPDevice *get_sclp_device(void)
>>  {
>> @@ -142,6 +143,15 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB =
*sccb)
>>      if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>>          s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
>>                              &read_info->fac134);
>> +        /*
>> +         * Diag318 is not available in protected mode and will result=

>> +         * in an operation exception. As we can dynamically move in
>> +         * and out of protected mode, we need to fence the feature
>> +         * here rather than when creating the CPU model.
>> +         */
>> +        if (s390_is_pv()) {
>> +            read_info->fac134 &=3D ~0x80;
>> +        }
>=20
> Hmm, I thought firmware would handle exposing cpu features and similar,=

> so we can't temper with it ....

STFLE data is indeed provided by the Ultravisor, but SCLP is still done
by QEMU as that data is often not machine specific as visible in this cas=
e

>=20
> Can we move that into s390_get_feat_block instead and check against the=

> feature bit instead?
>=20
You mean fence inside the s390_get_feat_block() function?


--cmdC2meIf2KuQ3zMXbVwzKa8PCJVU2X3Z--

--1cPwQKhhVgGvJDFCm05pKj0bXAAVF83xs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl+QQ2gACgkQ41TmuOI4
ufinXA/8CnhMQe+htEj6XZEHp5Iu7d3+MGMxysgjkgmliPWpwEGRe8Et+MLaRMDS
HC0pml5zFMvqQ3UW69StpfmN6e95cH8qgwQOE+pNc99nGNFekblDK6bAh0EJ6OQs
CUQDH8Ba7EwUccF7YO08KmCeV1Iff/t6dgee2q1FHUaIpBZ/TaPqspXPN1ja79wd
q+ZTz+xy+dtqc/ozwVzro6gK3gZQtWOq9B0vNOmhgaOAShs/UJ7mCZP2wz8fxe/O
2CjmGt+Q+V9e5GQkZqIvtHTv0QCK5kZFJVMhzEumj1DIglHN+/VBn31egxvjSrLl
TbAE45ellO2v4Qv4qK9/sMQIXeZY292l34VH4BOGKAkHM69gd25idt95OCYBWe3D
Qvwqok+JwGitrOmOciyoj+pCi08/tG0oqAZuvo+CWBLDU+5JfrpMgU00tUhw66Py
CfYTfTFbL1J2g2j0gWi9mPr52skh9JWuOMmDAyZLTObB8dtUUTGi0xnoLlBVCezX
RLNqI+3pX6kxOsmE+IMEvT6R7B5sHiYtKx79DZtziQC14dUbGIptWCmGI8KpN0eB
+WOcl2aJbZytsWI3pNvqLwpBZpNiR4ISFdbajTBNmSxPiMlfOHlRVBRFR3uteeWY
1dU4nfOe4qNrXBcqW7XALFiAPZt4Vjli5+tGNieKbd/Ci5ribqQ=
=1kLp
-----END PGP SIGNATURE-----

--1cPwQKhhVgGvJDFCm05pKj0bXAAVF83xs--


