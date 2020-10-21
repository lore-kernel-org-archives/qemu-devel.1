Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F32C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4187221F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0WSb3fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4187221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJFP-0007Vo-Ja
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0005xE-5A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDf-0008AQ-VN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2BBcCfVqHjMgRf/0GQk3HEMKrPlZ5yQ2xXwWI8hjaY4=;
 b=P0WSb3fzRF3tQVpBHCJDWV5zpSUJjFWJlGG7OUoxN4O3Z83KwMnthbHomNjqsGz7efTb2E
 WVhwgu58axTbx8FoCnvJOtfXtTnWt73+yWuUDhDmBjIbn6udhyvVPsHgAgimJPgV9yg56t
 /Lp+uhPo1x2gwE/LEXvDe7Yuo+7//ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-6wWkXZYqP-uSPhJtGh5sHQ-1; Wed, 21 Oct 2020 14:52:10 -0400
X-MC-Unique: 6wWkXZYqP-uSPhJtGh5sHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A94F55F9C1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:09 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02745100239F;
 Wed, 21 Oct 2020 18:52:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] python: absorb scripts/qmp/qom-* tooling
Date: Wed, 21 Oct 2020 14:51:53 -0400
Message-Id: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20201020193555.1493936-1-jsnow@redhat.com>=0D
          [PATCH v3 00/15] python: create installable package=0D
=0D
This is a bit of a demonstration of the direction I want to take our=0D
python tooling, and how it *might* work.=0D
=0D
By moving items from ./scripts/*.py over to ./python/qemu/* somewhere,=0D
they can be checked with the same isort/flake8/pylint/mypy tooling as=0D
everything else. This will help prevent regressions.=0D
=0D
I would like to, over time, move all applicable python scripts from=0D
./scripts to ./python. That will be a long, gradual stream of changes,=0D
but the more we do it, the better off we'll be for these tools.=0D
=0D
Reviewer notes:=0D
=0D
- I just rewrote qom-xxx entirely, though it is based on the original=0D
  scripts. Doing it brick by brick was too slow.=0D
=0D
- I added a symlink to the qom-fuse file under the python/ tree so I=0D
  could check it with the usual linters. This causes some future=0D
  knowledge to bleed through in a few places; notably I update the=0D
  python setup.cfg several times in the middle of the series where it=0D
  doesn't seem like that should have an effect.=0D
=0D
- qom-fuse disappears from the tree for a single commit, but that=0D
  preserves git-blame history. Best I could do.=0D
=0D
John Snow (15):=0D
  python/qmp: Add qom script rewrites=0D
  python/qmp: add qom script entry points=0D
  scripts/qmp: redirect qom-xxx scripts to python/qemu/qmp/=0D
  scripts/qom-fuse: apply isort rules=0D
  scripts/qom-fuse: apply flake8 rules=0D
  python: Add 'fh' to known-good variable names=0D
  scripts/qom-fuse: Apply pylint rules=0D
  scripts/qom-fuse: Add docstrings=0D
  scripts/qom-fuse: Convert to QOMCommand=0D
  scripts/qom-fuse: use QOMCommand.qom_list()=0D
  scripts/qom-fuse: ensure QOMFuse.read always returns bytes=0D
  scripts/qom-fuse: add static type hints=0D
  scripts/qom-fuse: move to python/qemu/qmp/qom_fuse.py=0D
  scripts/qom-fuse: add redirection shim to python/qemu/qmp/qom-fuse.py=0D
  python: add fuse command to 'qom' tools=0D
=0D
 python/qemu/qmp/qom.py        | 217 ++++++++++++++++++++++++++++++++++=0D
 python/qemu/qmp/qom_common.py | 153 ++++++++++++++++++++++++=0D
 python/qemu/qmp/qom_fuse.py   | 207 ++++++++++++++++++++++++++++++++=0D
 python/setup.cfg              |  24 +++-=0D
 scripts/qmp/qom-fuse          | 144 +---------------------=0D
 scripts/qmp/qom-get           |  66 +----------=0D
 scripts/qmp/qom-list          |  63 +---------=0D
 scripts/qmp/qom-set           |  63 +---------=0D
 scripts/qmp/qom-tree          |  74 +-----------=0D
 9 files changed, 618 insertions(+), 393 deletions(-)=0D
 create mode 100644 python/qemu/qmp/qom.py=0D
 create mode 100644 python/qemu/qmp/qom_common.py=0D
 create mode 100644 python/qemu/qmp/qom_fuse.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


