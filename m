Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA9C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145112168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU+eOEBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145112168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Lsy-0006iQ-63
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2LrQ-0005Hl-CX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2LrN-000457-3H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2LrM-00040M-Tk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ER9LCM5Fe6yt9oaVuU9sa6y89d/MD2p/fL21A7ALFYY=;
 b=PU+eOEBbJf/xNJpEk2+Vy9j5pG6Ryu+1KGXAui2S1SJyyNy2qBJmI/iMSG50hAEnkEv1BH
 yHKFC5G/7NWt0M1hBaCZFan7p4FGe0usuO2iGRe5OlbFHTNC8wUmuZWr6WGnyPmmGe83Tw
 vuJlQIURMRwTAFUrSVDJ4mhazwQC3eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-KsZmMkXJNPmAlHcnkTscWA-1; Thu, 13 Feb 2020 16:17:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB20800D48;
 Thu, 13 Feb 2020 21:17:15 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51EAC19925;
 Thu, 13 Feb 2020 21:17:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/8] Multifd Migration Compression
Date: Thu, 13 Feb 2020 22:17:01 +0100
Message-Id: <20200213211709.59065-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KsZmMkXJNPmAlHcnkTscWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200213132030.57757-1-quintela@redhat.com>

[v6]
- rebase to latest pull request
- move functions that read parameters to the parameters patechs (dave)
- require zstd on travis/docker/... (please review)
- rename multifd_method to multifd_compression
- improve documentation

Please review

[v5]
- rebased on top of latest pull request
- check zlib/zstd return codes in loops (denis suggestions)
- check that we do the right thing in error cases (I corrupted the
  stream, make buffers too small, etc by hand)

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

Juan Quintela (8):
  multifd: Add multifd-compression parameter
  migration: Add support for modules
  multifd: Make no compression operations into its own structure
  multifd: Add multifd-zlib-level parameter
  multifd: Add zlib compression multifd support
  configure: Enable test and libs for zstd
  multifd: Add multifd-zstd-level parameter
  multifd: Add zstd compression multifd support

 .gitlab-ci.yml                                |   1 +
 .travis.yml                                   |   1 +
 configure                                     |  30 ++
 hw/core/qdev-properties.c                     |  13 +
 include/hw/qdev-properties.h                  |   4 +
 include/qemu/module.h                         |   2 +
 migration/Makefile.objs                       |   2 +
 migration/migration.c                         |  70 ++++
 migration/migration.h                         |   3 +
 migration/multifd-zlib.c                      | 325 +++++++++++++++++
 migration/multifd-zstd.c                      | 339 ++++++++++++++++++
 migration/multifd.c                           | 191 +++++++++-
 migration/multifd.h                           |  31 ++
 migration/ram.c                               |   2 +-
 monitor/hmp-cmds.c                            |  21 ++
 qapi/migration.json                           |  80 ++++-
 tests/docker/dockerfiles/centos7.docker       |   3 +-
 .../dockerfiles/fedora-i386-cross.docker      |   3 +-
 tests/docker/dockerfiles/fedora.docker        |   3 +-
 tests/docker/dockerfiles/ubuntu.docker        |   1 +
 tests/docker/dockerfiles/ubuntu1804.docker    |   1 +
 tests/qtest/migration-test.c                  |  30 +-
 tests/vm/fedora                               |   5 +-
 tests/vm/freebsd                              |   3 +
 tests/vm/netbsd                               |   3 +
 tests/vm/openbsd                              |   3 +
 vl.c                                          |   1 +
 27 files changed, 1151 insertions(+), 20 deletions(-)
 create mode 100644 migration/multifd-zlib.c
 create mode 100644 migration/multifd-zstd.c

--=20
2.24.1


