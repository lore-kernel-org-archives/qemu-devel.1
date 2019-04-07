Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA85C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECCF20B1F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gSF602lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECCF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD3uQ-0008JB-KT
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 05:16:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hD3tW-0007t9-BJ
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hD3tV-0007Mc-Ba
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:15:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hD3tV-0007MC-0i
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:15:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x379FERO058270; Sun, 7 Apr 2019 09:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=kdv/i64V7G/Un8ja5JzlEYb74/46iaR1SYhnDDmdp0s=;
	b=gSF602lp3W6oarAIsqYGjaEGk2/DjmlD45ypJxutPGyUNiqsOhHtzBciqlbwxLEFAsLn
	H4gej4DVKwAf+cKOtKRX9wbHfD+TbxocrOaQo2ceTGVKxwO++eAQMGrEJ0M71QMrnOhY
	QEZxII3IsGVzGKxpF6W9cJ/OG8xm2NwMCH09LqZRsKMEzVtNeVbKUxgvJnTRSXvbQJOd
	X4zP14i4FWgTQda/6u+8LVp8fkvqh8XvbiYwwP2fqR2GYt+qbA7mPTd/JzQiT5OaUl1C
	nonz7/2vGOwE1u7HEpbpBQq9Hp++Q58ktqnLWHLxrIvUSarhUc4Q2KT6o0aDSJ9zcmMS
	6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rpkhsje47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2019 09:15:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x379DZd4018406; Sun, 7 Apr 2019 09:15:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2rpytandxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2019 09:15:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x379FCte025578;
	Sun, 7 Apr 2019 09:15:13 GMT
Received: from lap1 (/10.175.45.87) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 07 Apr 2019 09:15:12 +0000
Date: Sun, 7 Apr 2019 12:15:04 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <20190407091503.GB6737@lap1>
References: <20190403113343.26384-1-kamalheib1@gmail.com>
	<20190403181937.GE3446@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190403181937.GE3446@lap1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9219
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904070086
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9219
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904070087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH v3 0/4] pvrdma: Add support for SRQ
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407091504.saF5I3geKVPAmzPpms1tfJqQBt_m-qy2XUNxV6XQ0Fs@z>

On Wed, Apr 03, 2019 at 09:19:38PM +0300, Yuval Shaia wrote:
> On Wed, Apr 03, 2019 at 02:33:39PM +0300, Kamal Heib wrote:
> > This series implements the SRQ (Shared Receive Queue) for the pvrdma
> > device, It also includes all the needed functions and definitions for
> > support SRQ in the backend and resource management layers.
> > 
> > Changes from v2->3:
> > - Patch #1:
> > -- Fix commit message.
> > -- Remove initialization of backend_qp from rdma_backend_post_srq_recv().
> > -- Add rx_srq counter.
> > - Patch #2:
> > -- Add checks for srq attrs.
> > - Patch #3:
> > -- Move initialization of recv_cq_handle to be under is_srq.
> > -- Rearrange destroy_qp() to avoid use after free.
> > - Patch #4:
> > -- Avoid use after free.
> > -- Fix indentation.
> > 
> > Changes from v1->v2:
> > - Handle checkpatch.pl warnings. 
> 
> Appreciate if you can post v4 with a new patch to display the new counter
> (function rdma_dump_device_counters).

Please ignore this comment, counter is already added - i missed that.

With that - patchset lgtm, from my perspective ready to merge.

> 
> > 
> > Kamal Heib (4):
> >   hw/rdma: Add SRQ support to backend layer
> >   hw/rdma: Add support for managing SRQ resource
> >   hw/rdma: Modify create/destroy QP to support SRQ
> >   hw/pvrdma: Add support for SRQ
> > 
> >  hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++-
> >  hw/rdma/rdma_backend.h      |  18 +++-
> >  hw/rdma/rdma_backend_defs.h |   5 +
> >  hw/rdma/rdma_rm.c           | 117 +++++++++++++++++++-
> >  hw/rdma/rdma_rm.h           |  13 ++-
> >  hw/rdma/rdma_rm_defs.h      |  10 ++
> >  hw/rdma/vmw/pvrdma_cmd.c    | 206 ++++++++++++++++++++++++++++++++----
> >  hw/rdma/vmw/pvrdma_main.c   |  16 +++
> >  hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++-
> >  hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
> >  10 files changed, 521 insertions(+), 36 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> > 
> 

