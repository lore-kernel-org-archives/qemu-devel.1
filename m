Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F727C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E65A2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmSJ-0002nq-4Q
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iDmKb-0003vg-Dn
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iDmKa-0001Vp-1C
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:14:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iDmKZ-0001To-P7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:14:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8R98HpQ109206
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 05:14:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v9fey0cmn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 05:14:25 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 27 Sep 2019 10:14:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 27 Sep 2019 10:14:20 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8R9EIqH49938570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2019 09:14:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C3C8AE045;
 Fri, 27 Sep 2019 09:14:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F01B3AE055;
 Fri, 27 Sep 2019 09:14:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.85.251])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2019 09:14:17 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] s390x: Add sclp boundary check and fix error
 priority
To: David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <1569497622-12496-1-git-send-email-imbrenda@linux.ibm.com>
 <1569497622-12496-2-git-send-email-imbrenda@linux.ibm.com>
 <d7ee2ad4-d928-88f1-94d6-3f6b22d2da72@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 27 Sep 2019 11:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d7ee2ad4-d928-88f1-94d6-3f6b22d2da72@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TYN3slF9M4hiIIkraDXNhVBpUgqlWik6D"
X-TM-AS-GCONF: 00
x-cbid: 19092709-0008-0000-0000-0000031B9A4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092709-0009-0000-0000-00004A3A38E0
Message-Id: <a7f404a1-7985-e506-db3e-815bb6d8e8cc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-27_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TYN3slF9M4hiIIkraDXNhVBpUgqlWik6D
Content-Type: multipart/mixed; boundary="YxRJWbs5wERXllzShC8yECjaJZSs2Xdc2";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com
Message-ID: <a7f404a1-7985-e506-db3e-815bb6d8e8cc@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390x: Add sclp boundary check and fix error
 priority
References: <1569497622-12496-1-git-send-email-imbrenda@linux.ibm.com>
 <1569497622-12496-2-git-send-email-imbrenda@linux.ibm.com>
 <d7ee2ad4-d928-88f1-94d6-3f6b22d2da72@redhat.com>
In-Reply-To: <d7ee2ad4-d928-88f1-94d6-3f6b22d2da72@redhat.com>

--YxRJWbs5wERXllzShC8yECjaJZSs2Xdc2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/27/19 10:51 AM, David Hildenbrand wrote:
> On 26.09.19 13:33, Claudio Imbrenda wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> * All sclp codes need to be checked for page boundary violations.
>> * Requests over 4k are not a spec exception.
>> * Invalid command checking has to be done before the boundary check.
>=20
> Can we split this patch up so we fix one thing at a time?

Sure, but we would end up with very small patches.
Do you want that?

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>  hw/s390x/event-facility.c |  3 ---
>>  hw/s390x/sclp.c           | 25 ++++++++++++++++++++++---
>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index 797ecbb..6620569 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -377,9 +377,6 @@ static void command_handler(SCLPEventFacility *ef,=
 SCCB *sccb, uint64_t code)
>>      case SCLP_CMD_WRITE_EVENT_MASK:
>>          write_event_mask(ef, sccb);
>>          break;
>> -    default:
>> -        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP_CO=
MMAND);
>> -        break;
>>      }
>>  }
>> =20
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index fac7c3b..76feac8 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -213,14 +213,33 @@ int sclp_service_call(CPUS390XState *env, uint64=
_t sccb, uint32_t code)
>>      cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
>> =20
>>      /* Valid sccb sizes */
>> -    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader) ||
>> -        be16_to_cpu(work_sccb.h.length) > SCCB_SIZE) {
>> +    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
>>          r =3D -PGM_SPECIFICATION;
>>          goto out;
>>      }
>> =20
>> -    sclp_c->execute(sclp, &work_sccb, code);
>> +    switch (code & SCLP_CMD_CODE_MASK) {
>> +    case SCLP_CMDW_READ_SCP_INFO:
>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
>> +    case SCLP_CMDW_READ_CPU_INFO:
>> +    case SCLP_CMDW_CONFIGURE_IOA:
>> +    case SCLP_CMDW_DECONFIGURE_IOA:
>> +    case SCLP_CMD_READ_EVENT_DATA:
>> +    case SCLP_CMD_WRITE_EVENT_DATA:
>> +    case SCLP_CMD_WRITE_EVENT_MASK:
>> +        break;
>> +    default:
>> +        work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCL=
P_COMMAND);
>> +        goto out_write;
>> +    }
>> =20
>> +    if ((sccb + work_sccb.h.length) > ((sccb & PAGE_MASK) + PAGE_SIZE=
)) {
>> +        work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_SCCB_BOUNDA=
RY_VIOLATION);
>> +        goto out_write;
>> +    }
>> +
>> +    sclp_c->execute(sclp, &work_sccb, code);
>> +out_write:
>>      cpu_physical_memory_write(sccb, &work_sccb,
>>                                be16_to_cpu(work_sccb.h.length));
>> =20
>>
>=20
>=20



--YxRJWbs5wERXllzShC8yECjaJZSs2Xdc2--

--TYN3slF9M4hiIIkraDXNhVBpUgqlWik6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2N0ukACgkQ41TmuOI4
ufj6yA/9GVknph8Ics7mFOqfp4YlQhhEqEHrRVXJn46uW+fzikgivOJEwyYHaG7j
LypIH41N/Vu5Xa1Ei/W8wt+3Xblo8lHJ/cmP8viNV2lGvxA+Fzf6jYaR1f72Fwdw
xovr35hTuIsOIW1eG2rsBcvtZlIET5m3QMGys0kg93oSWqCF6VfcWOyMn/FGcLeV
glQWKBpXto3OVMj1gRTz6bwixaNXisVJPYSpyrHCWjIYhOQgOPawtZMxpCn8qMJk
MoWIS5KLby+Boq4HM/NjBt1oI61agaTKgG9gMkLFaugNT0+jx2lnnkB8/DE55rYh
eIkwMocCIIVeSPgxE++1Qe7QPQexP/RRu6+Tk9cfyHeabFPniL6XOGpiAxgfZcLS
h5P1qghgPMaozYGpTmu/JVj4YZ2QBDLhSau9m4sAeOjaq1USMPxZ1qCn+zRl6h+8
t5F12ZrcQ+Z0g6InKYwl9pUsSozL9tUfpAjz4qVOhuAc3FshUterpnxe2lcP8zIp
89fXVg1zWT4z/LZgeBHJP+01f28X2rL0wFUt/Na265nicIPRtXtS2hCpDg9J5mmO
tH4b4kmEPMReo0eW7SbYjn4kSCb7hOgvFi4/QN0gnywwczrr8KUpI95Krzuva32x
MA7QqwE4wPBd6T++rJPkYBA/0xX7El5BrVEqNXZIE4T8n5vovFQ=
=cm5K
-----END PGP SIGNATURE-----

--TYN3slF9M4hiIIkraDXNhVBpUgqlWik6D--


