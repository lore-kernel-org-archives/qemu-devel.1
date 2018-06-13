Received: from eggs.gnu.org ([2001:4830:134:3::10]:48116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT2zJ-0002Gr-7g
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT2zF-0000ro-0Y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT2zE-0000qq-Sc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 719F64022414
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:26:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 13 Jun 2018 11:26:39 +0100
Message-Id: <20180613102642.23995-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Postcopy bandwidth limiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  Postcopy currently turns off bandwidth limits during the postcopy
phase to make sure the urgent postcopy requests aren't delayed.
  This causes problems for larger clusters which share networking
between the migration stream and other critical services.

  This series restricts the background postcopy bandwidth but does
it in a way that lets the urgent postcopy requests get through.

  Testing on a 10Gbps link and a 400MByte/s limit shows
very little difference in the postcopy request latency, but
a network graph shows the bandwidth usage very close
to the set limit, even with a very heavy memory load running
in the guest.

Dr. David Alan Gilbert (3):
  migration/postcopy: Add max-postcopy-bandwidth parameter
  migration: Wake rate limiting for urgent requests
  migration/postcopy: Wake rate limit sleep on postcopy request

 hmp.c                  |  7 +++++
 migration/migration.c  | 70 +++++++++++++++++++++++++++++++++++++++---
 migration/migration.h  |  8 +++++
 migration/ram.c        |  9 +++++-
 migration/trace-events |  2 ++
 qapi/migration.json    | 19 ++++++++++--
 6 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.17.1
