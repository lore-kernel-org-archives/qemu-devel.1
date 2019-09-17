Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AE221852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxRvLs9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AE221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAEuK-0005Jt-W2
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1iAEtA-0004J7-K1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1iAEt8-0003kg-DV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1iAEt8-0003jl-4A
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:55:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HEpQhL119481;
 Tue, 17 Sep 2019 14:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YHqVDSsx9EQCSrY3Q2E8hLs4+10jCjMw0ynITO3SXCQ=;
 b=dxRvLs9jYtbdhuCCOR3k0KBwY25mVw8SHZ1XCKLtfzO9jfwivTLKzh0pmpCjKE7cmKdI
 ecCnikqFijQP1YW6YRb8oKUcoYfFYEVw3oIvWiHydViZXG2iKlhKJNJwtkkZriUivrla
 e5RjYLPf7PJA5TRcxAt3Yn0/K3wthOmtqOUO6jvab+GLqDsj0n/6sG5hp4tAZnndQ7vt
 Cu8CurGuMndAk6ibOvNBxU7KVvFgWcL6Idx+foGNVYBRXiiGOLCfLlatbiB59ATOWDoy
 LpT3YLBxVliytiIK8Xr6EF9k4M4QEyAwspmJ36hFK18ic/xm5m9T+dbZReAcjVBD/j3K gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2v0ruqq0ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 14:54:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HEoedb102433;
 Tue, 17 Sep 2019 14:52:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2v2nmv8fwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 14:52:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8HEq6gl029194;
 Tue, 17 Sep 2019 14:52:06 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 17 Sep 2019 07:52:05 -0700
Date: Tue, 17 Sep 2019 17:51:57 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190917145157.GA16309@lap1>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871568761.196432.13197720535866413065.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156871568761.196432.13197720535866413065.stgit@bahia.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170145
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 09/17] hw/rdma: Fix missing conversion to
 rdma_error_report()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 12:21:27PM +0200, Greg Kurz wrote:
> Commit 4d71b38ae8fa converted many error_setg() call sites to
> rdma_error_report(), but it forgot to convert a companion
> error_append_hint(). Since no guy doesn't set errp anymore in
> pvrdma_realize(), errp remains NULL and error_append_hint() does
> nothing.
> 
> Also error_append_hint() was a poor choice since its "intended use
> is adding helpful hints on the human user interface" and "not for
> clarifying a confusing error message".
> 
> Call rdma_error_report() instead.

Thanks,
So are you suggesting to replace all other error_setg calls with
rdma_error_report instead?

> 
> Fixes: 4d71b38ae8fa "hw/rdma: Switch to generic error reporting way"
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/rdma/vmw/pvrdma_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 3e36e130139c..d370ae07ca6a 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -667,7 +667,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  out:
>      if (rc) {
>          pvrdma_fini(pdev);
> -        error_append_hint(errp, "Device failed to load\n");
> +        rdma_error_report("Device failed to load");

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

>      }
>  }
>  
> 
> 

