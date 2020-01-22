Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA17CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8922465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTEt80pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8922465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuE02-0005Aj-Ad
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuDyn-0003yI-LC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuDyl-0006ZW-UQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:15:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuDyl-0006ZD-Qs
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579691722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jsA7Q5ejW7P90vLGGIopqaD3AFORCYc5cbek5xWUk1Q=;
 b=FTEt80pNtFitgIx3RhMBRRgh7yfbD1LrcQXp8fy97LzdHo1V5ojuaNcARJG8xwz9mJf06o
 9DsWEgf136L4/WS5w9lIO7IHh4g/V8WZMCRhWwy3MnB5bZjBPgQDfHlLI0Fq5Cqul5yZ+o
 Exvbff0WP5EDrmUdOsW9S+j09yIbWE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-nZh_7YGiNDOmz3Nk_k_DjA-1; Wed, 22 Jan 2020 06:15:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C108010CB
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 11:15:20 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C27905C1BB;
 Wed, 22 Jan 2020 11:15:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] Fix multifd + cancel + multifd
Date: Wed, 22 Jan 2020 12:15:11 +0100
Message-Id: <20200122111517.33223-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nZh_7YGiNDOmz3Nk_k_DjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

In the v4 series:
* Updated to latest pull request
* redo the check for active migration at the end of the iteration stage
* testing/testing/testing it now passes the test for multifd + cancel
  hundred of times in a row
* Use g_free consistently

Please review, Juan.

In the v3 series:
- Add back the ->shutdown fix
  Dave found the problem, we need to setup an error if we do shutdown.
- Make iotests to work back (we need to setup ->active for savevm)
- So postcopy/recovery is fixed again.

Please review, if there are not outstanding issues, I plan to push it.

Thanks, Juan

In the v2 series:
- get the multifd test patch
- drop the ->shutdown fix
  it break postcopy recovery test.  Still trying to determine if the
  problem is inside the recover test or the recover code.
- upgrade the migrate_cancel test

Please review.

[v1]
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

Juan Quintela (6):
  migration-test: Use g_free() instead of free()
  multifd: Make sure that we don't do any IO after an error
  qemu-file: Don't do IO after shutdown
  migration-test: Make sure that multifd and cancel works
  migration: Create migration_is_running()
  migration: Don't send data if we have stopped

 migration/migration.c        |  29 +++++++--
 migration/migration.h        |   1 +
 migration/qemu-file.c        |  22 ++++++-
 migration/ram.c              |  23 ++++---
 migration/savevm.c           |   4 +-
 tests/qtest/migration-test.c | 114 ++++++++++++++++++++++++++++++++++-
 6 files changed, 173 insertions(+), 20 deletions(-)

--=20
2.24.1


