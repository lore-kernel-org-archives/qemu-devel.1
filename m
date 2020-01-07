Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD9C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C10207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSO4Gm7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C10207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionXO-0006P0-R6
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iomQM-0004Ib-0F
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iomQK-0004l6-FN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iomQK-0004kw-Bu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wq9uhETQMxbGzYJ3jBgxUQc+fo0qNWVhuDg+t8IZDsg=;
 b=NSO4Gm7QysPktwJrTsKmiCz4ZrZ0tm0GclFxwXo/vl9KkjPvoNjbc8Mlpm4+Jl7U6VVd1+
 tUvB+2hBGuEq3W2s9sa+/Absp37N4QPcwcko9bLjSxpQhLuk3Dzn3h1pyxlJ5MAGN6JaAA
 00b5xKuqjxsv+T2pUaDh8fp28OKPJnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-BKTaTZgXPxS3qM8lYgjJ1w-1; Tue, 07 Jan 2020 05:49:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B54B18C35B2
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 10:49:17 +0000 (UTC)
Received: from secure.mitica (ovpn-116-240.ams2.redhat.com [10.36.116.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E20921A8D6;
 Tue,  7 Jan 2020 10:49:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Fix multifd + cancel + multifd
Date: Tue,  7 Jan 2020 11:49:11 +0100
Message-Id: <20200107104914.1814-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BKTaTZgXPxS3qM8lYgjJ1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

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

Juan Quintela (3):
  migration-test: Add migration multifd test
  migration: Make sure that we don't call write() in case of error
  migration-test: Make sure that multifd and cancel works

 migration/ram.c        |  25 +++++++
 tests/migration-test.c | 166 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 190 insertions(+), 1 deletion(-)

--=20
2.24.1


