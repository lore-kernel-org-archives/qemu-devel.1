Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C64C31E47
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7D120896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7D120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb1D7-00051a-PC
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0sn-0007uH-H0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0sl-0004gu-Ax
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0sl-0004gZ-36
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1126287638
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0383A17C46;
 Wed, 12 Jun 2019 10:53:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:53:17 +0200
Message-Id: <20190612105323.7051-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 10:53:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/6] Multifd compression support
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
- improve the code left and right
- use the MIGRATION_FLAG_SYNC
- use qerrors properly
- pass errors everywhere (no more printfs)
- create cleanup/save operations
- merged zlib patches into one
- general patches alreody on the migration pull request.
- commented all the methods.

ToDo: Didn't add the sztd compression because I changed the zlib
      code/methods quite a bit.
      My understanding is that all the issues are gone.

v3:
- improve the code
- address David and Markus comments
- make compression code into methods
  so we can add any other method ading just three functions

Please review, as far as I know everything is ok now.

Todo: Add zstd support

v2:
- improve the code left and right
- Split better the zlib code
- rename everything to v4.1
- Add tests for multifd-compress zlib
- Parameter is now an enum (soon will see sztd)

ToDo:
- Make operations for diferent methods:
  * multifd_prepare_send_none/zlib
  * multifd_send_none/zlib
  * multifd_recv_none/zlib
- Use the MULTIFD_FLAG_ZLIB (it is unused so far).

Please review and comment.

v1:

This series create compression code on top of multifd.  It is still
WIP, but it is already:
- faster that current compression code
- it does the minimum amount of copies possible
- we allow support for other compression codes
- it pass the multifd test sent in my previous series

Test for existing code didn't work because code is too slow, I need to
make downtime 10 times bigger to make it to converge on my test
machine.  This code works with same limits that multifd no-

ToDo:
- move printf's  to traces
- move code to a struct instead of if (zlib) inside the main threads.
- improve error handling.

Please, review and coment.

Juan Quintela (6):
  migration-test: introduce functions to handle string parameters
  migration: Make multifd_save_setup() get an Error parameter
  migration: Make multifd_load_setup() get an Error parameter
  migration: Add multifd-compress parameter
  migration: Make no compression operations into its own structure
  migration: Add zlib compression multifd support

 hmp.c                        |  13 +
 hw/core/qdev-properties.c    |  13 +
 include/hw/qdev-properties.h |   3 +
 migration/migration.c        |  34 ++-
 migration/migration.h        |   3 +-
 migration/ram.c              | 454 ++++++++++++++++++++++++++++++++++-
 migration/ram.h              |   4 +-
 migration/rdma.c             |   2 +-
 qapi/migration.json          |  30 ++-
 tests/migration-test.c       |  54 ++++-
 10 files changed, 585 insertions(+), 25 deletions(-)

--=20
2.21.0


