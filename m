Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7E6215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7JAzhlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7E6215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6ll-0004XZ-VW
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hb6e7-0006c1-Hz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hb6e3-0006nd-57
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:02:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hb6dr-0005qL-VB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:02:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CGmtDQ194153;
 Wed, 12 Jun 2019 17:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lKE1hfZgnt2Ll31k5y4lDARwK7kgVKvTEtjrO1X159s=;
 b=l7JAzhlMJI1dm6MWfEozFAUXPNWjyZSWRg+BRlGn99K7XE0Qylj2Mp41VuImzDB1b7Ka
 7UKsEuD5Y54F6pl3i4d2QNR3Q4QPN48TF9iNmfgp1Pne38idZ3MaChAht64pYFLpeBhI
 VgPlkHXqdPE8hXNnvsjTQtn5/8p1caboeil5ULyw/erfGcbRSzY6UbgL1y2/R+SJCcHm
 GRTGjD1SpV7Vu8q9HA5ragQ07iLOyFr9II7FAzyMBfW26DR9F8druakxuanH0FseHskW
 0Jsh9UgFCINDCzN1JUEY/hYCbhNI6qUeBuL79+GoFH+cBTP4Ed9PAxKfUwpZBSA4nZNM uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t05nqvsxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 17:01:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CH0qvP059877;
 Wed, 12 Jun 2019 17:01:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t1jpj4jt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 17:01:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CH1GoB005128;
 Wed, 12 Jun 2019 17:01:16 GMT
Received: from heatpipe (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 10:01:16 -0700
Date: Wed, 12 Jun 2019 10:01:12 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190612170112.GA16843@heatpipe>
References: <20190326080822.GC21018@stefanha-x1.localdomain>
 <e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
 <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
 <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
 <20190425154421.GG17806@stefanha-x1.localdomain>
 <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
 <20190523111130.GF26632@stefanha-x1.localdomain>
 <20190528151820.GA4545@heatpipe>
 <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
 <20190612162413.GB1620@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612162413.GB1620@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
 Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kanth.ghatraju@oracle.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 05:24:13PM +0100, Stefan Hajnoczi wrote:
> On Thu, May 30, 2019 at 01:54:35PM -0700, Elena Ufimtseva wrote:
> > On Tue, May 28, 2019 at 08:18:20AM -0700, Elena Ufimtseva wrote:
> > > On Thu, May 23, 2019 at 12:11:30PM +0100, Stefan Hajnoczi wrote:
> > > > Hi Jag and Elena,
> > > > Do you think a call would help to move discussion along more quickly?
> > > >
> > > 
> > > Hi Stefan,
> > > 
> > > We would like to join this call.
> > > And thank you inviting us!
> > > 
> > > Elena
> > > > We could use the next KVM Community Call on June 4th to discuss
> > > > remaining concerns and the next steps:
> > > > https://calendar.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> > > >
> > > > I also hope to include other core QEMU developers.  As you know, I'm
> > > > skeptical, but it could be just me and I don't want to block you
> > > > unnecessarily if others are more enthusiastic about this approach.
> > > >
> > 
> > Hi Stefan
> > 
> > A few questions we have are about the call.
> > What is the format of the call usually? Should we provide some kind of the project outline for 5 minutes?
> > We are planning to address some of the concerns you have voiced in regards to amount of changes, usability,
> > security and performance. I assume there will be other questions as well. Is there any time limit per topic?
> > 
> > And would you mind sharing the call details with us?
> 
> Hi Elena and Jag,

Hi Stefan,

> Sorry, I was away on sick leave. 

Ah, sorry about that - we have guessed that you were away, but thought
people were mostly on vacation.

> The KVM Community Call is informal.
> The goal is to get people together in a teleconference where we can
> discuss topics much more quickly than on the mailing list.  This can
> help make progress in areas where the mailing list discussion seems to
> be making slow progress.
> 
> I would suggest starting with a status update the describes your
> current approach (without assuming the audience has familiarity).  Then
> you could touch on any issues where you'd like input from the community
> and you could take questions.
> 
> Our goal should be to get a consensus on whether disaggregated QEMU can
> be merged or not.
>

Thanks!
> Here are the calendar details (Tuesday, June 18th at 8:00 UTC):
> https://calendar.google.com/calendar/ical/tob1tjqp37v8evp74h0q8kpjqs%40group.calendar.google.com/public/basic.ics
> 
> Is this time okay for you?

Yes, this time is fine.
Do you have dial-in info for us?

Thank you!

Elena, Jag and JJ
> 
> Stefan



