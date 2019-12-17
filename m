Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6873C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A66218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN5rNtFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A66218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEO3-0001lm-Kw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihEKM-0006L1-Uf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihEKK-00040F-9m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihEKK-0003rY-0p
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576594794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iWkeDPA9pq1Fch/p5WlEPtzFM+wyUpcOI9JsLCyEXrE=;
 b=aN5rNtFkTP1UdytQ4pkk1L/QIF5HFK9fThZv5Cnprh5tZO0tkgv2pso9rbRchG5Fc5sdll
 /gvlv6W3Vui8J47jtwvQjMXjHt7bF+UanCxXwjbh4l+8hey6xRcgNmWU8dXiOuJHtXNs7t
 5eiTYmu3tAPcFl+CLyBtfDnccZxai6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-_zkOjlk5OxaPClfjrA1ziA-1; Tue, 17 Dec 2019 09:59:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1097910054E3;
 Tue, 17 Dec 2019 14:59:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF21826574;
 Tue, 17 Dec 2019 14:59:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/3] block: Fix external snapshot with VM state
Date: Tue, 17 Dec 2019 15:59:36 +0100
Message-Id: <20191217145939.5537-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _zkOjlk5OxaPClfjrA1ziA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes bdrv_invalidate_cache_all() for some kinds of graphs where
part of the nodes are active and others are inactive. This is a scenario
that happens when libvirt takes an external snapshot with VM state.

This was reported in:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1781637
('qemu crashed when do mem and disk snapshot')

Based-on: <20191216170857.11880-1-kwolf@redhat.com>
('iotests: Remove duplicated blockdev_create()')

Kevin Wolf (3):
  block: Activate recursively even for already active nodes
  hmp: Allow using qdev ID for qemu-io command
  iotests: Test external snapshot with VM state

 block.c                    | 50 +++++++++++------------
 monitor/hmp-cmds.c         | 28 ++++++++-----
 hmp-commands.hx            |  8 ++--
 tests/qemu-iotests/280     | 83 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/280.out | 50 +++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 181 insertions(+), 39 deletions(-)
 create mode 100755 tests/qemu-iotests/280
 create mode 100644 tests/qemu-iotests/280.out

--=20
2.20.1


