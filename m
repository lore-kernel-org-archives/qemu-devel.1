Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B195C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA0520838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA0520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6yLp-0004nl-Lb
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6yLD-0004L6-Cp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6yLC-000843-C2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:11:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6yLC-0007yQ-40
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:11:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QF9Ja9095580
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:11:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkf990rb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:11:13 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 26 Feb 2020 15:11:10 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 15:11:08 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01QFB7F136503892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 15:11:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D74EAE061;
 Wed, 26 Feb 2020 15:11:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 667B1AE064;
 Wed, 26 Feb 2020 15:11:04 +0000 (GMT)
Received: from dyn-9-152-224-212.boeblingen.de.ibm.com (unknown
 [9.152.224.212])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 15:11:04 +0000 (GMT)
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 26 Feb 2020 16:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lQBLg2hAxUJFy7ynMwm4nDI6hwX04BUtK"
X-TM-AS-GCONF: 00
x-cbid: 20022615-0012-0000-0000-0000038A7F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022615-0013-0000-0000-000021C725A9
Message-Id: <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_05:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 suspectscore=3 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260109
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
--lQBLg2hAxUJFy7ynMwm4nDI6hwX04BUtK
Content-Type: multipart/mixed; boundary="SrGFtY8RuCL8INeY9Rc8h4xyOJRsriJZt"

--SrGFtY8RuCL8INeY9Rc8h4xyOJRsriJZt
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/26/20 3:59 PM, David Hildenbrand wrote:
> On 26.02.20 13:20, Janosch Frank wrote:
>> Ballooning in protected VMs can only be done when the guest shares the=

>> pages it gives to the host. Hence, until we have a solution for this
>> in the guest kernel, we inhibit ballooning when switching into
>> protected mode and reverse that once we move out of it.
>=20
> I don't understand what you mean here, sorry. zapping a page will mean
> that a fresh one will be faulted in when accessed. And AFAIK, that mean=
s
> it will be encrypted again when needed.

Yes, as soon as the host alters non-shared memory we'll run into
integrity issues.


I've been talking to Halil after I sent this out and it looks like we'll
rather try to automatically enable the IOMMU for all devices when
switching into protected mode. He said that if the IOMMU is set the
balloon code will do an early exit on feature negotiation.

>=20
> Is that more like the UV will detect this as an integrity issue and
> crash the VM?
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 9983165b05..0f4455d1df 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -41,6 +41,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/s390x/tod.h"
>>  #include "sysemu/sysemu.h"
>> +#include "sysemu/balloon.h"
>>  #include "hw/s390x/pv.h"
>>  #include "migration/blocker.h"
>> =20
>> @@ -336,6 +337,7 @@ static void s390_machine_unprotect(S390CcwMachineS=
tate *ms)
>>          ms->pv =3D false;
>>      }
>>      migrate_del_blocker(pv_mig_blocker);
>> +    qemu_balloon_inhibit(false);
>>  }
>> =20
>>  static int s390_machine_protect(S390CcwMachineState *ms)
>> @@ -344,6 +346,7 @@ static int s390_machine_protect(S390CcwMachineStat=
e *ms)
>>      CPUState *t;
>>      int rc;
>> =20
>> +    qemu_balloon_inhibit(true);
>>      if (!pv_mig_blocker) {
>>          error_setg(&pv_mig_blocker,
>>                     "protected VMs are currently not migrateable.");
>>
>=20
>=20



--SrGFtY8RuCL8INeY9Rc8h4xyOJRsriJZt--

--lQBLg2hAxUJFy7ynMwm4nDI6hwX04BUtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5WiocACgkQ41TmuOI4
ufjImA/9FNwwbASxsVNWxRDwpn0CbeaS7z9/KABG5ylbrwzV4kptvhGUEyeuVvQK
CnB8e3Eb3211nFILpqmOtUP9Z0poAJ6TdmamDxQNoPaesn4bhzHzwl+5jP1lXjYF
Crw9qySdXwC2Cz00puOoNLiJMe1k3xPYHZA1Eiwf4Xd3BNU/kDrLnJOQSDyNRsO2
cYTBp/KTM/XSmKEwoU1Kx6qucNrStmPthUq3CkUZzx5cLdD6Bwdr+RadHXC4FiB8
u9/vp7ya0YdlbXmnOA9Wy9EQMghSQE6RLlGvfOXScH21kGYpRTU/g8ZWAJh/OMjZ
96gkVAaYHlxLZTtKhD9SvaZfRYpDE7a9jNdDAA9gn9bTH+/IGvv85XggBDyUxEs4
BWGd91fA7SaOkCvH0ZmTJczOgYM4N4YXW43i8noCsEI6Nhl3GmFlyeTHlfbA48th
TFo3OAyBlUg2Q1xIosSPf4kUxos/jM4N4YORlaILkz1D0FxAIxqbQCMlxa98uhAv
7Qb3WUMCzpPQBElIQPiPRNkAbAotGzp7AERQRdZKKZPd9goBT9MSCBR5X+GhjhKd
0+F/wBXOF6y7rZ3Ka4ALSPe8oMbCXQiIoYC5yXWVxE1Poh+fFL4VmiHbxuXq/BkD
/dMWyNTvtYYrHnuD1MblZHlgmbQFD0zfNnq39aJQxbswVrHAnG4=
=wc5C
-----END PGP SIGNATURE-----

--lQBLg2hAxUJFy7ynMwm4nDI6hwX04BUtK--


