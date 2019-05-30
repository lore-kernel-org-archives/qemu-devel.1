Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434CC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 20:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C0E26190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gt95GFE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C0E26190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWS5W-0001oE-Li
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 16:55:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1hWS4h-0001QT-Qf
	for qemu-devel@nongnu.org; Thu, 30 May 2019 16:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1hWS4e-0004w8-2Y
	for qemu-devel@nongnu.org; Thu, 30 May 2019 16:54:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1hWS4Y-0004j0-MD
	for qemu-devel@nongnu.org; Thu, 30 May 2019 16:54:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4UKs0YE108236; Thu, 30 May 2019 20:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=qOkwN3FlXDgZE6NTH6YMUh0ecmFNaerJbSkKH4zJUxM=;
	b=gt95GFE3LIE5OtS+BAMq7WF0PJtJCAxJIDuouExIbSxkfPMm1wjlyy3lKIneVJgOaL2u
	BZKvGKC2eCYpiRuJZCjriaAe/oJvULS9KiCDYxhIvCIuOoS4A1rf55puEl5YiRD9Crgw
	PywPniXxYloVdylrei68HW3N6vcSPHltLRQnm5wMvuFo21e1QABI/IZJq2Q4O/w3aaKc
	lJw1dXnkBpE1IKkDhWoh3Zj2F5C2fI4mB5iPk+LT1241pZ04b6wqGRw7nOHtgUGLna8h
	IwHSGS/QOdFu+JXFc5eiiHfdoeGTykzJKSqyk7+BhR4mFyvaD0BVMUnvVigyKz+l+ZJQ
	2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2spw4ttp11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2019 20:54:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4UKrPut082466; Thu, 30 May 2019 20:54:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 2ss1fpa4ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2019 20:54:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UKsbv5011897;
	Thu, 30 May 2019 20:54:37 GMT
Received: from flaka.hsd1.ca.comcast.net (/73.170.27.202)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 30 May 2019 13:54:37 -0700
Date: Thu, 30 May 2019 13:54:35 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
References: <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
	<c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
	<20190425154421.GG17806@stefanha-x1.localdomain>
	<fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
	<20190523111130.GF26632@stefanha-x1.localdomain>
	<20190528151820.GA4545@heatpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528151820.GA4545@heatpipe>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905300148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905300148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
	Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com,
	Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, ross.lagerwall@citrix.com,
	liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kanth.ghatraju@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 08:18:20AM -0700, Elena Ufimtseva wrote:
> On Thu, May 23, 2019 at 12:11:30PM +0100, Stefan Hajnoczi wrote:
> > Hi Jag and Elena,
> > Do you think a call would help to move discussion along more quickly?
> >
> 
> Hi Stefan,
> 
> We would like to join this call.
> And thank you inviting us!
> 
> Elena
> > We could use the next KVM Community Call on June 4th to discuss
> > remaining concerns and the next steps:
> > https://calendar.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> >
> > I also hope to include other core QEMU developers.  As you know, I'm
> > skeptical, but it could be just me and I don't want to block you
> > unnecessarily if others are more enthusiastic about this approach.
> >

Hi Stefan

A few questions we have are about the call.
What is the format of the call usually? Should we provide some kind of the project outline for 5 minutes?
We are planning to address some of the concerns you have voiced in regards to amount of changes, usability,
security and performance. I assume there will be other questions as well. Is there any time limit per topic?

And would you mind sharing the call details with us?

Thanks!
Elena
> 
> 
> > Stefan
> 
> 

