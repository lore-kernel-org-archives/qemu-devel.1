Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7714EC10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E28E2148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amzqxnvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E28E2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW8F-0007Li-Gq
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:24:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hDW2H-0003cX-8Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hDW2G-0003w7-CH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hDW2F-0003sB-Vr
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:18:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38FGZEo147347; Mon, 8 Apr 2019 15:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=U7DO9gvD0XwHethQ/7Hdcxf9zGjH8Lr5NRYiCdwWS4s=;
	b=amzqxnvIMS6SxwrxE2kBnZ84cH0JJyvNjaqnCT9dj2CmRcwncL+/QW5Qznsm6O6GBts3
	F7K2270z0zRsnnFgO4WofseHBvV1RfEHoKXXvRtrRr1JPq3ro7ZUBd/6oF2rIqJx8cIw
	8qF6z0PAHPfO3Q8d4GVFQFIyqkkRXCAXjzsqbVLDrirfyhI0YPqhWvsQzXj5oyQmlSqR
	x9Aq+kQwvT0AeOZsPR36XHcyLzOqahip6aXDgQWSOn8NmfXI6/7Ma8LkL0tQkhs2peOK
	tvS7FstIQq7v3StK/JCG5eeslnBtqVpCXbyS0t9Utg0txOdMAHA2f/MbCd8UQYJroYSY
	VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rpkhsq6ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 15:17:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38FHVTH166270; Mon, 8 Apr 2019 15:17:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2rpj5a1tcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 15:17:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38FHpni009051;
	Mon, 8 Apr 2019 15:17:51 GMT
Received: from [10.0.5.57] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 08 Apr 2019 08:17:50 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <99f9b621-7e23-0ada-ca49-605cabf2abbd@oracle.com>
Date: Mon, 8 Apr 2019 18:17:47 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <4283A075-04C3-4DE3-AEA1-298E400EC7CA@oracle.com>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<99f9b621-7e23-0ada-ca49-605cabf2abbd@oracle.com>
To: Nir Weiner <nir.weiner@oracle.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904080124
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904080124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151747.BERTsCVDeQOcFlOq9Z9oHjCZwSIHigJiUAYp_2zmhE4@z>

Second ping.
This series has been sent almost 2 weeks ago. We would appreciate some =
feedback/review.

Thanks,
-Liran

> On 27 Mar 2019, at 12:40, Nir Weiner <nir.weiner@oracle.com> wrote:
>=20
> On 3/21/19 9:55 AM, Nir Weiner wrote:
>=20
>> Originally migration was not possible with vhost-scsi because
>> as part of migration, the source host target SCSI device state
>> needs to be saved and loaded into the destination host target SCSI
>> device. This cannot be done by QEMU.
>>=20
>> As this can be handled either by external orchestrator or by having
>> shared-storage (i.e. iSCSI), there is no reason to limit the
>> orchestrator from being able to explictly specify it wish to enable
>> migration even when VM have a vhost-scsi device.
>>=20
>> Liran Alon (1):
>>   vhost-scsi: Allow user to enable migration
>>=20
>> Nir Weiner (2):
>>   vhost-scsi: The vhost device should be stopped when the VM is not
>>     running
>>   vhost-scsi: Add vmstate descriptor
>>=20
>>  hw/scsi/vhost-scsi.c                  | 57 =
++++++++++++++++++++++-----
>>  include/hw/virtio/vhost-scsi-common.h |  1 +
>>  2 files changed, 48 insertions(+), 10 deletions(-)
>>=20
> ping + CC to relevant maintainers


