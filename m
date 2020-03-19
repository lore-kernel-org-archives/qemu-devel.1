Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6886AC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3152071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3152071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtn0-0002C4-89
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEtmJ-0001eK-PB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEtmI-00048p-ID
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:55:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24752
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEtmI-000483-BH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:55:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JBZ4vQ048948
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:55:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yv5h7wd49-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:55:57 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 19 Mar 2020 11:55:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 11:55:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02JBtq1d8323212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 11:55:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5CB8A4040;
 Thu, 19 Mar 2020 11:55:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F4F7A4057;
 Thu, 19 Mar 2020 11:55:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.146.136])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 11:55:52 +0000 (GMT)
Subject: Re: [PATCH v10 03/16] s390x: protvirt: Support unpack facility
To: Cornelia Huck <cohuck@redhat.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-4-frankja@linux.ibm.com>
 <20200319120848.19b34cb8.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Date: Thu, 19 Mar 2020 12:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200319120848.19b34cb8.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qtzUNt7LuTBHZ6WAv6ACcJYJRkv5UiEHC"
X-TM-AS-GCONF: 00
x-cbid: 20031911-0008-0000-0000-0000035FF893
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031911-0009-0000-0000-00004A81563D
Message-Id: <e15c18a9-6c94-379d-cd99-eed63c90fb88@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_03:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190051
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qtzUNt7LuTBHZ6WAv6ACcJYJRkv5UiEHC
Content-Type: multipart/mixed; boundary="0F1otkPfto2Y37zHm43fjQsfvSpYhjWem"

--0F1otkPfto2Y37zHm43fjQsfvSpYhjWem
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/19/20 12:08 PM, Cornelia Huck wrote:
> On Wed, 18 Mar 2020 10:30:34 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> The unpack facility provides the means to setup a protected guest. A
>> protected guest cannot be introspected by the hypervisor or any
>> user/administrator of the machine it is running on.
>>
>> Protected guests are encrypted at rest and need a special boot
>> mechanism via diag308 subcode 8 and 10.
>>
>> Code 8 sets the PV specific IPLB which is retained separately from
>> those set via code 5.
>>
>> Code 10 is used to unpack the VM into protected memory, verify its
>> integrity and start it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Chang=
es
>> to machine]
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  hw/s390x/Makefile.objs              |   1 +
>>  hw/s390x/ipl.c                      |  59 +++++++++++++-
>>  hw/s390x/ipl.h                      |  91 ++++++++++++++++++++-
>>  hw/s390x/pv.c                       |  98 +++++++++++++++++++++++
>=20
> More of an aside: In MAINTAINERS, this new file will be covered by the
> general s390x section, the tcg section, and the s390-ccw-virtio machine=

> section, but not by the kvm section. Do we want to tweak that?

@Christian?

>=20
>>  hw/s390x/s390-virtio-ccw.c          | 119 +++++++++++++++++++++++++++=
-
>>  include/hw/s390x/pv.h               |  55 +++++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>  target/s390x/cpu.c                  |   2 +
>>  target/s390x/cpu_features_def.inc.h |   1 +
>>  target/s390x/diag.c                 |  39 ++++++++-
>>  target/s390x/kvm-stub.c             |   5 ++
>>  target/s390x/kvm.c                  |   5 ++
>>  target/s390x/kvm_s390x.h            |   1 +
>>  13 files changed, 467 insertions(+), 10 deletions(-)
>>  create mode 100644 hw/s390x/pv.c
>>  create mode 100644 include/hw/s390x/pv.h
>=20
> (...)
>=20
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 3dd396e870357944..84029f14814b4980 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -37,6 +37,8 @@
>>  #include "sysemu/hw_accel.h"
>>  #include "hw/qdev-properties.h"
>>  #ifndef CONFIG_USER_ONLY
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "hw/s390x/pv.h"
>=20
> These are probably needed because of some inline stuff dragging
> definitions in?

Good catch.
pv.h is needed for s390_is_pv()

But since pv.h includes s390-virtio-ccw.h I can remove it.
I'll throw this through the CI to make sure it works on all s390x
compile targets

>=20
>>  #include "hw/boards.h"
>>  #include "sysemu/arch_init.h"
>>  #include "sysemu/sysemu.h"
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>=20

Thanks


--0F1otkPfto2Y37zHm43fjQsfvSpYhjWem--

--qtzUNt7LuTBHZ6WAv6ACcJYJRkv5UiEHC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5zXccACgkQ41TmuOI4
ufhrQg/+NYv0U+LgGlTQJRb8VwoJRd5fgaKNY8YHO6t2Fli8Zm+duRFyGO302JRm
lIiAzyA1TSTjiXAzMndSdyZsKz2Fpx7BRO0qRpc0yeRTRuncYBDN4nbsQ0WFxxPI
kqQQGwGyktqaLz0rSGbjwmk3HWmMyOoBL32NKYxgyuAcZOT89H946Zrbfpl3rb6b
/SDBQeLISVd2aM8SD5O8CkOemWUP9l2NkXSgjQxdnbdHDfdg+hmFuZskvlZx/dBP
5tiK8C9Xsf0o3jCXgVCzQTFkQnGAARQYNzRSN0bHcMM9rSoOZhsqmv5g4f9Mq7pk
y1s+d7NSOTkllI+BZXUGjyZGMBKyQbwME7kKN9aZUZZXYUS4drsLYdo8BrJa+5Yx
Dbb6kWKbkbSpdhw21qMVsD8ty16dWH6Kkn+3Uo/pCPGVOgObYhnIk1pz8RmjgpNa
yqF+hRfTmxvBC/iOrHT+NlViqIuJ8GZzEE7NoX1u8wa1pT3xeFMtvrralnqFXOWo
OZirl95FpowYtUZDjbr+lmyyAS9uk2ImG/cm9idGNsN1Et7Th8DVg9/wn2Rh8uie
p41L53wAYhRky0+M+5YIPcr9j5QomD3lhh0tW9/PY1ePt8iXX6CVQUsnj7IW8bin
mown30d00XzDBrBYQUcZTKnH6KX2cT/cdMyIIOR5GhtJMkBuVAU=
=D5Cy
-----END PGP SIGNATURE-----

--qtzUNt7LuTBHZ6WAv6ACcJYJRkv5UiEHC--


