Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B9C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE82A2087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qFyd5xys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE82A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzKK4-000426-QI
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 08:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzKJ4-0003bD-AT
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzKJ2-0002eh-SC
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:29:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hzKJ2-0002d2-Jl
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:29:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ICQfEF028422;
 Sun, 18 Aug 2019 12:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=P1ezYfSAZQ3MScrblYqF7Ne0pHoimEv5foakFs7eMYE=;
 b=qFyd5xysKUCKcLHDeZ7bi0moxmR+icI97cqwS9KOltjsjbX4xubPFit5EXd6OgkVdOOu
 t5r5un/2/jrlMNirshhqEeT/ntiHVImFhOZTsoVBy4bVqizluUs0rVPuPxFByFzbmg9s
 DD1avQLzdIWO4IXKwFIunuEQGGbdAsqtocYGGxyrCHhoZST4OuJgvbJlRitGzZkYmzqe
 iQFbJi9AfWecGuJTA/QbPIUHmpGtAatsq1cZUwQwrtv5j9Lk/rOLfEhLA8GH9EHqtBXA
 fUbiW607xm6+gaaKafNqGDiyPme+IfaiK8/QijOE6QaPxp8cXUT9o1KtzRHpcCm1NVTq 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ue9hp3fa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 12:29:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ICRsHM084613;
 Sun, 18 Aug 2019 12:29:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ue7mwqju7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 12:29:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7ICT2ck019721;
 Sun, 18 Aug 2019 12:29:02 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 18 Aug 2019 05:29:02 -0700
Date: Sun, 18 Aug 2019 15:28:58 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Stephen Kitt <steve@sk2.org>
Message-ID: <20190818122858.GA1926@lap1>
References: <20190811194247.9861-1-steve@sk2.org> <20190815105704.GA3018@lap1>
 <20190815141244.25a93a3a@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815141244.25a93a3a@heffalump.sk2.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908180138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908180137
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x7ICQfEF028422
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH] Fix hw/rdma/vmw/pvrdma_cmd.c build
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

On Thu, Aug 15, 2019 at 02:12:44PM +0200, Stephen Kitt wrote:
> On Thu, 15 Aug 2019 13:57:05 +0300, Yuval Shaia <yuval.shaia@oracle.com=
>
> wrote:
>=20
> > On Sun, Aug 11, 2019 at 09:42:47PM +0200, Stephen Kitt wrote:
> > > This was broken by the cherry-pick in 41dd30f. Fix by handling erro=
rs
> > > as in the rest of the function: "goto out" instead of "return rc".
> > >=20
> > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > > ---
> > >  hw/rdma/vmw/pvrdma_cmd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> > > index bb9a9f1cd1..a3a86d7c8e 100644
> > > --- a/hw/rdma/vmw/pvrdma_cmd.c
> > > +++ b/hw/rdma/vmw/pvrdma_cmd.c
> > > @@ -514,7 +514,7 @@ static int create_qp(PVRDMADev *dev, union
> > > pvrdma_cmd_req *req, cmd->recv_cq_handle, rings, &resp->qpn);
> > >      if (resp->hdr.err) {
> > >          destroy_qp_rings(rings);
> > > -        return rc;
> > > +        goto out; =20
> >=20
> > This label was removed, can you please check master branch?
>=20
> Sorry, it wasn=E2=80=99t clear from my message =E2=80=94 my patch is ag=
ainst the stable-3.1
> branch.

I see, in that case fix make sense.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>=20
> Regards,
>=20
> Stephen



