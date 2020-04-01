Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA066C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06F0206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hz+Ak/FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06F0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJiMs-0001lH-US
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJiM2-0001AR-Mi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJiM1-0005Ra-B9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:44:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36894
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJiM1-0005Qy-7r
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585766684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btjZ0OXf1e8hvKS6cRYKWBRWdxyI6vTC/ydt44F5EGw=;
 b=Hz+Ak/FGgLYUqIFeiwxfCLMiYlgf8XCwMGeVtIVOjP+9Xz6vThZOzMcloZvhTMZ+kAxbP0
 oxNWNlUYuFzje3xJtyMkPeV2fEl38S5whiQWiYmIRdlyMnwBc4/VBlDo2HqUUSRJmmKDqe
 k9QUqrhVMd2SHqlFFNFfwrQLYRg2hNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Y4S21g6hPLKK8sYPFgv29w-1; Wed, 01 Apr 2020 14:44:40 -0400
X-MC-Unique: Y4S21g6hPLKK8sYPFgv29w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F80918FF661;
 Wed,  1 Apr 2020 18:44:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A74F95D9CD;
 Wed,  1 Apr 2020 18:44:32 +0000 (UTC)
Date: Wed, 1 Apr 2020 20:44:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200401184431.GD27663@linux.fritz.box>
References: <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1403939459.52.1585765681569@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.04.2020 um 20:28 hat Dietmar Maurer geschrieben:
> > That's a pretty big change, and I'm not sure how it's related to
> > completed requests hanging in the thread pool instead of reentering the
> > file-posix coroutine. But I also tested it enough that I'm confident
> > it's really the first bad commit.
> >=20
> > Maybe you want to try if your problem starts at the same commit?
>=20
> Stefan already found that by bisecting last week:
>=20
> See: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07629.html
>=20
> But, IMHO the commit is not the reason for (my) bug - It just makes
> it easier to trigger... I can see (my) bug sometimes with 4.1.1, although
> I have no easy way to reproduce it reliable.
>=20
> Also, Stefan sent some patches to the list to fix some of the problems.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00022.html
>=20
> Does that fix your problem?

It seems to fix it, yes. Now I don't get any hangs any more. (Also, I
guess this means that this day was essentially wasted because I worked
on a problem that already has a fix... *sigh*)

Kevin


