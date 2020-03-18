Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4732DC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A0320767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A0320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEXrJ-0007eN-9O
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEXqK-00073q-D1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEXqI-0006Vn-Uj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEXqI-0006UC-Mx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:30:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IC2VG9021124
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 08:30:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu719s6dv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 08:30:36 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 18 Mar 2020 12:30:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 12:30:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02ICUVg049610968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 12:30:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBF80A4065;
 Wed, 18 Mar 2020 12:30:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82B95A405C;
 Wed, 18 Mar 2020 12:30:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.78.199])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 12:30:31 +0000 (GMT)
Subject: Re: [PATCH v9 04/15] s390x: protvirt: Inhibit balloon when switching
 to protected mode
To: Cornelia Huck <cohuck@redhat.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-5-frankja@linux.ibm.com>
 <20200318124214.15778f76.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 18 Mar 2020 13:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200318124214.15778f76.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UZu8sSxL8Zu1o0Hoy0wlBZSuf6OqgzAU1"
X-TM-AS-GCONF: 00
x-cbid: 20031812-0008-0000-0000-0000035F541A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031812-0009-0000-0000-00004A80AE6B
Message-Id: <1813cdeb-d5af-5210-7e66-58fca928d625@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_05:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180058
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UZu8sSxL8Zu1o0Hoy0wlBZSuf6OqgzAU1
Content-Type: multipart/mixed; boundary="0GdBHfXHUSKpH1ZgUF9WrJ1VFfE5LTdB2"

--0GdBHfXHUSKpH1ZgUF9WrJ1VFfE5LTdB2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/18/20 12:42 PM, Cornelia Huck wrote:
> On Wed, 11 Mar 2020 09:21:40 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Ballooning in protected VMs can only be done when the guest shares the=

>> pages it gives to the host. If pages are not shared, the integrity
>> checks will fail once those pages have been altered and are given back=

>> to the guest.
>>
>> As we currently do not yet have a solution for this we will continue
>> like this:
>>
>> 1. We block ballooning now in QEMU (with this patch)
>=20
> add trailing '.'
>=20
>>
>> 2. Later we will provide a change to virtio that removes the blocker
>=20
> s/Later/Later,/
>=20
>> and adds VIRTIO_F_IOMMU_PLATFORM automatically by QEMU when doing the
>> protvirt switch. This is ok as the guest balloon driver will reject to=

>> work with the IOMMU change
>=20
> "This is OK, as the balloon driver in Linux (the only supported guest)
> will refuse to work with the IOMMU_PLATFORM feature bit set."
>=20
> ?
>=20
>>
>> 3. Later we can fix the guest balloon driver to accept the IOMMU
>=20
> "Later, we can fix the Linux guest balloon driver..."
>=20
>> feature bit and correctly exercise sharing and unsharing of balloon
>> pages
>=20
> again, missing trailing '.'

All nits fixed

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index deb31e060052d279..066e01f303c35671 100644
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
>> @@ -326,6 +327,7 @@ static void s390_machine_unprotect(S390CcwMachineS=
tate *ms)
>>      ms->pv =3D false;
>>      migrate_del_blocker(pv_mig_blocker);
>>      error_free_or_abort(&pv_mig_blocker);
>> +    qemu_balloon_inhibit(false);
>>  }
>> =20
>>  static int s390_machine_protect(S390CcwMachineState *ms)
>> @@ -333,10 +335,12 @@ static int s390_machine_protect(S390CcwMachineSt=
ate *ms)
>>      Error *local_err =3D NULL;
>>      int rc;
>>
>=20
> Maybe add a comment?
>=20
> /*
>  * Ballooning on protected VMs needs support in the guest for
>  * sharing and unsharing balloon pages. Block ballooning for
>  * now, until we have a solution to make at least Linux guests
>  * either support it or fail gracefully.
>  */
>  =20
>> +    qemu_balloon_inhibit(true);
>>      error_setg(&pv_mig_blocker,
>>                 "protected VMs are currently not migrateable.");
>>      rc =3D migrate_add_blocker(pv_mig_blocker, &local_err);
>>      if (local_err) {
>> +        qemu_balloon_inhibit(false);
>>          error_report_err(local_err);
>>          error_free_or_abort(&pv_mig_blocker);
>>          return rc;
>> @@ -345,6 +349,7 @@ static int s390_machine_protect(S390CcwMachineStat=
e *ms)
>>      /* Create SE VM */
>>      rc =3D s390_pv_vm_enable();
>>      if (rc) {
>> +        qemu_balloon_inhibit(false);
>>          error_report_err(local_err);
>>          migrate_del_blocker(pv_mig_blocker);
>>          error_free_or_abort(&pv_mig_blocker);
>=20



--0GdBHfXHUSKpH1ZgUF9WrJ1VFfE5LTdB2--

--UZu8sSxL8Zu1o0Hoy0wlBZSuf6OqgzAU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5yFGcACgkQ41TmuOI4
ufjWpg//TOVyx+wgQoXMcaLkidH2QllyGWAZKgEohYN9pP0xnN8CvLYi7J9B3Dpf
WX5RVWAU1F6icQQg6VZSnYyK1P/3nEPiH62Fd588yS+37lI6elfgg7XYjPo9NrGZ
VhZcNan7e/mDgwrZzTHHuGow+LYVteaScUEkLfzEbkvmuRBeZ59w5nsFrLrWAuAJ
HOBbqmfBGizB/DsX2TxASemD+OtOlTgY8VZ0ApMapaBaPvpBTokiN8l8NAbLLkqj
yqiRQHBTOzakYaA43rZ72UP5nP2JVirjYtSWRUDp/L5wzOoPyD9oi/5YI8mxU9Hl
uJKOs1DpazZ//fayN2ypMmY8hof5sCG/rYZQ6M9TE+l6TT05+37vGZPSeBdqwXd3
0g3qQHOMF+EPHWWjMmCWtDKDpgaVLpjHTU11763CFU8YFkH17Sa+fxJF16ARgYj+
FG5gCDHw4N/90D68LQPTNt4jIRNdl6ZJPORHYV27+z5Lpg0iQg+WCMREjxfTx7c2
4VTUC5FSpEe2y992ioOyHhPqhA7cmgxcEgU6RqCxuV73puV/QTLKeab6owOem+to
tZvh+j0WxHpEdXErJ6kWTmaql0FkH+x0vc9sEHi9vpBcs9mBmKD6dnyktoaZw5Ds
yGx6E1qiz/YMQCvZqv9s2rSKfsLIuWJZnrq25UesI40Ag/28cwo=
=YjpO
-----END PGP SIGNATURE-----

--UZu8sSxL8Zu1o0Hoy0wlBZSuf6OqgzAU1--


