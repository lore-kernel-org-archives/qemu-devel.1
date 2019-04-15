Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18238C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807982070D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jc79uAuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807982070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyr0-0006mo-6p
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:28:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyqB-0006RD-Js
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFyqA-0003HP-Is
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:27:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hFyqA-0003Ed-7B
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:27:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FAEt6T130546; Mon, 15 Apr 2019 10:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=cwCDOoMj8HqKojsbDpaStwaIlbZtsuiHLRAYnxPPCXI=;
	b=jc79uAuv3uWffv75hrNs48aPea0wjRR8Q72Xr1+4Q8aNjSogj1F4ziyBMAR0Sh7uua+c
	insBJXPLi4hhUkWwx93nn6HgZE7KoNFdzUPawkKHqAAlHmNlvSSYU8kbvAGXCSQnCzQD
	OFzVilan/oz16WmeVLNyQ6BRl0l9cddK2/+aIw5BzP3kq5VOwg23unNZo4Fr7nWlKQGa
	PCtblfzJTTu2f+TKeunrB1FGxl6zH271C7x8XY1pCtAA1MQAhQ/h/LIIZpg42LpCx4Ve
	VqX+FHqUP07/5enfuNY42IgThDrT4iO0XGv5Sj0mkp74PI3unEXc7CZradxqwr+XqMkc
	7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2ru76t5rxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:27:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FAQB0u008187; Mon, 15 Apr 2019 10:27:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2rv2tu3gc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:27:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FARi7G002061;
	Mon, 15 Apr 2019 10:27:45 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 03:27:44 -0700
Date: Mon, 15 Apr 2019 13:27:39 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Devesh Sharma <devesh.sharma@broadcom.com>
Message-ID: <20190415102738.GB6145@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190411172402.GA14509@mellanox.com> <20190411173419.GB6259@lap1>
	<20190411174124.GA6428@lap1>
	<CANjDDBj0rqZEmHzMH+2461_DvjV5K4hT=hJ_usBuucV4Xwh84g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CANjDDBj0rqZEmHzMH+2461_DvjV5K4hT=hJ_usBuucV4Xwh84g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150073
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
	<virtualization@lists.linux-foundation.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415102739.HmvtbXOnckAfnu3g9SsJNKIo5lwVyez-aXAunaRRudU@z>

On Fri, Apr 12, 2019 at 03:21:56PM +0530, Devesh Sharma wrote:
> On Thu, Apr 11, 2019 at 11:11 PM Yuval Shaia <yuval.shaia@oracle.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 08:34:20PM +0300, Yuval Shaia wrote:
> > > On Thu, Apr 11, 2019 at 05:24:08PM +0000, Jason Gunthorpe wrote:
> > > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > > >
> > > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > > more software runs in virtualized environment.
> > > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > > >
> > > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > > technology and also because the Virtio specification
> > > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > > achieve bare metal performance.
> > > > > >
> > > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > > Virtio Specification and a look forward on possible implementation
> > > > > > techniques.
> > > > > >
> > > > > > Open issues/Todo list:
> > > > > > List is huge, this is only start point of the project.
> > > > > > Anyway, here is one example of item in the list:
> > > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > > >   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > > >   that this is reasonable so one option is to have one for all and
> > > > > >   multiplex the traffic on it. This is not good approach as by design it
> > > > > >   introducing an optional starvation. Another approach would be multi
> > > > > >   queues and round-robin (for example) between them.
> > > > > >
> > > > > > Expectations from this posting:
> > > > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > > > very bad idea, to yeah, go ahead, we really want it.
> > > > > > Idea here is that since it is not a minor effort i first want to know if
> > > > > > there is some sort interest in the community for such device.
> > > > >
> > > > > My first reaction is: Sounds sensible, but it would be good to have a
> > > > > spec for this :)
> > > >
> > > > I'm unclear why you'd want to have a virtio queue for anything other
> > > > that some kind of command channel.
> > > >
> > > > I'm not sure a QP or CQ benefits from this??
> > >
> > > Virtqueue is a standard mechanism to pass data from guest to host. By
> >
> > And vice versa (CQ?)
> >
> > > saying that - it really sounds like QP send and recv rings. So my thought
> > > is to use a standard way for rings. As i've learned this is how it is used
> > > by other virtio devices ex virtio-net.
> > >
> > > >
> > > > Jason
> > >
> I would like to ask more basic question, how virtio queue will glue
> with actual h/w qps? I may be to naive though.

Have to admit - I have no idea.
This work is based on emulated device so i'm my case - the emulated device
is creating the virtqueue. I guess that HW device will create a QP and
expose a virtqueue interface to it.
The same driver should serve both the SW and HW devices.

One of the objectives of this RFC is to collaborate an effort and
implementation notes/ideas from HW vendors.

> 
> -Regards
> Devesh

