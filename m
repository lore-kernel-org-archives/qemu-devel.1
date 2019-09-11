Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF0FC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5B620838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85iK-0002Yw-7P
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i85h3-0001LQ-1L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i85h1-00005F-9h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i85h1-0008WO-4k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6851300C03B
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 16:42:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-243.ams2.redhat.com
 [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFFF260BEC;
 Wed, 11 Sep 2019 16:42:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 quintela@redhat.com
Date: Wed, 11 Sep 2019 17:41:59 +0100
Message-Id: <20190911164202.31136-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 11 Sep 2019 16:42:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] Automatic RCU read unlock
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This patch uses glib's g_auto mechanism to automatically free
rcu_read_lock's at the end of the block.  Given that humans
have a habit of forgetting an error path somewhere it's
best to leave it to the compiler.

In particular:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1746787
suggests we've forgotten an unlock case somewhere in the
rdma migration code.

Dave


Dr. David Alan Gilbert (3):
  rcu: Add automatically released rcu_read_lock variant
  migration: Use automatic rcu_read unlock in ram.c
  migration: Use automatic rcu_read unlock in rdma.c

 include/qemu/rcu.h | 12 ++++++++++
 migration/ram.c    | 25 ++++++++------------
 migration/rdma.c   | 57 +++++++++-------------------------------------
 3 files changed, 32 insertions(+), 62 deletions(-)

--=20
2.21.0


