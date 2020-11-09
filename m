Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E2EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AB8206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="clADbtUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AB8206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9Uu-0000vB-BI
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kc9To-0000EL-AJ; Mon, 09 Nov 2020 10:53:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kc9Tl-0005mV-Mo; Mon, 09 Nov 2020 10:53:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A9F59HB097788; Mon, 9 Nov 2020 10:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jcgptVwEyE1q1F/VS+EBVlBfOAQqG2yyAGOmBuEfMxA=;
 b=clADbtUUKVOJrIUppYdeF7elBS56y8C9XQ70NrksqkmDueiaz4jfVWvmmQCL6hz/ui5T
 ghMrVw2ujo7PgliLORbdZyIgELX/Uo4lj6PtxkdSLC4EGFgcIP3WgN8l51sFVceOShl6
 T9blmJ5z+55KBfktKqQNh1CjnrdHtVJnmb6PU1+i5ArctN8kyiSadLJGBWAM34+z8m98
 /HA+YRSziqm/Pu86szYFQDa625lERdCYVZm/i46I+OSrrZ4QRZE4aOZM52Fwy7jcNiCt
 SgGLDyE7pniOwqN2VbpAK85OfEeLaWsRWiAQaHKUVEk9cqS0OdU7q9ZMCmQQS//YRmlW 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34q69vx5c1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 10:53:09 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A9F62Eq102958;
 Mon, 9 Nov 2020 10:53:09 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34q69vx5b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 10:53:08 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A9FRk7P006273;
 Mon, 9 Nov 2020 15:53:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 34njuh26t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 15:53:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A9Fr4h449873208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2020 15:53:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4150011C064;
 Mon,  9 Nov 2020 15:53:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2FAC11C050;
 Mon,  9 Nov 2020 15:53:03 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.52.42])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2020 15:53:03 +0000 (GMT)
Subject: Re: [PATCH 1/1] virtio-blk-ccw: tweak the default for num_queues
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20201109154831.20779-1-pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <e055ebae-721a-b567-f743-3bf4f1232827@de.ibm.com>
Date: Mon, 9 Nov 2020 16:53:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109154831.20779-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-09_08:2020-11-05,
 2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090106
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 10:53:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 09.11.20 16:48, Halil Pasic wrote:
> Currently the default value of num_queues is effectively 1 for
> virtio-blk-ccw. Recently 9445e1e15e ("virtio-blk-pci: default num_queues
> to -smp N") changed the default for pci to the number of vcpus, citing
> interrupt better locality and better performance as a rationale.
> 
> While virtio-blk-ccw does not yet benefit from better interrupt
> locality, measurements have shown that for secure VMs multiqueue does
> help with performance. Since the bounce buffering happens with the queue
> lock held (in the guest) this is hardly a surprise.
> 
> As for non-secure VMs the extra queues shouldn't hurt too much.

In fact we have also seen improvments for multiqueues for non secure guests
as one virtqueue seems to have a hard capping in terms of bandwidth that can
be smaller than newer storage devices.

> 
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> 
> We would prefer to land this for 5.2. If we do then commit 9445e1e15e
> ("virtio-blk-pci: default num_queues to -smp N") took care of all the
> necessary compat handling.
> 
> If that's not possible, I will send a version that does the necessary
> compat handling.

Right. At the moment the original patch has all the necessary compat handling
for 5.1 for all platforms. Adding multi-queue for s390x for > 5.2 would mean
that we would need to have additional platform specific compat handling and it
would increase the patch size unnecessarily. 
In the end you could consider this an enhancement (not calling it fix) of the
original patch.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw-blk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
> index 2294ce1ce4..7296140dde 100644
> --- a/hw/s390x/virtio-ccw-blk.c
> +++ b/hw/s390x/virtio-ccw-blk.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio.h"
>  #include "qapi/error.h"
> @@ -20,6 +21,11 @@ static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>  {
>      VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf = &dev->vdev.conf;
> +
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = MIN(4, current_machine->smp.cpus);
> +    }
>  
>      qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
>  }
> 
> base-commit: 2a190a7256a3e0563b29ffd67e0164097b4a6dac
> 

