Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A78C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0D820733
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdZX/J3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0D820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZNFu-0004H4-47
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 17:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZNEp-0003QN-CG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZNEl-00030u-VO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZNEj-0002zN-NC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574722420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rL+ZoUoH9mdM39pgHkaaPDZV3VAsvYAupezeoM8mJM0=;
 b=bdZX/J3UxljxzSq+XyUjJDz0INYuAKwAo3YdhPCZ64hh4AbunW/7c6KbmAMsSYA/u38jWI
 7HVNdB0Ot++8GTrBYAK8ujWXVCMDr4JBFXPwAOfOOv4aWEJtBbF8oHhCe9RIM76yqofpGn
 AdLUR3hsH1zBcZnQmdiPY/s/4hDm58c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-eLGLNgVWPHiRtRURWxz8Ig-1; Mon, 25 Nov 2019 17:53:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E2808026A6;
 Mon, 25 Nov 2019 22:53:35 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD2CC1001B08;
 Mon, 25 Nov 2019 22:53:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] vmstate-static-checker fix for 4.2
Date: Mon, 25 Nov 2019 19:53:32 -0300
Message-Id: <20191125225333.322163-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eLGLNgVWPHiRtRURWxz8Ig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701=
:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2019-11-25 15:47:44 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to e8d0ac5801edda91412e52fb82f291eed5171c2c:

  vmstate-static-checker: Fix for current python (2019-11-25 19:49:50 -0300=
)

----------------------------------------------------------------
vmstate-static-checker fix for 4.2

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  vmstate-static-checker: Fix for current python

 scripts/vmstate-static-checker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--=20
2.23.0


