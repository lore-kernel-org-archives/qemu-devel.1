Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D275C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6429120578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxgOiUxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6429120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SVC-0001Um-H4
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j4SIP-0007F1-Tp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j4SIO-0003RJ-7J
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:33:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j4SIO-0003Qp-3B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582130035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW2YJMWqg7N+PSqPap1qQzEuiRMH3WsQdq2V7QM1JZ8=;
 b=fxgOiUxU8g1fS/IhhVHGiY7hV+09Bz8DSb+oDXhP1Cpqmb9m/Ty/sHAW+YeOBXS/gcmqQt
 YLThrvbZYEnlFK9uUHk35AoURGSVcJS1S8svWkCuIkouViJI/RGyIR8Uz8kdtfjIeSFr/E
 FKFCuq2a3G5p96lC/72UDXIUnMkGqzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-rodx5PikP1au1mJILPvS1w-1; Wed, 19 Feb 2020 11:33:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DA5F107ACC5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:33:50 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-205-79.brq.redhat.com [10.40.205.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9449760BE1;
 Wed, 19 Feb 2020 16:33:45 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Migration mechanism with FD
Date: Wed, 19 Feb 2020 18:33:41 +0200
Message-Id: <20200219163344.27651-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rodx5PikP1au1mJILPvS1w-1
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
Cc: philmd@redhat.com, ehabkost@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To test migration through the file descriptor we should build and provide
a path to socket_scm_helper file. This way is inconvenient for acceptance
testing.
This series provides new functions to receive and send messages over a UNIX
socket. And adds a new migration test.

Oksana Vohchana (3):
  Adding functions _send_fds and _recv_fds
  Updates send_fd_scm function
  Acceptance test: FD migration

 python/qemu/machine.py        | 74 ++++++++++++++++++++++++-----------
 tests/acceptance/migration.py | 20 ++++++++++
 2 files changed, 72 insertions(+), 22 deletions(-)

--=20
2.21.1


