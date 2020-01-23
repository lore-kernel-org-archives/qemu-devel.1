Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897CD21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1sbgwbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897CD21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucQf-0003sX-8z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub8E-0001DR-70
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub8C-0004ad-QZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub8C-0004Zt-NG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YVwFHlvCrCQSIgmA/PDAW+q5oaorS0w+rbhohuhNnuU=;
 b=D1sbgwbc8jBk4nrk4jIy3xPY0Ek1NF6mLj5BmUsThTwcL+QShqVKemZ0XKCFbNrG9Aszn6
 XYWCfnoCLdoW3tHLtzqsUNVqJ3Z7q5fSdjcloRVQj5IJ8scYaWuFpZwmsEzaUH2Ux+sDFS
 u5t7XV2tdFEyD3pRtOE4EVb9fk2hYvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6c7SejFoOHu_70RkuKLtFw-1; Thu, 23 Jan 2020 06:58:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDD731005512
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:58:34 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC37819C69;
 Thu, 23 Jan 2020 11:58:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/21] Multifd Migration Compression
Date: Thu, 23 Jan 2020 12:58:10 +0100
Message-Id: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 6c7SejFoOHu_70RkuKLtFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[v3]
- rebased on top of upstream + previous multifd cancel series
- split multifd code into its own file (multifd.[ch])
- split zstd/zlib compression methods (multifd-zstd/zlib.c)
- use qemu module feauture to avoid ifdefs
  (my understanding is that zlib needs to be present, but
  we setup zstd only if it is not there or is disabled)
- multifd-method: none|zlib|zstd

  As far as I can see, there is no easy way to convince qapi that zstd
  option could/couldn't be there depending on compliation flags. I
  ended just checking in migrate_parameters_check() if it is enabled
  and giving an error message otherwise.

Questions:
- I am "reusing" the compress-level parameter for both zstd and zlib,
  but it poses a problem:
  * zlib values: 1-9 (default: 6?)
  * zstd values: 1-19 (default: 3)
So, what should I do:
  * create multifd-zstd-level and multifd-zlib-level (easier)
  * reuse compress-level, and change its maximum values depending on
    multifd-method
  * any other good option?

Please, review.

[v2] - rebase on top of previous arguments posted to the list -
introduces zlib compression - introduces zstd compression

Please help if you know anything about zstd/zlib compression.

This puts compression on top of multifd. Advantages about current
compression:

- We copy all pages in a single packet and then compress the whole
  thing.

- We reuse the compression stream for all the packets sent through the
  same channel.

- We can select nocomp/zlib/zstd levels of compression.

Please, review.

Juan Quintela (21):
  migration-test: Use g_free() instead of free()
  multifd: Make sure that we don't do any IO after an error
  qemu-file: Don't do IO after shutdown
  migration-test: Make sure that multifd and cancel works
  migration: Create migration_is_running()
  migration: Don't send data if we have stopped
  migration: Make multifd_save_setup() get an Error parameter
  migration: Make multifd_load_setup() get an Error parameter
  migration: Add multifd-compress parameter
  ram_addr: Split RAMBlock definition
  multifd: multifd_send_pages only needs the qemufile
  multifd: multifd_queue_page only needs the qemufile
  multifd: multifd_send_sync_main only needs the qemufile
  multifd: Use qemu_target_page_size()
  migration: Make checkpatch happy with comments
  migration: Add support for modules
  multifd: Split multifd code into its own file
  migration: Make no compression operations into its own structure
  migration: Add zlib compression multifd support
  configure: Enable test and libs for zstd
  migration: Add zstd compression multifd support

 MAINTAINERS                  |    1 +
 configure                    |   30 +
 hw/core/qdev-properties.c    |   13 +
 include/exec/ram_addr.h      |   40 +-
 include/exec/ramblock.h      |   64 ++
 include/hw/qdev-properties.h |    3 +
 include/qemu/module.h        |    2 +
 migration/Makefile.objs      |    3 +
 migration/migration.c        |   97 +++-
 migration/migration.h        |    4 +-
 migration/multifd-zlib.c     |  289 +++++++++
 migration/multifd-zstd.c     |  304 ++++++++++
 migration/multifd.c          | 1064 ++++++++++++++++++++++++++++++++++
 migration/multifd.h          |  185 ++++++
 migration/qemu-file.c        |   22 +-
 migration/ram.c              | 1006 +-------------------------------
 migration/ram.h              |    7 -
 migration/rdma.c             |    2 +-
 migration/savevm.c           |    4 +-
 monitor/hmp-cmds.c           |   13 +
 qapi/migration.json          |   30 +-
 tests/qtest/migration-test.c |  142 ++++-
 vl.c                         |    1 +
 23 files changed, 2266 insertions(+), 1060 deletions(-)
 create mode 100644 include/exec/ramblock.h
 create mode 100644 migration/multifd-zlib.c
 create mode 100644 migration/multifd-zstd.c
 create mode 100644 migration/multifd.c
 create mode 100644 migration/multifd.h

--=20
2.24.1


