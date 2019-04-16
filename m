Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427CFC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8D82073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJ7gOEd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8D82073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJuE-00051S-As
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:57:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hGJtT-0004iI-OR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hGJtS-0002IQ-Na
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hGJtS-0002Hk-Cg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3G8sMhh041422; Tue, 16 Apr 2019 08:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=7WmhKGCLMOl08RFR0t4p+Nbaq4WeQhMg2l3J/gNS1e8=;
	b=pJ7gOEd93SBek/wSJo+zgs0NDRG/4YZrUibaeZWBEFj7B2X7xwu2x74i8y9OQwLh3LGP
	ARq4sT+3/H0yIlKUhGWp1gz2I8Nq9ZgUXxdNvgVSNes1YtodfVjk998Ht0D0ZrvhiN3o
	D6sz02OEzXL+79DOLIEozItm+bDySTOLNs2z5IFLfzS+rDMDwa/DG2UnuVqv1PMCyBk7
	89JjSpAEyQqtRG7zI1dhFXybLdsBEY8c2H7Y49UPXyxQ+L3VmdWcB5wlSHHVcqM1s4tm
	ReAhlGDNRhyA4olinBdYYgMlCkMJmWRoeurO0aVzKflwjvluxi1SYmbM9ublUV+gfSWz
	9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2ru59d3eqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 08:56:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3G8uMU2009366; Tue, 16 Apr 2019 08:56:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 2rubq677q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 08:56:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3G8uS5P016975;
	Tue, 16 Apr 2019 08:56:28 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 01:56:27 -0700
Date: Tue, 16 Apr 2019 11:56:21 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>
Message-ID: <20190416085620.GA4493@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
	<f133d122-5b00-2e3b-f5cc-efc6d2cc3d3b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <f133d122-5b00-2e3b-f5cc-efc6d2cc3d3b@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904160063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904160063
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
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
Message-ID: <20190416085621.97qXiel2ZeGLvp9ml0V1najf_3IBkf83bs2DMzMn-KE@z>

On Mon, Apr 15, 2019 at 06:07:52PM -0700, Bart Van Assche wrote:
> On 4/11/19 4:01 AM, Yuval Shaia wrote:
> > +++ b/drivers/infiniband/hw/virtio/Kconfig
> > @@ -0,0 +1,6 @@
> > +config INFINIBAND_VIRTIO_RDMA
> > +	tristate "VirtIO Paravirtualized RDMA Driver"
> > +	depends on NETDEVICES && ETHERNET && PCI && INET
> > +	---help---
> > +	  This driver provides low-level support for VirtIO Paravirtual
> > +	  RDMA adapter.
> 
> Does this driver really depend on Ethernet, or does it also work with
> Ethernet support disabled?

The device should eventually expose Ethernet interface as well as IB.

> 
> > +static inline struct virtio_rdma_info *to_vdev(struct ib_device *ibdev)
> > +{
> > +	return container_of(ibdev, struct virtio_rdma_info, ib_dev);
> > +}
> 
> Is it really worth to introduce this function? Have you considered to
> use container_of(ibdev, struct virtio_rdma_info, ib_dev) directly instead
> of to_vdev()?

Agree, not sure really needed, just saw that some drivers uses this pattern.

> 
> > +static void rdma_ctrl_ack(struct virtqueue *vq)
> > +{
> > +	struct virtio_rdma_info *dev = vq->vdev->priv;
> > +
> > +	wake_up(&dev->acked);
> > +
> > +	printk("%s\n", __func__);
> > +}
> 
> Should that printk() be changed into pr_debug()? The same comment holds for
> all other printk() calls.

All prints will be removed, this is still wip.

> 
> > +#define VIRTIO_RDMA_BOARD_ID	1
> > +#define VIRTIO_RDMA_HW_NAME	"virtio-rdma"
> > +#define VIRTIO_RDMA_HW_REV	1
> > +#define VIRTIO_RDMA_DRIVER_VER	"1.0"
> 
> Is a driver version number useful in an upstream driver?

I've noticed that other drivers exposes this in sysfs.

> 
> > +struct ib_cq *virtio_rdma_create_cq(struct ib_device *ibdev,
> > +				    const struct ib_cq_init_attr *attr,
> > +				    struct ib_ucontext *context,
> > +				    struct ib_udata *udata)
> > +{
> > +	struct scatterlist in, out;
> > +	struct virtio_rdma_ib_cq *vcq;
> > +	struct cmd_create_cq *cmd;
> > +	struct rsp_create_cq *rsp;
> > +	struct ib_cq *cq = NULL;
> > +	int rc;
> > +
> > +	/* TODO: Check MAX_CQ */
> > +
> > +	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
> > +	if (!cmd)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
> > +	if (!rsp) {
> > +		kfree(cmd);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
> > +	if (!vcq)
> > +		goto out;
> 
> Are you sure that you want to mix GFP_ATOMIC and GFP_KERNEL in a single
> function?

Right, a mistake.

> 
> Thanks,
> 
> Bart.

Thanks.

> 

