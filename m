Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B416A24655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYXF11pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B416A24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuF3s-0000Rp-P9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuF35-00086a-QA
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuF34-0006rf-6p
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:23:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuF34-0006qm-1N
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579695832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8gcYQXyIwskRNCsQ61hKn8N3sdHS3jhvH2mpZHBb1Y=;
 b=ZYXF11pdjFZNiQYno5HEAcUSdH+uEYJUYGT0w3qmU+pMQtENgTDxcghUo1t+PlRoekRaHT
 /t7Jr79eW9lvrM78OKWbkj9mUBzYq6GhmeeTvAUsTUax3me6Ekr8nRwXTdbvEgq63vZ+Zb
 qcKHKHiuzKJACYeSTHc2FyiQDzGgEIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348--Jm0omTQPiCHe0XYJvi0uA-1; Wed, 22 Jan 2020 07:23:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C281A100550E;
 Wed, 22 Jan 2020 12:23:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-57.ams2.redhat.com [10.36.117.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A020B10018FF;
 Wed, 22 Jan 2020 12:23:35 +0000 (UTC)
Date: Wed, 22 Jan 2020 13:23:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v3 0/2] ide: Fix incorrect handling of some PRDTs and add
 the corresponding unit-test
Message-ID: <20200122122334.GA13482@linux.fritz.box>
References: <20191223175117.508990-1-alex.popov@linux.com>
 <f3bd803f-aa03-e6bd-2b6a-ef6172a38f4e@linux.com>
MIME-Version: 1.0
In-Reply-To: <f3bd803f-aa03-e6bd-2b6a-ef6172a38f4e@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -Jm0omTQPiCHe0XYJvi0uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.01.2020 um 12:53 hat Alexander Popov geschrieben:
> On 23.12.2019 20:51, Alexander Popov wrote:
> > Fuzzing the Linux kernel with syzkaller allowed to find how to crash qe=
mu
> > using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
> > ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
> >=20
> > This patch series fixes incorrect handling of some PRDTs in ide_dma_cb(=
)
> > and improves the ide-test to cover more PRDT cases (including one
> > that causes that particular qemu crash).
> >=20
> > Changes from v2 (thanks to Kevin Wolf for the feedback):
> >  - the assertion about prepare_buf() return value is improved;
> >  - the patch order is reversed to keep the tree bisectable;
> >  - the unit-test performance is improved -- now it runs 8 seconds
> >    instead of 3 minutes on my laptop.
> >=20
> > Alexander Popov (2):
> >   ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
> >   tests/ide-test: Create a single unit-test covering more PRDT cases
> >=20
> >  hw/ide/core.c    |  30 +++++---
> >  tests/ide-test.c | 174 ++++++++++++++++++++---------------------------
> >  2 files changed, 96 insertions(+), 108 deletions(-)
>=20
> Hello!
>=20
> Pinging again about this fix and unit-test...
>=20
> It's ready. Kevin Wolf has reviewed this (thanks a lot!).
>=20
> What is next?

I asked John about it just yesterday (if he will merge it or if he would
prefer me to take it through my tree) and he promised to take a look
very soon.

Kevin


