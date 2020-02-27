Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3480C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81756246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsU3c6s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81756246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7M57-0004CK-6f
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7M4G-0003ef-4J
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7M4E-0002ZC-NF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7M4E-0002YU-JM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=facQEEN/kzj3U8JrfXD3AJvEMo+bEIrvAt6fa1eikAo=;
 b=FsU3c6s1JPdlAL/unYDvZrdJg/XurAY2sQceMYPphcvMYMQxBgNJ4Yy4WyjpuJ8uSbTK9Q
 PSk6QSIutPDHh/jQ5mTJeZHEJ4+AbTAUtRSV5xrAgImmHf03CCyHOYsZHACet1mE3tfiuv
 /YPGurZUfwe1Wg2mzXfZSDpO3e1Cmtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-7hL486xrMy2sduXksF2KnQ-1; Thu, 27 Feb 2020 11:31:14 -0500
X-MC-Unique: 7hL486xrMy2sduXksF2KnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8FEB477;
 Thu, 27 Feb 2020 16:31:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C0066E3EE;
 Thu, 27 Feb 2020 16:31:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] misc: Improve error reporting on Windows
Date: Thu, 27 Feb 2020 17:30:55 +0100
Message-Id: <20200227163101.414-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two patches to improve bug reports on Windows.
(i.e. https://bugs.launchpad.net/qemu/+bug/1657841)

Since v1:
- Rebase an old patch from Alistair to use error_report()
  as suggested by Markus
- Fix other uses in util/osdep.c and QEMU guest-agent

Alistair Francis (1):
  util: Replace fprintf(stderr, "*\n" with error_report()

Philippe Mathieu-Daud=C3=A9 (5):
  chardev: Improve error report by calling error_setg_win32()
  util/oslib-win32: Improve error report by calling error_setg_win32()
  util/osdep: Improve error report by calling error_setg_win32()
  qga: Fix a memory leak
  qga: Improve error report by calling error_setg_win32()

 chardev/char-pipe.c          |  2 +-
 chardev/char-win.c           |  2 +-
 qga/channel-win32.c          |  7 ++++---
 qga/commands-win32.c         |  6 +++---
 util/coroutine-sigaltstack.c |  3 ++-
 util/mmap-alloc.c            | 11 ++++++-----
 util/module.c                | 13 ++++++-------
 util/osdep.c                 | 12 ++++++------
 util/oslib-posix.c           |  3 ++-
 util/oslib-win32.c           |  4 +++-
 util/qemu-coroutine.c        | 10 +++++-----
 util/qemu-thread-posix.c     |  5 +++--
 util/qemu-thread-win32.c     |  5 +++--
 util/qemu-timer-common.c     |  3 ++-
 14 files changed, 47 insertions(+), 39 deletions(-)

--=20
2.21.1


