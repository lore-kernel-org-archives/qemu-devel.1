Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D5A20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D5A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98oA-0003Yr-ET
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j98mg-0002Pu-OK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j98mb-0007ut-Ft
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:44:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j98mb-0007sC-7h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:44:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 023EL8ef116548
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2020 09:44:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhhy5axha-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:44:26 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Tue, 3 Mar 2020 14:44:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 3 Mar 2020 14:44:21 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 023EiK5a59113716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2020 14:44:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15854A404D;
 Tue,  3 Mar 2020 14:44:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD606A4040;
 Tue,  3 Mar 2020 14:44:19 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.80])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2020 14:44:19 +0000 (GMT)
Date: Tue, 3 Mar 2020 15:44:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200227104233-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030314-0016-0000-0000-000002ECCDDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030314-0017-0000-0000-000033501584
Message-Id: <20200303154418.43317b1d.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-03_05:2020-03-03,
 2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 10:47:22 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 27, 2020 at 02:02:15PM +0100, Halil Pasic wrote:
> > On Wed, 26 Feb 2020 11:52:26 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, Feb 26, 2020 at 04:36:18PM +0100, Halil Pasic wrote:
> > > > On Wed, 26 Feb 2020 08:37:13 -0500
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > 
> > > > > On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
> > > > > > On Wed, 26 Feb 2020 17:43:57 +0800
> > > > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > > 
> > > > > > > We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> > > > > > > platform without IOMMU support. This can lead unnecessary IOTLB
> > > > > > > transactions which will damage the performance.
> > > > > > > 
> > > > > > > Fixing this by check whether the device is backed by IOMMU and disable
> > > > > > > device IOTLB.
> > > > > > > 
> > > > > > > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> > > > > > > Cc: qemu-stable@nongnu.org
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > 
> > > > > > Tested-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > 
> > > > > > Thank you very much for fixing this! BTW as I mentioned before it
> > > > > > fixes vhost-vsock with iommu_platform=on as well.
> > > > > 
> > > > > Fixes as in improves performance?
> > > > 
> > > > No, fixes like one does not get something like:
> > > > qemu-system-s390x: vhost_set_features failed: Operation not supported (95)
> > > > qemu-system-s390x: Error starting vhost: 95
> > > > any more.
> > > > 
> > > > Regards,
> > > > Halil
> > > > 
> > > > [..]
> > > 
> > > But can commit c471ad0e9bd46 actually boot a secure guest
> > > where iommu_platform=on is required?
> > > 
> > 
> > No, of course it can not. But I'm not sure about AMD SEV. AFAIU without
> > Jason's patch it does not work for AMD SEV. Tom already stated that with
> > SEV they don't need the IOVA translation aspect of ACCESS_PLATFORM, but
> > I have no idea if the condition vdev->dma_as == &address_space_memory
> > catches them as well or not. They probably have !=.
> > 
> > CCing Tom. @Tom does vhost-vsock work for you with SEV and current qemu?
> > 
> > Also, one can specify iommu_platform=on on a device that ain't a part of
> > a secure-capable VM, just for the fun of it. And that breaks
> > vhost-vsock. Or is setting iommu_platform=on only valid if
> > qemu-system-s390x is protected virtualization capable?
> > 
> > BTW, I don't have a strong opinion on the fixes tag. We currently do not
> > recommend setting iommu_platform, and thus I don't think we care too
> > much about past qemus having problems with it.
> > 
> > Regards,
> > Halil
> 
> 
> Let's just say if we do have a Fixes: tag we want to set it correctly to
> the commit that needs this fix.
> 

You are absolutely correct. And c471ad0e9bd46 has nothing to do with
vsock. On s390x the situation with virtio-net + vhost + iommu_platform=on
seems rather complex. I did some digging, but I have no conclusive
results yet. And I don't think we care all that much for iommu_platform=on
for old qemus.

Regards,
Halil



