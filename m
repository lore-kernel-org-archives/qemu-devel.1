Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A323C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D26206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC/TfB6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D26206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkAy-0008UQ-8C
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLjyA-00009b-0k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLjy8-000636-1I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:52:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLjy7-00062d-Ta
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586249547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvX0pbMvWT9S94zP/2fd20+4oJcstPFlc84dRjUAjqk=;
 b=PC/TfB6E1eeuCO3MOV2cjTQf6Wrq+OC8QUoYUr/hSbN88ySTTCMfgX/AuiZXz1tZOJwXOq
 77ualLLp0LaAb54Cx0VtAblbXqaJ9gyB+B31MPH8UuIvzGd6L9AJuSyn+VYD4XMhW48l21
 2X35E1HJDsKG7keSVxKliHrFniGihOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-x5bkuj3kNkiSGPvKHhFN_w-1; Tue, 07 Apr 2020 04:52:24 -0400
X-MC-Unique: x5bkuj3kNkiSGPvKHhFN_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E400518C35AB;
 Tue,  7 Apr 2020 08:52:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A4B15C1BB;
 Tue,  7 Apr 2020 08:52:18 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:52:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for
 coroutine interfaces
Message-ID: <20200407085216.GA7695@linux.fritz.box>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.04.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 06.04.2020 20:14, Kevin Wolf wrote:
> > External callers of blk_co_*() don't currently increase the
> > BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
> > is an inconsistency whether the counter has been increased or not.
> >=20
> > This patch moves the actual operations to static functions that can
> > later know they will always be called with in_flight increased exactly
> > once, even for external callers using the blk_co_*() coroutine
> > interfaces.
> >=20
> > If the public blk_co_*() interface is unused, remove it.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Still, did you consider instead just move inc/dec to _co_ functions, like
> [...]
> (and same for write, ioctl, flush, discard). It seems more
> consistent.. Should it work?

No, it would be wrong because it would be too late. The main purpose of
blk_inc_in_flight() is to keep the request covered during the first and
the last phase outside of blk_co_*(), which can potentially involve BHs
like blk_aio_complete_bh().

Kevin


