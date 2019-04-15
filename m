Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB183C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993742075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1XJ/igGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993742075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyUl-0006jr-Tc
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:05:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyTq-0006Lx-2O
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyTn-00028V-PY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:04:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hFyTj-00022G-P8
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:04:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3F9x95O129755; Mon, 15 Apr 2019 10:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=ycqbcyh9hwr32GvLaOPBJG7TYwjKeuC/4PPPaV+2a2Q=;
	b=1XJ/igGjhFMQKLs2KdRGte/QBHnWxRmVTJluzJzM7DJlaeiFK3BU9HAcWV72GWxl7++K
	u354dIstnxJKju5qyc+oq2b974oVTjVSbORwenNZScl13xUG6zXLnZIpP6xxzSfP8lUV
	KC61vUJWZSS7J00j92b9p0kSiMfitf4CLBXPlQRdIh3IGEyCNip5YtgIZH+22kmym567
	EqQIpfb/k9Zx6G7lpiyBaMvlitTF9T7gYwDXKO9TGun+FEmPOxwq/UEhN29puccWIMjr
	tyZYN3ifps8vWTIclO0r5gPBMmnAPrJFpMgDMqtVZoUku7HITxjs0ScuLKsYBCKaLKgp
	GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2rusnekr2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:04:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FA46B7124734; Mon, 15 Apr 2019 10:04:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2ru5ta8gp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:04:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FA4VLL015957;
	Mon, 15 Apr 2019 10:04:31 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 03:04:30 -0700
Date: Mon, 15 Apr 2019 13:04:22 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Message-ID: <20190415100421.GA6145@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190411172402.GA14509@mellanox.com> <20190411173419.GB6259@lap1>
	<20190411174022.GA26227@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411174022.GA26227@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150071
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150071
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
Cc: "mst@redhat.com" <mst@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415100422.PVpbmpJu-1ZRLz8jTU0yOdfHG3x5e-ftK7KPVRtXr2U@z>

On Thu, Apr 11, 2019 at 05:40:26PM +0000, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2019 at 08:34:20PM +0300, Yuval Shaia wrote:
> > On Thu, Apr 11, 2019 at 05:24:08PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > > 
> > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > more software runs in virtualized environment.
> > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > > 
> > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > technology and also because the Virtio specification
> > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > achieve bare metal performance.
> > > > > 
> > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > Virtio Specification and a look forward on possible implementation
> > > > > techniques.
> > > > > 
> > > > > Open issues/Todo list:
> > > > > List is huge, this is only start point of the project.
> > > > > Anyway, here is one example of item in the list:
> > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > >   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > >   that this is reasonable so one option is to have one for all and
> > > > >   multiplex the traffic on it. This is not good approach as by design it
> > > > >   introducing an optional starvation. Another approach would be multi
> > > > >   queues and round-robin (for example) between them.
> > > > > 
> > > > > Expectations from this posting:
> > > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > > very bad idea, to yeah, go ahead, we really want it.
> > > > > Idea here is that since it is not a minor effort i first want to know if
> > > > > there is some sort interest in the community for such device.
> > > > 
> > > > My first reaction is: Sounds sensible, but it would be good to have a
> > > > spec for this :)
> > > 
> > > I'm unclear why you'd want to have a virtio queue for anything other
> > > that some kind of command channel.
> > > 
> > > I'm not sure a QP or CQ benefits from this??
> > 
> > Virtqueue is a standard mechanism to pass data from guest to host. By
> > saying that - it really sounds like QP send and recv rings. So my thought
> > is to use a standard way for rings. As i've learned this is how it is used
> > by other virtio devices ex virtio-net.
> 
> I doubt you can use virtio queues from userspace securely? Usually
> needs a dedicated page for each user space process

Not yet started to do any work on datapath, i guess you are right but need
further work on this area.
Thanks for raising the concern.

As i said, there are many open issues at this stage.

> 
> Jason

