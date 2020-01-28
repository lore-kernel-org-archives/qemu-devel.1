Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF8AC35240
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD962467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iReI7xQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD962467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMps-00076W-BI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwMor-0005ls-Oi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwMoq-0002p0-Kw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwMoq-0002oQ-HP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580202360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cSFEY4C4z7KrmhdLwXwnd9VcE5kqQ4h0tFCOYTN+zz8=;
 b=iReI7xQUEVY0WeYRxg4rgKiOAw6+YhnZ9ylQOcazKv/bp3udpm51baK0Ve/BRg2xsLThlb
 V4g6zyntTuH4Kxd4e6rYYOgYKZyI3jCoFVAkCK4c7t0utFP+qaHYuQnu4/A5spABUOTIwH
 1k8vzEralG3zXpUwaRKOI+NQZhCtis8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-K3g2mFjBNuyBAfuS4JM5Mg-1; Tue, 28 Jan 2020 04:05:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B758A0CC0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:05:54 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3321001B39;
 Tue, 28 Jan 2020 09:05:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] Multifd Migration Compression
Date: Tue, 28 Jan 2020 10:05:43 +0100
Message-Id: <20200128090550.5112-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: K3g2mFjBNuyBAfuS4JM5Mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20200127223321.2742-1-quintela@redhat.com

[v4]
- create new parameters: multifd-zlib-level & multifd-zstd-level
- use proper "conditionals" for qapi (thanks markus)
- more than half of the patches moved to the migration PULL request
  that this series are based on
- method type has moved to one int from a set of flags
- fixed all reviews comments

Please review.

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

Juan Quintela (7):
  migration: Add support for modules
  multifd: Make no compression operations into its own structure
  multifd: Add multifd-zlib-level parameter
  multifd: Add zlib compression multifd support
  configure: Enable test and libs for zstd
  multifd: Add multifd-zstd-level parameter
  multifd: Add zstd compression multifd support

 configure                    |  30 ++++
 hw/core/qdev-properties.c    |   2 +-
 include/qemu/module.h        |   2 +
 migration/Makefile.objs      |   2 +
 migration/migration.c        |  57 +++++++
 migration/migration.h        |   3 +
 migration/multifd-zlib.c     | 293 +++++++++++++++++++++++++++++++++
 migration/multifd-zstd.c     | 305 +++++++++++++++++++++++++++++++++++
 migration/multifd.c          | 191 +++++++++++++++++++++-
 migration/multifd.h          |  29 ++++
 migration/ram.c              |   2 +-
 monitor/hmp-cmds.c           |   8 +
 qapi/migration.json          |  58 ++++++-
 tests/qtest/migration-test.c |  16 ++
 vl.c                         |   1 +
 15 files changed, 985 insertions(+), 14 deletions(-)
 create mode 100644 migration/multifd-zlib.c
 create mode 100644 migration/multifd-zstd.c

--=20
2.24.1


