Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C047C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F2D215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F2D215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBghG-00073P-7j
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBgaA-0004vH-15
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBga8-00009h-Rq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBga8-0008Uo-Hx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AExmQa096806
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:14:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ynr9m2apq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:14:07 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 10 Mar 2020 15:14:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:14:03 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02AFE2cw47382668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:14:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2528C52054;
 Tue, 10 Mar 2020 15:14:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.23.214])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C9F475204F;
 Tue, 10 Mar 2020 15:14:01 +0000 (GMT)
Subject: Re: [PATCH v8 03/15] s390x: protvirt: Add migration blocker
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200310134008.130038-1-frankja@linux.ibm.com>
 <20200310134008.130038-4-frankja@linux.ibm.com>
 <984a38e2-f73c-dd68-b32d-ff419046c7ac@redhat.com>
 <be1990f6-c1a2-f657-0ab8-ec764ecb6a47@linux.ibm.com>
 <ec12bc79-c209-da27-e45f-cf8f35e97ec0@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 10 Mar 2020 16:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ec12bc79-c209-da27-e45f-cf8f35e97ec0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hTPzqvXf4724qaYkA5ReY1RSufK96EwAQ"
X-TM-AS-GCONF: 00
x-cbid: 20031015-0028-0000-0000-000003E2C200
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-0029-0000-0000-000024A8035B
Message-Id: <bf3483a7-5898-5411-f9ed-1892f20205d4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_08:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=2 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100099
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
--hTPzqvXf4724qaYkA5ReY1RSufK96EwAQ
Content-Type: multipart/mixed; boundary="4MLMnuxnTbFoS7xtMSrDdUjhGLcUvwSTP"

--4MLMnuxnTbFoS7xtMSrDdUjhGLcUvwSTP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/10/20 4:08 PM, David Hildenbrand wrote:
> On 10.03.20 16:02, Janosch Frank wrote:
>> On 3/10/20 3:57 PM, David Hildenbrand wrote:
>>> On 10.03.20 14:39, Janosch Frank wrote:
>>>> Migration is not yet supported.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c=

>>>> index 455ad31718..1ceb42c0b5 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -43,6 +43,9 @@
>>>>  #include "sysemu/sysemu.h"
>>>>  #include "hw/s390x/pv.h"
>>>>  #include <linux/kvm.h>
>>>> +#include "migration/blocker.h"
>>>> +
>>>> +static Error *pv_mig_blocker;
>>>> =20
>>>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>>>  {
>>>> @@ -323,15 +326,29 @@ static void s390_machine_unprotect(S390CcwMach=
ineState *ms)
>>>> =20
>>>>      s390_pv_vm_disable();
>>>>      ms->pv =3D false;
>>>> +    migrate_del_blocker(pv_mig_blocker);
>>>> +    error_free_or_abort(&pv_mig_blocker);
>>>>  }
>>>> =20
>>>>  static int s390_machine_protect(S390CcwMachineState *ms)
>>>>  {
>>>> +    static Error *local_err;
>>>
>>> You have to initialize it to NULL.
>>
>> That's a static variable, am I missing something?
>=20
> No, I was missing that :) Why is that a static variable?
>=20
> git grep "static Error *" will tell you that this is not common.
>=20

I'd guess I copied the other Error which is static...

So I now removed the static and set it to NULL.



--4MLMnuxnTbFoS7xtMSrDdUjhGLcUvwSTP--

--hTPzqvXf4724qaYkA5ReY1RSufK96EwAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5nrrkACgkQ41TmuOI4
ufiQ1RAAqZNWGccNaekIRmKCGP2asYtX1Bm/stGzY9hy+o6kVURibvaTnRYcvTsx
BS0O44GNbl1/iQ6j+PCoWFcIS9+kzVLvLxyX3SFv7JR8ZbeOXdKZQf/hKEASfUPl
G2JExWXMgBbgUop3Lrr9vNYIGzQ/BUMmVGFBN+0mrTzZKdzis/8pswXL8sfSOhWH
9xrCnjjuqBI+/zqJQupK3bR7/1GRiq9bDuBZl4Zt0lJW0fOuxggov9H7not6BPQt
Kp53Tf4b7rEKJPbclB9ZwO3PCC84vz0F3D3SydDxgGjeuHFDxtAVDqBeHeKLEFwK
WJXQ7I8/Ve55zxnaLWDfejsTPTG5CFAG/5FEvRyiX0TK8bYITJkoXLpqpc4z0bcV
J2rO1NZ/FT1vo4Xg8ulAJpsmzD0EGxrpHZFyp0+XEupHZkox4gSHsckR4PMZlOvx
/2M0p/OTuWhx8O2FxsVUcevQQQJW2ZaQ52ZAmHGKKJoY8Pm8wVByerBIUHsWxeHX
AxiTJ0iqLw8HcPLAt7YvQVPsV7yEe45+/0kG/iQvnB4z7P+HkhgHe+/9htsBODrc
5IhXl//N8Tmr9jkxq/kl9a+SzUSdX5yqvO3cjxhnDyiD3xaz0l7gBrbp9JOFy0m7
iWeHZvfts6ShGWGK5sVTbUHxmwsJkEKLzeF1hw4y5AfY/5pdJjU=
=Uigm
-----END PGP SIGNATURE-----

--hTPzqvXf4724qaYkA5ReY1RSufK96EwAQ--


