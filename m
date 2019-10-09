Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD820C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B6820B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ip+mBnN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B6820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIjG-0004yW-0v
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1iIGEn-0001k1-4d
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1iIGEl-0004yz-Fd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:59:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1iIGEl-0004vy-6Y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:58:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99Hms5k079695;
 Wed, 9 Oct 2019 17:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=7oeUSXT1ulV4eisUhTd9JLY9LHBxMn7EyYuxy0FLgiw=;
 b=ip+mBnN8nyF30yGqeXNZXnStGaS1TGXpnmdPum0vKaBwmyg0Wi5aaRh1k/7MmN7dJJRY
 eehCVWY4i2lg3BJ8/hBqQAa8QokisGEuYYxVw6LuC5+5D2SmiOGhd8ztfeToOyQhjzTt
 Ox/q6l3567UCgaeouk9BTtm9M2gsO9gCtBpqoza2pjhQTpJsou1rD+yPk0HwOqClNWfL
 OGsR3x543VrJSK4wYfGa1jT8MSHTdDRa8os8oi4Wn4h4Em83aSf2aylKVIbuu46crvSJ
 3xDPYnFyBoPiZjCR5zWXBsuXHxp5zFaKChIFrBu4GyYA4PwWOUa76Ig5eqF2tJb74WhE fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2vektrp4gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2019 17:58:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99HmojT146053;
 Wed, 9 Oct 2019 17:58:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2vhhsn1qer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2019 17:58:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99HwiSc019452;
 Wed, 9 Oct 2019 17:58:44 GMT
Received: from heatpipe (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Oct 2019 10:58:44 -0700
Date: Wed, 9 Oct 2019 10:58:41 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
Message-ID: <20191009175831.GA5214@heatpipe>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
 <20190912153435.GM23174@stefanha-x1.localdomain>
 <20191009133724.GP5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009133724.GP5747@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 02:37:24PM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 12, 2019 at 05:34:35PM +0200, Stefan Hajnoczi wrote:
> > On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
> > > +    msg->num_fds = 0;
> > > +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
> > > +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
> > > +        if ((chdr->cmsg_level == SOL_SOCKET) &&
> > > +            (chdr->cmsg_type == SCM_RIGHTS)) {
> > > +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
> > > +            msg->num_fds = fdsize / sizeof(int);
> > > +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
> > 
> > Please validate num_fds before memcpy to prevent the buffer overflow.
> > 
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +    if (msg->size && msg->bytestream) {
> > > +        msg->data2 = calloc(1, msg->size);
> > > +        data = msg->data2;
> > > +    } else {
> > > +        data = (uint8_t *)&msg->data1;
> > > +    }
> > > +
> > > +    if (msg->size) {
> > > +        do {
> > > +            rc = read(sock, data, msg->size);
> > > +        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> > > +    }
> > 
> > Please validate size to prevent the buffer overflow.
> 
> I didn't see a reply so I want to highlight that the effort to introduce
> isolation between devices is pointless if the communications link is not
> coded securely.
> 
> Multi-process QEMU adds no security if one process can corrupt the
> memory of another process by sending invalid inputs.  Please audit the
> code.
>

Hi Stefan

Sorry for not replyingi earlier. We have reviewed all the comments we received
on the this patch series and working on the code improvements which are
mostly done.
We recognize the importance of the secure code and making efforts to
eliminate as much as possible these mentioned unverified inputs along with other changes.

The changes will be in the next version of the patchset we are actively
working on.

The other your suggestion about reducing the number of syscalls by
stuffing all of the parts of the message in the io_vec and using one
sendmsg/recvmsg cannot be done at this point with the way we have
organized the messages structure. But we are looking into the
adoption of shared ring buffer for communication channel instead of the
current mechanism to reduce the number of syscalls.
Though this change will not be a part of the next patchset as we are
tinkering with live migration.
But all other recommendations and comments will be taken into account.

Regards,
Elena & Jag & JJ.


> Stefan



