Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C6FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25A1206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="apFm8V2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25A1206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwM2-0001ri-0E
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1igwKs-00010L-7L
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1igwKq-00047P-QJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:47:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1igwKq-00046r-G7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:47:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGJicES158827;
 Mon, 16 Dec 2019 19:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bYUnId4vFn6dnI7bi6hLFSC3OAvvMwsaaU2cALMa2LI=;
 b=apFm8V2XFxOOEnVj2+EbFFYfQVwxGrWivQaYTdX54QVG3Pep9BVW3MBH9vbK09VQTYVh
 +BTU4qVzFT9xqggNM+nxqsjYgOF49lc0kuC9ZBfqxZ9NHPtwXa3Y/ixQrl73MN7HoA7A
 Tr3f0IL1P/3rQwkRrsx4us54Vf738MXnVv7A6PY2WdKBGiSi5HrlTkLSo9D59cLXuMwB
 z/l0BP7l34AicQuSkSdz6gGJQ0QyOYTDV2KdRRNQq3Ql9bWBIcgq5F0iS9mG2I5KFc9l
 ReCFbcRIYisgUkbLVlxBfb6LFYipaqhS8+9HixSyxTwylUgp3RSmDw4JMjtr5BR31v5h dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2wvq5u9upq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2019 19:47:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGJiTfg037890;
 Mon, 16 Dec 2019 19:47:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2ww98symej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2019 19:47:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBGJl0Fe018817;
 Mon, 16 Dec 2019 19:47:00 GMT
Received: from flaka (/10.159.254.177) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 16 Dec 2019 11:46:59 -0800
Date: Mon, 16 Dec 2019 11:46:56 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191216194655.GA5922@flaka>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213104116.GB1180977@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160165
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 09, 2019 at 10:47:17PM -0800, Elena Ufimtseva wrote:
> > At this moment we are working on the first stage of the project with help of
> > the Nutanix developers.
> > The questions we have gathered so far will be addressed with muser
> > and Qemu developers after we finish the first stage and make sure we understand
> > what it will take for us to move onto the next stage.
> > 
> > We will also incorporate relevant review from Stefan that he provided
> > on the series 4 of the patchset. Thank you Stefan.
> > 
> > If anyone have any further suggestions or questions about the status,
> > please reply to this email.
> 
> Hi Elena,
> At KVM Forum we discussed spending 1 or 2 weeks trying out muser.  A few
> weeks have passed and from your email it sounds like this "next stage"
> might be a lot of work.
>

Hi Stefan

Perhaps we were not too clear about our work in the previous email.
Our assumption was that the question that came from KVM Forum was
if muser can be used to achieve the same what we have now.
We should have answered clearly yes to this question.  We have not yet
discovered major road blocks.
At the moment, we are mostly engaged in learning the code and discussing
the design, plus some coding to answer the specific questions.
We understand that the best way to make a progress is to work with the
upstream community on early stages and we agree with this and will present
the proposal shortly for discussion.
 
> Is there a work-in-progress muser patch series you can post to start the
> discussion early?  That way we can avoid reviewers like myself asking
> you to make changes after you have invested a lot of time.
>

Absolutely, that is our plan. At the moment we do not have the patches
ready for the review. We have setup internally a milestone and will be
sending that early version as a tarball after we have it completed.
Would be also a meeting something that could help us to stay on the same
page?
 
> It's good that you are in touch with the muser developers (via private
> discussion?  I haven't seen much activity on #muser IRC).
>

We use IRC (I know Jag got some answers there) and github for issues
(one of which was addressed). We are hoping to get the conversation going over
the email.

JJ, Jag and Elena 
> Stefan



