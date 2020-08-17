Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564F8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C66A2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NhAjlv3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C66A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7jvf-0005l8-BZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 14:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k7juX-0005Iv-Hf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 14:31:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k7juT-0004El-3u
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 14:31:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HIQRfG099561;
 Mon, 17 Aug 2020 18:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IXjbwCagRAUMGzuwfRCiHbZ+G6nLyJzIRMKNHqAyqPA=;
 b=NhAjlv3jZ+XAip+hXEai3MlY4jTwlR3aevIlk654fV+BZrDVA2Aq5Ep9yu9QQ6wU7RU9
 82VYy4j/P4yxle1uyPBn6tHz+9t4ogUpk2fgpZJYP19mg8aNEqjJXvzgORCf2WygNhJE
 /6gF5HLo9jNHjo2xl1u7+VuefS48oxg+NZFBR32eR+HoqmzVbIRAC7UDaZk6xrEZ2ERQ
 OZtdeaU0jJ3JquGhBUbtKrA3s63UGlHa0SuT5UfpygPSJIsuMkK3x00vjf7pXS+E1iZy
 BtdU/ZDrjpn9ZwyUHJ7cgw1FDRIOKg1JSKk/4gGA/A1rvtfNy8l2vEQ9NOvxQPg0gkFQ qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32x74r0jsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Aug 2020 18:30:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HIDiXD043129;
 Mon, 17 Aug 2020 18:30:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 32xsm0re6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2020 18:30:56 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07HIUrEr019206;
 Mon, 17 Aug 2020 18:30:54 GMT
Received: from [10.39.206.110] (/10.39.206.110)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Aug 2020 11:30:53 -0700
Subject: Re: [PATCH V1 18/32] osdep: import MADV_DOEXEC
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-19-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <51c859fb-3340-e361-1945-0ec2a393a34d@oracle.com>
Date: Mon, 17 Aug 2020 14:30:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170129
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 14:31:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/2020 11:14 AM, Steve Sistare wrote:
> Anonymous memory segments used by the guest are preserved across a re-exec
> of qemu, mapped at the same VA, via a proposed madvise(MADV_DOEXEC) option
> in the Linux kernel. For the madvise patches, see:
> 
> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/qemu/osdep.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Hi Alex,
  The MADV_DOEXEC functionality, which is a pre-requisite for the entire qemu 
live update series, is getting a chilly reception on lkml.  We could instead 
create guest memory using memfd_create and preserve the fd across exec.  However, 
the subsequent mmap(fd) will return a different VA than was used previously, 
which  is a problem for memory that was registered with vfio, as the original VA 
is remembered in the kernel struct vfio_dma and used in various kernel functions, 
such as vfio_iommu_replay.

To fix, we could provide a VFIO_IOMMU_REMAP_DMA ioctl taking iova, size, and
new_vaddr.  The implementation finds an exact match for (iova, size) and replaces 
vaddr with new_vaddr.  Flags cannot be changed.

memfd_create plus VFIO_IOMMU_REMAP_DMA would replace MADV_DOEXEC.
vfio on any form of shared memory (shm, dax, etc) could also be preserved across
exec with shmat/mmap plus VFIO_IOMMU_REMAP_DMA.

What do you think?

- Steve

