Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C8C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA2D205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhfPa6G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA2D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Jgj-0001pi-Ju
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3JfF-0001Ap-BY
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3JfD-00053Z-Np
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:36:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i3JfD-0004xn-DH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:36:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCZ7Ju013573;
 Thu, 29 Aug 2019 12:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=pxyVWTKsHlbhGpd/+lrnPoTi5QlKWpdoiaWfprlV2+g=;
 b=nhfPa6G7/6yqrNUwt3z90OhSPwhxvieJXlciGtxl0UMlYGcfqzgVZ2Khz2Hti8aOxskd
 kuDiJrAEjw+lhAO4uUu3CNR7NZCp7sMxQlIN7MaHY9lDylox/ZSKMDzrThffyUu6TJp3
 VUv7OmnjJ4LxErIlreVtx2UNc7Gr3MuihPIzlIAIvQvoIsIV9c+vGn9Uj/EPduq/TSk5
 hYaUHCjdsVB5HU/3OSXoS5g6/W05Hin9PohmcB9lYRZW1YYD1pcW6pstmLoIHvtifpa2
 gNqcJXcMQiF+R3DQbWpYHMeNTwIz8N+y2hYItov0+RiLo8LMlSZHstRHwOUoMdX+pNuo cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2upeu700e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:36:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCYFd9046733;
 Thu, 29 Aug 2019 12:36:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2unteuy6dv-75
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:36:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7TC0Hp2013536;
 Thu, 29 Aug 2019 12:00:17 GMT
Received: from lap1 (/10.175.46.168) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Aug 2019 05:00:17 -0700
Date: Thu, 29 Aug 2019 15:00:13 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190829120013.GA9911@lap1>
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828142328.24561-1-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Add live migration support in the
 PVRDMA device
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 07:53:26PM +0530, Sukrit Bhatnagar wrote:
> This series enables the migration of various GIDs used by the device.    
> This is in addition to the successful migration of PCI and MSIX states
> as well as various DMA addresses and ring page information.
>     
> We have a setup having two hosts and two VMs running atop them.    
> Migrations are performed over the local network.    
> 
> We also have performed various ping-pong tests (ibv_rc_pingpong) in the    
> guest(s) after adding GID migration support and this is the current status:    
> - ping-pong to localhost succeeds, when performed before starting the    
>   migration and after the completion of migration.    
> - ping-pong to a peer succeeds, both before and after migration as above,    
>   provided that both VMs are running on/migrated to the same host.    
>   So, if two VMs were started on two different hosts, and one of them    
>   was migrated to the other host, the ping-pong was successful.    

This limitation looks to me like wrongly configured network. This patch-set
should enable any migration.

After our last meeting, please confirm.

In addition, i don't see why non-VM peer (i.e. Bare-metal) is not
supported. Can you run a test and update with the results?

>   Similarly, if two VMs are migrated to the same host, then after migration,    
>   the ping-pong was successful.    
> - ping-pong to a peer on the remote host is not working as of now.    
>     
> Our next goal is to achieve successful migration with live traffic.    
>     
> This is the same as the RFC v3 series posted earlier:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04752.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04753.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04754.html
> 
> 
> Sukrit Bhatnagar (2):
>   hw/pvrdma: make DSR mapping idempotent in load_dsr()
>   hw/pvrdma: add live migration support
> 
>  hw/rdma/vmw/pvrdma_main.c | 94 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 8 deletions(-)
> 
> -- 
> 2.21.0
> 
> 

