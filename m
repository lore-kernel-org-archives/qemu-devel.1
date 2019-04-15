Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81357C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376DC2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LwPE2go3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376DC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyz6-0001hr-DM
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:37:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyy6-0001L4-Oj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyy5-0005qP-Bj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hFyy4-0005pn-Rp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FATA5k154348; Mon, 15 Apr 2019 10:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=y3V9ndy/Qm5yVBdn+YrDF4jd95IBdj4M6Ir3QrTHJOA=;
	b=LwPE2go3ika4GfcdL/mqQFwLnSf42Y9Gwoo6Z8+LegQpSIEzagjefWXYueDkMLNj/32G
	kcnJ8SS6wqIA8zQV91UCmSuqHDviaWX6o4ulU2/z1DFz7JW2eQPB2Ow66VT3Jx53aqjN
	pQsXZOKz+qRXSY8etzOom+/vrxwVJH7uWkTagfIz/W3JKLPdp/M0hsWzHmjLQqhabOxG
	myuVBjj+snviCCvg6T/bdA+b3jWKqokIQRuBXj1kwsH5wnNmaaLtkJ1+15juJwlJBn8m
	BfCGNL+ZxUaVnpK5rdjyffrUyfg1OjQFOlCEP6ZJVUCD/xM9dhM0zAP6zjY2a/jHK9CG
	NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2rusnekvb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:35:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FAY3tk188212; Mon, 15 Apr 2019 10:35:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2ru5ta8vpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:35:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FAZs7M000534;
	Mon, 15 Apr 2019 10:35:54 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 03:35:54 -0700
Date: Mon, 15 Apr 2019 13:35:47 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190415103546.GA6854@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411190215.2163572e.cohuck@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150074
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
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
Cc: mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415103547.2GxNeS6WBzZnT-AEhTs3uXgWHQA8csYrX2Nwkqrdy9o@z>

On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> On Thu, 11 Apr 2019 14:01:54 +0300
> Yuval Shaia <yuval.shaia@oracle.com> wrote:
> 
> > Data center backends use more and more RDMA or RoCE devices and more and
> > more software runs in virtualized environment.
> > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > 
> > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > technology and also because the Virtio specification
> > allows Hardware Vendors to support Virtio protocol natively in order to
> > achieve bare metal performance.
> > 
> > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > Virtio Specification and a look forward on possible implementation
> > techniques.
> > 
> > Open issues/Todo list:
> > List is huge, this is only start point of the project.
> > Anyway, here is one example of item in the list:
> > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> >   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> >   that this is reasonable so one option is to have one for all and
> >   multiplex the traffic on it. This is not good approach as by design it
> >   introducing an optional starvation. Another approach would be multi
> >   queues and round-robin (for example) between them.
> > 
> > Expectations from this posting:
> > In general, any comment is welcome, starting from hey, drop this as it is a
> > very bad idea, to yeah, go ahead, we really want it.
> > Idea here is that since it is not a minor effort i first want to know if
> > there is some sort interest in the community for such device.
> 
> My first reaction is: Sounds sensible, but it would be good to have a
> spec for this :)
> 
> You'll need a spec if you want this to go forward anyway, so at least a
> sketch would be good to answer questions such as how many virtqueues
> you use for which purpose, what is actually put on the virtqueues,
> whether there are negotiable features, and what the expectations for
> the device and the driver are. It also makes it easier to understand
> how this is supposed to work in practice.
> 
> If folks agree that this sounds useful, the next step would be to
> reserve an id for the device type.

Thanks for the tips, will sure do that, it is that first i wanted to make
sure there is a use case here.

Waiting for any feedback from the community.

> 
> > 
> > The scope of the implementation is limited to probing the device and doing
> > some basic ibverbs commands. Data-path is not yet implemented. So with this
> > one can expect only that driver is (partialy) loaded and basic queries and
> > resource allocation is done.
> > 
> > One note regarding the patchset.
> > I know it is not standard to collaps patches from several repos as i did
> > here (qemu and linux) but decided to do it anyway so the whole picture can
> > be seen.
> > 
> > patch 1: virtio-net: Move some virtio-net-pci decl to include/hw/virtio
> > 	This is a prelimenary patch just as a hack so i will not need to
> > 	impelement new netdev
> > patch 2: hw/virtio-rdma: VirtIO rdma device
> > 	The implementation of the device
> > patch 3: RDMA/virtio-rdma: VirtIO rdma driver
> > 	The device driver
> > 
> 

