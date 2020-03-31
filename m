Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7018AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D2A20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRL+Z8xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D2A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJ0I-0001yi-8O
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJIxL-00054V-0Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJIxJ-0007OK-O5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:37:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJIxJ-0007Ng-JO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585669052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTYRCJVj/cqn4QPaKA2vuSDnx4JMhRo9cEm7s3wuzvI=;
 b=IRL+Z8xSKASXKokB/tw469Ra/MoDeoIKSPQ7OIgSz5w7XQIcttqeqJrFnQmyln2pJeMKkm
 Q82rSZzRnmyii47CjirkJn+iE/M5UYO96ScqynHjphfvHgc4ms6v4QwMtEJTQFkQmsZZCz
 ZpumzYMsWpvhc3Z3HKLVKHBB6fYUVKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Qf5hHYCUN9ili97u4yeUzg-1; Tue, 31 Mar 2020 11:37:29 -0400
X-MC-Unique: Qf5hHYCUN9ili97u4yeUzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E48B1005055;
 Tue, 31 Mar 2020 15:37:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95490100EBD4;
 Tue, 31 Mar 2020 15:37:21 +0000 (UTC)
Date: Tue, 31 Mar 2020 17:37:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200331153719.GI7030@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <713436887.61.1585668262838@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Am 31.03.2020 um 17:24 hat Dietmar Maurer geschrieben:
>=20
> > > How can I see/debug those waiting request?
> >=20
> > Examine bs->tracked_requests list.
> >=20
> > BdrvTrackedRequest has "Coroutine *co" field. It's a pointer of corouti=
ne of this request. You may use qemu-gdb script to print request's coroutin=
e back-trace:
>=20
> I would, but there are no tracked request at all.
>=20
> print bs->tracked_requests
> $2 =3D {lh_first =3D 0x0}

Then it's one of the recursively checked parents, as you already figured
out.

> Looks bdrv_parent_drained_poll_single() calls
> blk_root_drained_poll(), which return true in my case (in_flight > 5).

Can you identify which BlockBackend is this? Specifically if it's the
one attached to a guest device or whether it belongs to the block job.

Maybe have a look at the job coroutine, too. You can probably easiest
find it in the 'jobs' list, and then print the coroutine backtrace for
job->co.

> Looks like I am loosing poll events somewhere?

I don't think we've lost any event if in_flight > 0. It means that
something is still supposedly active. Maybe the job deadlocked.

Kevin


