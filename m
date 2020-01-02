Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEEBC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 16:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F06F217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFeqXZwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2wJ-0000Tw-K0
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 11:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1in2vA-00080v-M5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 11:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1in2v9-0005Er-2J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 11:02:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1in2v8-0005E5-Oc
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 11:01:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002Fsd7S191640;
 Thu, 2 Jan 2020 16:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=jm1IyxFjLz23l0JulfRLNuNY85eqw+O2zSkv77giojM=;
 b=JFeqXZwqUXCjuD2NHPc/ijeQYY/XI2Bnk17xpDGTb8P7QWAzaFyY8VgTBYA7rOD9R3Ha
 oLx+VZH1u1JX5lVk/lk1eDzaCsN57+axdrtAlNxLfWLEpwpRVJUn3SiZvuDhoSXGdS+1
 YSL0pg4i4YZovPGBJ+EPLDv0grYqfOqJp/Bue1qRiKvnUN+CmgYx4T9C2BwGK04Pn/ke
 Y5wvlk5ztf4f0L1XQUKzOBjhx3+QHf9rtm3HeHOTulubl+885jG2MTTFEVwpV3n3AuIr
 Nxh5fSmkrRC+O/E5NLGDhcQ+PmI4Uj5ZEc6QINu25gpI/931bqm9hrK2fNuXMEC0q8vf hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2x5y0pr1ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2020 16:01:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002FsmTG084229;
 Thu, 2 Jan 2020 16:01:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2x8gurqf3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2020 16:01:43 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 002G1eZL021919;
 Thu, 2 Jan 2020 16:01:40 GMT
Received: from heatpipe (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 02 Jan 2020 08:01:39 -0800
Date: Thu, 2 Jan 2020 08:01:36 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200102160136.GA20919@heatpipe>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217163316.GB1333385@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020140
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 002Fsd7S191640
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 17, 2019 at 04:33:16PM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> > > On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.c=
om> wrote:
> > > =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi =
wrote:
> > >> Is there a work-in-progress muser patch series you can post to sta=
rt the
> > >> discussion early?  That way we can avoid reviewers like myself ask=
ing
> > >> you to make changes after you have invested a lot of time.
> > >>=20
> > >=20
> > > Absolutely, that is our plan. At the moment we do not have the patc=
hes
> > > ready for the review. We have setup internally a milestone and will=
 be
> > > sending that early version as a tarball after we have it completed.
> > > Would be also a meeting something that could help us to stay on the=
 same
> > > page?
> >=20
> > Please loop us in if you so set up a meeting.
>

Hi Stefan

And happy New Year to everyone!

> There is a bi-weekly KVM Community Call that we can use for phone
> discussions:
>=20
>   https://calendar.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZw=
NzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
>

Our team would like to join the call on Jan 14 and maybe talk over few th=
ings.
Felipe, will you and your team be joining as well?

> Or we can schedule a one-off call at any time :).
>

Awesome! Thank you, we will use for sure this opportunity.

Elena

> Questions I've seen when discussing muser with people have been:
>=20
> 1. Can unprivileged containers create muser devices?  If not, this is a
>    blocker for use cases that want to avoid root privileges entirely.
>=20
> 2. Does muser need to be in the kernel (e.g. slower to develop/ship,
>    security reasons)?  A similar library could be implemented in
>    userspace along the lines of the vhost-user protocol.  Although VMMs
>    would then need to use a new libmuser-client library instead of
>    reusing their VFIO code to access the device.
>=20
> 3. Should this feature be Linux-only?  vhost-user can be implemented on
>    non-Linux OSes...
>=20
> Stefan



