Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A8DC48BE5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289720673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heG3N-0005gx-At
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49419)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1heG1z-0004b2-C6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1heG1t-0002GK-P4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1heG1q-0002BB-EX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 805A4307D970;
 Fri, 21 Jun 2019 09:40:16 +0000 (UTC)
Received: from localhost (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36CE75D9D2;
 Fri, 21 Jun 2019 09:40:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Fri, 21 Jun 2019 10:40:01 +0100
Message-Id: <20190621094005.4134-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 21 Jun 2019 09:40:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] libvhost-user: VHOST_USER_PROTOCOL_F_MQ
 support
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sebastien Boeuf <sebastien.boeuf@intel.com> pointed out that libvhost-use=
r
doesn't advertise VHOST_USER_PROTOCOL_F_MQ.  Today this prevents vhost-us=
er-net
multiqueue from working.

In virtio-fs we also want to support multiqueue so I'm sending patches to=
 add
this.  It's free to advertise VHOST_USER_PROTOCOL_F_MQ for all devices so=
 we
can do it unconditionally in libvhost-user.

Several related improvements are included:
Patch 1 - clean up duplicated and risky VhostUserMsg reply building code
Patch 2 - remove hardcoded 8 virtqueue limit in libvhost-user
Patch 4 - clarify vhost-user multiqueue specification

Stefan Hajnoczi (4):
  libvhost-user: add vmsg_set_reply_u64() helper
  libvhost-user: support many virtqueues
  libvhost-user: implement VHOST_USER_PROTOCOL_F_MQ
  docs: avoid vhost-user-net specifics in multiqueue section

 contrib/libvhost-user/libvhost-user-glib.h |  2 +-
 contrib/libvhost-user/libvhost-user.h      | 10 +++-
 contrib/libvhost-user/libvhost-user-glib.c | 12 +++-
 contrib/libvhost-user/libvhost-user.c      | 65 +++++++++++++---------
 contrib/vhost-user-blk/vhost-user-blk.c    | 16 +++---
 contrib/vhost-user-gpu/main.c              |  9 ++-
 contrib/vhost-user-input/main.c            | 11 +++-
 contrib/vhost-user-scsi/vhost-user-scsi.c  | 21 +++----
 tests/vhost-user-bridge.c                  | 42 +++++++++-----
 docs/interop/vhost-user.rst                | 21 +++----
 10 files changed, 132 insertions(+), 77 deletions(-)

--=20
2.21.0


