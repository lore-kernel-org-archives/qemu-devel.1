Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD35BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8825D21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825D21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPZG-00068C-Kz
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iaMxi-0002J5-Qk
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iaMxf-0001Zz-KH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iaMxf-0001UN-Cm
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:11 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASGlOtF158989
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:48:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar8q4nr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:48:08 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Thu, 28 Nov 2019 16:48:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 16:48:03 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASGm1r249217646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 16:48:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85545AE053;
 Thu, 28 Nov 2019 16:48:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 437FDAE04D;
 Thu, 28 Nov 2019 16:48:01 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.151])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 16:48:01 +0000 (GMT)
Date: Thu, 28 Nov 2019 17:48:00 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] virtio-pci: disable vring processing when
 bus-mastering is disabled
In-Reply-To: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
References: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112816-0008-0000-0000-000003397A79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112816-0009-0000-0000-00004A588781
Message-Id: <20191128174800.2d4a2cc2.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_05:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911280142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 18:50:03 -0600
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

[..]
> I.e. the calling code is only scheduling a one-shot BH for
> virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
> an additional virtqueue entry before we get there. This is likely due
> to the following check in virtio_queue_host_notifier_aio_poll:
> 
>   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>   {
>       EventNotifier *n = opaque;
>       VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
>       bool progress;
> 
>       if (!vq->vring.desc || virtio_queue_empty(vq)) {
>           return false;
>       }
> 
>       progress = virtio_queue_notify_aio_vq(vq);
> 
> namely the call to virtio_queue_empty(). In this case, since no new
> requests have actually been issued, shadow_avail_idx == last_avail_idx,
> so we actually try to access the vring via vring_avail_idx() to get
> the latest non-shadowed idx:
> 
>   int virtio_queue_empty(VirtQueue *vq)
>   {
>       bool empty;
>       ...
> 
>       if (vq->shadow_avail_idx != vq->last_avail_idx) {
>           return 0;
>       }
> 
>       rcu_read_lock();
>       empty = vring_avail_idx(vq) == vq->last_avail_idx;
>       rcu_read_unlock();
>       return empty;
> 
> but since the IOMMU region has been disabled we get a bogus value (0
> usually), which causes virtio_queue_empty() to falsely report that
> there are entries to be processed, which causes errors such as:
> 
>   "virtio: zero sized buffers are not allowed"
> 
> or
> 
>   "virtio-blk missing headers"
> 
> and puts the device in an error state.
> 

I've seen something similar on s390x with virtio-ccw-blk under
protected virtualization, that made me wonder about how virtio-blk in
particular but also virtio in general handles shutdown and reset.

This makes me wonder if bus-mastering disabled is the only scenario when
a something like vdev->disabled should be used.

In particular I have the following mechanism in mind 

qemu_system_reset() --> ... --> qemu_devices_reset() --> ... --> 
--> virtio_[transport]_reset() --> ... --> virtio_bus_stop_ioeventfd()
--> virtio_blk_data_plane_stop()

which in turn triggesrs the following cascade:
virtio_blk_data_plane_stop_bh --> virtio_queue_aio_set_host_notifier_handler() -->
--> virtio_queue_host_notifier_aio_read() 
which however calls 
virtio_queue_notify_aio_vq() if the notifier tests as
positive. 

Since we still have vq->handle_aio_output that means we may
call virtqueue_pop() during the reset procedure.

This was a problem for us, because (due to a bug) the shared pages that
constitute the virtio ring weren't shared any more. And thus we got
the infamous  
virtio_error(vdev, "virtio: zero sized buffers are not allowed").

Now the bug is no more, and we can tolerate that somewhat late access
to the virtio ring.

But it keeps nagging me, is it really OK for the device to access the
virtio ring during reset? My intuition tells me that the device should
not look for new requests after it has been told to reset.

Opinions? (Michael, Connie)

Regards,
Halil

> This patch works around the issue by introducing virtio_set_disabled(),
> which sets a 'disabled' flag to bypass checks like virtio_queue_empty()
> when bus-mastering is disabled. Since we'd check this flag at all the
> same sites as vdev->broken, we replace those checks with an inline
> function which checks for either vdev->broken or vdev->disabled.
> 
> The 'disabled' flag is only migrated when set, which should be fairly
> rare, but to maintain migration compatibility we disable it's use for
> older machine types. Users requiring the use of the flag in conjunction
> with older machine types can set it explicitly as a virtio-device
> option.
> 


