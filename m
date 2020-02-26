Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E1C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF9721927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF9721927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6w9e-00060V-FH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j6w8x-000535-R5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j6w8w-0002Sh-IS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:50:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29954
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j6w8w-0002SA-Da
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:50:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QCns4e033671
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:50:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqkau90u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:50:24 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Wed, 26 Feb 2020 12:50:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 12:50:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QCoJEs54263864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 12:50:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B46614C050;
 Wed, 26 Feb 2020 12:50:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8706E4C04A;
 Wed, 26 Feb 2020 12:50:19 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 12:50:19 +0000 (GMT)
Date: Wed, 26 Feb 2020 13:50:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200226064243-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226045128-mutt-send-email-mst@kernel.org>
 <bd592433-71b9-773f-97ef-f5da87734b05@redhat.com>
 <20200226064243-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 20022612-0016-0000-0000-000002EA7143
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0017-0000-0000-0000334DA0C3
Message-Id: <20200226135018.608185bb.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=843 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260096
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 01QCns4e033671
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 06:44:25 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 26, 2020 at 06:17:34PM +0800, Jason Wang wrote:
> >=20
> > On 2020/2/26 =E4=B8=8B=E5=8D=885:53, Michael S. Tsirkin wrote:
> > > On Wed, Feb 26, 2020 at 05:43:57PM +0800, Jason Wang wrote:
> > > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditional=
ly on
> > > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > > transactions which will damage the performance.
> > > >=20
> > > > Fixing this by check whether the device is backed by IOMMU and di=
sable
> > > > device IOTLB.
> > > >=20
> > > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > Well it's just an optimization, isn't it?
> >=20
> >=20
> > Kind of, or a fix for the performance.
> >=20
>=20
> Given this wasn't a regression, it's a valuable enhancement
> but Fixes: seems to agressive.

IMHO Fixes is appropriate. Telling vhost-net F_ACCESS_PLATFORM
when when vdev->dma_as !=3D &address_space_memory results in a severe
performance degradation.

Regards,
Halil

[..]


