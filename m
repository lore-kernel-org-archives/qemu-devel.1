Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB97C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976ED21744
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="itDcFZUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976ED21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyDYj-0001N2-ON
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 07:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1hyDY5-0000we-LG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hyDY4-0008DX-66
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:04:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hyDY3-0008Cn-VE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:04:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FB0am2141142;
 Thu, 15 Aug 2019 11:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IRy8xnfC1c+1WDi2BfdkyruBCmC8ntzyuapptQJ90YI=;
 b=itDcFZUzFNht5/F0Pw3ql9OELF2XvXcZx/xDPU6k1O0kBxZ9FpiscyVaE1Rd7+zLgHIU
 b1VMbsu45nwlipRg3tEXLKGMr4XpByhex4XRzS+mZAl94Ey4S8jiXNpbUVFBXed9zPf+
 aW1lw4bi8KUZIBVrFkbDl9kPowxy5J5g3aeDAzcRobu8Mk/l3uBo6W2LFMJ3cGLayfYc
 nL67mPTq/T84JXr9Dfle8qdswnqnmMLnyltJLJ+77pdn8dSQH1q4HNCyQq9Kn+ZY5g+p
 DodUYXi7chQB6UmAkVBrDUrE0TVYGjlxOl+XFBmMVqu42zg4m+ZA6p+SJ88Dafs7G/N+ gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2u9nvpjab3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 11:04:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FB3pXT156578;
 Thu, 15 Aug 2019 11:04:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ucmwjjmdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 11:04:00 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7FB3xAE012925;
 Thu, 15 Aug 2019 11:03:59 GMT
Received: from lap1 (/218.189.35.1) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Aug 2019 04:03:58 -0700
Date: Thu, 15 Aug 2019 14:03:52 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190815110350.GB3018@lap1>
References: <20190720234803.18938-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720234803.18938-1-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC v3 0/2] Add live migration support in the
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

On Sun, Jul 21, 2019 at 05:18:01AM +0530, Sukrit Bhatnagar wrote:
> In v2, we had successful migration of PCI and MSIX states as well as
> various DMA addresses and ring page information.
> This series enables the migration of various GIDs used by the device.
> 
> We have switched to a setup having two hosts and two VMs running atop them.
> Migrations are now performed over the local network. This has settled the
> same-host issue with libvirt.
> 
> We also have performed various ping-pong tests (ibv_rc_pingpong) in the
> guest(s) after adding GID migration support and this is the current status:
> - ping-pong to localhost succeeds, when performed before starting the
>   migration and after the completion of migration.
> - ping-pong to a peer succeeds, both before and after migration as above,
>   provided that both VMs are running on/migrated to the same host.
>   So, if two VMs were started on two different hosts, and one of them
>   was migrated to the other host, the ping-pong was successful.
>   Similarly, if two VMs are migrated to the same host, then after migration,
>   the ping-pong was successful.
> - ping-pong to a peer on the remote host is not working as of now.
> 
> Our next goal is to achieve successful migration with live traffic.

As this is a major milestone which enable live migration (still when there
are no QPs), i believe we are ok for a patch.

Yuval

> 
> This series can be also found at:
> https://github.com/skrtbhtngr/qemu/tree/gsoc19
> 
> 
> History:
> 
> v2 -> v3:
> - remove struct PVRDMAMigTmp and VMSTATE_WITH_TMP
> - use predefined PVRDMA_HW_NAME for the vmsd name
> - add vmsd for gids and a gid table field in pvrdma_state
> - perform gid registration in pvrdma_post_load
> - define pvrdma_post_save to unregister gids in the source host
> 
> v1 -> v2:
> - modify load_dsr() to make it idempotent
> - switch to VMStateDescription
> - add fields for PCI and MSIX state
> - define a temporary struct PVRDMAMigTmp to use WITH_TMP macro
> - perform mappings to CQ and event notification rings at load
> - vmxnet3 issue solved by Marcel's patch
> - BounceBuffer issue solved automatically by switching to VMStateDescription
> 
> 
> Link(s) to v2:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01848.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01849.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01850.html
> 
> Link(s) to v1:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
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

