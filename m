Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F005C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DD2238C7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DD2238C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzTd-0001Fq-Hv
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hzzS7-0008Qy-GL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hzzS6-0004hc-Cl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1hzzS4-0004g2-6l; Tue, 20 Aug 2019 04:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2849EA38184;
 Tue, 20 Aug 2019 08:25:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CA1360C4E;
 Tue, 20 Aug 2019 08:25:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 10:24:54 +0200
Message-Id: <20190820082459.2101-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 20 Aug 2019 08:25:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] Fix multifd with big number of channels
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

In this v2:
- dropped the already included patches upstream
- dropped the semaphore changes
- add backlog listen parameter through all the call chain (danp suggestio=
n)
- also add the change for qio_channel_socket_async(), for consistency
  (it has zero users on tree anyways)
- for "fd" case, I just give an error if expected number of
  connections is bigger than 1.
- All patches except the multifd one should be noops (i.e. I pass
  everywhere the number of expected channels as one).

With this changes, I can migrate with 100 channels consistently.  It
always work.

Please, review.

Juan Quintela (5):
  socket: Add backlog parameter to socket_listen
  socket: Add num connections to qio_channel_socket_sync()
  socket: Add num connections to qio_channel_socket_async()
  socket: Add num connections to qio_net_listener_open_sync()
  multifd: Use number of channels as listen backlog

 blockdev-nbd.c                 |  2 +-
 chardev/char-socket.c          |  2 +-
 include/io/channel-socket.h    |  4 ++++
 include/io/net-listener.h      |  2 ++
 include/qemu/sockets.h         |  2 +-
 io/channel-socket.c            | 35 +++++++++++++++++++++++++---------
 io/net-listener.c              |  3 ++-
 io/trace-events                |  4 ++--
 migration/socket.c             |  7 ++++++-
 qemu-nbd.c                     |  2 +-
 qga/channel-posix.c            |  2 +-
 scsi/qemu-pr-helper.c          |  3 ++-
 tests/test-char.c              |  4 ++--
 tests/test-io-channel-socket.c |  4 ++--
 tests/test-util-sockets.c      | 12 ++++++------
 tests/tpm-emu.c                |  2 +-
 ui/vnc.c                       |  4 ++--
 util/qemu-sockets.c            | 33 +++++++++++++++++++++-----------
 util/trace-events              |  2 ++
 19 files changed, 86 insertions(+), 43 deletions(-)

--=20
2.21.0


