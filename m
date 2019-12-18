Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E8C21775
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwTcXWbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E8C21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOiI-0006ut-Ey
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOeg-0002yo-B5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOeZ-0005cZ-UK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOeV-0005YU-QE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S5XIySEQqK6tDORYN/Nag4QdqXcBHTEsKKu0ELMwjFI=;
 b=MwTcXWbqyKl7MCxy5/PSgFDTwTXIYqU2dSp7hNN1IJ0uJ7lB4dnO+Inuhdjur2jM2LAHEX
 T2C5pxRhxxPmkLFxMir1Tq7Maua5z9IiSKeod5bG8gCxseDR4rGGtPEymeKswBGRtXTH+U
 1SBh1fSQSdUebdq1A2F3BM6FIVrjnNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-jAqDZ6mEO1y3qhEEJVgSlw-1; Tue, 17 Dec 2019 21:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B03B6800D4E
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:22 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6B119C58;
 Wed, 18 Dec 2019 02:01:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] Multifd Migration Compression
Date: Wed, 18 Dec 2019 03:01:09 +0100
Message-Id: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jAqDZ6mEO1y3qhEEJVgSlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[v2]
- rebase on top of previous arguments posted to the list
- introduces zlib compression
- introduces zstd compression

Please help if you know anything about zstd/zlib compression.

This puts compression on top of multifd. Advantages about current
compression:

- We copy all pages in a single packet and then compress the whole
  thing.

- We reuse the compression stream for all the packets sent through the
  same channel.

- We can select nocomp/zlib/zstd levels of compression.

Please, review.

Juan Quintela (10):
  migration: Increase default number of multifd channels to 16
  migration-test: Add migration multifd test
  migration-test: introduce functions to handle string parameters
  migration: Make multifd_save_setup() get an Error parameter
  migration: Make multifd_load_setup() get an Error parameter
  migration: Add multifd-compress parameter
  migration: Make no compression operations into its own structure
  migration: Add zlib compression multifd support
  configure: Enable test and libs for zstd
  migration: Add zstd compression multifd support

 configure                    |  30 ++
 hw/core/qdev-properties.c    |  13 +
 include/hw/qdev-properties.h |   3 +
 migration/migration.c        |  36 +-
 migration/migration.h        |   3 +-
 migration/ram.c              | 750 ++++++++++++++++++++++++++++++++++-
 migration/ram.h              |   4 +-
 migration/rdma.c             |   2 +-
 monitor/hmp-cmds.c           |  13 +
 qapi/migration.json          |  30 +-
 tests/migration-test.c       | 112 ++++++
 11 files changed, 972 insertions(+), 24 deletions(-)

--=20
2.23.0


