Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57BC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2122137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9RLMFBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2122137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1ob-0007A9-Pw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n2-0004z0-PJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1mx-0002ch-J3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mw-0002bs-NC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EpPO/XObalilBIj2HmWfeweD7quZryiKR5Rc5DZWYtw=;
 b=e9RLMFBn+JvSZvz0Wz4jsKm7bqEvO43sWnmb6C6lrnhpXe57OdTfsz12hIoPyQXKVWdd1z
 y4HFR2c/Pb9PawZqqUxbBab8sRHYoapJfcXxcS2sYAVQxPw3B6qE6CS2weh7/x/Q338NXS
 TJVe1qX0rMJ0692hw32IYlocMtAQCCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-F68cgaRmNdGXMTvz6qjSOg-1; Thu, 30 Apr 2020 01:31:07 -0400
X-MC-Unique: F68cgaRmNdGXMTvz6qjSOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9319F1800D4A
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62A551001920
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D08F811358BC; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] QAPI patches for 2020-04-30
Date: Thu, 30 Apr 2020 07:30:44 +0200
Message-Id: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062=
:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' i=
nto staging (2020-04-29 15:07:33 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-04-30

for you to fetch changes up to 89bf68f933393a1bc0de4d07b59ffa8920da130f:

  qapi: Generate simpler marshalling code when no arguments (2020-04-30 07:=
26:41 +0200)

----------------------------------------------------------------
QAPI patches for 2020-04-30

----------------------------------------------------------------
Markus Armbruster (20):
      qobject: Clean up QLIST_FOREACH_ENTRY()
      qobject: Factor out helper json_pretty_newline()
      qobject: Eliminate qlist_iter(), use QLIST_FOREACH_ENTRY() instead
      qobject: Eliminate qdict_iter(), use qdict_first(), qdict_next()
      qemu-option: Clean up after the previous commit
      qapi: Belatedly update visitor.h's big comment for QAPI modules
      qapi: Fix the virtual walk example in visitor.h's big comment
      qapi: Fix typo in visit_start_list()'s contract
      qapi: Document @errp usage more thoroughly in visitor.h
      qapi: Polish prose in visitor.h
      qapi: Assert incomplete object occurs only in dealloc visitor
      qapi: Fix Visitor contract for start_alternate()
      qapi: Assert output visitors see only valid enum values
      qapi: Assert non-input visitors see only valid narrow integers
      qapi: Clean up visitor's recovery from input with invalid type
      qapi: Assert non-input visitors see only valid alternate tags
      qapi: Only input visitors can actually fail
      qom: Simplify object_property_get_enum()
      qapi: Disallow qmp_marshal_FOO(NULL, ...)
      qapi: Generate simpler marshalling code when no arguments

 docs/devel/qapi-code-gen.txt        |   4 +-
 include/qapi/qmp/qdict.h            |   3 -
 include/qapi/qmp/qlist.h            |  10 +-
 include/qapi/visitor-impl.h         |   9 +-
 include/qapi/visitor.h              | 192 +++++++++++++++++++++-----------=
----
 block.c                             |   9 +-
 block/sheepdog.c                    |   9 +-
 blockdev.c                          |  16 +--
 hw/core/machine-hmp-cmds.c          |   2 +-
 monitor/hmp-cmds.c                  |   3 +-
 monitor/qmp.c                       |   5 +-
 qapi/qapi-dealloc-visitor.c         |   7 --
 qapi/qapi-visit-core.c              |  20 ++--
 qapi/qobject-input-visitor.c        |  21 ++--
 qobject/qdict.c                     |  19 ----
 qobject/qjson.c                     | 107 +++++++-------------
 qobject/qlist.c                     |  44 +++------
 qom/object.c                        |   4 +-
 tests/check-qlist.c                 |  37 +++----
 tests/test-qobject-output-visitor.c |  39 --------
 tests/test-string-output-visitor.c  |  19 ----
 util/qemu-option.c                  |  43 ++++----
 scripts/qapi/commands.py            |  62 +++++-------
 scripts/qapi/visit.py               |   8 ++
 24 files changed, 272 insertions(+), 420 deletions(-)

--=20
2.21.1


