Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE319C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1B520784
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILF6TjNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1B520784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZA1-0002oP-MG
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8i-000167-MA
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8g-0003by-Ow
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8g-0003b0-J0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LBB7gPON3eyou2+j/tRjXmKGMR/t/+hSA/D9LtXIh+o=;
 b=ILF6TjNyRDku71oR3R+N/szJ29oYlsSCAxOlw8EMcAUy3R/clWlkWDPKTJ9pMVVrIYTqdX
 wA65UmmunwhnWGNXHD48xRHQNmxRo6MVHaC8QEpcE3K5lSJRRNMNjoMdm5XrCr99l8W0de
 exgBThVfk0ofslFZrwURyM6LS0K06AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-QxFO3uM9NhKsFYaV4t7_jw-1; Thu, 09 Apr 2020 11:30:43 -0400
X-MC-Unique: QxFO3uM9NhKsFYaV4t7_jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E121618FF660;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD35B396;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3254811385C8; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/8] qemu-option: Fix corner cases and clean up
Date: Thu,  9 Apr 2020 17:30:33 +0200
Message-Id: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster (8):
  tests-qemu-opts: Cover has_help_option(), qemu_opt_has_help_opt()
  qemu-options: Factor out get_opt_name_value() helper
  qemu-option: Fix sloppy recognition of "id=3D..." after ",,"
  qemu-option: Avoid has_help_option() in qemu_opts_parse_noisily()
  qemu-option: Fix has_help_option()'s sloppy parsing
  test-qemu-opts: Simplify test_has_help_option() after bug fix
  qemu-img: Factor out accumulate_options() helper
  qemu-option: Move is_valid_option_list() to qemu-img.c and rewrite

 include/qemu/option.h  |   1 -
 qemu-img.c             |  85 ++++++++++-------
 tests/test-qemu-opts.c |  40 +++++++-
 util/qemu-option.c     | 210 ++++++++++++++++++++---------------------
 4 files changed, 191 insertions(+), 145 deletions(-)

--=20
2.21.1


