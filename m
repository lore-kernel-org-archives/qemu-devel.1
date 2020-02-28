Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D23C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66EC2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c1NiM8dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66EC2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jqI-0002c8-UI
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7jpj-0002Cq-HB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j7jpi-00087G-Cm
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:53:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j7jpi-00083v-3J
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:53:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SHO4UF167996;
 Fri, 28 Feb 2020 17:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tc663kbJ88+rhqXAiujF8iZvGJl7YWqIEPUTUMQHW8o=;
 b=c1NiM8dAMm7dFdmGAiQZ4ITX4Vni39i1QwbeVqEd5Y7da39sP4evPnCnGEuS5hA2JWLG
 6f/ZBjoMUm/f6TpPOEzYRNXS0q6nVuQWmU9BeuluQvGaXz5Ge/OeWKorx+4MR2+0XvCQ
 d5F4wBxDhrR1pX99b6H3UAJLWC+gda1VpOtIIM8IIQqxEmdSkHlxiVgPeznr3YByOCoU
 KC1Ynn+sBlG6y2+qgznVghFh6q7zoLaMFdZodJ7FRp2ioHrejCjjRay1xc+1bChzu8Eh
 d0YxQSeF5BlhYp/9JjZsg0WOVS3jvujfkmuWCoDLCQ+dqGeKxIi3Mm8O3lSAffq2Z7Me Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yf0dmaqqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 17:53:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SHqFsJ196328;
 Fri, 28 Feb 2020 17:53:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ydj4rbywv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 17:53:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SHrUr3004625;
 Fri, 28 Feb 2020 17:53:30 GMT
Received: from flaka (/108.236.14.91) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Feb 2020 09:53:30 -0800
Date: Fri, 28 Feb 2020 09:53:28 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 48/50] multi-process: Validate incoming commands from
 Proxy
Message-ID: <20200228175328.GA25838@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <00737a41c9bc4993ad47e5d4387ac14f1892be40.1582576372.git.jag.raman@oracle.com>
 <20200227171830.GG315098@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227171830.GG315098@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280134
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 05:18:30PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 03:55:39PM -0500, Jagannathan Raman wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > 
> > Validate the incoming commands to confirm that they would not cause any
> > errors in the remote process.
> > 
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > ---
> >  hw/proxy/qemu-proxy.c    |  6 +++-
> >  include/io/mpqemu-link.h |  2 ++
> >  io/mpqemu-link.c         | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  remote/remote-main.c     |  4 +++
> >  4 files changed, 85 insertions(+), 2 deletions(-)
> 
> Please squash this into the patch(es) that introduced the code.
> 
> Reviewers want to see a logical sequence of patches.  Introducing
> unsafe code in an earlier patch and adding checks in a later patch makes
> it impossible to review the patches in sequence (reviewers would waste
> time pointing out bugs that end up getting fixed later).
>

Thanks Stefan, will merge that with appropriate patches.
 
> > diff --git a/remote/remote-main.c b/remote/remote-main.c
> > index 20d160e..c4aa3e0 100644
> > --- a/remote/remote-main.c
> > +++ b/remote/remote-main.c
> > @@ -435,6 +435,10 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
> >      if (msg->id > MAX_REMOTE_DEVICES) {
> >          error_setg(&err, "id of the device is larger than max number of "\
> >                           "devices per remote process.");
> > +    }
> 
> Was goto finalize_loop accidentally dropped?
Yes, thank you.

Elena



