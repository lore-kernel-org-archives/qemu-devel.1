Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1121FC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C7222CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKZhyvXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C7222CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4M8U-0007LM-TX
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 05:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4M7V-0006sP-Ea
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4M7T-0001Pu-PH
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:26:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i4M7T-0001P2-CK
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:25:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819O0eA094610;
 Sun, 1 Sep 2019 09:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YlK+dQN9SJlP51tdkZx++1Bw5GA2DUMmcOTzML2U3OI=;
 b=ZKZhyvXG69fr4izHrtcAD7J3bvZ23hlvR1NKZUJVLYi1anemE/Xsc0lcI/LKjZb1y22t
 y4QwGkxGDEY5yCn0ZGl6TxvYrzQ2XO/lzVDdKOIyHbw/xhU3hPOb5U/cmnfMxhWyP9L+
 eXyNf3V5kg05x9he65vljcMfirS+hD7HPlotKjbb6hTuEicYmJ+5YKdBUV0FWPY5NQyD
 sgFvj0rKeWhft8KGJ4VWKiUB+BZG4okdTooWhOMySaKqqQfenhN8n9JWze2lPPpxcxWC
 pJVf+hLR4diZ7Buk3XNBEDsw+6tEjahPaYd/4ozEH2tpNQz+nehNQag9KsTDPpXMfz/Y sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2urb8r80b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:25:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819NvOr035318;
 Sun, 1 Sep 2019 09:25:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2uqe1aw3ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:25:52 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x819PkEp006095;
 Sun, 1 Sep 2019 09:25:46 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 01 Sep 2019 02:25:46 -0700
Date: Sun, 1 Sep 2019 12:25:41 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190901092541.GA16041@lap1>
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
 <20190818132107.18181-2-yuval.shaia@oracle.com>
 <e9e23e9c-5fa3-0619-bb34-15a05df08c38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e23e9c-5fa3-0619-bb34-15a05df08c38@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 1/2] configure: Check if we can use
 ibv_reg_mr_iova
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
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 laurent@vivier.eu, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 10:28:18PM +0300, Marcel Apfelbaum wrote:
> 
> 
> On 8/18/19 4:21 PM, Yuval Shaia wrote:
> > The function reg_mr_iova is an enhanced version of ibv_reg_mr function
> > that can help to easly register and use guest's MRs.
> > 
> > Add check in 'configure' phase to detect if we have libibverbs with this
> > support.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   configure | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 714e7fb6a1..e8e4a57b6f 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3205,6 +3205,34 @@ else
> >       pvrdma="no"
> >   fi
> > +# Let's see if enhanced reg_mr is supported
> > +if test "$pvrdma" = "yes" ; then
> > +
> > +cat > $TMPC <<EOF &&
> > +#include <infiniband/verbs.h>
> > +
> > +int
> > +main(void)
> > +{
> > +    struct ibv_mr *mr;
> > +    struct ibv_pd *pd = NULL;
> > +    size_t length = 10;
> > +    uint64_t iova = 0;
> > +    int access = 0;
> > +    void *addr = NULL;
> > +
> > +    mr = ibv_reg_mr_iova(pd, addr, length, iova, access);
> 
> Here you check if the API is changed, right?

Yes.

> Can you query for a library version instead?

Library version is set in the spec file which is under the distros'es
responsibility. I don't see a reason to be depend on that especially when
the check for support is so easy. In addition, this way allows one to
download latest upstream code and compile against it even when his distro
still didn't update the repo.

> 
> Thanks,
> Marcel
> 
> > +
> > +    ibv_dereg_mr(mr);
> > +
> > +    return 0;
> > +}
> > +EOF
> > +    if ! compile_prog "" "-libverbs"; then
> > +        QEMU_CFLAGS="$QEMU_CFLAGS -DLEGACY_RDMA_REG_MR"
> > +    fi
> > +fi
> > +
> >   ##########################################
> >   # VNC SASL detection
> >   if test "$vnc" = "yes" && test "$vnc_sasl" != "no" ; then
> 
> 

