Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C152147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ri6QmJVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C152147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWdt-0001iF-TM
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:34:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLWKU-0003GC-RR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLWKT-00055l-Gi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:14:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hLWKT-00055C-5u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:14:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UH4rsl014697; Tue, 30 Apr 2019 17:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=DQTNZZhsQKt4voEepoJ9Y47rLJgWfSsZm28VVRxKQ1E=;
	b=ri6QmJVwL/vr3a9gKu6Qasq3OYCj9svwQNWW60yA+aUylSbPzGjGFIn3b7xDc2TJrq0C
	AddJDwzWN2Cegw0rJrINuTMIod7gXnL8AjezRBCjXLo2NvohkgSGJ05R8+WdewEOpxpz
	CvVNuJAtEU2Hq6U2sY6BbGoDr2AXkj8w5sIwaeeUq5rePxxGvqseDV/vR3Vc+IZoPBzL
	56SAlAPdzBaxV9yUmM4IRarVSbdQx3t3ORh5zL8D+Sc8WwPMikRicnSLF1/unzPW1rM2
	j7lq0czU1fRutnUPFJGdYRER3E90k1Pi390tpr/VPU77BXdEKkRIWhfhqC7FPiUTdCTl
	OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 2s4ckde5n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 17:14:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UHDalr186532; Tue, 30 Apr 2019 17:14:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2s4yy9nxh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 17:14:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UHDxkl013605;
	Tue, 30 Apr 2019 17:13:59 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 30 Apr 2019 10:13:58 -0700
Date: Tue, 30 Apr 2019 20:13:54 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <20190430171350.GA2763@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
	<20190422164527.GF21588@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422164527.GF21588@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904300104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904300104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
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
Cc: mst@redhat.com, linux-rdma@vger.kernel.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, Hannes Reinecke <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430171354.5lBxLH4QtVnYhSu0byFvkws7K4LC_cCTz976-8BjuNw@z>

On Mon, Apr 22, 2019 at 01:45:27PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> > On 4/15/19 12:35 PM, Yuval Shaia wrote:
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
> > > > >    in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > >    that this is reasonable so one option is to have one for all and
> > > > >    multiplex the traffic on it. This is not good approach as by design it
> > > > >    introducing an optional starvation. Another approach would be multi
> > > > >    queues and round-robin (for example) between them.
> > > > > 
> > Typically there will be a one-to-one mapping between QPs and CPUs (on the
> > guest). 
> 
> Er we are really overloading words here.. The typical expectation is
> that a 'RDMA QP' will have thousands and thousands of instances on a
> system.
> 
> Most likely I think mapping 1:1 a virtio queue to a 'RDMA QP, CQ, SRQ,
> etc' is a bad idea...

We have three options, no virtqueue for QP, 1 to 1 or multiplexing. What
would be your vote on that?
I think you are for option #1, right? but in this case there is actually no
use of having a virtio-driver, isn't it?

> 
> > However, I'm still curious about the overall intent of this driver. Where
> > would the I/O be routed _to_ ?
> > It's nice that we have a virtualized driver, but this driver is
> > intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> > And this I/O needs to be send to (and possibly received from)
> > something.
> 
> As yet I have never heard of public RDMA HW that could be coupled to a
> virtio scheme. All HW defines their own queue ring buffer formats
> without standardization.

With virtio it is the time to have a standard, do you agree?

> 
> > If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> > by using virtio-mdev?
> 
> Using PCI pass through means the guest has to have drivers for the
> device. A generic, perhaps slower, virtio path has some appeal in some
> cases.

From experience we have with other emulated device the gap is getting lower
as the message size getting higher. So for example with message of size 2M
the emulated device gives close to line rate performances.

> 
> > If so, how would we route the I/O from one guest to the other?
> > Shared memory? Implementing a full-blown RDMA switch in qemu?
> 
> RoCE rides over the existing ethernet switching layer quemu plugs
> into
> 
> So if you built a shared memory, local host only, virtio-rdma then
> you'd probably run through the ethernet switch upon connection
> establishment to match the participating VMs.

Or you may use an enhanced rxe device, which bypass the Ethernet and
perform fast copy, as backend device for the virtio-rdma emulated device.

> 
> Jason

