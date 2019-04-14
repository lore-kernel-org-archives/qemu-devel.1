Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35CC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 05:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69E620693
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 05:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oloNbpjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69E620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFXeG-0003CC-JN
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 01:25:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFXdR-0002mv-2t
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFXbP-00076y-W4
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:22:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hFXbP-00075D-JZ
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:22:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3E5EhUv186059; Sun, 14 Apr 2019 05:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=Dxn+cYQUpCUAieAsgTX1R4UwvINnZuC5oaBq+LyuzTI=;
	b=oloNbpjNjJgv+0OMuc3AyfKC9Ryj7ChYA3YOImFxNAP+st9cRJRotLQg90HhhcXMpRRa
	sLp8of3s/H+cR5ARLr4RnI88AP4H1vjifsyiprN5jBsn7nboydInY2lyzaywApqPycjv
	WjbhxMbEQQMZxiTL+gUlsz6HLS1bKP89roQZZMQV/amunMLgdQou7L+/H1BCjQXmwocL
	9POoOC/cgQlk4Zkd3rMzVdakNUkDgEbxxF18UxL7Ag/1aFlU8ySNdNmvP4DmuYH5FD3Y
	mQ9Q2pGnDWCBBrSs1r1S7EAfGPZimHwjpGTZYHZ763RVXwHAOvLuV/u6tE4xcTpe+6Sh
	xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2rusnegdvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2019 05:22:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3E5KADe164087; Sun, 14 Apr 2019 05:20:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2rue156xpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2019 05:20:38 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3E5KXCO029161;
	Sun, 14 Apr 2019 05:20:36 GMT
Received: from lap1 (/199.203.86.132) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 14 Apr 2019 05:20:32 +0000
Date: Sun, 14 Apr 2019 08:20:25 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Yanjun Zhu <yanjun.zhu@oracle.com>
Message-ID: <20190414052024.GA2842@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
	<199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=760
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904140037
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=785
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904140037
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
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
Cc: mst@redhat.com, linux-rdma@vger.kernel.org, cohuck@redhat.com,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414052025.mtMhfHJ0TI17OAQ-D6Pw8kW2Zj6xdbBbXxrJzk75dLk@z>

> > +
> > +	wake_up(&dev->acked);
> > +
> > +	printk("%s\n", __func__);
> 
> Cool:-)
> 
> this line should be for debug?

Yes

> 
> Zhu Yanjun
> 

