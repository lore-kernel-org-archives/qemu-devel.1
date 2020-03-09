Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FAC3F2C6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB7A21655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB7A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIpy-0001MX-Ng
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBIpD-0000nA-CN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBIpB-0004fi-Id
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBIp9-0004dF-IJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:52:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029DodLw037869
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 09:52:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym6tmtdnf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 09:52:01 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 13:51:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 13:51:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029DpunV40435956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 13:51:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A79D4C044;
 Mon,  9 Mar 2020 13:51:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53C4E4C040;
 Mon,  9 Mar 2020 13:51:56 +0000 (GMT)
Received: from dyn-9-152-224-87.boeblingen.de.ibm.com (unknown [9.152.224.87])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 13:51:56 +0000 (GMT)
Subject: Re: [PATCH v7 03/15] s390x: protvirt: Add migration blocker
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-4-frankja@linux.ibm.com>
 <81ffc55c-e7e7-b474-aa7a-5d4bc0db8c02@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 9 Mar 2020 14:51:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <81ffc55c-e7e7-b474-aa7a-5d4bc0db8c02@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iGEvtjj0jm0InEzTH1TvSOuXAlIrH7a2L"
X-TM-AS-GCONF: 00
x-cbid: 20030913-0008-0000-0000-0000035AC77E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030913-0009-0000-0000-00004A7C078C
Message-Id: <c488fa9f-f2d4-2426-832c-1401e52e2995@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_04:2020-03-09,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 suspectscore=11 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090095
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
--iGEvtjj0jm0InEzTH1TvSOuXAlIrH7a2L
Content-Type: multipart/mixed; boundary="tfVdy7HSHIx1IMlZDt1MnIcSPGCMWtlHM"

--tfVdy7HSHIx1IMlZDt1MnIcSPGCMWtlHM
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/9/20 2:41 PM, David Hildenbrand wrote:
> On 09.03.20 12:21, Janosch Frank wrote:
>> Migration is not yet supported.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index f718cfc591..4bb38704ff 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -43,6 +43,9 @@
>>  #include "sysemu/sysemu.h"
>>  #include "hw/s390x/pv.h"
>>  #include <linux/kvm.h>
>> +#include "migration/blocker.h"
>> +
>> +static Error *pv_mig_blocker;
>> =20
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -331,16 +334,33 @@ static void s390_machine_unprotect(S390CcwMachin=
eState *ms)
>>          }
>>          ms->pv =3D false;
>>      }
>> +    migrate_del_blocker(pv_mig_blocker);
>> +    error_free(pv_mig_blocker);
>> +    pv_mig_blocker =3D NULL;
>=20
> Maybe use error_free_or_abort(&pv_mig_blocker);

I dislike hiding setting the ptr to NULL with that function.
The assert for NULL in error_setg has caused me a lot of headache initial=
ly.

But if that's how it's done I'll fix it.

>=20
>>  }
>> =20
>>  static int s390_machine_protect(S390CcwMachineState *ms)
>>  {
>> +    static Error *local_err;
>>      CPUState *t;
>>      int rc;
>> =20
>> +    error_setg(&pv_mig_blocker,
>> +               "protected VMs are currently not migrateable.");
>> +    rc =3D migrate_add_blocker(pv_mig_blocker, &local_err);
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +        error_free(pv_mig_blocker);
>> +        pv_mig_blocker =3D NULL;
>=20
> Dito.
>=20
>> +        return rc;
>> +    }
>> +
>>      /* Create SE VM */
>>      rc =3D s390_pv_vm_enable();
>>      if (rc) {
>> +        error_report_err(local_err);
>> +        error_free(pv_mig_blocker);
>> +        pv_mig_blocker =3D NULL;
>=20
> Dito.
>=20
>>          return rc;
>>      }
>> =20
>> @@ -470,11 +490,13 @@ static void s390_machine_reset(MachineState *mac=
hine)
>> =20
>>          if (s390_machine_protect(ms)) {
>>              s390_machine_inject_pv_error(cs);
>> -            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> -            return;
>> +            goto pv_err;
>>          }
>> =20
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>> +pv_err:
>> +        /* Continue after the diag308 so the guest knows something we=
nt wrong. */
>> +        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>          break;
>=20
> Why does this change *not* belong into path #2? I think I asked this
> already.

Yes, I'll move it



--tfVdy7HSHIx1IMlZDt1MnIcSPGCMWtlHM--

--iGEvtjj0jm0InEzTH1TvSOuXAlIrH7a2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5mSfsACgkQ41TmuOI4
ufjQpBAAm97ig3uejrZXaAEUv/yRwsNVBSJRzzaBvkjawdWWULQJlmlna4bBFPlu
TEC4Y+3oTavdCa0Pc9mA1eBJG92LjNB6XMEVr5alq0CbD72j9ye4qcHw3b5O9W4r
MEqgnRHcXkwvAkm/TrA1mFN0nIvjTus9Tiou0Oc77TK6FcUbzALwX+lGU+C1Lv0v
2WU1L1lxLDm7QKEgrzz+PiXhrXMdqqJd+KJ9PwCQ37TvpzcNalOj/B7yF/dFSiJI
nslqKTuVU3Lq3fiHjRrIKtAmefazuLms+IL1DnYMPM81wUHY6EkIy/rXAN/miaaW
MpJpogfFnI0J3V8hPVSlkHlW49YyfMxawuEMW9VRr1V5z7+2qazwKIQM0UmV+D/D
502DoTK1iXnAk7C8hrsPBFTL5ZZ99VhYUVlCM7FZ1bMi15S7Dl77r+dIBZt0lPHo
FqZzOMVKwP/4Rp4xw4ZkJPSFDNuphkqDpcSCtlseOBa9CUJRHceveeb+ZPLx6EhE
J7lPvnorf3TAtwhYeBRr0buMXrZFt6LQgmUU90TXXak6LX1L+PmOLlre+SaNNEEd
eapjW2Ai9fm/kt2nrIN2/BAmh6mjxKn+jXcvRqnJdC3VPAAvD+gQQH5QWLEG8DSd
eJNA5ktO7cNuQShG1dhRezQ6bOcZmLvKXS+G4VmdUdscqRxTv8Q=
=xkdo
-----END PGP SIGNATURE-----

--iGEvtjj0jm0InEzTH1TvSOuXAlIrH7a2L--


