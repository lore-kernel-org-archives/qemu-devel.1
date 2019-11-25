Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC83520679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PThwCAxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC83520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGjJ-0000i5-Uk
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZGZf-0006rv-VG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZGZe-00015e-NS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:46:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZGZe-00015J-Go
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9pVk1/3JCsWFufkOwOTgRsvb19M8x3vCsqlUtynMLw=;
 b=PThwCAxgtXOdvdPYnlJvpODlJUAubR68kpNYFb/R9pNF31D+ZOaFQ6A8mKs8thWMJuBF8Q
 J20m1n1PlFHLTS3ted4kdRRHOl9ilRAnsawrsIQlJX4lnNH8d5XFgMkSyGZzotqrx/MIhA
 mATFRsfTRlo4WdQJW/NFNa+tG5k83LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-vMkPdEXENyWtp4RgeqriQw-1; Mon, 25 Nov 2019 10:46:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55367107B28C;
 Mon, 25 Nov 2019 15:46:44 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 903321001281;
 Mon, 25 Nov 2019 15:46:38 +0000 (UTC)
Date: Mon, 25 Nov 2019 16:46:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191125154637.GC4638@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <4f6f9488-8ec1-85bf-5584-bac5b0f8ce92@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <4f6f9488-8ec1-85bf-5584-bac5b0f8ce92@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vMkPdEXENyWtp4RgeqriQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "fam@euphon.net" <fam@euphon.net>, Alberto Garcia <berto@igalia.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.11.2019 um 11:08 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Ping?
>=20
> Hi! Why so silent? Postpone this to 5.0? This is fixing the same
> problem with block commit, like Kevin's series, just commit not to mid
> but to base..

To be honest, I think by now we've found so many problems around short
backing files, each with a non-trivial fix, that I don't think we can
have a reasonably complete fix in -rc3 without risking breaking
everything. None of the problems are new, in fact I think they have
existed since day one of resize/commit, and nobody has reported problems
before, so they can't be hitting a large number of users.

So, reluctantly, I have to admit that both series and whatever we'll add
on top are probably better kept for 5.0 (and 4.2.1) rather than added
very late into 4.2.

Kevin


