Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE47C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E62205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UhFR7LeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E62205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgbE-0006NR-B4
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:36:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNga1-0005gB-8M
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNga0-0001HI-9D
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNga0-0001FM-0O
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x46GYTi5170825; Mon, 6 May 2019 16:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=MHa5f3GuZ0dpS8obNu6fkzYKsiFoUmHkyl0R9RDBy4A=;
	b=UhFR7LeSqYpSO0CK/E5d5/bfiJBUVsTjtSHNtfC/lgX3thweiN49RxPnVpV/C7UdHXPk
	YJVKV8C7IBapHNbJV4UhBzi+q12nrH8ziR371Fma0R7iFaMai0dMgjZ0dD1hMMvdu6OV
	scDbrt8Z4xg7+wGQUfErpM9E1lgrf6pPDn5Xt6E+Dv59U8MixlyqAaczVpBGAgT6ggAA
	3bzKQjqLo46a967kkA82pnXVRIsZdQ2R5ejcmUjIcwkS0Uc9typ5pDMcrxJgC1w+v8UL
	PTaa8Rq39c3X3lGl3NkFZ2biAdL124z6nLCSPloGcbwISZVSzOmkId+CWqa9MmpiGiaT
	sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2s94bfqsbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2019 16:34:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x46GYvvR067862; Mon, 6 May 2019 16:34:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2s94b90cd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2019 16:34:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x46GYtVj009063;
	Mon, 6 May 2019 16:34:55 GMT
Received: from lap1 (/10.175.9.30) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 06 May 2019 09:34:55 -0700
Date: Mon, 6 May 2019 19:34:55 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190506163455.GA11809@lap1>
References: <20190505105518.22793-1-yuval.shaia@oracle.com>
	<05ff71d8-eb9d-08be-6081-dc66631b2034@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ff71d8-eb9d-08be-6081-dc66631b2034@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905060141
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905060141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Add support for GID state changes
 for non-qmp frameworks
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

On Mon, May 06, 2019 at 10:09:29AM -0500, Eric Blake wrote:
> On 5/5/19 5:55 AM, Yuval Shaia wrote:
> > Any GID change in guest must be propogate to host. This is already done
> 
> s/propogate to/propagated to the/
> 
> > by firing QMP event to managment system such as libvirt which in turn
> 
> s/managment/management/
> 
> > will update the host with the relevant change.
> > 
> > When qemu is executed on non-qmp framework (ex from command-line) we
> > need to update the host instead.
> > Fix it by adding support to update the RoCE device's Ethernet function
> > IP list from qemu via netlink.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >  configure              |  6 ++++
> >  hw/rdma/rdma_backend.c | 74 +++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 79 insertions(+), 1 deletion(-)
> > 
> 
> > @@ -1123,7 +1183,13 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
> >                                              gid->global.subnet_prefix,
> >                                              gid->global.interface_id);
> >  
> > -    return ret;
> > +    /*
> > +     * We ignore return value since operation might completed sucessfully
> 
> s/completed sucessfully/have completed successfully/
> 
> > +     * by the QMP consumer
> > +     */
> > +    netlink_route_update(ifname, gid, RTM_NEWADDR);
> > +
> > +    return 0;
> >  }
> >  
> >  int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
> > @@ -1149,6 +1215,12 @@ int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
> >                                              gid->global.subnet_prefix,
> >                                              gid->global.interface_id);
> >  
> > +    /*
> > +     * We ignore return value since operation might completed sucessfully
> 
> and again

Thanks for the spelling mistake corrections.
Will fix and respin.

> 
> > +     * by the QMP consumer
> > +     */
> > +    netlink_route_update(ifname, gid, RTM_DELADDR);
> > +
> >      return 0;
> >  }
> >  
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 




