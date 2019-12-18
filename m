Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9345C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7877B21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcDUy48b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7877B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRXT-0008Ho-Eq
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihRW1-0006vX-QD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihRVv-0003Yy-Ej
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihRVu-0003TN-A6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576645485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hq6TJ2Uoyd/yqte+nyc3zm5lw9I9CJr9XVb2+n1ZxLA=;
 b=NcDUy48bnrd9k93njyHk/L39ewWDhAj5h+ct5Qzq2t/Y5sgYxw6w/ZC5prWZTrru8lRL+K
 pZiDiuXUl6Y/DNTYtKKw8g3XVOVhdHTgzJ5A5iqGt4iR5KMg2t/Ap0pBnQ8Kb3u2RfokoM
 t9ZdkJ+ER+1ZCFlFpsVwYMB8CTjOcWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-vNdKWz_ZOsqFHLQE4UYs9g-1; Wed, 18 Dec 2019 00:04:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CD164A84
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:04:42 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0923A5D9E1;
 Wed, 18 Dec 2019 05:04:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Fix multifd + cancel + multifd
Date: Wed, 18 Dec 2019 06:04:35 +0100
Message-Id: <20191218050439.5989-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vNdKWz_ZOsqFHLQE4UYs9g-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

This series:
- create a test that does:
  launch multifd on target
  migrate to target
  cancel on source
  create another target
  migrate again

- And fixes the cases that made it fail:
* Make sure that we don't try ever IO after shutdown/error

Please, review.

Juan Quintela (4):
  qemu-file: Don't do IO after shutdown
  multifd: Make sure that we don't do any IO after an error
  migration-test: Make sure that multifd and cancel works
  migration: Make sure that we don't call write() in case of error

 migration/qemu-file.c  |  13 +++++
 migration/ram.c        |  41 ++++++++++++----
 tests/migration-test.c | 108 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 152 insertions(+), 10 deletions(-)

--=20
2.23.0


