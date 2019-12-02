Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D14C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFBE20881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbsslFl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFBE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibniR-0004Tf-LT
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibncD-0006bM-PM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibnc9-0002CJ-SZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:27:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibnc9-0002BK-9u
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575300472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jnK+3aDCfAVfgTaTDHNOIQOyWxkt0Vd8XIfHq3g49jk=;
 b=JbsslFl67qEAssgpC6Fvm/7p1/5nCmVprPuhEXnxv4b8U213ME4GCWHnhgQnXJG0t7q56I
 LwW9oGFq0UJmsA2ARxO9yJqRuRTsLD1g5rCJLMxbOwqbWshiioOfaNlvFQsXcrLDgW5KRl
 2ky8AnvbDk4OocG1rSX1WSI8biu3o6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-LF3Eo7wvPuORtB8IrVPDwQ-1; Mon, 02 Dec 2019 10:27:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C526618C030E
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 15:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9680A619DB
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 15:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C25E1138606; Mon,  2 Dec 2019 16:27:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2 0/3] Error reporting patches for 2019-12-02
Date: Mon,  2 Dec 2019 16:27:43 +0100
Message-Id: <20191202152746.32292-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LF3Eo7wvPuORtB8IrVPDwQ-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PATCH 1+2 fix a crash in virtio-net failover error handling.  Failover
is new in 4.2.  Jens Freimann would prefer this fix to go into 4.2.

PATCH 3 fixes a crash in Linux AIO initialization error handling.
Stefan Hajnoczi thinks it's worth including in 4.2.

Both fixes are straightforward.

The following changes since commit fb2246882a2c8d7f084ebe0617e97ac78467d156=
:

  .travis.yml: drop xcode9.4 from build matrix (2019-11-29 15:51:52 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-02

for you to fetch changes up to cb09104ea8418d9521d9a9d36ea0527b84ce51ac:

  block/file-posix: Fix laio_init() error handling crash bug (2019-12-02 16=
:14:41 +0100)

----------------------------------------------------------------
Error reporting patches for 2019-12-02

----------------------------------------------------------------
Markus Armbruster (3):
      net/virtio: Drop useless n->primary_dev not null checks
      net/virtio: Fix failover error handling crash bugs
      block/file-posix: Fix laio_init() error handling crash bug

 block/file-posix.c  |  2 +-
 hw/net/virtio-net.c | 27 ++++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

--=20
2.21.0


