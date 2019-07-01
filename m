Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03B120B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xZz3/v+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03B120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvAV-0007AW-V6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hhv97-0006Ks-Ih
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hhv95-0007Q1-Nc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:10:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hhv93-0007GS-Nb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:10:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61C8jS2045395;
 Mon, 1 Jul 2019 12:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=P9FmLEo08+g18Ii9dpqQHhtU0pAcysT+2GOUk4GVPMo=;
 b=xZz3/v+fFUg+cbDu5CE8fnlh4nwPIyGRLWuyNmLMNtqsq/yEzA8s2LJPVBTibp2hRj7s
 ySMCFDX5Ua+hEZzOGWuRcHHNe2OemG3igcrQafB+l/cxMoxCwuJvfTivZGGQw+42fdn3
 IuGdSh1eT8684+1KvNZv6qVpS495BaRcaDpkM8UoR0QKHwZZN8E9NO6AsszGPiZxeo5A
 rDrKT7J8cA3O6hbQm93vsVRaEupqWQAldHHq5tCUQPLi/gtQhdwYJrhWPdvQa/r+L9Wa
 zC6aEeHaxNcEboMWnf+bOxiR2Q89kLwRZ2o+MM8t7Tp/3rwVMaagUrrEVSRArdO0KBYz EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2te5tbdapt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Jul 2019 12:10:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61C8Co3099022;
 Mon, 1 Jul 2019 12:08:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2tebbj4xue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Jul 2019 12:08:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61C8gQJ027665;
 Mon, 1 Jul 2019 12:08:42 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 01 Jul 2019 05:08:42 -0700
Date: Mon, 1 Jul 2019 15:08:36 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190701120835.GA8626@lap1>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <20190621144541.13770-2-skrtbhtngr@gmail.com>
 <20190625153253.GA10458@lap1> <20190628112634.GB2987@work-vm>
 <CAMzgYoOb7VbFk3U6zP9OvDPtcbT3K4CHjBVuaKUzQWfe_yFCYQ@mail.gmail.com>
 <20190630081349.GA2817@lap1>
 <CAMzgYoML=BR4GnLYs_+cRzn__Rqytu5pnbDn-YhqByPn_X7v-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzgYoML=BR4GnLYs_+cRzn__Rqytu5pnbDn-YhqByPn_X7v-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9304
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010152
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC 1/1] hw/pvrdma: Add live migration support
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > >
> > > @Marcel, @Yuval: As David has suggested, what if we just read the dma
> > > addresses in pvrdma_load(), and let the load_dsr() do the mapping?
> > > In pvrdma_regs_write(), we can check if dev->dsr_info.dma is already set, so
> > > that its value is not overwritten.
> >
> > Have you tried that? Did it works?
> 
> I haven't tried it, but in the dest, the guest will not call pvrdma_regs_write()
> for DSR again as it calls it only when the guest driver probes pci.
> load_dsr() will not be called then.
> So, I guess my assumption was wrong.

To clarify. The guest is not "calling" pvrdma_regs_write() directly, it
writes into a register and this triggers the function.

So my thinking was that you meant to hook into *any* such register-write
and call "load_dsr" indirectly, i.e. to simulate a guest writing into DSR
register.

This might work and it is nice idea, just wondering whether you actually
give that a try.

> 
> > So it is like a lazy load and the first command will be bit slower, we can
> > live with that i guess.

That is way i called it "lazy load".

> >

