Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13046C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99DC20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99DC20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuLT-0001lK-2p
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jDt3l-0007d7-VG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jDt3k-0007nK-Aa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:57:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48020
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jDt3k-0007Qa-2U
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:57:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02GGpa0j103853
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:57:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ytb3ndgvh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:57:46 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 16 Mar 2020 16:57:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Mar 2020 16:57:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02GGve3g48889874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 16:57:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F024C062;
 Mon, 16 Mar 2020 16:57:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C874E4C059;
 Mon, 16 Mar 2020 16:57:39 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.172.163])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2020 16:57:39 +0000 (GMT)
Date: Mon, 16 Mar 2020 17:57:37 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200313163122.GB95517@xz-x1>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 20031616-0020-0000-0000-000003B564DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031616-0021-0000-0000-0000220DC563
Message-Id: <20200316175737.365d7b32.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-16_07:2020-03-12,
 2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160075
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 12:31:22 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > [..]
> > > > >=20
> > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and curren=
t qemu?
> > > > >=20
> > > > > Also, one can specify iommu_platform=3Don on a device that ain't =
a part of
> > > > > a secure-capable VM, just for the fun of it. And that breaks
> > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > > > qemu-system-s390x is protected virtualization capable?
> > > > >=20
> > > > > BTW, I don't have a strong opinion on the fixes tag. We currently=
 do not
> > > > > recommend setting iommu_platform, and thus I don't think we care =
too
> > > > > much about past qemus having problems with it.
> > > > >=20
> > > > > Regards,
> > > > > Halil
> > > >=20
> > > >=20
> > > > Let's just say if we do have a Fixes: tag we want to set it correct=
ly to
> > > > the commit that needs this fix.
> > > >=20
> > >=20
> > > I finally did some digging regarding the performance degradation. For
> > > s390x the performance degradation on vhost-net was introduced by comm=
it
> > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > > calculated as the rest of the memory regions size (from address), and
> > > covered most of the guest address space. That is we didn't have a who=
le
> > > lot of IOTLB API overhead.
> > >=20
> > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff whi=
ch comes
> > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things wor=
king
> > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level=
 of
> > > 076a93d797 and 076a93d797~1.
> >=20
> > Peter, what's your take on this one?
>=20
> Commit 076a93d797 was one of the patchset where we want to provide
> sensible IOTLB entries and also that should start to work with huge
> pages.  Frankly speaking after a few years I forgot the original
> motivation of that whole thing, but IIRC there's a patch that was
> trying to speedup especially for vhost but I noticed it's not merged:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html
>=20

=46rom the looks of it, I don't think we would have seen that big
performance degradation had this patch been included. I can give
it a spin if you like. Shall I?

> Regarding to the current patch, I'm not sure I understand it
> correctly, but is that performance issue only happens when (1) there's
> no intel-iommu device, and (2) there is iommu_platform=3Don specified
> for the vhost backend?
>=20

I can confirm, that your description covers my scenario. I didn't
investigate what happens when we have an intel-iommu, because s390 does
not do intel-iommu. I can also confirm that no performance degradation
is observed when the virtio-net has iommu_platform=3Doff. The property
iommu_platform is a virtio device (and not a backend) level property.
=20

> If so, I'd confess I am not too surprised if this fails the boot with
> vhost-vsock because after all we speicified iommu_platform=3Don
> explicitly in the cmdline, so if we want it to work we can simply
> remove that iommu_platform=3Don when vhost-vsock doesn't support it
> yet...  I thougth iommu_platform=3Don was added for that case - when we
> want to force IOMMU to be enabled from host side, and it should always
> be used with a vIOMMU device.
>=20

The problem is that the virtio feature bit F_ACCESS_PLATFORM, which is
directly controlled by the iommu_platform proprerty stands for two things
1) need to do IOVA translation
2) the access of the device to the guests RAM is restricted.

There are cases where 2) does apply and 1) does not. We need to specify
iommu_platform=3Don to make the virtio implementation in the guest use
the dma api, because we need to grant access to memory as required. But
we don't need translation and we don't have a vIOMMU.

Regards,
Halil


> However I also agree that from performance POV this patch helps for
> this quite special case.
>=20
> Thanks,
>=20


