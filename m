Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3146E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbOiyAJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3146E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSa7-0004Ok-Tq
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZK-000337-3R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZG-0000ZK-Vi
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=58X0qAmo6C/uZdtnfwxeK2i74iGpXw1khfx2if1VYEM=;
 b=hbOiyAJUrJ4Y29jgM4vAiKYtSFevUowkxuuxVL1bBhr+L+HsdWDN0U634Stp5icvr/NjGj
 kDbhKiVo+Zxpvw1ODSrsGwrhp+lIG9lGm4l0wDXmLBmiXfJlUYKjWkb1+6Li/pR+h2SgPY
 ft8BL4Pdx0hMPLejjFTXA40upQtUS2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-wS1TjTfBNKeoH2ppQODPpQ-1; Thu, 10 Sep 2020 15:49:12 -0400
X-MC-Unique: wS1TjTfBNKeoH2ppQODPpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1708A2FD02;
 Thu, 10 Sep 2020 19:49:10 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC6719C66;
 Thu, 10 Sep 2020 19:49:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/18] chardev: QOM cleanups
Date: Thu, 10 Sep 2020 15:48:45 -0400
Message-Id: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some chardev QOM cleanup patches had to be dropped from my queue=0D
due to build erros introduced by code movements across ifdef=0D
boundaries at char-parallel.c.  This series redo the changes from=0D
those patches, but the macro renames are now a little different:=0D
=0D
In this version I have decided to rename the type checking macros=0D
from *_CHARDEV to CHARDEV_* instead of renaming tye=0D
TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the=0D
identifiers actually match the QOM type name strings=0D
("chardev-*").=0D
=0D
Eduardo Habkost (18):=0D
  chardev: Move PARALLEL_CHARDEV macro to common code=0D
  chardev: Move ParallelChardev typedef to common code=0D
  chardev: Use DECLARE_INSTANCE_CHECKER macro for PARALLEL_CHARDEV=0D
  chardev: Rename MOUSE_CHARDEV to CHARDEV_MSMOUSE=0D
  chardev: Rename BAUM_CHARDEV to CHARDEV_BRAILLE=0D
  chardev: Rename FD_CHARDEV to CHARDEV_FD=0D
  chardev: Rename MUX_CHARDEV to CHARDEV_MUX=0D
  chardev: Rename PARALLEL_CHARDEV to CHARDEV_PARALLEL=0D
  chardev: Rename PTY_CHARDEV to CHARDEV_PTY=0D
  chardev: Rename RINGBUF_CHARDEV to CHARDEV_RINGBUF=0D
  chardev: Rename SOCKET_CHARDEV to CHARDEV_SOCKET=0D
  chardev: Rename SPICE_CHARDEV to CHARDEV_SPICE=0D
  chardev: Rename TESTDEV_CHARDEV to CHARDEV_TESTDEV=0D
  chardev: Rename UDP_CHARDEV to CHARDEV_UDP=0D
  chardev: Rename VC_CHARDEV to CHARDEV_VC=0D
  chardev: Rename WCTABLET_CHARDEV to CHARDEV_WCTABLET=0D
  chardev: Rename WIN_CHARDEV to CHARDEV_WIN=0D
  chardev: Rename WIN_STDIO_CHARDEV to CHARDEV_WIN_STDIO=0D
=0D
 chardev/chardev-internal.h |  2 +-=0D
 include/chardev/char-fd.h  |  2 +-=0D
 include/chardev/char-win.h |  2 +-=0D
 include/chardev/spice.h    |  2 +-=0D
 chardev/baum.c             | 14 ++++----=0D
 chardev/char-fd.c          | 14 ++++----=0D
 chardev/char-fe.c          |  4 +--=0D
 chardev/char-mux.c         | 22 ++++++------=0D
 chardev/char-parallel.c    | 28 ++++++++--------=0D
 chardev/char-pipe.c        |  2 +-=0D
 chardev/char-pty.c         | 22 ++++++------=0D
 chardev/char-ringbuf.c     | 12 +++----=0D
 chardev/char-serial.c      |  2 +-=0D
 chardev/char-socket.c      | 68 +++++++++++++++++++-------------------=0D
 chardev/char-udp.c         | 14 ++++----=0D
 chardev/char-win-stdio.c   | 14 ++++----=0D
 chardev/char-win.c         | 14 ++++----=0D
 chardev/char.c             |  2 +-=0D
 chardev/msmouse.c          | 12 +++----=0D
 chardev/spice.c            | 16 ++++-----=0D
 chardev/testdev.c          |  4 +--=0D
 chardev/wctablet.c         | 12 +++----=0D
 ui/console.c               | 10 +++---=0D
 ui/gtk.c                   |  8 ++---=0D
 ui/spice-app.c             |  2 +-=0D
 25 files changed, 151 insertions(+), 153 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


