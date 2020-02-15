Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A84C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A236F20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHlfOcUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A236F20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vqJ-00063M-RA
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpM-0004Rc-S2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpL-0006p0-3p
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpK-0006oj-Qs
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UekgsobMyZ+ud/Fg1J7KZNfXXDVUeaN1xJcjCWc+Pmc=;
 b=WHlfOcUGLcS4XL6XiXKIgeDPii+VKHQBsHgLbnuIeYCr2O6zDSqnWFOM3hnlgv2FAGW7xc
 t9FpwxfJy5pWTAlWrCJUUGU4hh2YAHVhQTvncUoFkbZjN6vJdwJKIym5+mAmFwLx83vxAr
 3WsU+67rSjEIClZaSsrLDxwriC4JklY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-cxunPCn2OEGSLLMhl6SsNg-1; Sat, 15 Feb 2020 06:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0ED6800D4E
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B21A15D9CD
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B6A711385C9; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] QAPI patches for 2020-02-15
Date: Sat, 15 Feb 2020 12:41:15 +0100
Message-Id: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cxunPCn2OEGSLLMhl6SsNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The following changes since commit 517c84cef759a453cfb8f51498aebc909a5f3b39=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200213-pull-reque=
st' into staging (2020-02-13 18:55:57 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-02-15

for you to fetch changes up to bb5ccf225e81d2801c03e63d16c371f0617270e8:

  qapi: Delete all the "foo: dropped in n.n" notes (2020-02-15 11:41:50 +01=
00)

----------------------------------------------------------------
QAPI patches for 2020-02-15

* QAPI schema doc comment fixes and cleanups, most of them in
  preparation of the upcoming switch to rST

* A Make dependency typo fix

* configure improvements for sphinx-build

----------------------------------------------------------------
Andrea Bolognani (1):
      qapi: Expand documentation for LostTickPolicy

Markus Armbruster (1):
      configure: Pick sphinx-build-3 when available

Peter Maydell (16):
      configure: Allow user to specify sphinx-build binary
      configure: Check that sphinx-build is using Python 3
      Makefile: Fix typo in dependency list for interop manpages
      qga/qapi-schema.json: Fix missing '-' in GuestDiskBusType doc comment
      qga/qapi-schema.json: Fix indent level on doc comments
      qga/qapi-schema.json: minor format fixups for rST
      qapi/block-core.json: Use literal block for ascii art
      qapi: Fix incorrect "Not documented" claims in QMP documentation
      qapi: Fix indent level on doc comments in json files
      qapi: Remove hardcoded tabs
      qapi/ui.json: Put input-send-event body text in the right place
      qapi/ui.json: Avoid `...' Texinfo style quoting
      qapi: Use explicit bulleted lists
      qapi: Add blank lines before bulleted lists
      qapi/migration.json: Replace _this_ with *this*
      qapi: Delete all the "foo: dropped in n.n" notes

 docs/conf.py             |   10 +
 configure                |   32 +-
 Makefile                 |    4 +-
 qapi/block-core.json     | 1139 +++++++++++++++++++++++-------------------=
----
 qapi/block.json          |   47 +-
 qapi/char.json           |   10 +-
 qapi/dump.json           |    4 +-
 qapi/introspect.json     |   12 +-
 qapi/job.json            |   32 +-
 qapi/machine-target.json |   18 +-
 qapi/machine.json        |   14 +-
 qapi/migration.json      |  206 ++++-----
 qapi/misc-target.json    |    8 +-
 qapi/misc.json           |  166 +++----
 qapi/net.json            |   26 +-
 qapi/qdev.json           |   10 +-
 qapi/qom.json            |    4 +-
 qapi/rocker.json         |   12 +-
 qapi/run-state.json      |   34 +-
 qapi/sockets.json        |    8 +-
 qapi/tpm.json            |    4 +-
 qapi/trace.json          |   15 +-
 qapi/transaction.json    |    4 +-
 qapi/ui.json             |  117 ++---
 qga/qapi-schema.json     |  156 ++++---
 25 files changed, 1070 insertions(+), 1022 deletions(-)

--=20
2.21.1


