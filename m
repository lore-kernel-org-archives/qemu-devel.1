Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E8C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FB121734
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C6C+KxHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FB121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWWW-0004D4-FB
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:26:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLWNI-0005PB-E2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hLWNG-0006rA-Jl
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:17:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hLWNE-0006pa-Mb
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:16:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UH4FwP003846; Tue, 30 Apr 2019 17:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=YCvAXQQY1/RYFeen1yHy0EWWZQl2k3jibJKenif4IWk=;
	b=C6C+KxHRLNuKoYz9vV6GyXwrDJ5HS/peF9RF+fYLCMG0u088X9sb+n9k36o08svxhIPp
	YbDecGp3XSDLLqCPsaP5izOxO15EXRYgZk7tkhaGwRnSyw2u3xdQ1gDcu5bteG1VPIzT
	Nc/nP59okv0atFK+hf0IFuu0XKkOEH0otSt/3H49hoOfeVK9Gkr/T+ky8d2ciOilEhLt
	mRYVHdDc4UViDeb+8TmYQubx1j9luv21SoKZFEVj7NZiEIuzuNYNgqKcabDeSYmhxRVV
	ISnvOdFBw1wdmDYb1h6+dZqVfqz5xJARDezgOGXn2PWFK/rkXzedRGvzgA1zMBH4ZA+e
	GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2s5j5u2mvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 17:16:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3UHGgbF007102; Tue, 30 Apr 2019 17:16:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2s4d4an35x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2019 17:16:42 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UHGgRJ015187;
	Tue, 30 Apr 2019 17:16:42 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 30 Apr 2019 10:16:41 -0700
Date: Tue, 30 Apr 2019 20:16:37 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20190430171635.GA2937@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
	<20190422060034.GA27901@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422060034.GA27901@mtr-leonro.mtl.com>
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
Cc: mst@redhat.com, linux-rdma@vger.kernel.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, jgg@mellanox.com,
	Hannes Reinecke <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430171637.Y46Wl9Zr-N1_Bmwoliq-5qI5atKmy2QgmZSs1KItqxs@z>

On Mon, Apr 22, 2019 at 09:00:34AM +0300, Leon Romanovsky wrote:
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
> > guest). So while one would need to be prepared to support quite some QPs,
> > the expectation is that the actual number of QPs used will be rather low.
> > In a similar vein, multiplexing QPs would be defeating the purpose, as the
> > overall idea was to have _independent_ QPs to enhance parallelism.
> >
> > > > > Expectations from this posting:
> > > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > > very bad idea, to yeah, go ahead, we really want it.
> > > > > Idea here is that since it is not a minor effort i first want to know if
> > > > > there is some sort interest in the community for such device.
> > > >
> > > > My first reaction is: Sounds sensible, but it would be good to have a
> > > > spec for this :)
> > > >
> > > > You'll need a spec if you want this to go forward anyway, so at least a
> > > > sketch would be good to answer questions such as how many virtqueues
> > > > you use for which purpose, what is actually put on the virtqueues,
> > > > whether there are negotiable features, and what the expectations for
> > > > the device and the driver are. It also makes it easier to understand
> > > > how this is supposed to work in practice.
> > > >
> > > > If folks agree that this sounds useful, the next step would be to
> > > > reserve an id for the device type.
> > >
> > > Thanks for the tips, will sure do that, it is that first i wanted to make
> > > sure there is a use case here.
> > >
> > > Waiting for any feedback from the community.
> > >
> > I really do like the ides; in fact, it saved me from coding a similar thing
> > myself :-)
> >
> > However, I'm still curious about the overall intent of this driver. Where
> > would the I/O be routed _to_ ?
> > It's nice that we have a virtualized driver, but this driver is
> > intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> > And this I/O needs to be send to (and possibly received from)
> > something.
> >
> > So what exactly is this something?
> > An existing piece of HW on the host?
> > If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> > by using virtio-mdev?
> >
> > Another guest?
> > If so, how would we route the I/O from one guest to the other?
> > Shared memory? Implementing a full-blown RDMA switch in qemu?
> >
> > Oh, and I would _love_ to have a discussion about this at KVM Forum.
> > Maybe I'll manage to whip up guest-to-guest RDMA connection using ivshmem
> > ... let's see.
> 
> Following success in previous years to transfer ideas into code,
> we started to prepare RDMA miniconference in LPC 2019, which will
> be co-located with Kernel Summit and networking track.
> 
> I'm confident that such broad audience of kernel developers
> will be good fit for such discussion.

Just posted a proposal for a talk at Linux Plumbers.

> 
> Previous years:
> 2016: https://www.spinics.net/lists/linux-rdma/msg43074.html
> 2017: https://lwn.net/Articles/734163/
> 2018: It was so full in audience and intensive that I failed to
> summarize it :(
> 
> Thanks
> 
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke            Teamlead Storage & Networking
> > hare@suse.de                              +49 911 74053 688
> > SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N??rnberg
> > GF: Felix Imend??rffer, Mary Higgins, Sri Rasiah
> > HRB 21284 (AG N??rnberg)

